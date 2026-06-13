import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/app_role.dart';
import 'package:sist_prestamo/controllers/role_helper.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

class RoleAccessContext {
  final AppRole role;
  final String roleName;
  final String? idUsuario;
  final String? ciPersona;
  final int? idCobrador;
  final int? idCliente;

  const RoleAccessContext({
    required this.role,
    required this.roleName,
    required this.idUsuario,
    required this.ciPersona,
    required this.idCobrador,
    required this.idCliente,
  });

  bool get isAdmin => role == AppRole.admin;
  bool get isCobrador => role == AppRole.cobrador;
  bool get isCliente => role == AppRole.cliente;
}

// ======================================
// CONTROL DE ACCESO POR ROLES (RBAC)
// Archivo: role_service.dart
// Resuelve el rol real del usuario logueado
// desde usuario, rol, cobrador y cliente.
// El cobrador solo visualiza informacion
// correspondiente a su cartera.
// Principio: menor privilegio.
// ======================================
class RoleService {
  static final RoleService _instance = RoleService._internal();

  factory RoleService() {
    return _instance;
  }

  RoleService._internal();

  final localDb = DatabaseConfig.client;

  Future<RoleAccessContext> currentAccess() async {
    final authUser = localDb.auth.currentUser;
    if (authUser == null) {
      return const RoleAccessContext(
        role: AppRole.desconocido,
        roleName: 'SIN ROL',
        idUsuario: null,
        ciPersona: null,
        idCobrador: null,
        idCliente: null,
      );
    }

    final usuarios = await _listarSeguro('usuario');
    final usuario = usuarios.cast<Map<String, dynamic>?>().firstWhere(
      (item) =>
          item?['id_usuario']?.toString() == authUser.id ||
          item?['email']?.toString() == authUser.email ||
          item?['correo']?.toString() == authUser.email ||
          item?['username']?.toString() == authUser.email,
      orElse: () => null,
    );

    final roles = await _listarRoles();
    final rol = roles.cast<Map<String, dynamic>?>().firstWhere(
      (item) => item?['id_rol']?.toString() == usuario?['id_rol']?.toString(),
      orElse: () => null,
    );
    final roleName = rol?['nombre']?.toString().toUpperCase() ?? 'ADMIN';
    final role = RoleHelper.fromName(roleName);
    final ciPersona = usuario?['ci_persona']?.toString();

    final idCobrador = role == AppRole.cobrador
        ? await _idPorCi('cobrador', 'id_cobrador', ciPersona)
        : null;
    final idCliente = role == AppRole.cliente
        ? await _idPorCi('cliente', 'id_cliente', ciPersona)
        : null;

    return RoleAccessContext(
      role: role,
      roleName: RoleHelper.displayName(role),
      idUsuario: usuario?['id_usuario']?.toString() ?? authUser.id,
      ciPersona: ciPersona,
      idCobrador: idCobrador,
      idCliente: idCliente,
    );
  }

  Future<int?> currentCobradorId() async {
    return (await currentAccess()).idCobrador;
  }

  Future<List<int>> clientesAsignadosCobrador(int idCobrador) async {
    final prestamos = await _listarSeguro('prestamo');
    return prestamos
        .where((prestamo) => _toInt(prestamo['id_cobrador']) == idCobrador)
        .map((prestamo) => _toInt(prestamo['id_cliente']))
        .whereType<int>()
        .toSet()
        .toList();
  }

  Future<int?> _idPorCi(
    String table,
    String idColumn,
    String? ciPersona,
  ) async {
    if (ciPersona == null || ciPersona.isEmpty) return null;
    final rows = await _listarSeguro(table);
    final row = rows.cast<Map<String, dynamic>?>().firstWhere(
      (item) => item?['ci_persona']?.toString() == ciPersona,
      orElse: () => null,
    );
    return _toInt(row?[idColumn]);
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

  Future<List<Map<String, dynamic>>> _listarSeguro(String table) async {
    try {
      final response = await localDb.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
