import 'package:sist_prestamo/controllers/app_role.dart';

// ======================================
// CONTROL DE ACCESO POR ROLES (RBAC)
// Archivo: role_helper.dart
// Centraliza conversiones de rol para que
// no existan comparaciones duplicadas.
// Principio: menor privilegio.
// ======================================
class RoleHelper {
  static AppRole fromName(String? value) {
    final role = value?.trim().toUpperCase() ?? '';
    return switch (role) {
      'ADMIN' => AppRole.admin,
      'COBRADOR' => AppRole.cobrador,
      'CLIENTE' => AppRole.cliente,
      _ => AppRole.desconocido,
    };
  }

  static String displayName(AppRole role) {
    return switch (role) {
      AppRole.admin => 'ADMIN',
      AppRole.cobrador => 'COBRADOR',
      AppRole.cliente => 'CLIENTE',
      AppRole.desconocido => 'SIN ROL',
    };
  }
}
