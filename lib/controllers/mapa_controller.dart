import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/mapa_service.dart';

class MapaController extends ChangeNotifier {
  final service = MapaService();

  bool loading = false;
  List<Map<String, dynamic>> clientes = [];

  Future<void> cargarClientes() async {
    loading = true;
    notifyListeners();

    clientes = await service.listarClientesConPersona();

    loading = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> get clientesConUbicacion {
    return clientes.where((cliente) {
      final persona = cliente['persona'];
      return _toDouble(persona?['latitud']) != null &&
          _toDouble(persona?['longitud']) != null;
    }).toList();
  }

  List<Map<String, dynamic>> get clientesSinUbicacion {
    return clientes.where((cliente) {
      final persona = cliente['persona'];
      return _toDouble(persona?['latitud']) == null ||
          _toDouble(persona?['longitud']) == null;
    }).toList();
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }
}
