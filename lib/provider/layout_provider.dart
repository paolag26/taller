import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/layout_controller.dart';

class LayoutProvider extends ChangeNotifier {
  final controller = LayoutController();

  bool cargando = false;
  String? error;

  Future<void> logout() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.logout();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
