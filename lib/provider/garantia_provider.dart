import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/garantia_controller.dart';
import 'package:sist_prestamo/database/database.dart';

class GarantiaProvider extends ChangeNotifier {
  final controller = GarantiaController();

  List<Garantia> garantias = [];
  bool cargando = false;
  String? error;

  Future<void> cargarGarantias() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      garantias = await controller.listar();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar({
    required String descripcion,
    required double valorEstimado,
    String fotografia = '',
    String urlReferencia = '',
    bool estado = true,
  }) async {
    await controller.insertar(
      descripcion: descripcion,
      valorEstimado: valorEstimado,
      fotografia: fotografia,
      urlReferencia: urlReferencia,
      estado: estado,
    );
    await cargarGarantias();
  }

  Future<void> actualizar(Garantia garantia) async {
    await controller.actualizar(garantia);
    await cargarGarantias();
  }

  Future<void> eliminar(int idGarantia) async {
    await controller.eliminar(idGarantia);
    await cargarGarantias();
  }
}
