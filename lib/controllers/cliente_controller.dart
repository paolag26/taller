import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/cliente_model.dart';

import 'package:sist_prestamo/controllers/cliente_service.dart';

import 'package:sist_prestamo/models/persona_model.dart';

class ClienteController extends ChangeNotifier {
  final service = ClienteService();

  bool loading = false;

  List<Map<String, dynamic>> clientes = [];
  String query = '';
  String estadoFiltro = 'TODOS';

  // =========================
  // LISTAR
  // =========================

  Future<void> cargarClientes() async {
    loading = true;

    notifyListeners();

    clientes = await service.listarClientes();

    loading = false;

    notifyListeners();
  }

  List<Map<String, dynamic>> get clientesFiltrados {
    return clientes.where((cliente) {
      final coincideEstado =
          estadoFiltro == 'TODOS' ||
          (estadoFiltro == 'ACTIVOS' && cliente['estado'] == true) ||
          (estadoFiltro == 'INACTIVOS' && cliente['estado'] != true);

      final coincideBusqueda = _coincideBusqueda(cliente);

      return coincideEstado && coincideBusqueda;
    }).toList();
  }

  void cambiarBusqueda(String value) {
    query = value;
    notifyListeners();
  }

  void cambiarEstado(String value) {
    estadoFiltro = value;
    notifyListeners();
  }

  bool _coincideBusqueda(Map<String, dynamic> cliente) {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return true;

    final persona = cliente['persona'];
    final nombre =
        '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''} ${persona?['apellido_materno'] ?? ''}'
            .toLowerCase();
    final ci = cliente['ci_persona']?.toString().toLowerCase() ?? '';
    final telefono = persona?['telefono']?.toString().toLowerCase() ?? '';

    return nombre.contains(text) ||
        ci.contains(text) ||
        telefono.contains(text);
  }

  // =========================
  // INSERTAR
  // =========================

  Future<void> insertarCliente(ClienteModel cliente) async {
    await service.insertarCliente(cliente);

    await cargarClientes();
  }

  Future<void> insertarClienteConPersona(
    PersonaModel persona,

    ClienteModel cliente, {
    String tipoUsuario = 'CLIENTE',
    required String username,
    required String password,
  }) async {
    await service.insertarClienteConPersona(
      persona,
      cliente,
      tipoUsuario: tipoUsuario,
      username: username,
      password: password,
    );

    await cargarClientes();
  }

  // =========================
  // ACTUALIZAR
  // =========================

  Future<void> actualizarCliente(ClienteModel cliente) async {
    await service.actualizarCliente(cliente);

    await cargarClientes();
  }

  Future<void> actualizarClienteConPersona(
    PersonaModel persona,

    ClienteModel cliente,
  ) async {
    await service.actualizarClienteConPersona(persona, cliente);

    await cargarClientes();
  }

  // =========================
  // ELIMINAR
  // =========================

  Future<void> eliminarCliente(int idCliente) async {
    await service.eliminarCliente(idCliente);

    await cargarClientes();
  }
}
