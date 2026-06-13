import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/dashboard_controller.dart';

class DashboardProvider extends ChangeNotifier {
  final controller = DashboardController();

  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> clientes = [];
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagosHoy = [];
  List<Map<String, dynamic>> pagosMes = [];
  bool cargando = false;
  String? error;

  Future<void> cargarDashboard() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarDashboard();
      prestamos = controller.prestamos;
      clientes = controller.clientes;
      cuotas = controller.cuotas;
      pagosHoy = controller.pagosHoy;
      pagosMes = controller.pagosMes;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }
}
