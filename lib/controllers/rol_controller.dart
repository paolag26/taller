import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/database/database.dart';

class RolController extends ChangeNotifier {
  final localDb = DatabaseConfig.client;

  List<RolUsuario> roles = [];
  bool loading = false;

  Future<List<RolUsuario>> listar() async {
    final response = await localDb.from('rol').select().order('nombre');
    return List<Map<String, dynamic>>.from(
      response,
    ).map(RolUsuario.fromJson).toList();
  }

  Future<void> cargarRoles() async {
    loading = true;
    notifyListeners();
    roles = await listar();
    loading = false;
    notifyListeners();
  }

  Future<void> insertar({
    required String nombre,
    String descripcion = '',
    bool activo = true,
  }) async {
    await localDb.from('rol').insert({
      'nombre': nombre,
      'descripcion': descripcion,
      'activo': activo,
    });
    await cargarRoles();
  }

  Future<void> actualizar(RolUsuario rol) async {
    await localDb.from('rol').update(rol.toJson()).eq('id_rol', rol.idRol);
    await cargarRoles();
  }

  Future<void> eliminar(int idRol) async {
    await localDb.from('rol').update({'activo': false}).eq('id_rol', idRol);
    await cargarRoles();
  }
}
