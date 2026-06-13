import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/reporte_controller.dart';

class ReporteProvider extends ChangeNotifier {
  final controller = ReporteController();

  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagos = [];
  List<Map<String, dynamic>> egresos = [];
  List<Map<String, dynamic>> clientes = [];
  bool cargando = false;
  String? error;

  Future<void> cargarReporte() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarReporte();
      prestamos = controller.prestamos;
      cuotas = controller.cuotas;
      pagos = controller.pagos;
      egresos = controller.egresos;
      clientes = controller.clientes;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }
}
