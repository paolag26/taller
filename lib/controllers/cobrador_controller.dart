import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/database_config.dart';

class CobradorController extends ChangeNotifier {
  final db = DatabaseConfig.client;

  bool loading = false;
  String? error;
  String query = '';
  List<Map<String, dynamic>> cobradores = [];

  Future<void> cargarCobradores() async {
    try {
      loading = true;
      error = null;
      notifyListeners();
      cobradores = await listar();
    } catch (e) {
      error = 'No se pudieron cargar cobradores: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<List<Map<String, dynamic>>> listar() async {
    final response = await db.from('cobrador').select().order('id_cobrador');
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertar({
    required String ciPersona,
    String? zona,
    bool estado = true,
  }) async {
    await db.from('cobrador').insert({
      'ci_persona': ciPersona,
      'zona': zona ?? '',
      'estado': estado,
    });
    await cargarCobradores();
  }

  Future<void> actualizar({
    required int idCobrador,
    required Map<String, dynamic> data,
  }) async {
    await db.from('cobrador').update(data).eq('id_cobrador', idCobrador);
    await cargarCobradores();
  }

  Future<void> eliminar(int idCobrador) async {
    await db.from('cobrador').delete().eq('id_cobrador', idCobrador);
    await cargarCobradores();
  }

  void filtrar(String value) {
    query = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> get cobradoresFiltrados {
    final term = query.trim().toLowerCase();
    if (term.isEmpty) return cobradores;
    return cobradores.where((item) {
      return item.values.any(
        (value) => value?.toString().toLowerCase().contains(term) ?? false,
      );
    }).toList();
  }
}
