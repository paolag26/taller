import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sist_prestamo/provider/auth_provider.dart';
import 'package:sist_prestamo/provider/calculadora_provider.dart';
import 'package:sist_prestamo/provider/cliente_provider.dart';
import 'package:sist_prestamo/provider/cobranza_provider.dart';
import 'package:sist_prestamo/provider/configuracion_provider.dart';
import 'package:sist_prestamo/provider/cuota_provider.dart';
import 'package:sist_prestamo/provider/dashboard_provider.dart';
import 'package:sist_prestamo/provider/diagnostico_provider.dart';
import 'package:sist_prestamo/provider/egreso_provider.dart';
import 'package:sist_prestamo/provider/garante_provider.dart';
import 'package:sist_prestamo/provider/garantia_provider.dart';
import 'package:sist_prestamo/provider/layout_provider.dart';
import 'package:sist_prestamo/provider/mapa_provider.dart';
import 'package:sist_prestamo/provider/pago_provider.dart';
import 'package:sist_prestamo/provider/persona_provider.dart';
import 'package:sist_prestamo/provider/plan_pago_provider.dart';
import 'package:sist_prestamo/provider/prestamo_provider.dart';
import 'package:sist_prestamo/provider/reporte_provider.dart';
import 'package:sist_prestamo/provider/rol_provider.dart';
import 'package:sist_prestamo/provider/usuario_provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LayoutProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => CalculadoraProvider()),
        ChangeNotifierProvider(create: (_) => ClienteProvider()),
        ChangeNotifierProvider(create: (_) => PersonaProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => RolProvider()),
        ChangeNotifierProvider(create: (_) => PrestamoProvider()),
        ChangeNotifierProvider(create: (_) => GarantiaProvider()),
        ChangeNotifierProvider(create: (_) => GaranteProvider()),
        ChangeNotifierProvider(create: (_) => PlanPagoProvider()),
        ChangeNotifierProvider(create: (_) => CuotaProvider()),
        ChangeNotifierProvider(create: (_) => PagoProvider()),
        ChangeNotifierProvider(create: (_) => CobranzaProvider()),
        ChangeNotifierProvider(create: (_) => MapaProvider()),
        ChangeNotifierProvider(create: (_) => EgresoProvider()),
        ChangeNotifierProvider(create: (_) => ReporteProvider()),
        ChangeNotifierProvider(create: (_) => ConfiguracionProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosticoProvider()),
      ],
      child: child,
    );
  }
}
