import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_formatters.dart';
import 'package:sist_prestamo/views/erp_card.dart';

class PagoTable extends StatelessWidget {
  final List<Map<String, dynamic>> pagos;

  const PagoTable({super.key, required this.pagos});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _PagoCards(pagos: pagos);
        }

        return _PagoDesktopTable(pagos: pagos);
      },
    );
  }
}

class _PagoDesktopTable extends StatelessWidget {
  final List<Map<String, dynamic>> pagos;

  const _PagoDesktopTable({required this.pagos});

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 48,
          dataRowMinHeight: 54,
          dataRowMaxHeight: 62,
          headingRowColor: WidgetStateProperty.all(const Color(0xfff8fafc)),
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey.shade100),
          ),
          columns: const [
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Cliente')),
            DataColumn(label: Text('Monto')),
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Metodo')),
            DataColumn(label: Text('Estado')),
            DataColumn(label: Text('Cuotas')),
          ],
          rows: pagos.map((pago) {
            final tipo = pago['tipo_pago'] ?? 'NORMAL';
            final estado =
                pago['estado_pago'] ??
                (pago['pago_completo'] == true ? 'COMPLETO' : 'PARCIAL');
            final cuotasIds = pago['cuotas_ids'];
            final cantidadCuotas = cuotasIds is List ? cuotasIds.length : 1;

            return DataRow(
              cells: [
                DataCell(Text(pago['fecha_pago']?.toString() ?? '')),
                DataCell(Text(_nombreCliente(pago))),
                DataCell(Text(AppFormatters.money(pago['monto']))),
                DataCell(
                  _Badge(text: tipo.toString(), color: _tipoColor(tipo)),
                ),
                DataCell(Text(pago['metodo_pago'] ?? '')),
                DataCell(
                  _Badge(
                    text: estado.toString(),
                    color: estado == 'COMPLETO' ? Colors.green : Colors.orange,
                  ),
                ),
                DataCell(Text('$cantidadCuotas')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _PagoCards extends StatelessWidget {
  final List<Map<String, dynamic>> pagos;

  const _PagoCards({required this.pagos});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: pagos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final pago = pagos[index];
        final tipo = pago['tipo_pago'] ?? 'NORMAL';
        final estado =
            pago['estado_pago'] ??
            (pago['pago_completo'] == true ? 'COMPLETO' : 'PARCIAL');
        final cuotasIds = pago['cuotas_ids'];
        final cantidadCuotas = cuotasIds is List ? cuotasIds.length : 1;

        return ErpCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _nombreCliente(pago),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'detalle',
                        child: Text('Ver detalle'),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Badge(text: tipo.toString(), color: _tipoColor(tipo)),
                  _Badge(
                    text: estado.toString(),
                    color: estado == 'COMPLETO' ? Colors.green : Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _Field(
                label: 'Fecha',
                value: pago['fecha_pago']?.toString() ?? '',
              ),
              _Field(label: 'Monto', value: AppFormatters.money(pago['monto'])),
              _Field(
                label: 'Metodo',
                value: pago['metodo_pago']?.toString() ?? '',
              ),
              _Field(label: 'Cuotas', value: '$cantidadCuotas'),
            ],
          ),
        );
      },
    );
  }
}

String _nombreCliente(Map<String, dynamic> pago) {
  final persona = pago['cuota']?['prestamo']?['cliente']?['persona'];
  final nombres = persona?['nombres'] ?? '';
  final paterno = persona?['apellido_paterno'] ?? '';
  final nombre = '$nombres $paterno'.trim();
  return nombre.isEmpty ? 'Sin cliente' : nombre;
}

Color _tipoColor(dynamic tipo) {
  return switch (tipo?.toString()) {
    'ADELANTADO' => Colors.blue,
    'MORA' => Colors.red,
    'AMORTIZACION' => Colors.purple,
    _ => Colors.green,
  };
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: TextStyle(color: color)),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final String value;

  const _Field({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 78,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xff64748b),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
