import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/local_data_client.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

class AuthService {
  final localDb = DatabaseConfig.client;

  Future<LocalAuthResponse> login({
    required String email,
    required String password,
  }) async {
    return localDb.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await localDb.auth.signOut();
  }

  LocalUser? currentUser() {
    return localDb.auth.currentUser;
  }

  Future<Map<String, dynamic>?> currentUsuario() async {
    final user = currentUser();
    if (user == null) return null;

    final usuarios = await _listarSeguro('usuario');
    final usuario = usuarios.cast<Map<String, dynamic>?>().firstWhere(
      (item) =>
          item?['id_usuario']?.toString() == user.id ||
          item?['email']?.toString() == user.email ||
          item?['correo']?.toString() == user.email,
      orElse: () => null,
    );
    if (usuario == null) return null;

    final roles = await _listarRoles();
    final rol = roles.cast<Map<String, dynamic>?>().firstWhere(
      (item) => item?['id_rol']?.toString() == usuario['id_rol']?.toString(),
      orElse: () => null,
    );

    return {...usuario, 'rol': rol};
  }

  Future<String> currentRoleName() async {
    final usuario = await currentUsuario();
    final rol = usuario?['rol'];
    return rol?['nombre']?.toString().toUpperCase() ?? 'ADMIN';
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(String table) async {
    try {
      final response = await localDb.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
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
      if (roles.isEmpty) debugPrint('ROL VACIO DESDE BASE LOCAL');
      return roles;
    } catch (e, stackTrace) {
      debugPrint('ERROR REAL DE BASE LOCAL: $e');
      debugPrint('STACKTRACE ROLES: $stackTrace');
      rethrow;
    }
  }
}
