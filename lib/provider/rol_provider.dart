import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/rol_controller.dart';
import 'package:sist_prestamo/database/database.dart';

class RolProvider extends ChangeNotifier {
  final controller = RolController();

  List<RolUsuario> roles = [];
  bool cargando = false;
  String? error;

  Future<void> cargarRoles() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      roles = await controller.listar();
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(String nombre, String descripcion, bool activo) async {
    await controller.insertar(
      nombre: nombre,
      descripcion: descripcion,
      activo: activo,
    );
    await cargarRoles();
  }

  Future<void> actualizar(RolUsuario rol) async {
    await controller.actualizar(rol);
    await cargarRoles();
  }

  Future<void> eliminar(int idRol) async {
    await controller.eliminar(idRol);
    await cargarRoles();
  }
}
