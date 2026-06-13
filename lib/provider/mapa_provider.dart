import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/mapa_controller.dart';

class MapaProvider extends ChangeNotifier {
  final controller = MapaController();

  List<Map<String, dynamic>> clientes = [];
  bool cargando = false;
  String? error;

  Future<void> cargarClientes() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarClientes();
      clientes = controller.clientes;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }
}
