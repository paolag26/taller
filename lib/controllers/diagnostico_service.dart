import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/database_config.dart';

class DiagnosticoService {
  final localDb = DatabaseConfig.client;

  Future<Map<String, dynamic>> cargarDiagnostico() async {
    final roles = await _listarRoles();
    final usuarios = await _listarSeguro('usuario');
    final personas = await _listarSeguro('persona');
    final prestamos = await _listarSeguro('prestamo');
    final planes = await _listarSeguro('plan_pagos');
    final cuotas = await _listarSeguro('cuota');
    final pagos = await _listarSeguro('pago');
    final conceptos = await _listarSeguro('concepto_gasto');
    final egresos = await _listarSeguro('egreso');

    return {
      'roles': roles,
      'usuarios': usuarios,
      'personas': personas,
      'prestamos': prestamos,
      'planes': planes,
      'cuotas': cuotas,
      'pagos': pagos,
      'conceptos_gasto': conceptos,
      'egresos': egresos,
      'concepto_gasto_error': await diagnosticarConceptoGastoRls(),
    };
  }

  Future<String?> diagnosticarConceptoGastoRls() async {
    try {
      await localDb.from('concepto_gasto').select().limit(1);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(String table) async {
    try {
      final response = await localDb.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      return [
        {'_error': e.toString()},
      ];
    }
  }

  Future<List<Map<String, dynamic>>> _listarRoles() async {
    try {
      debugPrint('CONSULTANDO TABLA ROL');
      final response = await localDb.from('rol').select();
      debugPrint('RESPUESTA ROL: $response');
      debugPrint('TIPO RESPUESTA: ${response.runtimeType}');
      debugPrint('TOTAL REGISTROS: ${response.length}');

      final roles = List<Map<String, dynamic>>.from(response);
      if (roles.isEmpty) {
        debugPrint('ROL VACIO DESDE SUPABASE');
      }
      return roles;
    } catch (e, stackTrace) {
      debugPrint('ERROR REAL DE SUPABASE: $e');
      debugPrint('STACKTRACE ROLES: $stackTrace');
      rethrow;
    }
  }
}
