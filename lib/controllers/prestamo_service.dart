import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/database_config.dart';

import 'package:sist_prestamo/models/prestamo_model.dart';

class PrestamoService {
  // ==============================
  // PATRON SINGLETON
  // PrestamoService utiliza Singleton
  // para garantizar una unica instancia
  // durante toda la ejecucion del sistema.
  // Defensa: Patron Creacional.
  // Razon en Cuentas Claras: centraliza
  // operaciones de prestamos, planes y cuotas.
  // ==============================
  static final PrestamoService _instance = PrestamoService._internal();

  factory PrestamoService() {
    return _instance;
  }

  PrestamoService._internal();

  final localDb = DatabaseConfig.client;

  // =========================
  // INSERTAR PRESTAMO
  // =========================

  Future<int?> insertarPrestamo(PrestamoModel prestamo) async {
    try {
      _validarInteresPermitido(prestamo.interes);
      final payload = prestamo.toJson();
      payload['id_estado'] =
          await _idEstadoPrestamo('ACTIVO') ?? payload['id_estado'];

      final response = await localDb
          .from('prestamo')
          .insert(payload)
          .select('id_prestamo')
          .single();

      final int id = response['id_prestamo'];
      return id;
    } catch (e) {
      debugPrint('ERROR INSERTAR PRESTAMO: $e');
      rethrow;
    }
  }

  // =========================
  // LISTAR PRESTAMOS
  // =========================

  Future<List<Map<String, dynamic>>> listarPrestamos() async {
    try {
      final prestamos = await _listarSeguro('prestamo');
      final clientes = await _listarSeguro('cliente');
      final personas = await _listarSeguro('persona');
      final tipos = await listarTiposPrestamo();
      final estados = await listarEstadosPrestamo();
      final cuotas = await _listarSeguro('cuota');

      final personasByCi = {
        ..._byKey(personas, 'ci'),
        ..._byKey(personas, 'ci_persona'),
      };
      final clientesById = _byKey(clientes, 'id_cliente');
      final tiposById = _byKey(tipos, 'id_tipo');
      final estadosById = _byKey(estados, 'id_estado');
      final estadosByNombre = _byNormalizedName(estados);
      final cuotasByPrestamo = <String, List<Map<String, dynamic>>>{};
      for (final cuota in cuotas) {
        final idPrestamo = cuota['id_prestamo']?.toString();
        if (idPrestamo == null || idPrestamo.isEmpty) continue;
        cuotasByPrestamo.putIfAbsent(idPrestamo, () => []).add(cuota);
      }

      final enlazados =
          prestamos.map((prestamo) {
            final cliente = Map<String, dynamic>.from(
              clientesById[prestamo['id_cliente']?.toString() ?? ''] ?? {},
            );
            cliente['persona'] =
                personasByCi[cliente['ci_persona']?.toString() ?? ''];

            final cuotasPrestamo =
                cuotasByPrestamo[prestamo['id_prestamo']?.toString() ?? ''] ??
                <Map<String, dynamic>>[];
            final estadoCalculado = _estadoCalculadoDesdeCuotas(cuotasPrestamo);

            return {
              ...prestamo,
              'cliente': cliente.isEmpty ? null : cliente,
              'tipo_prestamo': tiposById[prestamo['id_tipo']?.toString() ?? ''],
              'estado_prestamo':
                  estadosByNombre[estadoCalculado] ??
                  estadosById[prestamo['id_estado']?.toString() ?? ''],
              'cuotas': cuotasPrestamo,
            };
          }).toList()..sort(
            (a, b) => (b['id_prestamo'] ?? 0).compareTo(a['id_prestamo'] ?? 0),
          );

      return enlazados;
    } catch (e) {
      debugPrint('ERROR LISTAR PRESTAMOS: $e');

      return [];
    }
  }

  Future<int> contarPrestamosActivosCliente(int idCliente) async {
    final prestamos = await listarPrestamos();
    return prestamos.where((prestamo) {
      if (prestamo['id_cliente'] != idCliente) return false;
      final estado =
          prestamo['estado_prestamo']?['nombre']?.toString().toUpperCase() ??
          '';
      return estado == 'ACTIVO' || estado == 'MORA' || estado.isEmpty;
    }).length;
  }

  // =========================
  // LISTAR TIPOS PRESTAMO
  // =========================

  Future<List<Map<String, dynamic>>> listarTiposPrestamo() async {
    try {
      final response = await localDb
          .from('tipo_prestamo')
          .select()
          .order('id_tipo');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('ERROR LISTAR TIPOS PRESTAMO: $e');

      return [];
    }
  }

  // =========================
  // LISTAR ESTADOS PRESTAMO
  // =========================

  Future<List<Map<String, dynamic>>> listarEstadosPrestamo() async {
    try {
      final response = await localDb
          .from('estado_prestamo')
          .select()
          .order('id_estado');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('ERROR LISTAR ESTADOS PRESTAMO: $e');

      return [];
    }
  }

  // =========================
  // CREAR CATALOGOS BASE
  // =========================

  Future<void> asegurarCatalogosBase() async {
    final tipos = await listarTiposPrestamo();
    final estados = await listarEstadosPrestamo();

    if (tipos.isEmpty) {
      await localDb.from('tipo_prestamo').upsert([
        {'id_tipo': 1, 'nombre': 'Gota a gota'},
        {'id_tipo': 2, 'nombre': 'Mensual'},
        {'id_tipo': 3, 'nombre': 'Frances'},
        {'id_tipo': 4, 'nombre': 'Amortizacion Universal'},
      ], onConflict: 'id_tipo');
    }

    if (estados.isEmpty) {
      await localDb.from('estado_prestamo').upsert([
        {'id_estado': 1, 'nombre': 'ACTIVO'},
        {'id_estado': 2, 'nombre': 'PAGADO'},
        {'id_estado': 3, 'nombre': 'MORA'},
        {'id_estado': 4, 'nombre': 'CANCELADO'},
      ], onConflict: 'id_estado');
    }
  }

  // =========================
  // ACTUALIZAR PRESTAMO
  // =========================

  Future<void> actualizarPrestamo(PrestamoModel prestamo) async {
    try {
      _validarInteresPermitido(prestamo.interes);
      final payload = prestamo.toJson();
      final id = prestamo.idPrestamo;
      if (id != null) {
        final estadoCalculado = await _estadoCalculadoPrestamo(id);
        payload['id_estado'] =
            await _idEstadoPrestamo(estadoCalculado) ?? payload['id_estado'];
      }
      await localDb
          .from('prestamo')
          .update(payload)
          .eq('id_prestamo', prestamo.idPrestamo!);
    } catch (e) {
      debugPrint('ERROR ACTUALIZAR PRESTAMO: $e');
      rethrow;
    }
  }

  // ======================================
  // REGLA DE NEGOCIO
  // El interés permitido debe estar
  // entre 0% y 20%.
  // ======================================
  void _validarInteresPermitido(double interes) {
    if (interes < 0) {
      throw Exception('El interés no puede ser negativo.');
    }
    if (interes > 20) {
      throw Exception('El interés máximo permitido es 20%.');
    }
  }

  Future<void> actualizarEstadoAutomaticoPrestamo(int idPrestamo) async {
    final estadoNombre = await _estadoCalculadoPrestamo(idPrestamo);
    final idEstado = await _idEstadoPrestamo(estadoNombre);
    if (idEstado == null) {
      debugPrint('No existe el estado de prestamo $estadoNombre');
      return;
    }

    await localDb
        .from('prestamo')
        .update({'id_estado': idEstado})
        .eq('id_prestamo', idPrestamo);
  }

  Future<String> _estadoCalculadoPrestamo(int idPrestamo) async {
    final cuotas = (await _listarSeguro('cuota')).where((cuota) {
      return _toInt(cuota['id_prestamo']) == idPrestamo;
    }).toList();

    if (cuotas.isEmpty) return 'ACTIVO';

    final todasPagadas = cuotas.every(_cuotaPagada);
    if (todasPagadas) return 'CANCELADO';

    final hayMora = cuotas.any(_cuotaEnMora);
    if (hayMora) return 'MORA';

    return 'ACTIVO';
  }

  bool _cuotaPagada(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().trim().toUpperCase() ?? '';
    final saldo = _toDouble(
      cuota['saldo_pendiente'] ?? cuota['saldo_restante'],
    );
    final monto = _toDouble(cuota['monto_cuota'] ?? cuota['monto_total']);
    return estado == 'PAGADA' ||
        estado == 'PAGADO' ||
        (monto > 0 && saldo <= 0);
  }

  bool _cuotaEnMora(Map<String, dynamic> cuota) {
    if (_cuotaPagada(cuota)) return false;
    final estado = cuota['estado']?.toString().trim().toUpperCase() ?? '';
    if (estado == 'MORA') return true;
    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return false;
    final hoy = DateTime.now();
    final actual = DateTime(hoy.year, hoy.month, hoy.day);
    final vencimiento = DateTime(fecha.year, fecha.month, fecha.day);
    return vencimiento.isBefore(actual);
  }

  Future<int?> _idEstadoPrestamo(String nombre) async {
    final estados = await _listarSeguro('estado_prestamo');
    final buscado = nombre.trim().toUpperCase();
    for (final estado in estados) {
      if (estado['nombre']?.toString().trim().toUpperCase() == buscado) {
        return _toInt(estado['id_estado']);
      }
    }
    return null;
  }

  Future<void> cancelarPrestamo(int idPrestamo) async {
    try {
      final estadoCancelado = await localDb
          .from('estado_prestamo')
          .select('id_estado')
          .eq('nombre', 'CANCELADO')
          .maybeSingle();

      final idEstado = estadoCancelado?['id_estado'];

      if (idEstado == null) {
        throw Exception('No existe el estado CANCELADO');
      }

      await localDb
          .from('prestamo')
          .update({'id_estado': idEstado})
          .eq('id_prestamo', idPrestamo);
    } catch (e) {
      debugPrint('ERROR CANCELAR PRESTAMO: $e');
      rethrow;
    }
  }

  Future<void> registrarGarantes(
    int idPrestamo,
    List<Map<String, dynamic>> garantes,
  ) async {
    if (garantes.length > 2) {
      throw Exception('Solo se permiten maximo 2 garantes por prestamo.');
    }
    for (final garante in garantes) {
      final idCliente = garante['id_cliente'];
      if (idCliente == null) continue;
      await localDb.from('prestamo_garante').upsert({
        'id_prestamo': idPrestamo,
        'id_cliente': idCliente,
      });
    }
  }

  Future<void> registrarArticulosGarantia(
    int idPrestamo,
    List<Map<String, dynamic>> articulos,
  ) async {
    for (final articulo in articulos) {
      final descripcion = articulo['descripcion']?.toString().trim() ?? '';
      final valor = _toDouble(articulo['valor_estimado']);
      if (descripcion.isEmpty) {
        throw Exception(
          'La descripcion del articulo en garantia es obligatoria.',
        );
      }
      if (valor <= 0) {
        throw Exception(
          'El valor estimado del articulo debe ser mayor a cero.',
        );
      }

      final response = await localDb
          .from('garantia')
          .insert({
            'descripcion': descripcion,
            'fotografia': articulo['fotografia'] ?? '',
            'url_referencia': articulo['url_referencia'] ?? '',
            'valor_estimado': valor,
            'estado': true,
          })
          .select('id_garantia')
          .single();

      final idGarantia = response['id_garantia'];
      if (idGarantia == null) {
        throw Exception('No se pudo registrar la garantia del articulo.');
      }

      await localDb.from('prestamo_garantia').insert({
        'id_prestamo': idPrestamo,
        'id_garantia': idGarantia,
      });

      await localDb
          .from('prestamo')
          .update({'id_garantia': idGarantia})
          .eq('id_prestamo', idPrestamo)
          .isFilter('id_garantia', null);
    }
  }

  // =========================
  // ELIMINAR PRESTAMO
  // =========================

  Future<void> eliminarPrestamo(int idPrestamo) async {
    try {
      await cancelarPrestamo(idPrestamo);
    } catch (e) {
      debugPrint('ERROR ELIMINAR PRESTAMO: $e');
      rethrow;
    }
  }

  // =========================
  // INSERTAR LOTES DE CUOTAS
  // =========================
  Future<void> insertarCuotas(List<Map<String, dynamic>> cuotas) async {
    for (final cuotaPayload in cuotas) {
      try {
        await localDb.from('cuota').insert(cuotaPayload);
      } catch (e) {
        debugPrint('ERROR CUOTA: $e');
        rethrow;
      }
    }
  }

  Future<int> crearPlanPagos({
    required int idPrestamo,
    required int numeroCuotas,
    required String frecuenciaPago,
  }) async {
    final planPayload = {
      'id_prestamo': idPrestamo,
      'numero_cuotas': numeroCuotas,
      'frecuencia_pago': frecuenciaPago,
    };

    try {
      final response = await localDb
          .from('plan_pagos')
          .insert(planPayload)
          .select('id_plan')
          .single();
      final idPlan = response['id_plan'];
      if (idPlan is int) return idPlan;
      final parsed = int.tryParse(idPlan?.toString() ?? '');
      if (parsed == null) {
        throw Exception('plan_pagos no devolvio id_plan valido: $response');
      }
      return parsed;
    } catch (e) {
      debugPrint('ERROR PLAN_PAGOS: $e');
      rethrow;
    }
  }

  String _estadoCalculadoDesdeCuotas(List<Map<String, dynamic>> cuotas) {
    if (cuotas.isEmpty) return 'ACTIVO';
    if (cuotas.every(_cuotaPagada)) return 'CANCELADO';
    if (cuotas.any(_cuotaEnMora)) return 'MORA';
    return 'ACTIVO';
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(String tabla) async {
    try {
      final response = await localDb.from(tabla).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      debugPrint('NO SE PUDO LISTAR $tabla: $e');
      return [];
    }
  }

  Map<String, Map<String, dynamic>> _byKey(
    List<Map<String, dynamic>> items,
    String key,
  ) {
    return {
      for (final item in items)
        if (item[key] != null) item[key].toString(): item,
    };
  }

  Map<String, Map<String, dynamic>> _byNormalizedName(
    List<Map<String, dynamic>> items,
  ) {
    return {
      for (final item in items)
        if (item['nombre'] != null)
          item['nombre'].toString().trim().toUpperCase(): item,
    };
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
