import 'package:sist_prestamo/controllers/app_role.dart';

// ======================================
// CONTROL DE ACCESO POR ROLES (RBAC)
// Archivo: role_guard.dart
// El cobrador solo visualiza informacion
// correspondiente a su cartera.
// Principio: menor privilegio y separacion
// de responsabilidades.
// ======================================
class RoleGuard {
  static bool canAccessModule(AppRole role, String module) {
    if (role == AppRole.admin) return true;
    if (role == AppRole.cliente) {
      return {'dashboard', 'cuotas', 'perfil'}.contains(module);
    }
    if (role == AppRole.cobrador) {
      return {
        'dashboard',
        'cuotas',
        'pagos',
        'cobranza',
        'mapa',
      }.contains(module);
    }
    return module == 'dashboard';
  }

  static bool canAccessReportes(AppRole role) => role == AppRole.admin;

  static bool canAccessConfiguracion(AppRole role) => role == AppRole.admin;

  static bool canAccessCobranza(AppRole role) {
    return role == AppRole.admin || role == AppRole.cobrador;
  }

  static bool canDeletePagos(AppRole role) => role == AppRole.admin;
}
