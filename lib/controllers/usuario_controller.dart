import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/database/database.dart';

class UsuarioController extends ChangeNotifier {
  final localDb = DatabaseConfig.client;

  List<Usuario> usuarios = [];
  bool loading = false;

  Future<List<Usuario>> listar() async {
    final response = await localDb.from('usuario').select().order('username');
    return List<Map<String, dynamic>>.from(
      response,
    ).map(Usuario.fromJson).toList();
  }

  Future<void> cargarUsuarios() async {
    loading = true;
    notifyListeners();
    usuarios = await listar();
    loading = false;
    notifyListeners();
  }

  Future<void> insertar(Usuario usuario) async {
    await localDb.from('usuario').insert(usuario.toJson());
    await cargarUsuarios();
  }

  Future<void> actualizar(Usuario usuario) async {
    await localDb
        .from('usuario')
        .update(usuario.toJson())
        .eq('id_usuario', usuario.idUsuario);
    await cargarUsuarios();
  }

  Future<void> eliminar(String idUsuario) async {
    await localDb
        .from('usuario')
        .update({'estado': false})
        .eq('id_usuario', idUsuario);
    await cargarUsuarios();
  }
}
