import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/plan_pago_controller.dart';
import 'package:sist_prestamo/database/database.dart';

class PlanPagoProvider extends ChangeNotifier {
  final controller = PlanPagoController();

  List<PlanPago> planes = [];
  bool cargando = false;
  String? error;

  Future<void> cargarPlanes() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      planes = await controller.listar();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar({
    required int idPrestamo,
    required int numeroCuotas,
    required String frecuenciaPago,
  }) async {
    await controller.insertar(
      idPrestamo: idPrestamo,
      numeroCuotas: numeroCuotas,
      frecuenciaPago: frecuenciaPago,
    );
    await cargarPlanes();
  }

  Future<void> actualizar(PlanPago plan) async {
    await controller.actualizar(plan);
    await cargarPlanes();
  }

  Future<void> eliminar(int idPlan) async {
    await controller.eliminar(idPlan);
    await cargarPlanes();
  }
}
