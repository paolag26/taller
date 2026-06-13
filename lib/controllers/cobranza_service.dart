import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

class CobranzaService {
  // ==============================
  // PATRON SINGLETON
  // CobranzaService utiliza Singleton
  // para garantizar una unica instancia
  // durante toda la ejecucion del sistema.
  // Defensa: Patron Creacional.
  // Razon en Cuentas Claras: centraliza
  // datos de rutas, mora y cobranza diaria.
  // ==============================
  static final CobranzaService _instance = CobranzaService._internal();

  factory CobranzaService() {
    return _instance;
  }

  CobranzaService._internal();

  final localDb = DatabaseConfig.client;
  final roleService = RoleService();

  Future<List<Map<String, dynamic>>> listarCuotasCobranza() async {
    final access = await roleService.currentAccess();
    final cuotas = await _listarOrdenado(
      table: 'cuota',
      orderColumn: 'fecha_vencimiento',
    );
    final prestamos = await _listarSeguro('prestamo');
    final clientes = await _listarSeguro('cliente');
    final personas = await _listarSeguro('persona');
    final tipos = await _listarSeguro('tipo_prestamo');
    final estadosPrestamo = await _listarSeguro('estado_prestamo');
    final estadosCuota = await _listarSeguro('estado_cuota');
    final planes = await _listarSeguro('plan_pagos');

    final prestamosById = _byKey(prestamos, 'id_prestamo');
    final clientesById = _byKey(clientes, 'id_cliente');
    final personasByCi = _personasPorCi(personas);
    final tiposById = _byKey(tipos, 'id_tipo');
    final estadosPrestamoById = _byKey(estadosPrestamo, 'id_estado');
    final estadosCuotaById = _byKey(estadosCuota, 'id_estado');
    final planesById = _byKey(planes, 'id_plan');
    final saldoPrestamoById = <String, double>{};

    for (final cuota in cuotas) {
      final plan = planesById[cuota['id_plan']?.toString() ?? ''];
      final idPrestamo = cuota['id_prestamo'] ?? plan?['id_prestamo'];
      if (idPrestamo == null) continue;
      final estado = cuota['estado']?.toString().toUpperCase() ?? '';
      if (estado == 'PAGADA' || estado == 'PAGADO') continue;
      final saldo = _toDouble(
        cuota['saldo_pendiente'] ?? cuota['saldo_restante'],
      );
      final monto = _toDouble(cuota['monto_cuota'] ?? cuota['monto_total']);
      saldoPrestamoById[idPrestamo.toString()] =
          (saldoPrestamoById[idPrestamo.toString()] ?? 0) +
          (saldo > 0 ? saldo : monto);
    }

    final result = <Map<String, dynamic>>[];

    for (final cuotaOriginal in cuotas) {
      final cuota = Map<String, dynamic>.from(cuotaOriginal);
      final plan = planesById[cuota['id_plan']?.toString() ?? ''];
      final idPrestamo = cuota['id_prestamo'] ?? plan?['id_prestamo'];
      if (idPrestamo == null) continue;

      final prestamoOriginal = prestamosById[idPrestamo.toString()];
      if (prestamoOriginal == null) continue;
      if (access.isCobrador &&
          _toInt(prestamoOriginal['id_cobrador']) != access.idCobrador) {
        continue;
      }

      final prestamo = Map<String, dynamic>.from(prestamoOriginal);
      final cliente = clientesById[prestamo['id_cliente']?.toString() ?? ''];
      if (cliente == null) continue;

      final clienteConPersona = {
        ...cliente,
        'persona': personasByCi[cliente['ci_persona']?.toString() ?? ''],
      };
      final estadoPrestamo =
          estadosPrestamoById[prestamo['id_estado']?.toString() ?? ''];
      final tipoPrestamo = tiposById[prestamo['id_tipo']?.toString() ?? ''];
      final estadoCuota =
          estadosCuotaById[cuota['id_estado']?.toString() ?? ''];

      cuota['id_prestamo'] = idPrestamo;
      cuota['monto_cuota'] ??= cuota['monto_total'];
      cuota['capital'] ??= cuota['monto_capital'];
      cuota['interes'] ??= cuota['monto_interes'];
      cuota['saldo_pendiente'] ??= cuota['saldo_restante'];
      cuota['estado'] = _estadoCuota(cuota, estadoCuota);
      cuota['prestamo'] = {
        ...prestamo,
        'saldo_pendiente_calculado':
            saldoPrestamoById[idPrestamo.toString()] ?? 0,
        'tipo_prestamo': tipoPrestamo ?? {'nombre': 'Sin tipo'},
        'estado_prestamo': estadoPrestamo ?? {'nombre': 'ACTIVO'},
        'cliente': clienteConPersona,
      };

      if (_esCuotaCobrable(cuota)) {
        result.add(cuota);
      }
    }

    result.sort((a, b) {
      final fechaA = DateTime.tryParse(
        a['fecha_vencimiento']?.toString() ?? '',
      );
      final fechaB = DateTime.tryParse(
        b['fecha_vencimiento']?.toString() ?? '',
      );
      return (fechaA ?? DateTime(2100)).compareTo(fechaB ?? DateTime(2100));
    });

    return result;
  }

  Future<List<Map<String, dynamic>>> listarPagos() async {
    final access = await roleService.currentAccess();
    final pagos = await _listarOrdenado(
      table: 'pago',
      orderColumn: 'fecha_pago',
      ascending: false,
    );
    final cuotas = await _listarSeguro('cuota');
    final prestamos = await _listarSeguro('prestamo');
    final clientes = await _listarSeguro('cliente');
    final personas = await _listarSeguro('persona');

    final cuotasById = _byKey(cuotas, 'id_cuota');
    final prestamosById = _byKey(prestamos, 'id_prestamo');
    final clientesById = _byKey(clientes, 'id_cliente');
    final personasByCi = _personasPorCi(personas);

    return pagos
        .map((pagoOriginal) {
          final pago = Map<String, dynamic>.from(pagoOriginal);
          final cuota = Map<String, dynamic>.from(
            cuotasById[pago['id_cuota']?.toString() ?? ''] ?? {},
          );
          final idPrestamo = pago['id_prestamo'] ?? cuota['id_prestamo'];
          final prestamo = Map<String, dynamic>.from(
            prestamosById[idPrestamo?.toString() ?? ''] ?? {},
          );
          final cliente =
              clientesById[prestamo['id_cliente']?.toString() ?? ''];

          cuota['id_prestamo'] = idPrestamo;
          cuota['prestamo'] = {
            ...prestamo,
            'cliente': {
              ...?cliente,
              'persona': personasByCi[cliente?['ci_persona']?.toString() ?? ''],
            },
          };
          pago['cuota'] = cuota;
          return pago;
        })
        .where((pago) {
          if (!access.isCobrador) return true;
          final prestamo = pago['cuota']?['prestamo'];
          return _toInt(prestamo?['id_cobrador']) == access.idCobrador;
        })
        .toList();
  }

  Future<List<Map<String, dynamic>>> _listarOrdenado({
    required String table,
    required String orderColumn,
    bool ascending = true,
  }) async {
    try {
      final response = await localDb
          .from(table)
          .select()
          .order(orderColumn, ascending: ascending);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return _listarSeguro(table);
    }
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(String table) async {
    try {
      final response = await localDb.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  Map<String, Map<String, dynamic>> _byKey(
    List<Map<String, dynamic>> rows,
    String key,
  ) {
    return {
      for (final row in rows)
        if (row[key] != null) row[key].toString(): row,
    };
  }

  Map<String, Map<String, dynamic>> _personasPorCi(
    List<Map<String, dynamic>> rows,
  ) {
    return {
      for (final row in rows)
        if (row['ci'] != null) row['ci'].toString(): row,
      for (final row in rows)
        if (row['ci_persona'] != null) row['ci_persona'].toString(): row,
    };
  }

  String _estadoCuota(
    Map<String, dynamic> cuota,
    Map<String, dynamic>? estadoCuota,
  ) {
    final estadoPlano = cuota['estado']?.toString().trim();
    if (estadoPlano != null && estadoPlano.isNotEmpty) return estadoPlano;
    final estadoCatalogo = estadoCuota?['nombre']?.toString().trim();
    if (estadoCatalogo != null && estadoCatalogo.isNotEmpty) {
      return estadoCatalogo;
    }
    return _toDouble(cuota['saldo_pendiente'] ?? cuota['saldo_restante']) <= 0
        ? 'PAGADA'
        : 'PENDIENTE';
  }

  bool _esCuotaCobrable(Map<String, dynamic> cuota) {
    final prestamoEstado =
        cuota['prestamo']?['estado_prestamo']?['nombre']
            ?.toString()
            .toUpperCase() ??
        '';
    final cuotaEstado = cuota['estado']?.toString().toUpperCase() ?? '';
    final saldo = _toDouble(
      cuota['saldo_pendiente'] ?? cuota['saldo_restante'],
    );
    final monto = _toDouble(cuota['monto_cuota'] ?? cuota['monto_total']);

    final prestamoActivo =
        prestamoEstado.isEmpty ||
        prestamoEstado == 'ACTIVO' ||
        prestamoEstado == 'MORA';
    final cuotaPendiente =
        cuotaEstado != 'PAGADA' &&
        cuotaEstado != 'PAGADO' &&
        (saldo > 0 || monto > 0);

    return prestamoActivo && cuotaPendiente;
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
