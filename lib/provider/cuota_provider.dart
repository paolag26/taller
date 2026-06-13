import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/cuota_controller.dart';
import 'package:sist_prestamo/models/cuota_model.dart';

class CuotaProvider extends ChangeNotifier {
  final controller = CuotaController();

  List<Map<String, dynamic>> cuotas = [];
  bool cargando = false;
  String? error;

  Future<void> cargarCuotas() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarCuotas();
      cuotas = controller.cuotas;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(CuotaModel cuota) async {
    await controller.insertarCuota(cuota);
    await cargarCuotas();
  }

  Future<void> actualizar(CuotaModel cuota) async {
    await controller.actualizarCuota(cuota);
    await cargarCuotas();
  }

  Future<void> eliminar(int idCuota) async {
    await controller.eliminarCuota(idCuota);
    await cargarCuotas();
  }

  void buscar(String value) {
    controller.cambiarBusqueda(value);
    cuotas = controller.cuotasFiltradas;
    notifyListeners();
  }
}
