import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/local_model_adapter.dart';
import 'package:sist_prestamo/controllers/role_guard.dart';
import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

import 'package:sist_prestamo/models/pago_model.dart';
import 'package:sist_prestamo/controllers/prestamo_service.dart';

class PagoService {
  // ==============================
  // PATRON SINGLETON
  // PagoService utiliza Singleton
  // para garantizar una unica instancia
  // durante toda la ejecucion del sistema.
  // Defensa: Patron Creacional.
  // Razon en Cuentas Claras: centraliza
  // pagos y actualizacion de cuotas.
  // ==============================
  static final PagoService _instance = PagoService._internal();

  factory PagoService() {
    return _instance;
  }

  PagoService._internal();

  final localDb = DatabaseConfig.client;
  final roleService = RoleService();

  final prestamoService = PrestamoService();

  // =========================
  // INSERTAR
  // =========================

  Future<void> insertarPago(PagoModel pago) async {
    try {
      final cuotas = await _listarCuotasEnlazadas();
      final cuotaResponse = cuotas.firstWhere(
        (cuota) => cuota['id_cuota'] == pago.cuotaId,
        orElse: () => <String, dynamic>{},
      );

      if (cuotaResponse.isEmpty) {
        throw Exception('No se encontro la cuota seleccionada.');
      }

      final payload = pago.toJson();
      payload['id_prestamo'] ??= cuotaResponse['id_prestamo'];

      await _insertarPagoSeguro(payload);
      debugPrint('PAGO REGISTRADO');

      debugPrint('PAGO INSERTADO');

      final double actualSaldo = _saldoCuota(cuotaResponse);

      // 3. Calcular nuevo saldo y estado
      final double nuevoSaldo = (actualSaldo - (pago.monto + pago.descuento))
          .clamp(0.0, double.infinity);
      final String nuevoEstado = nuevoSaldo <= 0.1 ? 'PAGADO' : 'PENDIENTE';

      // 4. Actualizar la cuota en Base local
      await _actualizarCuotaPago(
        idCuota: pago.cuotaId,
        saldo: nuevoSaldo,
        estado: nuevoEstado,
        fecha: DateTime.now().toIso8601String().substring(0, 10),
      );
      await _actualizarEstadoPrestamoSiCorresponde(
        payload['id_prestamo'] ?? cuotaResponse['id_prestamo'],
      );

      debugPrint(
        'CUOTA ACTUALIZADA: nuevo saldo $nuevoSaldo, estado $nuevoEstado',
      );
    } catch (e) {
      debugPrint('ERROR INSERTAR PAGO: $e');

      rethrow;
    }
  }

  Future<void> registrarPagoEnCuota({
    required int idCuota,
    required double monto,
    required String fecha,
    required String metodoPago,
    String observacion = '',
    double mora = 0,
    double descuento = 0,
    String tipoPago = 'NORMAL',
  }) async {
    final pago = PagoModel(
      cuotaId: idCuota,
      monto: monto,
      fecha: fecha,
      metodoPago: metodoPago,
      observacion: observacion,
      pagoCompleto: true,
      tipoPago: tipoPago,
      estadoPago: 'COMPLETO',
      cuotasIds: [idCuota],
      mora: mora,
      descuento: descuento,
    );

    await insertarPago(pago);
  }

  Future<void> registrarPagosCuotas({
    required List<Map<String, dynamic>> cuotas,
    required double montoTotal,
    required String fecha,
    required String metodoPago,
    required String observacion,
    String tipoPago = 'NORMAL',
  }) async {
    if (cuotas.isEmpty) return;

    final cuotasOrdenadas = _ordenarCuotas(cuotas);
    final totalSeleccionado = cuotasOrdenadas.fold<double>(
      0,
      (total, cuota) => total + _saldoCuota(cuota),
    );
    final idPrestamo = cuotasOrdenadas.first['id_prestamo'];
    final ids = cuotasOrdenadas
        .map((cuota) => cuota['id_cuota'] as int)
        .toList();

    await _validarSeleccionConsecutiva(cuotasOrdenadas);

    await _insertarPagoSeguro({
      'id_cuota': ids.first,
      'id_prestamo': idPrestamo,
      'monto': totalSeleccionado,
      'fecha_pago': fecha,
      'metodo_pago': metodoPago,
      'observacion': observacion,
      'pago_completo': true,
      'tipo_pago': tipoPago,
      'estado_pago': 'COMPLETO',
      'cuotas_ids': ids,
      'mora': 0,
      'descuento': 0,
    });
    debugPrint('PAGO REGISTRADO');

    for (final cuota in cuotasOrdenadas) {
      await _marcarCuotaPagada(_toInt(cuota['id_cuota']) ?? 0, fecha);
    }

    await _actualizarEstadoPrestamoSiCorresponde(idPrestamo);
  }

  Future<void> registrarAmortizacion({
    required int idPrestamo,
    required double monto,
    required String fecha,
    required String metodoPago,
    required String observacion,
  }) async {
    final cuotas = await listarCuotasPendientesPorPrestamo(idPrestamo);
    if (cuotas.isEmpty) return;

    final cuotasOrdenadas = _ordenarCuotas(cuotas);
    final totalPendiente = cuotasOrdenadas.fold<double>(
      0,
      (total, cuota) => total + _saldoCuota(cuota),
    );
    final montoAplicado = monto > totalPendiente ? totalPendiente : monto;
    var restante = montoAplicado;
    final idsAfectadas = <int>[];

    await _insertarPagoSeguro({
      'id_cuota': cuotasOrdenadas.first['id_cuota'],
      'id_prestamo': idPrestamo,
      'monto': montoAplicado,
      'fecha_pago': fecha,
      'metodo_pago': metodoPago,
      'observacion': observacion.isEmpty ? 'Amortizacion parcial' : observacion,
      'pago_completo': montoAplicado >= totalPendiente,
      'tipo_pago': 'AMORTIZACION',
      'estado_pago': montoAplicado >= totalPendiente ? 'COMPLETO' : 'PARCIAL',
      'cuotas_ids': cuotasOrdenadas.map((cuota) => cuota['id_cuota']).toList(),
      'mora': 0,
      'descuento': 0,
    });
    debugPrint('PAGO REGISTRADO');

    for (final cuota in cuotasOrdenadas) {
      if (restante <= 0) break;
      final saldo = _saldoCuota(cuota);
      final aplicado = restante >= saldo ? saldo : restante;
      final nuevoSaldo = (saldo - aplicado).clamp(0.0, double.infinity);
      idsAfectadas.add(cuota['id_cuota']);

      await _actualizarCuotaPago(
        idCuota: _toInt(cuota['id_cuota']) ?? 0,
        saldo: nuevoSaldo,
        estado: nuevoSaldo <= 0.1 ? 'PAGADO' : 'PENDIENTE',
        fecha: nuevoSaldo <= 0.1 ? fecha : null,
      );

      restante -= aplicado;
    }

    await _recalcularPlanRestante(idPrestamo);
    await _actualizarEstadoPrestamoSiCorresponde(idPrestamo);
  }

  Future<void> _insertarPagoSeguro(Map<String, dynamic> payload) async {
    try {
      await localDb.from('pago').insert(payload);
    } catch (e) {
      final minimo = <String, dynamic>{
        if (payload['id_cuota'] != null) 'id_cuota': payload['id_cuota'],
        if (payload['id_prestamo'] != null)
          'id_prestamo': payload['id_prestamo'],
        'monto': payload['monto'],
        'fecha_pago': payload['fecha_pago'],
        'metodo_pago': payload['metodo_pago'],
        'observacion': payload['observacion'] ?? '',
      };
      try {
        await localDb.from('pago').insert(minimo);
      } catch (_) {
        final ultraMinimo = <String, dynamic>{
          if (payload['id_cuota'] != null) 'id_cuota': payload['id_cuota'],
          'monto': payload['monto'],
          'fecha_pago': payload['fecha_pago'],
        };
        await localDb.from('pago').insert(ultraMinimo);
      }
    }
  }

  Future<void> _actualizarCuotaPago({
    required int idCuota,
    required double saldo,
    required String estado,
    required String? fecha,
  }) async {
    if (idCuota <= 0) return;
    final payload = {
      'saldo_pendiente': saldo,
      'saldo_restante': saldo,
      'estado': estado,
      'fecha_pago': fecha,
    };
    await localDb.from('cuota').update(payload).eq('id_cuota', idCuota);
  }

  Future<List<Map<String, dynamic>>> listarClientesConCuotas() async {
    final clientes = await listarClientesActivos();
    final prestamos = await _listarPrestamosEnlazados();
    final todasCuotas = await _listarCuotasEnlazadas();
    final clientesPorId = <int, Map<String, dynamic>>{};
    final prestamosPorCliente = <int, List<Map<String, dynamic>>>{};

    for (final cliente in clientes) {
      final idCliente = _toInt(cliente['id_cliente']);
      if (idCliente == null) continue;

      clientesPorId[idCliente] = {
        ...Map<String, dynamic>.from(cliente),
        'cuotas': <Map<String, dynamic>>[],
        'cuotas_pendientes': <Map<String, dynamic>>[],
        'prestamos_activos': <Map<String, dynamic>>[],
      };
    }

    for (final prestamo in prestamos) {
      final idCliente = _toInt(prestamo['id_cliente']);
      if (idCliente == null) continue;
      if (!_prestamoActivo(prestamo)) continue;
      prestamosPorCliente.putIfAbsent(idCliente, () => []).add({
        ...prestamo,
        'cuotas': <Map<String, dynamic>>[],
        'cuotas_pendientes': <Map<String, dynamic>>[],
        'saldo_pendiente_calculado': 0.0,
      });
    }

    for (final cuota in todasCuotas) {
      final prestamo = cuota['prestamo'];
      final cliente = prestamo?['cliente'];
      final idCliente = _toInt(cliente?['id_cliente']);
      final idPrestamo = _toInt(
        cuota['id_prestamo'] ?? prestamo?['id_prestamo'],
      );
      final pendiente = _cuotaPendiente(cuota);

      if (idCliente == null) continue;

      clientesPorId.putIfAbsent(idCliente, () {
        return {
          ...Map<String, dynamic>.from(cliente),
          'cuotas': <Map<String, dynamic>>[],
          'cuotas_pendientes': <Map<String, dynamic>>[],
          'prestamos_activos': <Map<String, dynamic>>[],
        };
      });

      (clientesPorId[idCliente]!['cuotas'] as List<Map<String, dynamic>>).add(
        cuota,
      );

      if (pendiente) {
        (clientesPorId[idCliente]!['cuotas_pendientes']
                as List<Map<String, dynamic>>)
            .add(cuota);
      }

      final prestamosCliente = prestamosPorCliente[idCliente] ?? [];
      Map<String, dynamic>? prestamoCliente;
      for (final item in prestamosCliente) {
        if (_toInt(item['id_prestamo']) == idPrestamo) {
          prestamoCliente = item;
          break;
        }
      }
      if (prestamoCliente != null) {
        (prestamoCliente['cuotas'] as List<Map<String, dynamic>>).add(cuota);
        if (pendiente) {
          (prestamoCliente['cuotas_pendientes'] as List<Map<String, dynamic>>)
              .add(cuota);
          prestamoCliente['saldo_pendiente_calculado'] =
              _toDouble(prestamoCliente['saldo_pendiente_calculado']) +
              _saldoCuota(cuota);
        }
      }
    }

    for (final entry in prestamosPorCliente.entries) {
      final cliente = clientesPorId[entry.key];
      if (cliente == null) continue;
      final list = entry.value
        ..sort(
          (a, b) => (a['id_prestamo'] ?? 0).compareTo(b['id_prestamo'] ?? 0),
        );
      cliente['prestamos_activos'] = list;
    }

    final result = clientesPorId.values.where((cliente) {
      final prestamosActivos = List<Map<String, dynamic>>.from(
        cliente['prestamos_activos'] ?? [],
      );
      final cuotasPendientes = List<Map<String, dynamic>>.from(
        cliente['cuotas_pendientes'] ?? [],
      );
      return prestamosActivos.isNotEmpty || cuotasPendientes.isNotEmpty;
    }).toList();
    result.sort((a, b) => _nombreCliente(a).compareTo(_nombreCliente(b)));
    return result;
  }

  Future<List<Map<String, dynamic>>> listarClientesActivos() async {
    try {
      final clientes = await _listarOrdenado('cliente', 'id_cliente');
      final personas = await _listarSeguro('persona');
      final personasByCi = {
        ..._byKey(personas, 'ci'),
        ..._byKey(personas, 'ci_persona'),
      };

      return clientes.where((cliente) => cliente['estado'] != false).map((
        cliente,
      ) {
        return {
          ...cliente,
          'persona': personasByCi[cliente['ci_persona']?.toString() ?? ''],
        };
      }).toList();
    } catch (e) {
      debugPrint('ERROR LISTAR CLIENTES PARA PAGOS: $e');
      return [];
    }
  }

  // =========================
  // LISTAR CUOTAS PENDIENTES
  // =========================

  Future<List<Map<String, dynamic>>> listarCuotasPendientes() async {
    try {
      final cuotas = await _listarCuotasEnlazadas();

      return cuotas.where(_cuotaPendiente).toList();
    } catch (e) {
      debugPrint('ERROR LISTAR CUOTAS PENDIENTES: $e');

      return [];
    }
  }

  Future<List<Map<String, dynamic>>> listarCuotasPendientesPorPrestamo(
    int idPrestamo,
  ) async {
    final cuotas = await listarCuotasPendientes();

    return cuotas.where((cuota) => cuota['id_prestamo'] == idPrestamo).toList();
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  double _saldoCuota(Map<String, dynamic> cuota) {
    final saldo = _toDouble(
      cuota['saldo_pendiente'] ?? cuota['saldo_restante'] ?? cuota['saldo'],
    );
    if (saldo > 0) return saldo;
    return _toDouble(
      cuota['monto_cuota'] ?? cuota['monto_total'] ?? cuota['monto'],
    );
  }

  bool _cuotaPendiente(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado == 'PAGADA' || estado == 'PAGADO') return false;

    final saldo = _saldoCuota(cuota);
    if (saldo > 0) return true;

    return _toDouble(
          cuota['monto_cuota'] ?? cuota['monto_total'] ?? cuota['monto'],
        ) >
        0;
  }

  bool _prestamoActivo(Map<String, dynamic> prestamo) {
    final estado =
        prestamo['estado_prestamo']?['nombre']?.toString().toUpperCase() ??
        prestamo['estado_nombre']?.toString().toUpperCase() ??
        '';
    return estado.isEmpty || estado == 'ACTIVO' || estado == 'MORA';
  }

  Future<List<Map<String, dynamic>>> _listarPrestamosEnlazados() async {
    final access = await roleService.currentAccess();
    final prestamos = await _listarOrdenado('prestamo', 'id_prestamo');
    final clientes = await listarClientesActivos();
    final tipos = await _listarSeguro('tipo_prestamo');
    final estados = await _listarSeguro('estado_prestamo');
    final clientesById = _byKey(clientes, 'id_cliente');
    final tiposById = _byKey(tipos, 'id_tipo');
    final estadosById = _byKey(estados, 'id_estado');

    var result = prestamos.map((prestamo) {
      return {
        ...prestamo,
        'cliente': clientesById[prestamo['id_cliente']?.toString() ?? ''],
        'tipo_prestamo':
            tiposById[prestamo['id_tipo']?.toString() ?? ''] ??
            {'nombre': 'Sin tipo'},
        'estado_prestamo':
            estadosById[prestamo['id_estado']?.toString() ?? ''] ??
            {'nombre': 'ACTIVO'},
      };
    }).toList();

    if (access.isCobrador) {
      result = result
          .where(
            (prestamo) => _toInt(prestamo['id_cobrador']) == access.idCobrador,
          )
          .toList();
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> _listarCuotasBase() async {
    final cuotas = await _listarOrdenado('cuota', 'fecha_vencimiento');
    final planes = await _listarSeguro('plan_pagos');
    final estados = await _listarSeguro('estado_cuota');
    final planesById = _byKey(planes, 'id_plan');
    final estadosById = _byKey(estados, 'id_estado');

    return cuotas.map((cuota) {
      final plan = planesById[cuota['id_plan']?.toString() ?? ''];
      final estado = estadosById[cuota['id_estado']?.toString() ?? ''];
      return LocalModelAdapter.cuotaDesdeLocal(
        cuota,
        plan: plan,
        estado: estado,
      );
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _listarCuotasEnlazadas() async {
    final cuotas = await _listarCuotasBase();
    final prestamos = await _listarPrestamosEnlazados();
    final prestamosById = _byKey(prestamos, 'id_prestamo');

    return cuotas
        .map((cuota) {
          final prestamo =
              prestamosById[cuota['id_prestamo']?.toString() ?? ''];
          return {...cuota, 'prestamo': prestamo};
        })
        .where((cuota) => cuota['prestamo'] != null)
        .toList();
  }

  Future<List<Map<String, dynamic>>> _listarOrdenado(
    String table,
    String orderColumn, {
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

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final ci = cliente['ci_persona'] ?? '';
    return '$nombres $paterno $ci'.trim().toLowerCase();
  }

  List<Map<String, dynamic>> _ordenarCuotas(List<Map<String, dynamic>> cuotas) {
    final copy = [...cuotas];
    copy.sort((a, b) {
      final fechaA =
          DateTime.tryParse(a['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      final fechaB =
          DateTime.tryParse(b['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      final compareFecha = fechaA.compareTo(fechaB);
      if (compareFecha != 0) return compareFecha;
      return (a['numero_cuota'] ?? 0).compareTo(b['numero_cuota'] ?? 0);
    });
    return copy;
  }

  Future<void> _validarSeleccionConsecutiva(
    List<Map<String, dynamic>> seleccionadas,
  ) async {
    final idPrestamo = seleccionadas.first['id_prestamo'];
    final pendientes = _ordenarCuotas(
      await listarCuotasPendientesPorPrestamo(idPrestamo),
    );
    final seleccionIds = seleccionadas
        .map((cuota) => cuota['id_cuota'])
        .toSet();

    for (final cuota in pendientes) {
      final id = cuota['id_cuota'];
      if (seleccionIds.contains(id)) continue;
      if (seleccionIds.any((selectedId) {
        final selected = seleccionadas.firstWhere(
          (c) => c['id_cuota'] == selectedId,
        );
        return _compareCuotas(cuota, selected) < 0;
      })) {
        throw Exception('Debe pagar primero las cuotas mas antiguas.');
      }
    }
  }

  int _compareCuotas(Map<String, dynamic> a, Map<String, dynamic> b) {
    final fechaA =
        DateTime.tryParse(a['fecha_vencimiento']?.toString() ?? '') ??
        DateTime(2100);
    final fechaB =
        DateTime.tryParse(b['fecha_vencimiento']?.toString() ?? '') ??
        DateTime(2100);
    final byDate = fechaA.compareTo(fechaB);
    if (byDate != 0) return byDate;
    return (a['numero_cuota'] ?? 0).compareTo(b['numero_cuota'] ?? 0);
  }

  Future<void> _marcarCuotaPagada(int idCuota, String fecha) async {
    await _actualizarCuotaPago(
      idCuota: idCuota,
      saldo: 0,
      estado: 'PAGADO',
      fecha: fecha,
    );
  }

  Future<void> _recalcularPlanRestante(int idPrestamo) async {
    final pendientes = _ordenarCuotas(
      await listarCuotasPendientesPorPrestamo(idPrestamo),
    );
    if (pendientes.isEmpty) return;

    final totalPendiente = pendientes.fold<double>(
      0,
      (total, cuota) => total + _saldoCuota(cuota),
    );
    final nuevaCuota = totalPendiente / pendientes.length;
    var saldoRestante = totalPendiente;

    for (var i = 0; i < pendientes.length; i++) {
      final cuota = pendientes[i];
      final montoCuota = i == pendientes.length - 1
          ? saldoRestante
          : nuevaCuota;
      saldoRestante = (saldoRestante - montoCuota).clamp(0.0, double.infinity);

      await localDb
          .from('cuota')
          .update({
            'monto_cuota': montoCuota,
            'monto_total': montoCuota,
            'capital': montoCuota,
            'monto_capital': montoCuota,
            'interes': 0,
            'monto_interes': 0,
            'saldo_pendiente': montoCuota,
            'saldo_restante': montoCuota,
            'estado': 'PENDIENTE',
          })
          .eq('id_cuota', cuota['id_cuota']);
    }
  }

  Future<void> _actualizarEstadoPrestamoSiCorresponde(
    dynamic idPrestamo,
  ) async {
    final id = _toInt(idPrestamo);
    if (id == null) return;
    await prestamoService.actualizarEstadoAutomaticoPrestamo(id);
  }

  // =========================
  // LISTAR
  // =========================

  Future<List<Map<String, dynamic>>> listarPagos() async {
    try {
      final access = await roleService.currentAccess();
      final pagos = await _listarOrdenado(
        'pago',
        'fecha_pago',
        ascending: false,
      );
      final cuotas = await _listarCuotasEnlazadas();
      final cuotasById = _byKey(cuotas, 'id_cuota');

      final result = pagos.map((pago) {
        return {
          ...pago,
          'monto': pago['monto'] ?? pago['monto_pagado'],
          'cuota': cuotasById[pago['id_cuota']?.toString() ?? ''],
        };
      }).toList();

      if (!access.isCobrador) return result;

      return result.where((pago) {
        final cuota = pago['cuota'];
        final prestamo = cuota?['prestamo'];
        return _toInt(prestamo?['id_cobrador']) == access.idCobrador;
      }).toList();
    } catch (e) {
      debugPrint('ERROR LISTAR PAGOS: $e');

      return [];
    }
  }

  // =========================
  // ACTUALIZAR
  // =========================

  Future<void> actualizarPago(PagoModel pago) async {
    try {
      await localDb
          .from('pago')
          .update(pago.toJson())
          .eq('id_pago', pago.id ?? 0);
    } catch (e) {
      debugPrint('ERROR ACTUALIZAR PAGO: $e');
    }
  }

  // =========================
  // ELIMINAR
  // =========================

  Future<void> eliminarPago(int idPago) async {
    try {
      final access = await roleService.currentAccess();
      if (!RoleGuard.canDeletePagos(access.role)) {
        throw Exception('El cobrador no puede eliminar pagos historicos.');
      }
      await localDb.from('pago').delete().eq('id_pago', idPago);
    } catch (e) {
      debugPrint('ERROR ELIMINAR PAGO: $e');
    }
  }
}
