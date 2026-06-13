import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/calculadora_model.dart';
import 'package:sist_prestamo/views/plan_pagos_table.dart';

class ResumenFinancieroCard extends StatelessWidget {
  final SimulacionPrestamo? simulacion;
  final String? error;

  const ResumenFinancieroCard({
    super.key,
    required this.simulacion,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xffe2e8f0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen financiero',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (error != null)
              _ErrorBox(message: error!)
            else if (simulacion == null)
              const Center(child: Text('Complete los datos para simular'))
            else ...[
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Metric(
                    title: 'Total a cobrar',
                    value: _money(simulacion!.totalACobrar),
                    icon: Icons.account_balance,
                  ),
                  _Metric(
                    title: 'Interes total',
                    value: _money(simulacion!.interesTotal),
                    icon: Icons.trending_up,
                  ),
                  _Metric(
                    title: 'Valor cuota',
                    value: _money(simulacion!.valorCuota),
                    icon: Icons.payments,
                  ),
                  _Metric(
                    title: 'Cuotas',
                    value: '${simulacion!.numeroCuotas}',
                    icon: Icons.view_list,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Cronograma de pagos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffe2e8f0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: PlanPagosTable(cuotas: simulacion!.cuotas),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _money(double value) {
    return 'Bs ${value.toStringAsFixed(2)}';
  }
}

class _Metric extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _Metric({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xff14532d)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff64748b),
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;

  const _ErrorBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffff1f2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xfffecdd3)),
      ),
      child: Text(message, style: const TextStyle(color: Color(0xffbe123c))),
    );
  }
}
