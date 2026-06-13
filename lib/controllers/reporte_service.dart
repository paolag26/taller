import 'package:sist_prestamo/controllers/database_config.dart';

class ReporteService {
  // ==============================
  // PATRON SINGLETON
  // ReporteService utiliza Singleton
  // para garantizar una unica instancia
  // durante toda la ejecucion del sistema.
  // Defensa: Patron Creacional.
  // Razon en Cuentas Claras: centraliza
  // consultas agregadas para indicadores.
  // ==============================
  static final ReporteService _instance = ReporteService._internal();

  factory ReporteService() {
    return _instance;
  }

  ReporteService._internal();

  final localDb = DatabaseConfig.client;

  Future<Map<String, dynamic>> cargarReporte({
    required DateTime desde,
    required DateTime hasta,
  }) async {
    final desdeTexto = _date(desde);
    final hastaTexto = _date(hasta);

    final personas = await _listarSeguro('persona');
    final clientes = await _listarSeguro('cliente', orderBy: 'id_cliente');
    final estados = await _listarSeguro('estado_prestamo');
    final tipos = await _listarSeguro('tipo_prestamo', orderBy: 'nombre');
    final prestamosBase = await _listarSeguro('prestamo');
    final planes = await _listarSeguro('plan_pagos');
    final cuotasBase = await _listarSeguro('cuota');
    final pagosBase = await _listarPagos(desdeTexto, hastaTexto);
    final egresos = await _listarEgresos(desdeTexto, hastaTexto);

    final personasPorCi = {
      ..._porClave(personas, 'ci'),
      ..._porClave(personas, 'ci_persona'),
    };
    final clientesEnriquecidos = clientes.map((cliente) {
      return {
        ...cliente,
        'persona': personasPorCi[cliente['ci_persona']?.toString()],
      };
    }).toList();

    final clientesPorId = _porClave(clientesEnriquecidos, 'id_cliente');
    final estadosPorId = _porClave(estados, 'id_estado');
    final tiposPorId = _porClave(tipos, 'id_tipo');

    final prestamos = prestamosBase.map((prestamo) {
      return {
        ...prestamo,
        'cliente': clientesPorId[prestamo['id_cliente']?.toString()],
        'estado_prestamo': estadosPorId[prestamo['id_estado']?.toString()],
        'tipo_prestamo': tiposPorId[prestamo['id_tipo']?.toString()],
      };
    }).toList();

    final prestamosPorId = _porClave(prestamos, 'id_prestamo');
    final planesPorId = _porClave(planes, 'id_plan');
    final cuotas = cuotasBase.map((cuota) {
      final copy = Map<String, dynamic>.from(cuota);
      final plan = planesPorId[copy['id_plan']?.toString() ?? ''];
      copy['id_prestamo'] ??= plan?['id_prestamo'];
      copy['monto_cuota'] ??= copy['monto_total'];
      copy['capital'] ??= copy['monto_capital'];
      copy['interes'] ??= copy['monto_interes'];
      copy['saldo_pendiente'] ??= copy['saldo_restante'];
      return {
        ...copy,
        'prestamo': prestamosPorId[copy['id_prestamo']?.toString()],
      };
    }).toList();

    final cuotasPorId = _porClave(cuotas, 'id_cuota');
    final pagos = pagosBase.map((pago) {
      final cuota = cuotasPorId[pago['id_cuota']?.toString()];
      final idPrestamo = pago['id_prestamo'] ?? cuota?['id_prestamo'];
      final prestamo = prestamosPorId[idPrestamo?.toString()];
      return {
        ...pago,
        'id_prestamo': idPrestamo,
        'cuota': {...?cuota, 'prestamo': prestamo},
      };
    }).toList();

    return {
      'prestamos': List<Map<String, dynamic>>.from(prestamos),
      'cuotas': List<Map<String, dynamic>>.from(cuotas),
      'pagos': List<Map<String, dynamic>>.from(pagos),
      'egresos': List<Map<String, dynamic>>.from(egresos),
      'clientes': List<Map<String, dynamic>>.from(clientesEnriquecidos),
      'tipos': List<Map<String, dynamic>>.from(tipos),
      'powerbi_url': await _cargarPowerBiUrl(),
    };
  }

  Future<void> guardarPowerBiUrl(String url) async {
    final data = {
      'clave': 'powerbi_url',
      'valor': url,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await localDb.from('configuracion').upsert(data, onConflict: 'clave');
    } catch (_) {
      await localDb
          .from('configuracion')
          .upsert(
            Map<String, dynamic>.from(data)..remove('updated_at'),
            onConflict: 'clave',
          );
    }
  }

  String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(
    String tabla, {
    String? orderBy,
  }) async {
    try {
      final query = localDb.from(tabla).select();
      final response = orderBy == null
          ? await query
          : await query.order(orderBy);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _listarPagos(
    String desde,
    String hasta,
  ) async {
    try {
      final response = await localDb
          .from('pago')
          .select()
          .gte('fecha_pago', desde)
          .lte('fecha_pago', hasta)
          .order('fecha_pago', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _listarEgresos(
    String desde,
    String hasta,
  ) async {
    try {
      final response = await localDb
          .from('egreso')
          .select()
          .gte('fecha', desde)
          .lte('fecha', hasta)
          .order('fecha', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  Future<String> _cargarPowerBiUrl() async {
    try {
      final powerBi = await localDb
          .from('configuracion')
          .select('valor')
          .eq('clave', 'powerbi_url')
          .maybeSingle();
      return powerBi?['valor']?.toString() ?? '';
    } catch (_) {
      return '';
    }
  }

  Map<String, Map<String, dynamic>> _porClave(
    List<Map<String, dynamic>> data,
    String clave,
  ) {
    return {
      for (final item in data)
        if (item[clave] != null) item[clave].toString(): item,
    };
  }
}
