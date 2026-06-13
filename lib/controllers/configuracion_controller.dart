import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/configuracion_service.dart';

class ConfiguracionController extends ChangeNotifier {
  final service = ConfiguracionService();

  bool loading = false;
  String? error;

  List<Map<String, dynamic>> tiposPrestamo = [];
  List<Map<String, dynamic>> estadosPrestamo = [];
  List<Map<String, dynamic>> conceptosGasto = [];
  List<Map<String, dynamic>> roles = [];
  List<Map<String, dynamic>> monedas = [];

  Future<void> cargarConfiguracion() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      tiposPrestamo = await _listarSeguro('tipo_prestamo');
      estadosPrestamo = await _listarSeguro('estado_prestamo');
      conceptosGasto = await _listarSeguro('concepto_gasto');
      roles = await service.listarRoles();
      monedas = await _listarSeguro('moneda');
    } catch (e) {
      error = e.toString();
      debugPrint('Error real al cargar configuracion: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> guardarCatalogo({
    required CatalogoConfig config,
    dynamic id,
    required String nombre,
    String? descripcion,
    bool activo = true,
  }) async {
    final data = <String, dynamic>{'nombre': nombre};

    if (config.tieneDescripcion) {
      data['descripcion'] = descripcion ?? '';
    }

    if (config.tieneActivo) {
      data['activo'] = activo;
    }

    if (id == null) {
      await service.insertarCatalogo(tabla: config.tabla, data: data);
    } else {
      await service.actualizarCatalogo(
        tabla: config.tabla,
        idColumn: config.idColumn,
        id: id,
        data: data,
      );
    }

    await cargarConfiguracion();
  }

  Future<void> eliminarCatalogo(CatalogoConfig config, dynamic id) async {
    await service.eliminarCatalogo(
      tabla: config.tabla,
      idColumn: config.idColumn,
      id: id,
    );

    await cargarConfiguracion();
  }

  Future<void> cambiarActivo({
    required CatalogoConfig config,
    required Map<String, dynamic> item,
    required bool activo,
  }) async {
    if (!config.tieneActivo) return;

    await service.actualizarCatalogo(
      tabla: config.tabla,
      idColumn: config.idColumn,
      id: item[config.idColumn],
      data: {'activo': activo},
    );

    await cargarConfiguracion();
  }

  Future<void> cambiarPassword(String password) async {
    await service.cambiarPassword(password);
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(String tabla) async {
    try {
      return await service.listarCatalogo(tabla);
    } catch (e) {
      debugPrint('No se pudo cargar $tabla: $e');
      return [];
    }
  }
}

class CatalogoConfig {
  final String titulo;
  final String tabla;
  final String idColumn;
  final IconData icon;
  final bool tieneDescripcion;
  final bool tieneActivo;

  const CatalogoConfig({
    required this.titulo,
    required this.tabla,
    required this.idColumn,
    required this.icon,
    this.tieneDescripcion = true,
    this.tieneActivo = false,
  });
}
