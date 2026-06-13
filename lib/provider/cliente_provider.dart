import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/cliente_controller.dart';
import 'package:sist_prestamo/models/cliente_model.dart';
import 'package:sist_prestamo/models/persona_model.dart';

class ClienteProvider extends ChangeNotifier {
  final controller = ClienteController();

  List<Map<String, dynamic>> clientes = [];
  bool cargando = false;
  String? error;

  Future<void> cargarClientes() async {
    cargando = true;
    error = null;
    notifyListeners();
    try {
      await controller.cargarClientes();
      clientes = controller.clientes;
    } catch (e) {
      error = e.toString().replaceFirst('Exception: ', '');
    }
    cargando = false;
    notifyListeners();
  }

  Future<void> insertar(ClienteModel cliente) async {
    await controller.insertarCliente(cliente);
    await cargarClientes();
  }

  Future<void> insertarConPersona(
    PersonaModel persona,
    ClienteModel cliente, {
    required String username,
    required String password,
    String tipoUsuario = 'CLIENTE',
  }) async {
    await controller.insertarClienteConPersona(
      persona,
      cliente,
      username: username,
      password: password,
      tipoUsuario: tipoUsuario,
    );
    await cargarClientes();
  }

  Future<void> actualizar(ClienteModel cliente) async {
    await controller.actualizarCliente(cliente);
    await cargarClientes();
  }

  Future<void> eliminar(int idCliente) async {
    await controller.eliminarCliente(idCliente);
    await cargarClientes();
  }

  void buscar(String value) {
    controller.cambiarBusqueda(value);
    clientes = controller.clientesFiltrados;
    notifyListeners();
  }
}
