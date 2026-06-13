import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/database/database.dart';

class GarantiaController extends ChangeNotifier {
  final localDb = DatabaseConfig.client;

  List<Garantia> garantias = [];
  bool loading = false;

  Future<List<Garantia>> listar() async {
    final response = await localDb
        .from('garantia')
        .select()
        .order('id_garantia', ascending: false);
    return List<Map<String, dynamic>>.from(
      response,
    ).map(Garantia.fromJson).toList();
  }

  Future<void> cargarGarantias() async {
    loading = true;
    notifyListeners();
    garantias = await listar();
    loading = false;
    notifyListeners();
  }

  Future<void> insertar({
    required String descripcion,
    required double valorEstimado,
    String fotografia = '',
    String urlReferencia = '',
    bool estado = true,
  }) async {
    await localDb.from('garantia').insert({
      'descripcion': descripcion,
      'fotografia': fotografia,
      'url_referencia': urlReferencia,
      'valor_estimado': valorEstimado,
      'estado': estado,
    });
    await cargarGarantias();
  }

  Future<void> actualizar(Garantia garantia) async {
    await localDb
        .from('garantia')
        .update(garantia.toJson())
        .eq('id_garantia', garantia.idGarantia);
    await cargarGarantias();
  }

  Future<void> eliminar(int idGarantia) async {
    await localDb
        .from('garantia')
        .update({'estado': false})
        .eq('id_garantia', idGarantia);
    await cargarGarantias();
  }
}
