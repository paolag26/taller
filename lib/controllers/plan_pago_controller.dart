import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/database/database.dart';

class PlanPagoController extends ChangeNotifier {
  final localDb = DatabaseConfig.client;

  List<PlanPago> planes = [];
  bool loading = false;

  Future<List<PlanPago>> listar() async {
    final response = await localDb
        .from('plan_pagos')
        .select()
        .order('id_plan', ascending: false);
    return List<Map<String, dynamic>>.from(
      response,
    ).map(PlanPago.fromJson).toList();
  }

  Future<void> cargarPlanes() async {
    loading = true;
    notifyListeners();
    planes = await listar();
    loading = false;
    notifyListeners();
  }

  Future<void> insertar({
    required int idPrestamo,
    required int numeroCuotas,
    required String frecuenciaPago,
  }) async {
    await localDb.from('plan_pagos').insert({
      'id_prestamo': idPrestamo,
      'numero_cuotas': numeroCuotas,
      'frecuencia_pago': frecuenciaPago,
    });
    await cargarPlanes();
  }

  Future<void> actualizar(PlanPago plan) async {
    await localDb
        .from('plan_pagos')
        .update(plan.toJson())
        .eq('id_plan', plan.idPlan);
    await cargarPlanes();
  }

  Future<void> eliminar(int idPlan) async {
    await localDb.from('plan_pagos').delete().eq('id_plan', idPlan);
    await cargarPlanes();
  }
}
