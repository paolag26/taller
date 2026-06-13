import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/configuracion_controller.dart';

class ConfiguracionProvider extends ChangeNotifier {
  final controller = ConfiguracionController();

  List<Map<String, dynamic>> tiposPrestamo = [];
  List<Map<String, dynamic>> estadosPrestamo = [];
  List<Map<String, dynamic>> conceptosGasto = [];
  List<Map<String, dynamic>> roles = [];
  List<Map<String, dynamic>> monedas = [];
  bool cargando = false;
  String? error;

  Future<void> cargarConfiguracion() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarConfiguracion();
      tiposPrestamo = controller.tiposPrestamo;
      estadosPrestamo = controller.estadosPrestamo;
      conceptosGasto = controller.conceptosGasto;
      roles = controller.roles;
      monedas = controller.monedas;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> guardarCatalogo({
    required CatalogoConfig config,
    dynamic id,
    required String nombre,
    String descripcion = '',
    bool activo = true,
  }) async {
    await controller.guardarCatalogo(
      config: config,
      id: id,
      nombre: nombre,
      descripcion: descripcion,
      activo: activo,
    );
    await cargarConfiguracion();
  }

  Future<void> eliminarCatalogo(CatalogoConfig config, dynamic id) async {
    await controller.eliminarCatalogo(config, id);
    await cargarConfiguracion();
  }
}
