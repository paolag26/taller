import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/empty_widget.dart';
import 'package:sist_prestamo/views/erp_card.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/provider/pago_provider.dart';
import 'package:sist_prestamo/views/pago_form_dialog.dart';
import 'package:sist_prestamo/provider/cuota_provider.dart';
import 'package:sist_prestamo/controllers/cuota_controller.dart';

class CuotasView extends StatefulWidget {
  const CuotasView({super.key});

  @override
  State<CuotasView> createState() => _CuotasViewState();
}

class _CuotasViewState extends State<CuotasView> {
  final controller = CuotaProvider().controller;
  final pagoController = PagoProvider().controller;
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    controller.dispose();
    pagoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.loading) return const LoadingWidget();

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: 'Plan de pagos',
                subtitle:
                    'Busque un cliente, seleccione su prestamo y revise todas sus cuotas.',
              ),
              const SizedBox(height: 16),
              _SearchPanel(
                controller: controller,
                searchController: searchController,
              ),
              if (controller.errorBusqueda != null) ...[
                const SizedBox(height: 12),
                _InfoBox(text: controller.errorBusqueda!),
              ],
              const SizedBox(height: 16),
              Expanded(
                child: _Body(controller: controller, onPay: _registrarPago),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _registrarPago(Map<String, dynamic> cuota) async {
    await showDialog(
      context: context,
      builder: (context) {
        return PagoFormDialog(
          controller: pagoController,
          cuotaInicialId: cuota['id_cuota'],
        );
      },
    );

    final cliente = controller.clienteEncontrado;
    if (cliente != null) {
      await controller.seleccionarCliente(cliente);
    }
  }
}

class _SearchPanel extends StatelessWidget {
  final CuotaController controller;
  final TextEditingController searchController;

  const _SearchPanel({
    required this.controller,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 360,
            child: TextField(
              controller: searchController,
              inputFormatters: AppValidators.safeText,
              onSubmitted: controller.buscarClientes,
              decoration: const InputDecoration(
                labelText: 'Buscar por CI, nombre completo o telefono',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => controller.buscarClientes(searchController.text),
            icon: const Icon(Icons.search),
            label: const Text('Buscar cliente'),
          ),
          if (controller.clientesEncontrados.length > 1)
            SizedBox(
              width: 330,
              child: DropdownButtonFormField<int>(
                decoration: const InputDecoration(
                  labelText: 'Seleccionar cliente',
                ),
                items: controller.clientesEncontrados.map((cliente) {
                  return DropdownMenuItem<int>(
                    value: cliente['id_cliente'],
                    child: Text(_nombreCliente(cliente)),
                  );
                }).toList(),
                onChanged: (id) {
                  if (id == null) return;
                  final cliente = controller.clientesEncontrados.firstWhere(
                    (item) => item['id_cliente'] == id,
                  );
                  controller.seleccionarCliente(cliente);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final CuotaController controller;
  final ValueChanged<Map<String, dynamic>> onPay;

  const _Body({required this.controller, required this.onPay});

  @override
  Widget build(BuildContext context) {
    if (controller.clienteEncontrado == null) {
      return const EmptyWidget(
        message: 'Busque un cliente para visualizar su plan de pagos.',
      );
    }

    if (controller.prestamosCliente.isEmpty) {
      return const EmptyWidget(
        message: 'El cliente no tiene prestamos registrados.',
      );
    }

    return Column(
      children: [
        _ClienteResumen(controller: controller),
        const SizedBox(height: 14),
        _PrestamosSelector(controller: controller),
        const SizedBox(height: 14),
        Expanded(
          child: _PlanPagosPanel(
            controller: controller,
            cuotas: controller.cuotasPrestamoSeleccionado,
            onPay: onPay,
          ),
        ),
      ],
    );
  }
}

class _ClienteResumen extends StatelessWidget {
  final CuotaController controller;

  const _ClienteResumen({required this.controller});

  @override
  Widget build(BuildContext context) {
    final cliente = controller.clienteEncontrado!;
    final prestamo = controller.prestamoSeleccionado;
    final persona = cliente['persona'];
    final nombre = _nombreCliente(cliente);
    final tipo = prestamo?['tipo_prestamo']?['nombre'] ?? 'Sin prestamo';

    return ErpCard(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: [
          _SummaryItem(title: 'Cliente', value: nombre, icon: Icons.person),
          _SummaryItem(
            title: 'CI',
            value: cliente['ci_persona']?.toString() ?? '',
            icon: Icons.badge,
          ),
          _SummaryItem(
            title: 'Telefono',
            value: persona?['telefono']?.toString() ?? '',
            icon: Icons.phone,
          ),
          _SummaryItem(
            title: 'Tipo prestamo',
            value: tipo,
            icon: Icons.account_balance_wallet,
          ),
          _SummaryItem(
            title: 'Monto total',
            value: controller.money(controller.montoPrestamo),
            icon: Icons.request_quote,
          ),
          _SummaryItem(
            title: 'Total pagado',
            value: controller.money(controller.totalPagado),
            icon: Icons.check_circle,
          ),
          _SummaryItem(
            title: 'Saldo pendiente',
            value: controller.money(controller.saldoPendiente),
            icon: Icons.pending_actions,
          ),
          _SummaryItem(
            title: 'Pagadas',
            value: '${controller.cuotasPagadas}',
            icon: Icons.verified,
          ),
          _SummaryItem(
            title: 'Pendientes',
            value: '${controller.cuotasPendientes}',
            icon: Icons.schedule,
          ),
          _SummaryItem(
            title: 'En mora',
            value: '${controller.cuotasMora}',
            icon: Icons.warning,
          ),
        ],
      ),
    );
  }
}

class _PrestamosSelector extends StatelessWidget {
  final CuotaController controller;

  const _PrestamosSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: controller.prestamosCliente.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final prestamo = controller.prestamosCliente[index];
          final selected =
              controller.prestamoSeleccionado?['id_prestamo'] ==
              prestamo['id_prestamo'];
          final saldo = _saldoPrestamo(prestamo);

          return InkWell(
            onTap: () => controller.seleccionarPrestamo(prestamo),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 285,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: selected ? const Color(0xffecfdf5) : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? const Color(0xff14532d)
                      : const Color(0xffe2e8f0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '#${prestamo['id_prestamo']} - ${prestamo['tipo_prestamo']?['nombre'] ?? 'Sin tipo'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                      StatusChip.fromText(
                        prestamo['estado_prestamo']?['nombre'] ?? 'INFO',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Monto: Bs ${_num(prestamo['monto']).toStringAsFixed(2)}',
                  ),
                  Text('Inicio: ${prestamo['fecha_inicio'] ?? ''}'),
                  Text('Saldo: Bs ${saldo.toStringAsFixed(2)}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  double _saldoPrestamo(Map<String, dynamic> prestamo) {
    final cuotas = List<Map<String, dynamic>>.from(prestamo['cuotas'] ?? []);
    return cuotas.fold<double>(0, (total, cuota) {
      final estado = cuota['estado']?.toString().toUpperCase() ?? '';
      if (estado == 'PAGADA' || estado == 'PAGADO') return total;
      final saldo = _num(cuota['saldo_pendiente']);
      return total + (saldo > 0 ? saldo : _num(cuota['monto_cuota']));
    });
  }
}

class _PlanPagosPanel extends StatelessWidget {
  final CuotaController controller;
  final List<Map<String, dynamic>> cuotas;
  final ValueChanged<Map<String, dynamic>> onPay;

  const _PlanPagosPanel({
    required this.controller,
    required this.cuotas,
    required this.onPay,
  });

  @override
  Widget build(BuildContext context) {
    final cuotasVisibles = controller.filtrarCuotasPlan(cuotas);

    if (cuotas.isEmpty) {
      return const EmptyWidget(message: 'Este prestamo no tiene cuotas.');
    }

    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Plan de pagos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          _CuotaEstadoChips(controller: controller),
          const SizedBox(height: 12),
          if (cuotasVisibles.isEmpty)
            const Expanded(
              child: EmptyWidget(message: 'No hay cuotas para este filtro.'),
            )
          else
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 700) {
                    return ListView.separated(
                      itemCount: cuotasVisibles.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final cuota = cuotasVisibles[index];
                        final estado = controller.estadoCuota(cuota);
                        final pagada = estado == 'PAGADO';
                        return ErpCard(
                          padding: const EdgeInsets.all(14),
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
                                  StatusChip.fromText(estado),
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'detalle') {
                                        _showDetalle(context, cuota);
                                      }
                                      if (value == 'pago' && !pagada) {
                                        onPay(cuota);
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 'detalle',
                                        child: Text('Ver detalle'),
                                      ),
                                      if (!pagada)
                                        const PopupMenuItem(
                                          value: 'pago',
                                          child: Text('Registrar pago'),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              _MobileField(
                                label: 'Vence',
                                value:
                                    cuota['fecha_vencimiento']?.toString() ??
                                    '',
                              ),
                              _MobileField(
                                label: 'Monto',
                                value: controller.money(
                                  controller.montoCuota(cuota),
                                ),
                              ),
                              _MobileField(
                                label: 'Capital',
                                value: controller.money(cuota['capital']),
                              ),
                              _MobileField(
                                label: 'Interes',
                                value: controller.money(cuota['interes']),
                              ),
                              _MobileField(
                                label: 'Saldo',
                                value: controller.money(
                                  controller.saldoCuota(cuota),
                                ),
                              ),
                              _MobileField(
                                label: 'Pago',
                                value: controller.tipoPagoCuota(cuota),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.all(
                        const Color(0xfff8fafc),
                      ),
                      columns: const [
                        DataColumn(label: Text('Nro')),
                        DataColumn(label: Text('Vencimiento')),
                        DataColumn(label: Text('Monto cuota')),
                        DataColumn(label: Text('Capital')),
                        DataColumn(label: Text('Interes')),
                        DataColumn(label: Text('Saldo restante')),
                        DataColumn(label: Text('Estado')),
                        DataColumn(label: Text('Pago')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: cuotasVisibles.map((cuota) {
                        final estado = controller.estadoCuota(cuota);
                        final pagada = estado == 'PAGADO';
                        return DataRow(
                          cells: [
                            DataCell(Text('${cuota['numero_cuota'] ?? ''}')),
                            DataCell(
                              Text(
                                cuota['fecha_vencimiento']?.toString() ?? '',
                              ),
                            ),
                            DataCell(
                              Text(
                                controller.money(controller.montoCuota(cuota)),
                              ),
                            ),
                            DataCell(Text(controller.money(cuota['capital']))),
                            DataCell(Text(controller.money(cuota['interes']))),
                            DataCell(
                              Text(
                                controller.money(controller.saldoCuota(cuota)),
                              ),
                            ),
                            DataCell(StatusChip.fromText(estado)),
                            DataCell(
                              StatusChip.fromText(
                                controller.tipoPagoCuota(cuota),
                              ),
                            ),
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    tooltip: 'Detalle',
                                    onPressed: () =>
                                        _showDetalle(context, cuota),
                                    icon: const Icon(Icons.visibility_outlined),
                                  ),
                                  IconButton(
                                    tooltip: pagada
                                        ? 'Cuota pagada'
                                        : 'Registrar pago',
                                    onPressed: pagada
                                        ? null
                                        : () => onPay(cuota),
                                    icon: const Icon(Icons.payments_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  void _showDetalle(BuildContext context, Map<String, dynamic> cuota) {
    showDialog(
      context: context,
      builder: (context) {
        return _CuotaDetalleDialog(controller: controller, cuota: cuota);
      },
    );
  }
}

class _CuotaEstadoChips extends StatelessWidget {
  final CuotaController controller;

  const _CuotaEstadoChips({required this.controller});

  @override
  Widget build(BuildContext context) {
    const items = {
      'TODOS': 'Todas',
      'PENDIENTE': 'Pendientes',
      'PAGADO': 'Pagadas',
      'MORA': 'Vencidas',
      'HOY': 'Hoy',
    };

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.entries.map((item) {
        return FilterChip(
          label: Text(item.value),
          selected: controller.estadoFiltro == item.key,
          onSelected: (_) => controller.cambiarEstado(item.key),
        );
      }).toList(),
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
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 76,
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

class _CuotaDetalleDialog extends StatelessWidget {
  final CuotaController controller;
  final Map<String, dynamic> cuota;

  const _CuotaDetalleDialog({required this.controller, required this.cuota});

  @override
  Widget build(BuildContext context) {
    final pagos = List<Map<String, dynamic>>.from(cuota['pagos'] ?? []);

    return AlertDialog(
      title: Text('Detalle cuota #${cuota['numero_cuota'] ?? ''}'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailRow(
                'Vencimiento',
                cuota['fecha_vencimiento']?.toString() ?? '',
              ),
              _DetailRow(
                'Monto',
                controller.money(controller.montoCuota(cuota)),
              ),
              _DetailRow('Capital', controller.money(cuota['capital'])),
              _DetailRow('Interes', controller.money(cuota['interes'])),
              _DetailRow(
                'Saldo',
                controller.money(controller.saldoCuota(cuota)),
              ),
              _DetailRow('Estado', controller.estadoCuota(cuota)),
              _DetailRow('Tipo pago', controller.tipoPagoCuota(cuota)),
              const SizedBox(height: 14),
              const Text(
                'Historial de pagos',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              if (pagos.isEmpty)
                const Text('Esta cuota no tiene pagos registrados.')
              else
                ...pagos.map((pago) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.payments),
                    title: Text(controller.money(pago['monto'])),
                    subtitle: Text(
                      '${pago['fecha_pago'] ?? ''} - ${pago['metodo_pago'] ?? ''}',
                    ),
                    trailing: StatusChip.fromText(
                      pago['tipo_pago']?.toString() ?? 'NORMAL',
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185,
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xffdcfce7),
            child: Icon(icon, size: 18, color: const Color(0xff14532d)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xff64748b))),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
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

class _InfoBox extends StatelessWidget {
  final String text;

  const _InfoBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffffbeb),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xfffde68a)),
      ),
      child: Text(text, style: const TextStyle(color: Color(0xff92400e))),
    );
  }
}

String _nombreCliente(Map<String, dynamic> cliente) {
  final persona = cliente['persona'];
  final nombre =
      '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''} ${persona?['apellido_materno'] ?? ''}'
          .trim();
  final ci = cliente['ci_persona']?.toString() ?? '';
  return nombre.isEmpty ? ci : '$nombre - $ci';
}

double _num(dynamic value) {
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
