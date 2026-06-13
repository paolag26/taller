import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/database_config.dart';

class GaranteController extends ChangeNotifier {
  final db = DatabaseConfig.client;

  bool loading = false;
  String? error;
  String query = '';
  List<Map<String, dynamic>> garantes = [];

  Future<void> cargarGarantes() async {
    try {
      loading = true;
      error = null;
      notifyListeners();
      garantes = await listar();
    } catch (e) {
      error = 'No se pudieron cargar garantes: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<List<Map<String, dynamic>>> listar() async {
    final response = await db.from('garante').select().order('id_garante');
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertar({
    required String ciPersona,
    double? ingresoMensual,
    String ocupacion = '',
    bool estado = true,
  }) async {
    await db.from('garante').insert({
      'ci_persona': ciPersona,
      'ingreso_mensual': ingresoMensual,
      'ocupacion': ocupacion,
      'estado': estado,
    });
    await cargarGarantes();
  }

  Future<void> actualizar({
    required int idGarante,
    required Map<String, dynamic> data,
  }) async {
    await db.from('garante').update(data).eq('id_garante', idGarante);
    await cargarGarantes();
  }

  Future<void> eliminar(int idGarante) async {
    await db.from('garante').delete().eq('id_garante', idGarante);
    await cargarGarantes();
  }

  void filtrar(String value) {
    query = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> get garantesFiltrados {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) return garantes;
    return garantes.where((item) {
      return item.values.any(
        (value) => value?.toString().toLowerCase().contains(term) ?? false,
      );
    }).toList();
  }
}
