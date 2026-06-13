import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/egreso_model.dart';
import 'package:sist_prestamo/controllers/concepto_gasto_service.dart';

class ConceptoGastoController extends ChangeNotifier {
  final service = ConceptoGastoService();

  bool loading = false;
  String? error;
  List<ConceptoGastoModel> conceptos = [];

  Future<void> cargarConceptos() async {
    try {
      loading = true;
      error = null;
      notifyListeners();
      conceptos = await service.listarConceptos();
    } catch (e) {
      error = 'No se pudieron cargar conceptos de gasto: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> guardarConcepto(ConceptoGastoModel concepto) async {
    await service.guardarConcepto(concepto);
    await cargarConceptos();
  }

  Future<void> cambiarEstado(ConceptoGastoModel concepto, bool activo) async {
    if (concepto.id == null) return;
    await service.cambiarEstado(concepto.id!, activo);
    await cargarConceptos();
  }
}
