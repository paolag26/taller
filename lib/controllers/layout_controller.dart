import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_role.dart';
import 'package:sist_prestamo/controllers/role_guard.dart';
import 'package:sist_prestamo/controllers/role_helper.dart';
import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/auth_service.dart';
import 'package:sist_prestamo/views/dashboard_view.dart';

class LayoutController extends ChangeNotifier {
  late Widget currentView;

  String title = 'Dashboard';
  String roleName = 'ADMIN';
  AppRole role = AppRole.admin;

  final _authService = AuthService();
  final _roleService = RoleService();

  LayoutController() {
    openDashboard();
    cargarSesion();
  }

  Future<void> cargarSesion() async {
    final access = await _roleService.currentAccess();
    role = access.role;
    roleName = access.roleName;
    notifyListeners();
  }

  bool get isAdmin => role == AppRole.admin;
  bool get isCliente => role == AppRole.cliente;
  bool get isCobrador => role == AppRole.cobrador;
  String get roleLabel => RoleHelper.displayName(role);

  bool canAccess(String module) {
    return RoleGuard.canAccessModule(role, module);
  }

  void openDashboard() {
    currentView = DashboardView(
      onNavigate: (view, title) {
        changeView(view: view, newTitle: title);
      },
    );

    title = 'Dashboard';

    notifyListeners();
  }

  void changeView({required Widget view, required String newTitle}) {
    currentView = view;

    title = newTitle;

    notifyListeners();
  }

  Future<void> logout() {
    return _authService.logout();
  }
}
