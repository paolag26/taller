import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/diagnostico_controller.dart';

class DiagnosticoProvider extends ChangeNotifier {
  final controller = DiagnosticoController();

  List<Map<String, dynamic>> roles = [];
  List<Map<String, dynamic>> usuarios = [];
  List<Map<String, dynamic>> personas = [];
  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> planes = [];
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagos = [];
  List<Map<String, dynamic>> conceptosGasto = [];
  List<Map<String, dynamic>> egresos = [];
  bool cargando = false;
  String? error;

  Future<void> cargarDiagnostico() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargar();
      roles = controller.roles;
      usuarios = controller.usuarios;
      personas = controller.personas;
      prestamos = controller.prestamos;
      planes = controller.planes;
      cuotas = controller.cuotas;
      pagos = controller.pagos;
      conceptosGasto = controller.conceptosGasto;
      egresos = controller.egresos;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }
}
