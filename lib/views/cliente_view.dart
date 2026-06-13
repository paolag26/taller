import 'package:flutter/material.dart';

import 'package:sist_prestamo/provider/cliente_provider.dart';
import 'package:sist_prestamo/views/cliente_search.dart';
import 'package:sist_prestamo/views/cliente_filters.dart';
import 'package:sist_prestamo/views/cliente_table.dart';
import 'package:sist_prestamo/views/cliente_form_dialog.dart';

import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/views/empty_widget.dart';

class ClientesView extends StatefulWidget {
  const ClientesView({super.key});

  @override
  State<ClientesView> createState() => _ClientesViewState();
}

class _ClientesViewState extends State<ClientesView> {
  final controller = ClienteProvider().controller;

  @override
  void initState() {
    super.initState();

    controller.cargarClientes();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,

      builder: (context, child) {
        // =====================
        // LOADING
        // =====================

        if (controller.loading) {
          return const LoadingWidget();
        }

        return Container(
          width: double.infinity,

          height: double.infinity,

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // =====================
              // TOOLBAR
              // =====================
              Wrap(
                spacing: 20,

                runSpacing: 20,

                crossAxisAlignment: WrapCrossAlignment.center,

                children: [
                  SizedBox(
                    width: 300,
                    child: ClienteSearch(onChanged: controller.cambiarBusqueda),
                  ),

                  SizedBox(
                    width: 180,
                    child: ClienteFilters(
                      value: controller.estadoFiltro,
                      onChanged: controller.cambiarEstado,
                    ),
                  ),

                  SizedBox(
                    height: 45,

                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,

                          builder: (context) {
                            return ClienteFormDialog(controller: controller);
                          },
                        );
                      },

                      icon: const Icon(Icons.add),

                      label: const Text('Nuevo Cliente'),
                    ),
                  ),
                ],
              ),

              // =====================
              // TABLA
              // =====================
              Expanded(
                child: controller.clientesFiltrados.isEmpty
                    ? const EmptyWidget(message: 'No existen clientes')
                    : ClientesTable(
                        clientes: controller.clientesFiltrados,
                        onEdit: _editarCliente,
                        onDelete: _confirmarEliminarCliente,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editarCliente(Map<String, dynamic> cliente) async {
    await showDialog(
      context: context,
      builder: (context) {
        return ClienteFormDialog(controller: controller, cliente: cliente);
      },
    );
  }

  Future<void> _confirmarEliminarCliente(Map<String, dynamic> cliente) async {
    final persona = cliente['persona'] as Map<String, dynamic>? ?? {};
    final nombre =
        '${persona['nombres'] ?? ''} '
                '${persona['apellido_paterno'] ?? ''}'
            .trim();

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Desactivar cliente'),
          content: Text(
            'El cliente ${nombre.isEmpty ? cliente['ci_persona'] : nombre} quedara inactivo.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Desactivar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    try {
      await controller.eliminarCliente(cliente['id_cliente']);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cliente desactivado')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo desactivar el cliente: $e')),
      );
    }
  }
}
