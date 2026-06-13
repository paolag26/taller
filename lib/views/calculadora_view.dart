import 'package:flutter/material.dart';

import 'package:sist_prestamo/provider/calculadora_provider.dart';
import 'package:sist_prestamo/views/calculadora_form_card.dart';
import 'package:sist_prestamo/views/resumen_financiero_card.dart';

class CalculadoraView extends StatefulWidget {
  final void Function(Widget view, String title)? onNavigate;

  const CalculadoraView({super.key, this.onNavigate});

  @override
  State<CalculadoraView> createState() => _CalculadoraViewState();
}

class _CalculadoraViewState extends State<CalculadoraView> {
  final controller = CalculadoraProvider().controller;

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
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Calculadora de Prestamos',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Simule cuotas, intereses y cronograma antes de registrar un prestamo.',
                style: TextStyle(color: Color(0xff64748b)),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= 980;
                  final form = CalculadoraFormCard(
                    controller: controller,
                    onGuardar: () {
                      _guardarSimulacion();
                    },
                    onConfirmar: _confirmarPrestamo,
                  );
                  final resumen = ResumenFinancieroCard(
                    simulacion: controller.simulacion,
                    error: controller.error,
                  );

                  if (!wide) {
                    return Column(
                      children: [form, const SizedBox(height: 16), resumen],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 380, child: form),
                      const SizedBox(width: 16),
                      Expanded(child: resumen),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _guardarSimulacion() async {
    final simulacion = controller.simulacion;
    if (simulacion == null) return;

    try {
      await controller.guardarSimulacion();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Simulacion guardada: ${controller.tipoLabel} por Bs ${simulacion.totalACobrar.toStringAsFixed(2)}',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo guardar la simulacion: $e')),
      );
    }
  }

  Future<void> _confirmarPrestamo() async {
    final simulacion = controller.simulacion;
    if (simulacion == null) return;

    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar prestamo'),
          content: Text(
            'Se guardara el prestamo con ${simulacion.cuotas.length} cuotas por un total de Bs ${simulacion.totalACobrar.toStringAsFixed(2)}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Revisar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirmar prestamo'),
            ),
          ],
        );
      },
    );

    if (confirmar != true) return;

    try {
      await controller.confirmarPrestamo();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Prestamo guardado con plan de pagos automatico'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo confirmar el prestamo: $e')),
      );
    }
  }
}
