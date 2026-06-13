import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

class DashboardService {
  final localDb = DatabaseConfig.client;
  final roleService = RoleService();

  Future<Map<String, dynamic>> cargarDashboard() async {
    final access = await roleService.currentAccess();
    final hoy = DateTime.now();
    final hoyTexto = _date(hoy);
    final inicioMes = DateTime(hoy.year, hoy.month, 1);
    final finMes = DateTime(hoy.year, hoy.month + 1, 0);

    final estados = await _listarSeguro('estado_prestamo');
    final clientes = await _listarSeguro('cliente');
    final personas = await _listarSeguro('persona');
    final prestamosBase = await _listarSeguro('prestamo');
    final cuotasBase = await _listarSeguro('cuota');
    final planes = await _listarSeguro('plan_pagos');
    final estadosCuota = await _listarSeguro('estado_cuota');
    final pagos = await _listarSeguro('pago');

    final estadosById = _byKey(estados, 'id_estado');
    final estadosCuotaById = _byKey(estadosCuota, 'id_estado');
    final clientesById = _byKey(clientes, 'id_cliente');
    final planesById = _byKey(planes, 'id_plan');
    final personasByCi = {
      ..._byKey(personas, 'ci'),
      ..._byKey(personas, 'ci_persona'),
    };

    var prestamos = prestamosBase.map((prestamo) {
      final cliente = Map<String, dynamic>.from(
        clientesById[prestamo['id_cliente']?.toString() ?? ''] ?? {},
      );
      cliente['persona'] =
          personasByCi[cliente['ci_persona']?.toString() ?? ''];
      return {
        ...prestamo,
        'cliente': cliente.isEmpty ? null : cliente,
        'estado_prestamo': estadosById[prestamo['id_estado']?.toString() ?? ''],
      };
    }).toList();

    if (access.isCobrador) {
      prestamos = prestamos
          .where(
            (prestamo) => _toInt(prestamo['id_cobrador']) == access.idCobrador,
          )
          .toList();
    }

    final prestamosById = _byKey(prestamos, 'id_prestamo');
    final cuotas = cuotasBase.map((cuota) {
      final plan = planesById[cuota['id_plan']?.toString() ?? ''];
      final idPrestamo = cuota['id_prestamo'] ?? plan?['id_prestamo'];
      final estadoCuota =
          estadosCuotaById[cuota['id_estado']?.toString() ?? ''];
      final copy = Map<String, dynamic>.from(cuota);
      copy['id_prestamo'] = idPrestamo;
      copy['monto_cuota'] ??= copy['monto_total'];
      copy['capital'] ??= copy['monto_capital'];
      copy['interes'] ??= copy['monto_interes'];
      copy['saldo_pendiente'] ??= copy['saldo_restante'];
      copy['estado'] = (copy['estado']?.toString().isNotEmpty == true)
          ? copy['estado']
          : estadoCuota?['nombre'];
      return {...copy, 'prestamo': prestamosById[idPrestamo?.toString() ?? '']};
    }).toList();

    final clientesPermitidos = prestamos
        .map((prestamo) => _toInt(prestamo['id_cliente']))
        .whereType<int>()
        .toSet();
    final cuotasPermitidas = cuotas
        .map((cuota) => _toInt(cuota['id_cuota']))
        .whereType<int>()
        .toSet();
    final prestamosPermitidos = prestamos
        .map((prestamo) => _toInt(prestamo['id_prestamo']))
        .whereType<int>()
        .toSet();

    final clientesFiltrados = access.isCobrador
        ? clientes
              .where(
                (cliente) =>
                    clientesPermitidos.contains(_toInt(cliente['id_cliente'])),
              )
              .toList()
        : clientes;
    final cuotasFiltradas = access.isCobrador
        ? cuotas.where((cuota) => cuota['prestamo'] != null).toList()
        : cuotas;

    final pagosHoy = pagos.where((pago) {
      if (pago['fecha_pago']?.toString() != hoyTexto) return false;
      return !access.isCobrador ||
          _pagoPerteneceCobrador(pago, cuotasPermitidas, prestamosPermitidos);
    }).toList();

    final desde = _date(inicioMes);
    final hasta = _date(finMes);
    final pagosMes = pagos.where((pago) {
      final fecha = pago['fecha_pago']?.toString() ?? '';
      final enRango =
          fecha.compareTo(desde) >= 0 && fecha.compareTo(hasta) <= 0;
      return enRango &&
          (!access.isCobrador ||
              _pagoPerteneceCobrador(
                pago,
                cuotasPermitidas,
                prestamosPermitidos,
              ));
    }).toList();

    return {
      'prestamos': List<Map<String, dynamic>>.from(prestamos),
      'clientes': List<Map<String, dynamic>>.from(clientesFiltrados),
      'cuotas': List<Map<String, dynamic>>.from(cuotasFiltradas),
      'pagos_hoy': List<Map<String, dynamic>>.from(pagosHoy),
      'pagos_mes': List<Map<String, dynamic>>.from(pagosMes),
    };
  }

  bool _pagoPerteneceCobrador(
    Map<String, dynamic> pago,
    Set<int> cuotasPermitidas,
    Set<int> prestamosPermitidos,
  ) {
    final idPrestamo = _toInt(pago['id_prestamo']);
    if (idPrestamo != null && prestamosPermitidos.contains(idPrestamo)) {
      return true;
    }
    final idCuota = _toInt(pago['id_cuota']);
    return idCuota != null && cuotasPermitidas.contains(idCuota);
  }

  String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
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

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
