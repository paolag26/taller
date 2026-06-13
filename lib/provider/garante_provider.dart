import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/garante_controller.dart';

class GaranteProvider extends ChangeNotifier {
  final controller = GaranteController();

  List<Map<String, dynamic>> garantes = [];
  bool cargando = false;
  String? error;

  Future<void> cargarGarantes() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      garantes = await controller.listar();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar({
    required String ciPersona,
    double? ingresoMensual,
    String ocupacion = '',
    bool estado = true,
  }) async {
    await controller.insertar(
      ciPersona: ciPersona,
      ingresoMensual: ingresoMensual,
      ocupacion: ocupacion,
      estado: estado,
    );
    await cargarGarantes();
  }

  Future<void> actualizar({
    required int idGarante,
    required Map<String, dynamic> data,
  }) async {
    await controller.actualizar(idGarante: idGarante, data: data);
    await cargarGarantes();
  }

  Future<void> eliminar(int idGarante) async {
    await controller.eliminar(idGarante);
    await cargarGarantes();
  }
}
