import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/persona_controller.dart';
import 'package:sist_prestamo/models/persona_model.dart';

class PersonaProvider extends ChangeNotifier {
  final controller = PersonaController();

  List<PersonaModel> personas = [];
  bool cargando = false;
  String? error;

  Future<void> cargarPersonas() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarPersonas();
      personas = controller.personas;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(PersonaModel persona) async {
    await controller.insertarPersona(persona);
    await cargarPersonas();
  }

  Future<void> actualizar(PersonaModel persona) async {
    await controller.actualizarPersona(persona);
    await cargarPersonas();
  }

  Future<void> eliminar(String ciPersona) async {
    await controller.eliminarPersona(ciPersona);
    await cargarPersonas();
  }
}
