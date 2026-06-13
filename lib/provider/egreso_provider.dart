import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/egreso_controller.dart';
import 'package:sist_prestamo/models/egreso_model.dart';

class EgresoProvider extends ChangeNotifier {
  final controller = EgresoController();

  List<EgresoModel> egresos = [];
  List<ConceptoGastoModel> conceptos = [];
  List<UsuarioEgresoModel> usuarios = [];
  bool cargando = false;
  String? error;

  Future<void> cargarEgresos() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarEgresos();
      egresos = controller.egresos;
      conceptos = controller.conceptos;
      usuarios = controller.usuarios;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(EgresoModel egreso) async {
    await controller.guardarEgreso(egreso);
    await cargarEgresos();
  }

  Future<void> actualizar(EgresoModel egreso) async {
    await controller.guardarEgreso(egreso);
    await cargarEgresos();
  }

  Future<void> eliminar(int idEgreso) async {
    await controller.eliminarEgreso(idEgreso);
    await cargarEgresos();
  }
}
