import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/auth_service.dart';

class AuthController extends ChangeNotifier {
  final service = AuthService();

  bool loading = false;

  Future<bool> login({required String email, required String password}) async {
    try {
      loading = true;

      notifyListeners();

      await service.login(email: email, password: password);

      return true;
    } catch (e) {
      debugPrint(e.toString());

      return false;
    } finally {
      loading = false;

      notifyListeners();
    }
  }

  Future<void> logout() async {
    await service.logout();
  }
}
