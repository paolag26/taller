import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/local_data_client.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

class ConfiguracionService {
  // ==============================
  // PATRON SINGLETON
  // ConfiguracionService utiliza Singleton
  // para garantizar una unica instancia
  // durante toda la ejecucion del sistema.
  // Defensa: Patron Creacional.
  // Razon en Cuentas Claras: centraliza
  // catalogos, roles, monedas y seguridad.
  // ==============================
  static final ConfiguracionService _instance =
      ConfiguracionService._internal();

  factory ConfiguracionService() {
    return _instance;
  }

  ConfiguracionService._internal();

  final localDb = DatabaseConfig.client;

  Future<List<Map<String, dynamic>>> listarCatalogo(String tabla) async {
    if (tabla == 'rol') return listarRoles();

    final response = await localDb.from(tabla).select().order('nombre');
    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> listarRoles() async {
    try {
      debugPrint('CONSULTANDO TABLA ROL');
      final response = await localDb.from('rol').select();
      debugPrint('RESPUESTA ROL: $response');
      debugPrint('TIPO RESPUESTA: ${response.runtimeType}');
      debugPrint('TOTAL REGISTROS: ${response.length}');
      final roles = List<Map<String, dynamic>>.from(response);
      debugPrint('ROLES RECUPERADOS: $roles');
      debugPrint('TOTAL ROLES: ${roles.length}');
      if (roles.isEmpty) {
        debugPrint('ROL VACIO DESDE BASE LOCAL');
      }
      for (final rol in roles) {
        debugPrint('ID: ${rol['id_rol']}');
        debugPrint('NOMBRE: ${rol['nombre']}');
        debugPrint('DESCRIPCION: ${rol['descripcion']}');
      }
      return roles;
    } catch (e, stackTrace) {
      debugPrint('ERROR REAL DE BASE LOCAL: $e');
      debugPrint('STACKTRACE ROLES: $stackTrace');
      rethrow;
    }
  }

  Future<void> insertarCatalogo({
    required String tabla,
    required Map<String, dynamic> data,
  }) async {
    await localDb.from(tabla).insert(data);
  }

  Future<void> actualizarCatalogo({
    required String tabla,
    required String idColumn,
    required dynamic id,
    required Map<String, dynamic> data,
  }) async {
    await localDb.from(tabla).update(data).eq(idColumn, id);
  }

  Future<void> eliminarCatalogo({
    required String tabla,
    required String idColumn,
    required dynamic id,
  }) async {
    await localDb.from(tabla).delete().eq(idColumn, id);
  }

  Future<void> cambiarPassword(String password) async {
    await localDb.auth.updateUser(LocalUserAttributes(password: password));
  }

  Future<Map<String, dynamic>?> obtenerConfiguracion(String clave) async {
    final response = await localDb
        .from('configuracion')
        .select()
        .eq('clave', clave)
        .maybeSingle();

    return response;
  }

  Future<void> guardarConfiguracion({
    required String clave,
    required String valor,
  }) async {
    await localDb.from('configuracion').upsert({
      'clave': clave,
      'valor': valor,
    }, onConflict: 'clave');
  }
}
