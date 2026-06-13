import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/auth_controller.dart';

class AuthProvider extends ChangeNotifier {
  final controller = AuthController();

  bool cargando = false;
  String? error;

  Future<bool> login({required String email, required String password}) async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      final ok = await controller.login(email: email, password: password);
      return ok;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      cargando = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    cargando = true;
    notifyListeners();
    try {
      await controller.logout();
      error = null;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }
}
