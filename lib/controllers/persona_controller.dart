import 'package:flutter/material.dart';
import 'package:sist_prestamo/models/persona_model.dart';
import 'package:sist_prestamo/controllers/persona_service.dart';

class PersonaController extends ChangeNotifier {
  final service = PersonaService();

  bool loading = false;

  List<PersonaModel> personas = [];

  // =========================
  // LISTAR
  // =========================
  Future<void> cargarPersonas() async {
    loading = true;

    notifyListeners();

    personas = await service.listarPersonas();

    loading = false;

    notifyListeners();
  }

  // =========================
  // INSERTAR
  // =========================
  Future<void> insertarPersona(PersonaModel persona) async {
    await service.insertarPersona(persona);

    await cargarPersonas();
  }

  // =========================
  // ACTUALIZAR
  // =========================
  Future<void> actualizarPersona(PersonaModel persona) async {
    await service.actualizarPersona(persona);

    await cargarPersonas();
  }

  // =========================
  // ELIMINAR
  // =========================
  Future<void> eliminarPersona(String ciPersona) async {
    await service.eliminarPersona(ciPersona);

    await cargarPersonas();
  }
}
