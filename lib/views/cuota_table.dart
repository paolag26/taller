import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_formatters.dart';
import 'package:sist_prestamo/views/erp_card.dart';

class CuotaTable extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;

  const CuotaTable({super.key, required this.cuotas});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _CuotaCards(cuotas: cuotas);
        }

        return _CuotaDesktopTable(cuotas: cuotas);
      },
    );
  }
}

class _CuotaDesktopTable extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;

  const _CuotaDesktopTable({required this.cuotas});

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xfff8fafc),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffe2e8f0)),
            ),
            child: const Row(
              children: [
                Expanded(child: _HeaderText('Nro')),
                Expanded(flex: 2, child: _HeaderText('Cliente / CI')),
                Expanded(child: _HeaderText('Prestamo')),
                Expanded(child: _HeaderText('Monto')),
                Expanded(child: _HeaderText('Vencimiento')),
                Expanded(child: _HeaderText('Saldo')),
                Expanded(child: _HeaderText('Estado')),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cuotas.length,
              itemBuilder: (context, index) {
                final cuota = cuotas[index];
                final estado = _estadoCuota(cuota);
                final color = _estadoColor(estado);
                final cliente = cuota['prestamo']?['cliente'];
                final persona = cliente?['persona'];
                final nombre =
                    '${persona?['nombres'] ?? ''} '
                            '${persona?['apellido_paterno'] ?? ''}'
                        .trim();
                final ci = cliente?['ci_persona'] ?? '';

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffedf2f7)),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text('${cuota['numero_cuota'] ?? ''}')),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${nombre.isEmpty ? 'Cliente sin nombre' : nombre}\n$ci',
                        ),
                      ),
                      Expanded(child: Text('#${cuota['id_prestamo'] ?? ''}')),
                      Expanded(
                        child: Text(AppFormatters.money(cuota['monto_cuota'])),
                      ),
                      Expanded(child: Text(cuota['fecha_vencimiento'] ?? '')),
                      Expanded(
                        child: Text(
                          AppFormatters.money(
                            cuota['saldo_pendiente'] ?? cuota['saldo_restante'],
                          ),
                        ),
                      ),
                      Expanded(
                        child: StatusChip(label: estado, color: color),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CuotaCards extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;

  const _CuotaCards({required this.cuotas});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cuotas.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final cuota = cuotas[index];
        final estado = _estadoCuota(cuota);
        final color = _estadoColor(estado);
        final cliente = cuota['prestamo']?['cliente'];
        final persona = cliente?['persona'];
        final nombre =
            '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''}'
                .trim();
        final ci = cliente?['ci_persona'] ?? '';

        return ErpCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Cuota #${cuota['numero_cuota'] ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  StatusChip(label: estado, color: color),
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
              _Field(
                label: 'Cliente',
                value:
                    '${nombre.isEmpty ? 'Cliente sin nombre' : nombre} - $ci',
              ),
              _Field(
                label: 'Prestamo',
                value: '#${cuota['id_prestamo'] ?? ''}',
              ),
              _Field(
                label: 'Monto',
                value: AppFormatters.money(cuota['monto_cuota']),
              ),
              _Field(
                label: 'Saldo',
                value: AppFormatters.money(
                  cuota['saldo_pendiente'] ?? cuota['saldo_restante'],
                ),
              ),
              _Field(
                label: 'Vence',
                value: cuota['fecha_vencimiento']?.toString() ?? '',
              ),
            ],
          ),
        );
      },
    );
  }
}

String _estadoCuota(Map<String, dynamic> cuota) {
  final estado = cuota['estado']?.toString().toUpperCase() ?? '';
  if (estado == 'PAGADA' || estado == 'PAGADO') return 'PAGADO';
  if (estado == 'MORA') return 'MORA';

  final saldo =
      double.tryParse(
        (cuota['saldo_pendiente'] ?? cuota['saldo_restante'])?.toString() ?? '',
      ) ??
      0;
  final fecha = DateTime.tryParse(cuota['fecha_vencimiento'] ?? '');
  if (saldo > 0 && fecha != null) {
    final hoy = DateTime.now();
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    final fechaSinHora = DateTime(fecha.year, fecha.month, fecha.day);
    if (fechaSinHora.isBefore(hoySinHora)) return 'MORA';
  }

  return 'PENDIENTE';
}

Color _estadoColor(String estado) {
  switch (estado) {
    case 'PAGADO':
      return const Color(0xff16a34a);
    case 'MORA':
      return const Color(0xffdc2626);
    default:
      return const Color(0xffd97706);
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
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;

  const _HeaderText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xff475569),
        fontSize: 12,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
