import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/prestamo_controller.dart';
import 'package:sist_prestamo/models/prestamo_model.dart';

class PrestamoProvider extends ChangeNotifier {
  final controller = PrestamoController();

  List<Map<String, dynamic>> prestamos = [];
  bool cargando = false;
  String? error;

  Future<void> cargarPrestamos() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarPrestamos();
      prestamos = controller.prestamos;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(
    PrestamoModel prestamo, {
    required int plazo,
    List<Map<String, dynamic>> garantes = const [],
    List<Map<String, dynamic>> articulos = const [],
  }) async {
    await controller.insertarPrestamo(
      prestamo,
      plazo: plazo,
      garantes: garantes,
      articulos: articulos,
    );
    await cargarPrestamos();
  }

  Future<void> actualizar(PrestamoModel prestamo) async {
    await controller.actualizarPrestamo(prestamo);
    await cargarPrestamos();
  }

  Future<void> eliminar(int idPrestamo) async {
    await controller.eliminarPrestamo(idPrestamo);
    await cargarPrestamos();
  }

  void buscar(String value) {
    controller.cambiarBusqueda(value);
    prestamos = controller.prestamosFiltrados;
    notifyListeners();
  }
}
