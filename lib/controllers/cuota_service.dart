import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/models/cuota_model.dart';

class CuotaService {
  // ==============================
  // PATRON SINGLETON
  // CuotaService utiliza Singleton
  // para garantizar una unica instancia
  // durante toda la ejecucion del sistema.
  // Defensa: Patron Creacional.
  // Razon en Cuentas Claras: centraliza
  // lectura y actualizacion del plan de pagos.
  // ==============================
  static final CuotaService _instance = CuotaService._internal();

  factory CuotaService() {
    return _instance;
  }

  CuotaService._internal();

  final localDb = DatabaseConfig.client;
  final roleService = RoleService();

  Future<void> insertarCuota(CuotaModel cuota) async {
    try {
      await localDb.from('cuota').insert(cuota.toJson());
      debugPrint('CUOTA INSERTADA');
    } catch (e) {
      debugPrint('ERROR INSERTAR CUOTA: $e');
    }
  }

  Future<List<Map<String, dynamic>>> listarCuotas() async {
    try {
      return _listarCuotasEnlazadas();
    } catch (e) {
      debugPrint('ERROR LISTAR CUOTAS: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> buscarClientes(String query) async {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return [];

    try {
      final clientes = await _listarClientesEnlazados();

      return clientes.where((cliente) {
        final persona = cliente['persona'];
        final ci = cliente['ci_persona']?.toString().toLowerCase() ?? '';
        final telefono = persona?['telefono']?.toString().toLowerCase() ?? '';
        final nombre =
            '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''} ${persona?['apellido_materno'] ?? ''}'
                .toLowerCase();

        return ci.contains(text) ||
            telefono.contains(text) ||
            nombre.contains(text);
      }).toList();
    } catch (e) {
      debugPrint('ERROR BUSCAR CLIENTES CUOTAS: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> cargarClienteCompleto(int idCliente) async {
    try {
      final clientes = await _listarClientesEnlazados();
      final cliente = clientes.cast<Map<String, dynamic>?>().firstWhere(
        (item) => _toInt(item?['id_cliente']) == idCliente,
        orElse: () => null,
      );
      if (cliente == null) return null;

      final prestamos =
          (await _listarPrestamosEnlazados())
              .where((prestamo) => _toInt(prestamo['id_cliente']) == idCliente)
              .toList()
            ..sort((a, b) {
              final fechaA =
                  DateTime.tryParse(a['fecha_inicio']?.toString() ?? '') ??
                  DateTime(1900);
              final fechaB =
                  DateTime.tryParse(b['fecha_inicio']?.toString() ?? '') ??
                  DateTime(1900);
              return fechaB.compareTo(fechaA);
            });

      final cuotas = await _listarCuotasEnlazadas();
      final pagos = await _listarSeguro('pago');

      for (final prestamo in prestamos) {
        final idPrestamo = _toInt(prestamo['id_prestamo']);
        final cuotasPrestamo =
            cuotas
                .where((cuota) => _toInt(cuota['id_prestamo']) == idPrestamo)
                .map((cuota) => Map<String, dynamic>.from(cuota))
                .toList()
              ..sort(_compararCuotas);

        for (final cuota in cuotasPrestamo) {
          final idCuota = cuota['id_cuota'];
          cuota['pagos'] = pagos.where((pago) {
            if (pago['id_cuota'] == idCuota) return true;
            final cuotasIds = pago['cuotas_ids'];
            return cuotasIds is List && cuotasIds.contains(idCuota);
          }).toList();
        }

        prestamo['cuotas'] = cuotasPrestamo;
      }

      return {...cliente, 'prestamos': prestamos};
    } catch (e) {
      debugPrint('ERROR CARGAR CLIENTE CUOTAS: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> buscarClientePorCarnet(String ci) async {
    final clientes = await buscarClientes(ci);
    if (clientes.isEmpty) return null;
    return cargarClienteCompleto(clientes.first['id_cliente']);
  }

  Future<void> actualizarCuota(CuotaModel cuota) async {
    try {
      await localDb
          .from('cuota')
          .update(cuota.toJson())
          .eq('id_cuota', cuota.idCuota!);
    } catch (e) {
      debugPrint('ERROR ACTUALIZAR CUOTA: $e');
    }
  }

  Future<void> eliminarCuota(int idCuota) async {
    try {
      await localDb.from('cuota').delete().eq('id_cuota', idCuota);
    } catch (e) {
      debugPrint('ERROR ELIMINAR CUOTA: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _listarCuotasEnlazadas() async {
    final cuotas = await _listarOrdenado('cuota', 'fecha_vencimiento');
    final planes = await _listarSeguro('plan_pagos');
    final prestamos = await _listarPrestamosEnlazados();
    final planesById = _byKey(planes, 'id_plan');
    final prestamosById = _byKey(prestamos, 'id_prestamo');

    return cuotas
        .map((cuotaOriginal) {
          final cuota = Map<String, dynamic>.from(cuotaOriginal);
          final plan = planesById[cuota['id_plan']?.toString() ?? ''];
          cuota['id_prestamo'] ??= plan?['id_prestamo'];
          cuota['monto_cuota'] ??= cuota['monto_total'];
          cuota['monto_cuota'] ??= cuota['monto'];
          cuota['capital'] ??= cuota['monto_capital'];
          cuota['interes'] ??= cuota['monto_interes'];
          cuota['saldo_pendiente'] ??= cuota['saldo_restante'];
          cuota['saldo_pendiente'] ??= cuota['saldo'];
          cuota['estado'] ??= 'PENDIENTE';
          cuota['prestamo'] =
              prestamosById[cuota['id_prestamo']?.toString() ?? ''];
          return cuota;
        })
        .where((cuota) => cuota['prestamo'] != null)
        .toList();
  }

  Future<List<Map<String, dynamic>>> _listarPrestamosEnlazados() async {
    final access = await roleService.currentAccess();
    final prestamos = await _listarOrdenado('prestamo', 'id_prestamo');
    final clientes = await _listarClientesEnlazados();
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

  Future<List<Map<String, dynamic>>> _listarClientesEnlazados() async {
    final clientes = await _listarOrdenado('cliente', 'id_cliente');
    final personas = await _listarSeguro('persona');
    final personasByCi = {
      ..._byKey(personas, 'ci'),
      ..._byKey(personas, 'ci_persona'),
    };

    return clientes.map((cliente) {
      return {
        ...cliente,
        'persona': personasByCi[cliente['ci_persona']?.toString() ?? ''],
      };
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _listarOrdenado(
    String table,
    String orderColumn,
  ) async {
    try {
      final response = await localDb.from(table).select().order(orderColumn);
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

  int _compararCuotas(Map<String, dynamic> a, Map<String, dynamic> b) {
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

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
