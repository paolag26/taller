import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/erp_card.dart';

double _progressValue(String estado) {
  final text = estado.toUpperCase();
  if (text == 'PAGADO' || text == 'CANCELADO') return 1;
  return 0;
}

Color _progressColor(String estado) {
  final text = estado.toUpperCase();
  if (text == 'PAGADO') return const Color(0xff16a34a);
  if (text == 'MORA') return const Color(0xffdc2626);
  if (text == 'CANCELADO') return const Color(0xff64748b);
  return const Color(0xff2563eb);
}

String _money(dynamic value) {
  final number = double.tryParse(value?.toString() ?? '') ?? 0;
  return number.toStringAsFixed(2);
}

double _num(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

double _prestamoProgress(Map<String, dynamic> prestamo) {
  final cuotas = List<Map<String, dynamic>>.from(prestamo['cuotas'] ?? []);
  if (cuotas.isEmpty) {
    return _progressValue(prestamo['estado_prestamo']?['nombre'] ?? '');
  }

  final total = cuotas.length;
  if (total <= 0) return 0;

  final pagadas = cuotas.where((cuota) {
    final saldo = _num(cuota['saldo_pendiente'] ?? cuota['saldo_restante']);
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    return estado == 'PAGADO' || estado == 'PAGADA' || saldo <= 0;
  }).length;

  return (pagadas / total).clamp(0, 1);
}

class PrestamoTable extends StatelessWidget {
  final List<Map<String, dynamic>> prestamos;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const PrestamoTable({
    super.key,
    required this.prestamos,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return _PrestamoCardList(
            prestamos: prestamos,
            onEdit: onEdit,
            onDelete: onDelete,
          );
        }

        return _PrestamoDesktopTable(
          prestamos: prestamos,
          onEdit: onEdit,
          onDelete: onDelete,
        );
      },
    );
  }
}

class _PrestamoDesktopTable extends StatelessWidget {
  final List<Map<String, dynamic>> prestamos;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const _PrestamoDesktopTable({
    required this.prestamos,
    required this.onEdit,
    required this.onDelete,
  });

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
                Expanded(child: _HeaderText('Codigo')),
                Expanded(flex: 2, child: _HeaderText('Cliente')),
                Expanded(child: _HeaderText('Monto')),
                Expanded(child: _HeaderText('Interes')),
                Expanded(child: _HeaderText('Tipo')),
                Expanded(child: _HeaderText('Estado')),
                Expanded(child: _HeaderText('Avance')),
                SizedBox(width: 120, child: _HeaderText('Acciones')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: prestamos.length,
              itemBuilder: (context, index) {
                final prestamo = prestamos[index];
                final persona = prestamo['cliente']?['persona'];
                final tipo = prestamo['tipo_prestamo'];
                final estado = prestamo['estado_prestamo'];
                final estadoText = estado?['nombre']?.toString() ?? 'INFO';
                final progress = _prestamoProgress(prestamo);
                final progressLabel = '${(progress * 100).toStringAsFixed(0)}%';

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
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '#${prestamo['id_prestamo']}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${persona?['nombres'] ?? ''} '
                                  '${persona?['apellido_paterno'] ?? ''}'
                              .trim(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(child: Text('Bs ${_money(prestamo['monto'])}')),
                      Expanded(child: Text('${prestamo['interes']}%')),
                      Expanded(
                        child: Text(
                          tipo?['nombre'] ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(child: StatusChip.fromText(estadoText)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(999),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 7,
                                    backgroundColor: const Color(0xffeef2f7),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _progressColor(estadoText),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                progressLabel,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () => onEdit(prestamo),
                              tooltip: 'Editar',
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () => onDelete(prestamo),
                              tooltip: 'Cancelar',
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        ),
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

class _PrestamoCardList extends StatelessWidget {
  final List<Map<String, dynamic>> prestamos;
  final ValueChanged<Map<String, dynamic>> onEdit;
  final ValueChanged<Map<String, dynamic>> onDelete;

  const _PrestamoCardList({
    required this.prestamos,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: prestamos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final prestamo = prestamos[index];
        final persona = prestamo['cliente']?['persona'];
        final tipo = prestamo['tipo_prestamo'];
        final estado = prestamo['estado_prestamo'];
        final estadoText = estado?['nombre']?.toString() ?? 'INFO';
        final progress = _prestamoProgress(prestamo);
        final nombre =
            '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''}'
                .trim();

        return ErpCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${prestamo['id_prestamo']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  StatusChip.fromText(estadoText),
                ],
              ),
              const SizedBox(height: 10),
              _MobileField(label: 'Cliente', value: nombre),
              _MobileField(
                label: 'Monto',
                value: 'Bs ${_money(prestamo['monto'])}',
              ),
              _MobileField(label: 'Interes', value: '${prestamo['interes']}%'),
              _MobileField(
                label: 'Tipo',
                value: tipo?['nombre']?.toString() ?? '',
              ),
              _MobileField(
                label: 'Avance',
                value: '${(progress * 100).toStringAsFixed(0)}%',
              ),
              const SizedBox(height: 4),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: const Color(0xffeef2f7),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _progressColor(estadoText),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => onEdit(prestamo),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => onDelete(prestamo),
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MobileField extends StatelessWidget {
  final String label;
  final String value;

  const _MobileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 74,
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
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
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
