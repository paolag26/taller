import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/usuario_controller.dart';
import 'package:sist_prestamo/database/database.dart';

class UsuarioProvider extends ChangeNotifier {
  final controller = UsuarioController();

  List<Usuario> usuarios = [];
  bool cargando = false;
  String? error;

  Future<void> cargarUsuarios() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      usuarios = await controller.listar();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(Usuario usuario) async {
    await controller.insertar(usuario);
    await cargarUsuarios();
  }

  Future<void> actualizar(Usuario usuario) async {
    await controller.actualizar(usuario);
    await cargarUsuarios();
  }

  Future<void> eliminar(String idUsuario) async {
    await controller.eliminar(idUsuario);
    await cargarUsuarios();
  }
}
