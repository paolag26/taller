import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/views/calculadora_view.dart';
import 'package:sist_prestamo/views/cliente_view.dart';
import 'package:sist_prestamo/views/cobranza_view.dart';
import 'package:sist_prestamo/views/cuota_view.dart';
import 'package:sist_prestamo/views/mapa_clientes_view.dart';
import 'package:sist_prestamo/views/pagos_view.dart';
import 'package:sist_prestamo/views/prestamos_view.dart';
import 'package:sist_prestamo/views/reporte_view.dart';
import 'package:sist_prestamo/views/dashboard_card.dart';
import 'package:sist_prestamo/provider/dashboard_provider.dart';
import 'package:sist_prestamo/controllers/dashboard_controller.dart';
import 'package:sist_prestamo/views/quick_action_button.dart';

class DashboardView extends StatefulWidget {
  final void Function(Widget view, String title)? onNavigate;

  const DashboardView({super.key, this.onNavigate});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final controller = DashboardProvider().controller;

  @override
  void initState() {
    super.initState();
    controller.cargarDashboard();
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

        return RefreshIndicator(
          onRefresh: controller.cargarDashboard,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  onRefresh: controller.cargarDashboard,
                  isCobrador: controller.isCobrador,
                ),
                if (controller.error != null) ...[
                  const SizedBox(height: 16),
                  _ErrorBox(message: controller.error!),
                ],
                const SizedBox(height: 24),
                controller.isCobrador
                    ? _CobradorMetrics(controller: controller)
                    : _AdminMetrics(controller: controller, money: _money),
                const SizedBox(height: 28),
                if (!controller.isCobrador) ...[
                  _FinancialSnapshot(controller: controller),
                  const SizedBox(height: 28),
                ],
                const Text(
                  'Acciones rapidas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                controller.isCobrador
                    ? _CobradorQuickActions(go: _go)
                    : Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          QuickActionButton(
                            title: 'Nuevo prestamo',
                            icon: Icons.add_business,
                            onTap: () =>
                                _go(const PrestamosView(), 'Prestamos'),
                          ),
                          QuickActionButton(
                            title: 'Registrar pago',
                            icon: Icons.payments,
                            onTap: () => _go(const PagosView(), 'Pagos'),
                          ),
                          QuickActionButton(
                            title: 'Nuevo cliente',
                            icon: Icons.person_add,
                            onTap: () => _go(const ClientesView(), 'Clientes'),
                          ),
                          QuickActionButton(
                            title: 'Cobranza',
                            icon: Icons.route,
                            onTap: () => _go(const CobranzaView(), 'Cobranza'),
                          ),
                          QuickActionButton(
                            title: 'Simular prestamo',
                            icon: Icons.calculate,
                            onTap: () => _go(
                              CalculadoraView(onNavigate: widget.onNavigate),
                              'Calculadora',
                            ),
                          ),
                          QuickActionButton(
                            title: 'Ver reportes',
                            icon: Icons.bar_chart,
                            onTap: () => _go(const ReportesView(), 'Reportes'),
                          ),
                        ],
                      ),
                const SizedBox(height: 28),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final twoColumns = constraints.maxWidth > 940;
                    final width = twoColumns
                        ? (constraints.maxWidth - 16) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: width,
                          child: _AlertasPanel(controller: controller),
                        ),
                        SizedBox(
                          width: width,
                          child: _ProximasCuotasPanel(controller: controller),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _go(Widget view, String title) {
    final onNavigate = widget.onNavigate;
    if (onNavigate == null) return;
    onNavigate(view, title);
  }

  String _money(double value) {
    return 'Bs ${value.toStringAsFixed(2)}';
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onRefresh;
  final bool isCobrador;

  const _Header({required this.onRefresh, required this.isCobrador});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xff052e16),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff052e16).withValues(alpha: 0.16),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCobrador ? 'Panel del Cobrador' : 'Panel General',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  isCobrador
                      ? 'Resumen operativo de tu cartera asignada'
                      : 'Resumen operativo y financiero de Cuentas Claras',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xffbbf7d0),
                  ),
                ),
              ],
            ),
          ),
          IconButton.filledTonal(
            onPressed: onRefresh,
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class _AdminMetrics extends StatelessWidget {
  final DashboardController controller;
  final String Function(double value) money;

  const _AdminMetrics({required this.controller, required this.money});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        DashboardCard(
          title: 'Prestamos activos',
          value: '${controller.prestamosActivos}',
          icon: Icons.account_balance_wallet,
          color: const Color(0xff166534),
        ),
        DashboardCard(
          title: 'Cobrado hoy',
          value: money(controller.cobradoHoy),
          icon: Icons.payments,
          color: const Color(0xff1d4ed8),
        ),
        DashboardCard(
          title: 'Cuotas vencidas',
          value: '${controller.cuotasVencidas}',
          icon: Icons.warning,
          color: const Color(0xffdc2626),
        ),
        DashboardCard(
          title: 'Clientes activos',
          value: '${controller.clientesActivos}',
          icon: Icons.people,
          color: const Color(0xff7c3aed),
        ),
        DashboardCard(
          title: 'Cartera pendiente',
          value: money(controller.carteraPendiente),
          icon: Icons.savings,
          color: const Color(0xff0f766e),
        ),
        DashboardCard(
          title: 'Cobrado mes',
          value: money(controller.cobradoMes),
          icon: Icons.trending_up,
          color: const Color(0xffea580c),
        ),
        DashboardCard(
          title: 'Cuotas pagadas',
          value: '${controller.cuotasPagadas}',
          icon: Icons.check_circle,
          color: const Color(0xff15803d),
        ),
        DashboardCard(
          title: 'Cuotas pendientes',
          value: '${controller.cuotasPendientes}',
          icon: Icons.pending_actions,
          color: const Color(0xffca8a04),
        ),
        DashboardCard(
          title: 'Riesgo mora',
          value: money(controller.riesgoMora),
          icon: Icons.report_problem,
          color: const Color(0xffb91c1c),
        ),
      ],
    );
  }
}

class _CobradorMetrics extends StatelessWidget {
  final DashboardController controller;

  const _CobradorMetrics({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        DashboardCard(
          title: 'Cuotas pendientes hoy',
          value: '${controller.cuotasVencenHoy}',
          icon: Icons.today,
          color: const Color(0xffca8a04),
        ),
        DashboardCard(
          title: 'Cobros realizados hoy',
          value: '${controller.cobrosRealizadosHoy}',
          icon: Icons.receipt_long,
          color: const Color(0xff1d4ed8),
        ),
        DashboardCard(
          title: 'Monto recaudado hoy',
          value: 'Bs ${controller.cobradoHoy.toStringAsFixed(2)}',
          icon: Icons.payments,
          color: const Color(0xff166534),
        ),
        DashboardCard(
          title: 'Clientes por visitar',
          value: '${controller.clientesPendientesVisita}',
          icon: Icons.person_pin_circle,
          color: const Color(0xff7c3aed),
        ),
      ],
    );
  }
}

class _CobradorQuickActions extends StatelessWidget {
  final void Function(Widget view, String title) go;

  const _CobradorQuickActions({required this.go});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        QuickActionButton(
          title: 'Cuotas',
          icon: Icons.calendar_month,
          onTap: () => go(const CuotasView(), 'Cuotas'),
        ),
        QuickActionButton(
          title: 'Registrar pago',
          icon: Icons.payments,
          onTap: () => go(const PagosView(), 'Pagos'),
        ),
        QuickActionButton(
          title: 'Cobranza',
          icon: Icons.route,
          onTap: () => go(const CobranzaView(), 'Cobranza'),
        ),
        QuickActionButton(
          title: 'Mapa clientes',
          icon: Icons.map,
          onTap: () => go(const MapaClientesView(), 'Mapa Clientes'),
        ),
      ],
    );
  }
}

class _FinancialSnapshot extends StatelessWidget {
  final DashboardController controller;

  const _FinancialSnapshot({required this.controller});

  @override
  Widget build(BuildContext context) {
    final total = controller.cobradoMes + controller.carteraPendiente;
    final ratio = total <= 0 ? 0.0 : controller.cobradoMes / total;

    return Container(
      padding: const EdgeInsets.all(18),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 760;

          final chart = _ProgressSummary(
            title: 'Avance de cobro mensual',
            value: ratio.clamp(0, 1),
            label: '${(ratio * 100).toStringAsFixed(0)}%',
          );

          final stats = Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _SmallStat(
                title: 'Cobrado mes',
                value: _money(controller.cobradoMes),
                color: const Color(0xff16a34a),
              ),
              _SmallStat(
                title: 'Pendiente',
                value: _money(controller.carteraPendiente),
                color: const Color(0xff2563eb),
              ),
              _SmallStat(
                title: 'Riesgo mora',
                value: '${controller.cuotasVencidas}',
                color: const Color(0xffdc2626),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [chart, const SizedBox(height: 16), stats],
            );
          }

          return Row(
            children: [
              Expanded(child: chart),
              const SizedBox(width: 18),
              Expanded(child: stats),
            ],
          );
        },
      ),
    );
  }

  String _money(double value) => 'Bs ${value.toStringAsFixed(2)}';
}

class _ProgressSummary extends StatelessWidget {
  final String title;
  final double value;
  final String label;

  const _ProgressSummary({
    required this.title,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xff14532d),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: const Color(0xffeef2f7),
            valueColor: const AlwaysStoppedAnimation(Color(0xff16a34a)),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Indicador visual para seguimiento rápido de cartera y cobros.',
          style: TextStyle(color: Color(0xff64748b)),
        ),
      ],
    );
  }
}

class _SmallStat extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SmallStat({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xff0f172a),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertasPanel extends StatelessWidget {
  final DashboardController controller;

  const _AlertasPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final alertas = controller.alertas;

    return _Panel(
      title: 'Alertas importantes',
      child: alertas.isEmpty
          ? const _EmptyText('No hay alertas pendientes')
          : Column(
              children: alertas.map((alerta) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(alerta['icon'], color: alerta['color']),
                  title: Text(alerta['title']),
                  subtitle: Text(alerta['subtitle']),
                );
              }).toList(),
            ),
    );
  }
}

class _ProximasCuotasPanel extends StatelessWidget {
  final DashboardController controller;

  const _ProximasCuotasPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    final cuotas = controller.proximasCuotas;

    return _Panel(
      title: 'Proximas cuotas',
      child: cuotas.isEmpty
          ? const _EmptyText('No hay cuotas pendientes')
          : Column(
              children: cuotas.map((cuota) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Color(0xff14532d),
                  ),
                  title: Text(controller.nombreCliente(cuota)),
                  subtitle: Text(
                    'Vence: ${cuota['fecha_vencimiento'] ?? 'Sin fecha'}',
                  ),
                  trailing: Text(
                    'Bs ${controller.saldoCuota(cuota).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe2e8f0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
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
