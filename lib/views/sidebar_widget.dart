import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/calculadora_view.dart';
import 'package:sist_prestamo/views/cliente_view.dart';
import 'package:sist_prestamo/views/cobranza_view.dart';
import 'package:sist_prestamo/views/configuracion_view.dart';
import 'package:sist_prestamo/views/cuota_view.dart';
import 'package:sist_prestamo/views/diagnostico_view.dart';
import 'package:sist_prestamo/views/egreso_view.dart';
import 'package:sist_prestamo/views/mapa_clientes_view.dart';
import 'package:sist_prestamo/views/pagos_view.dart';
import 'package:sist_prestamo/views/prestamos_view.dart';
import 'package:sist_prestamo/views/reporte_view.dart';
import 'package:sist_prestamo/controllers/app_routes.dart';
import 'package:sist_prestamo/controllers/layout_controller.dart';
import 'package:sist_prestamo/views/navigation_item.dart';

class SidebarWidget extends StatelessWidget {
  final LayoutController controller;
  final bool isOpen;

  const SidebarWidget({
    super.key,
    required this.controller,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: isOpen ? 270 : 84,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff052e16), Color(0xff14532d)],
        ),
      ),
      child: Column(
        children: [
          _BrandHeader(isOpen: isOpen),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(isOpen: isOpen, text: 'Operaciones'),
                  NavigationItem(
                    isOpen: isOpen,
                    icon: Icons.dashboard_outlined,
                    title: 'Dashboard',
                    onTap: controller.openDashboard,
                  ),
                  if (controller.canAccess('calculadora'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.calculate_outlined,
                      title: 'Calculadora',
                      onTap: () {
                        controller.changeView(
                          view: CalculadoraView(
                            onNavigate: (view, title) {
                              controller.changeView(
                                view: view,
                                newTitle: title,
                              );
                            },
                          ),
                          newTitle: 'Calculadora',
                        );
                      },
                    ),
                  if (controller.canAccess('clientes'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.group_outlined,
                      title: 'Clientes',
                      onTap: () {
                        controller.changeView(
                          view: const ClientesView(),
                          newTitle: 'Clientes',
                        );
                      },
                    ),
                  if (controller.canAccess('prestamos'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Préstamos',
                      onTap: () {
                        controller.changeView(
                          view: const PrestamosView(),
                          newTitle: 'Préstamos',
                        );
                      },
                    ),
                  if (controller.canAccess('cuotas'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.calendar_month_outlined,
                      title: 'Cuotas',
                      onTap: () {
                        controller.changeView(
                          view: const CuotasView(),
                          newTitle: 'Cuotas',
                        );
                      },
                    ),
                  if (controller.canAccess('pagos'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.payments_outlined,
                      title: 'Pagos',
                      onTap: () {
                        controller.changeView(
                          view: PagosView(),
                          newTitle: 'Pagos',
                        );
                      },
                    ),
                  if (controller.canAccess('cobranza'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.route_outlined,
                      title: 'Cobranza',
                      onTap: () {
                        controller.changeView(
                          view: const CobranzaView(),
                          newTitle: 'Cobranza',
                        );
                      },
                    ),
                  _SectionLabel(isOpen: isOpen, text: 'Gestion'),
                  if (controller.canAccess('mapa'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.map_outlined,
                      title: 'Mapa Clientes',
                      onTap: () {
                        controller.changeView(
                          view: const MapaClientesView(),
                          newTitle: 'Mapa Clientes',
                        );
                      },
                    ),
                  if (controller.canAccess('reportes'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.bar_chart_outlined,
                      title: 'Reportes',
                      onTap: () {
                        controller.changeView(
                          view: const ReportesView(),
                          newTitle: 'Reportes',
                        );
                      },
                    ),
                  if (controller.canAccess('egresos'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.money_off_outlined,
                      title: 'Egresos',
                      onTap: () {
                        controller.changeView(
                          view: const EgresosView(),
                          newTitle: 'Egresos',
                        );
                      },
                    ),
                  _SectionLabel(isOpen: isOpen, text: 'Sistema'),
                  if (controller.canAccess('configuracion'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.settings_outlined,
                      title: 'Configuración',
                      onTap: () {
                        controller.changeView(
                          view: const ConfiguracionView(),
                          newTitle: 'Configuración',
                        );
                      },
                    ),
                  if (controller.canAccess('diagnostico'))
                    NavigationItem(
                      isOpen: isOpen,
                      icon: Icons.fact_check_outlined,
                      title: 'Diagnostico',
                      onTap: () {
                        controller.changeView(
                          view: const DiagnosticoView(),
                          newTitle: 'Diagnostico Base local',
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.white12),
          NavigationItem(
            isOpen: isOpen,
            icon: Icons.logout_outlined,
            title: 'Cerrar sesión',
            onTap: () async {
              await controller.logout();

              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              }
            },
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  final bool isOpen;

  const _BrandHeader({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(isOpen ? 18 : 12, 24, isOpen ? 18 : 12, 18),
      child: Row(
        mainAxisAlignment: isOpen
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.14),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Color(0xff14532d),
            ),
          ),
          if (isOpen) ...[
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cuentas Claras',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'ERP Financiero',
                    style: TextStyle(color: Color(0xffbbf7d0), fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final bool isOpen;
  final String text;

  const _SectionLabel({required this.isOpen, required this.text});

  @override
  Widget build(BuildContext context) {
    if (!isOpen) return const SizedBox(height: 8);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: Color(0xff86efac),
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
