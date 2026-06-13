import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/cobranza_controller.dart';

class CobranzaProvider extends ChangeNotifier {
  final controller = CobranzaController();

  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagos = [];
  bool cargando = false;
  String? error;

  Future<void> cargarCobranza() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarCobranza();
      cuotas = controller.cuotas;
      pagos = controller.pagos;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  void buscar(String value) {
    controller.cambiarBusqueda(value);
    cuotas = controller.cuotasFiltradas;
    notifyListeners();
  }

  void filtrar(String value) {
    controller.cambiarFiltro(value);
    cuotas = controller.cuotasFiltradas;
    notifyListeners();
  }
}
