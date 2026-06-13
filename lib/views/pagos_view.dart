import 'package:flutter/material.dart';

import 'package:sist_prestamo/provider/pago_provider.dart';

import 'package:sist_prestamo/views/pago_table.dart';

import 'package:sist_prestamo/views/pago_search.dart';

import 'package:sist_prestamo/views/pago_filters.dart';

import 'package:sist_prestamo/views/pago_form_dialog.dart';

import 'package:sist_prestamo/views/loading_widget.dart';

import 'package:sist_prestamo/views/empty_widget.dart';
import 'package:sist_prestamo/views/erp_card.dart';

class PagosView extends StatefulWidget {
  const PagosView({super.key});

  @override
  State<PagosView> createState() => _PagosViewState();
}

class _PagosViewState extends State<PagosView> {
  final controller = PagoProvider().controller;

  @override
  void initState() {
    super.initState();

    controller.cargarPagos();
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
                title: 'Pagos',
                subtitle:
                    'Registro de pagos normales, adelantados, mora y amortizaciones.',
                trailing: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PagoFormDialog(controller: controller);
                      },
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Nuevo pago'),
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

                  children: [
                    const SizedBox(width: 300, child: PagoSearch()),

                    const SizedBox(width: 220, child: PagoFilters()),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =====================
              // TABLA
              // =====================
              Expanded(
                child: controller.pagos.isEmpty
                    ? const EmptyWidget(message: 'No existen pagos')
                    : PagoTable(pagos: controller.pagos),
              ),
            ],
          ),
        );
      },
    );
  }
}
