import 'package:flutter/material.dart';
import 'package:sist_prestamo/provider/prestamo_provider.dart';
import 'package:sist_prestamo/models/calculadora_model.dart';
import 'package:sist_prestamo/views/prestamo_search.dart';
import 'package:sist_prestamo/views/prestamo_filters.dart';
import 'package:sist_prestamo/views/prestamo_table.dart';
import 'package:sist_prestamo/views/prestamo_form_dialog.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/views/empty_widget.dart';
import 'package:sist_prestamo/views/erp_card.dart';

class PrestamosView extends StatefulWidget {
  final SimulacionPrestamo? simulacionInicial;

  const PrestamosView({super.key, this.simulacionInicial});

  @override
  State<PrestamosView> createState() => _PrestamosViewState();
}

class _PrestamosViewState extends State<PrestamosView> {
  final controller = PrestamoProvider().controller;

  @override
  void initState() {
    super.initState();

    controller.cargarPrestamos();

    if (widget.simulacionInicial != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _nuevoPrestamoDesdeSimulacion();
        }
      });
    }
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

          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SectionTitle(
                title: 'Prestamos',
                subtitle:
                    'Cartera activa, estados y seguimiento operativo de creditos.',
                trailing: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PrestamoFormDialog(controller: controller);
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Nuevo prestamo'),
                ),
              ),

              const SizedBox(height: 18),

              // =====================
              // TOOLBAR
              // =====================
              ErpCard(
                padding: const EdgeInsets.all(14),
                child: Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,

                      child: PrestamoSearch(
                        onChanged: controller.cambiarBusqueda,
                      ),
                    ),

                    SizedBox(
                      width: 180,

                      child: PrestamoFilters(
                        value: controller.estadoFiltro,
                        onChanged: controller.cambiarEstado,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =====================
              // TABLA
              // =====================
              Expanded(
                child: controller.prestamosFiltrados.isEmpty
                    ? const EmptyWidget(message: 'No existen prestamos')
                    : PrestamoTable(
                        prestamos: controller.prestamosFiltrados,
                        onEdit: _editarPrestamo,
                        onDelete: _confirmarCancelarPrestamo,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editarPrestamo(Map<String, dynamic> prestamo) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PrestamoFormDialog(controller: controller, prestamo: prestamo);
      },
    );
  }

  Future<void> _nuevoPrestamoDesdeSimulacion() async {
    await showDialog(
      context: context,
      builder: (context) {
        return PrestamoFormDialog(
          controller: controller,
          simulacionInicial: widget.simulacionInicial,
        );
      },
    );
  }

  Future<void> _confirmarCancelarPrestamo(Map<String, dynamic> prestamo) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cancelar prestamo'),
          content: Text(
            'El prestamo #${prestamo['id_prestamo']} quedara en estado CANCELADO.',
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
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) {
      return;
    }

    try {
      await controller.cancelarPrestamo(prestamo['id_prestamo']);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Prestamo cancelado')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo cancelar el prestamo: $e')),
      );
    }
  }
}
