import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/controllers/app_formatters.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/views/erp_card.dart';
import 'package:sist_prestamo/provider/reporte_provider.dart';
import 'package:sist_prestamo/controllers/reporte_controller.dart';

class ReportesView extends StatefulWidget {
  const ReportesView({super.key});

  @override
  State<ReportesView> createState() => _ReportesViewState();
}

class _ReportesViewState extends State<ReportesView> {
  final controller = ReporteProvider().controller;

  @override
  void initState() {
    super.initState();
    controller.cargarReporte();
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

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(
                desde: controller.desde,
                hasta: controller.hasta,
                clientes: controller.clientes,
                tipos: controller.tipos,
                clienteFiltro: controller.clienteFiltro,
                tipoFiltro: controller.tipoFiltro,
                onCambiarRango: _seleccionarRango,
                onRefresh: controller.cargarReporte,
                onExport: _copiarClientesMorosos,
                onClienteChanged: controller.cambiarCliente,
                onTipoChanged: controller.cambiarTipo,
              ),
              if (controller.error != null) ...[
                const SizedBox(height: 16),
                _ErrorBox(message: controller.error!),
              ],
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final mobile = constraints.maxWidth < 700;
                  final width = mobile ? constraints.maxWidth : 230.0;
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _MetricCard(
                        width: width,
                        title: 'Cartera activa',
                        value: _money(controller.carteraActiva),
                        icon: Icons.account_balance_wallet,
                        color: const Color(0xff166534),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Cartera vencida',
                        value: _money(controller.carteraVencida),
                        icon: Icons.warning,
                        color: const Color(0xffb91c1c),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Cobrado periodo',
                        value: _money(controller.cobradoPeriodo),
                        icon: Icons.payments,
                        color: const Color(0xff1d4ed8),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Egresos periodo',
                        value: _money(controller.egresosPeriodo),
                        icon: Icons.money_off,
                        color: const Color(0xff9333ea),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Utilidad periodo',
                        value: _money(controller.utilidadPeriodo),
                        icon: Icons.trending_up,
                        color: controller.utilidadPeriodo >= 0
                            ? const Color(0xff15803d)
                            : const Color(0xffdc2626),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Cuotas vencidas',
                        value: '${controller.cuotasVencidas}',
                        icon: Icons.event_busy,
                        color: const Color(0xffea580c),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Cuotas pagadas',
                        value: '${controller.cuotasPagadas}',
                        icon: Icons.check_circle,
                        color: const Color(0xff16a34a),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Pagos adelantados',
                        value: '${controller.pagosAdelantados}',
                        icon: Icons.fast_forward,
                        color: const Color(0xff2563eb),
                      ),
                      _MetricCard(
                        width: width,
                        title: 'Amortizaciones',
                        value: '${controller.amortizacionesParciales}',
                        icon: Icons.pie_chart,
                        color: const Color(0xff7c3aed),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              _PowerBiPanel(
                url: controller.powerBiUrl,
                onSave: controller.guardarPowerBiUrl,
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoColumns = constraints.maxWidth > 980;
                  final width = twoColumns
                      ? (constraints.maxWidth - 16) / 2
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      SizedBox(
                        width: width,
                        child: _ClientesMorososPanel(controller: controller),
                      ),
                      SizedBox(
                        width: width,
                        child: _PagosRecientesPanel(controller: controller),
                      ),
                      SizedBox(
                        width: width,
                        child: _BarsPanel(
                          title: 'Prestamos por estado',
                          data: controller.prestamosPorEstado,
                          money: false,
                        ),
                      ),
                      SizedBox(
                        width: width,
                        child: _BarsPanel(
                          title: 'Cartera por tipo',
                          data: controller.carteraPorTipo,
                          money: true,
                        ),
                      ),
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

  Future<void> _seleccionarRango() async {
    final rango = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: DateTimeRange(
        start: controller.desde,
        end: controller.hasta,
      ),
    );

    if (rango == null) return;

    await controller.cambiarRango(rango.start, rango.end);
  }

  Future<void> _copiarClientesMorosos() async {
    await Clipboard.setData(
      ClipboardData(text: controller.csvClientesMorosos()),
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reporte copiado en formato CSV')),
    );
  }

  static String _money(double value) {
    return AppFormatters.money(value);
  }
}

class _Header extends StatelessWidget {
  final DateTime desde;
  final DateTime hasta;
  final List<Map<String, dynamic>> clientes;
  final List<Map<String, dynamic>> tipos;
  final int? clienteFiltro;
  final int? tipoFiltro;
  final VoidCallback onCambiarRango;
  final VoidCallback onRefresh;
  final VoidCallback onExport;
  final ValueChanged<int?> onClienteChanged;
  final ValueChanged<int?> onTipoChanged;

  const _Header({
    required this.desde,
    required this.hasta,
    required this.clientes,
    required this.tipos,
    required this.clienteFiltro,
    required this.tipoFiltro,
    required this.onCambiarRango,
    required this.onRefresh,
    required this.onExport,
    required this.onClienteChanged,
    required this.onTipoChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reportes',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_date(desde)} al ${_date(hasta)}',
                    style: const TextStyle(color: Color(0xff64748b)),
                  ),
                ],
              ),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                OutlinedButton.icon(
                  onPressed: onCambiarRango,
                  icon: const Icon(Icons.date_range),
                  label: const Text('Rango'),
                ),
                IconButton.filledTonal(
                  onPressed: onRefresh,
                  tooltip: 'Actualizar',
                  icon: const Icon(Icons.refresh),
                ),
                ElevatedButton.icon(
                  onPressed: onExport,
                  icon: const Icon(Icons.download),
                  label: const Text('Exportar mora'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 260,
              child: DropdownButtonFormField<int?>(
                // ignore: deprecated_member_use
                value: clienteFiltro,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Cliente',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text('Todos los clientes'),
                  ),
                  ...clientes.map((cliente) {
                    return DropdownMenuItem<int?>(
                      value: cliente['id_cliente'],
                      child: Text(_nombreCliente(cliente)),
                    );
                  }),
                ],
                onChanged: onClienteChanged,
              ),
            ),
            SizedBox(
              width: 240,
              child: DropdownButtonFormField<int?>(
                // ignore: deprecated_member_use
                value: tipoFiltro,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Tipo de prestamo',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<int?>(
                    value: null,
                    child: Text('Todos los tipos'),
                  ),
                  ...tipos.map((tipo) {
                    return DropdownMenuItem<int?>(
                      value: tipo['id_tipo'],
                      child: Text(tipo['nombre'] ?? ''),
                    );
                  }),
                ],
                onChanged: onTipoChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final ci = cliente['ci_persona'] ?? '';
    final nombre = '$nombres $paterno'.trim();
    return nombre.isEmpty ? ci : '$nombre - $ci';
  }

  static String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

class _PowerBiPanel extends StatefulWidget {
  final String url;
  final Future<void> Function(String url) onSave;

  const _PowerBiPanel({required this.url, required this.onSave});

  @override
  State<_PowerBiPanel> createState() => _PowerBiPanelState();
}

class _PowerBiPanelState extends State<_PowerBiPanel> {
  late final TextEditingController urlController;
  bool saving = false;
  bool get urlValida {
    final text = urlController.text.trim();
    if (text.isEmpty) return true;
    final uri = Uri.tryParse(text);
    return uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        !RegExp(r'[<>{}`]').hasMatch(text);
  }

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController(text: widget.url);
  }

  @override
  void didUpdateWidget(covariant _PowerBiPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url && urlController.text != widget.url) {
      urlController.text = widget.url;
    }
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configured = widget.url.trim().isNotEmpty;

    return ErpCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.analytics, color: Color(0xff14532d)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  configured
                      ? 'Power BI configurado. Abra el dashboard interactivo con los datos publicados desde Base local.'
                      : 'Pegue la URL publica/embebida de Power BI para abrir el dashboard interactivo.',
                ),
              ),
              OutlinedButton.icon(
                onPressed: configured
                    ? () async {
                        await launchUrl(
                          Uri.parse(widget.url),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    : null,
                icon: const Icon(Icons.open_in_new),
                label: const Text('Abrir Power BI'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: urlController,
                  inputFormatters: AppValidators.safeText,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: 'URL Power BI',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color(0xfff8fafc),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: saving
                    ? null
                    : !urlValida
                    ? null
                    : () async {
                        setState(() {
                          saving = true;
                        });
                        try {
                          await widget.onSave(
                            AppValidators.sanitizeText(urlController.text),
                          );
                        } finally {
                          if (mounted) {
                            setState(() {
                              saving = false;
                            });
                          }
                        }
                      },
                icon: const Icon(Icons.save),
                label: Text(saving ? 'Guardando...' : 'Guardar'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Para graficos autoactualizados, conecte Power BI a Base local/PostgreSQL o a vistas/RPC de Base local y configure la actualizacion programada en Power BI Service.',
            style: TextStyle(color: Color(0xff64748b)),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final double width;
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.width,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffe2e8f0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 14),
          Text(title, style: const TextStyle(color: Color(0xff64748b))),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ClientesMorososPanel extends StatelessWidget {
  final ReporteController controller;

  const _ClientesMorososPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final clientes = controller.clientesMorosos;

    return _Panel(
      title: 'Clientes morosos',
      child: clientes.isEmpty
          ? const _EmptyText('No hay clientes en mora')
          : Column(
              children: clientes.take(10).map((item) {
                final cliente = item['cliente'];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.warning, color: Color(0xffdc2626)),
                  title: Text(controller.nombreCliente(cliente)),
                  subtitle: Text(
                    'CI ${cliente?['ci_persona'] ?? ''} - ${item['cuotas_vencidas']} cuotas vencidas',
                  ),
                  trailing: Text(
                    AppFormatters.money(item['saldo']),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class _PagosRecientesPanel extends StatelessWidget {
  final ReporteController controller;

  const _PagosRecientesPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final pagos = controller.pagosRecientes;

    return _Panel(
      title: 'Pagos del periodo',
      child: pagos.isEmpty
          ? const _EmptyText('No hay pagos en el rango seleccionado')
          : Column(
              children: pagos.map((pago) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.payments, color: Color(0xff1d4ed8)),
                  title: Text(controller.nombreClienteFromPago(pago)),
                  subtitle: Text(
                    '${pago['fecha_pago'] ?? ''} - ${pago['metodo_pago'] ?? 'EFECTIVO'}',
                  ),
                  trailing: Text(
                    AppFormatters.money(pago['monto'] ?? pago['monto_pagado']),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class _BarsPanel extends StatelessWidget {
  final String title;
  final Map<String, double> data;
  final bool money;

  const _BarsPanel({
    required this.title,
    required this.data,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    final max = data.values.fold<double>(
      0,
      (current, value) => value > current ? value : current,
    );

    return _Panel(
      title: title,
      child: data.isEmpty
          ? const _EmptyText('No hay informacion')
          : Column(
              children: data.entries.map((entry) {
                final percent = max <= 0 ? 0.0 : entry.value / max;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(entry.key)),
                          Text(
                            money
                                ? AppFormatters.money(entry.value)
                                : entry.value.toStringAsFixed(0),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: percent,
                          backgroundColor: const Color(0xffe2e8f0),
                          color: const Color(0xff166534),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const _Panel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          child,
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

class _EmptyText extends StatelessWidget {
  final String text;

  const _EmptyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Center(
        child: Text(text, style: const TextStyle(color: Color(0xff64748b))),
      ),
    );
  }
}
