import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/calculadora_model.dart';
import 'package:sist_prestamo/views/plan_pagos_table.dart';

class PrestamoPlanPreview extends StatelessWidget {
  final SimulacionPrestamo? simulacion;

  const PrestamoPlanPreview({super.key, required this.simulacion});

  @override
  Widget build(BuildContext context) {
    final data = simulacion;
    if (data == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe2e8f0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vista previa del plan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _Chip(label: 'Total', value: _money(data.totalACobrar)),
              _Chip(label: 'Interes', value: _money(data.interesTotal)),
              _Chip(label: 'Cuota', value: _money(data.valorCuota)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 260,
            child: SingleChildScrollView(
              child: PlanPagosTable(cuotas: data.cuotas, maxRows: 12),
            ),
          ),
        ],
      ),
    );
  }

  String _money(double value) {
    return 'Bs ${value.toStringAsFixed(2)}';
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;

  const _Chip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe2e8f0)),
      ),
      child: Text('$label: $value'),
    );
  }
}
