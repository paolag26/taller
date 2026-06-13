import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/pago_controller.dart';
import 'package:sist_prestamo/models/pago_model.dart';

class PagoProvider extends ChangeNotifier {
  final controller = PagoController();

  List<Map<String, dynamic>> pagos = [];
  bool cargando = false;
  String? error;

  Future<void> cargarPagos() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarPagos();
      pagos = controller.pagos;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(PagoModel pago) async {
    await controller.insertarPago(pago);
    await cargarPagos();
  }

  Future<void> actualizar(PagoModel pago) async {
    await controller.actualizarPago(pago);
    await cargarPagos();
  }

  Future<void> eliminar(int idPago) async {
    await controller.eliminarPago(idPago);
    await cargarPagos();
  }
}
