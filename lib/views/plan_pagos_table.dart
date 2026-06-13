import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/calculadora_model.dart';

class PlanPagosTable extends StatelessWidget {
  final List<CuotaCalculada> cuotas;
  final int maxRows;

  const PlanPagosTable({super.key, required this.cuotas, this.maxRows = 60});

  @override
  Widget build(BuildContext context) {
    if (cuotas.isEmpty) {
      return const Center(child: Text('Sin cuotas calculadas'));
    }

    final visibles = cuotas.take(maxRows).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final cuota = visibles[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xffe2e8f0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuota #${cuota.numero}',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    _Field(label: 'Fecha', value: _date(cuota.fecha)),
                    _Field(label: 'Capital', value: _money(cuota.capital)),
                    _Field(label: 'Interes', value: _money(cuota.interes)),
                    _Field(label: 'Total', value: _money(cuota.total)),
                    _Field(label: 'Saldo', value: _money(cuota.saldoRestante)),
                  ],
                ),
              );
            },
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(const Color(0xfff8fafc)),
            columns: const [
              DataColumn(label: Text('Nro')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Capital')),
              DataColumn(label: Text('Interes')),
              DataColumn(label: Text('Total cuota')),
              DataColumn(label: Text('Saldo restante')),
            ],
            rows: visibles.map((cuota) {
              return DataRow(
                cells: [
                  DataCell(Text('${cuota.numero}')),
                  DataCell(Text(_date(cuota.fecha))),
                  DataCell(Text(_money(cuota.capital))),
                  DataCell(Text(_money(cuota.interes))),
                  DataCell(Text(_money(cuota.total))),
                  DataCell(Text(_money(cuota.saldoRestante))),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String _money(double value) {
    return 'Bs ${value.toStringAsFixed(2)}';
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xff64748b),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}
