import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/reporte_service.dart';

class ReporteController extends ChangeNotifier {
  final service = ReporteService();

  bool loading = false;
  String? error;

  late DateTime desde;
  late DateTime hasta;

  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagos = [];
  List<Map<String, dynamic>> egresos = [];
  List<Map<String, dynamic>> clientes = [];
  List<Map<String, dynamic>> tipos = [];
  String powerBiUrl = '';
  int? clienteFiltro;
  int? tipoFiltro;

  ReporteController() {
    final hoy = DateTime.now();
    desde = DateTime(hoy.year, hoy.month, 1);
    hasta = DateTime(hoy.year, hoy.month + 1, 0);
  }

  Future<void> cargarReporte() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final data = await service.cargarReporte(desde: desde, hasta: hasta);
      prestamos = data['prestamos'];
      cuotas = data['cuotas'];
      pagos = data['pagos'];
      egresos = data['egresos'];
      clientes = data['clientes'];
      tipos = data['tipos'];
      powerBiUrl = data['powerbi_url'];
      debugPrint(
        'REPORTE CALCULADO prestamos=${prestamos.length} cuotas=${cuotas.length} pagos=${pagos.length} egresos=${egresos.length}',
      );
    } catch (e) {
      error = 'No se pudo cargar el reporte: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> cambiarRango(DateTime nuevoDesde, DateTime nuevoHasta) async {
    desde = nuevoDesde;
    hasta = nuevoHasta;
    await cargarReporte();
  }

  Future<void> guardarPowerBiUrl(String url) async {
    await service.guardarPowerBiUrl(url.trim());
    powerBiUrl = url.trim();
    notifyListeners();
  }

  void cambiarCliente(int? value) {
    clienteFiltro = value;
    notifyListeners();
  }

  void cambiarTipo(int? value) {
    tipoFiltro = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> get prestamosFiltrados {
    return prestamos.where((prestamo) {
      final byCliente =
          clienteFiltro == null || prestamo['id_cliente'] == clienteFiltro;
      final byTipo = tipoFiltro == null || prestamo['id_tipo'] == tipoFiltro;
      return byCliente && byTipo;
    }).toList();
  }

  List<Map<String, dynamic>> get cuotasFiltradas {
    final prestamosIds = prestamosFiltrados
        .map((p) => _toInt(p['id_prestamo']))
        .toSet();
    return cuotas.where((cuota) {
      return prestamosIds.contains(
        _toInt(cuota['id_prestamo'] ?? cuota['prestamo']?['id_prestamo']),
      );
    }).toList();
  }

  List<Map<String, dynamic>> get pagosFiltrados {
    final prestamosIds = prestamosFiltrados
        .map((p) => _toInt(p['id_prestamo']))
        .toSet();
    return pagos.where((pago) {
      final idPrestamo = pago['id_prestamo'] ?? pago['cuota']?['id_prestamo'];
      return prestamosIds.isEmpty || prestamosIds.contains(_toInt(idPrestamo));
    }).toList();
  }

  double get carteraActiva {
    final saldoCuotas = cuotasFiltradas
        .where((cuota) => !_cuotaPagada(cuota))
        .fold<double>(0, (total, cuota) => total + _saldoCuota(cuota));
    if (saldoCuotas > 0) return saldoCuotas;

    return prestamosFiltrados
        .where(_prestamoActivo)
        .fold<double>(0, (total, prestamo) => total + _num(prestamo['monto']));
  }

  double get carteraVencida {
    return cuotasFiltradas
        .where(_cuotaEnMora)
        .fold<double>(0, (total, cuota) => total + _saldoCuota(cuota));
  }

  double get cobradoPeriodo {
    return pagosFiltrados.fold<double>(
      0,
      (total, pago) => total + _num(pago['monto'] ?? pago['monto_pagado']),
    );
  }

  double get egresosPeriodo {
    return egresos.fold<double>(
      0,
      (total, egreso) => total + _num(egreso['monto']),
    );
  }

  double get utilidadPeriodo => cobradoPeriodo - egresosPeriodo;

  int get prestamosActivos {
    return prestamosFiltrados.where(_prestamoActivo).length;
  }

  int get cuotasVencidas => cuotasFiltradas.where(_cuotaEnMora).length;

  int get cuotasPagadas => cuotasFiltradas.where(_cuotaPagada).length;

  int get cuotasPendientes {
    return cuotasFiltradas
        .where((cuota) => !_cuotaPagada(cuota) && !_cuotaEnMora(cuota))
        .length;
  }

  int get pagosAdelantados {
    return pagosFiltrados
        .where((pago) => pago['tipo_pago']?.toString() == 'ADELANTADO')
        .length;
  }

  int get amortizacionesParciales {
    return pagosFiltrados
        .where((pago) => pago['tipo_pago']?.toString() == 'AMORTIZACION')
        .length;
  }

  List<Map<String, dynamic>> get clientesMorosos {
    final clientes = <String, Map<String, dynamic>>{};

    for (final cuota in cuotasFiltradas.where(_cuotaEnMora)) {
      final prestamo = cuota['prestamo'];
      final cliente = prestamo?['cliente'];
      final idCliente = cliente?['id_cliente']?.toString() ?? '';
      if (idCliente.isEmpty) continue;

      final actual = clientes.putIfAbsent(idCliente, () {
        return {'cliente': cliente, 'cuotas_vencidas': 0, 'saldo': 0.0};
      });

      actual['cuotas_vencidas'] = (actual['cuotas_vencidas'] as int) + 1;
      actual['saldo'] = (actual['saldo'] as double) + _saldoCuota(cuota);
    }

    final lista = clientes.values.toList();
    lista.sort((a, b) => (b['saldo'] as double).compareTo(a['saldo']));
    return lista;
  }

  Map<String, double> get prestamosPorEstado {
    final data = <String, double>{};
    for (final prestamo in prestamosFiltrados) {
      final estado =
          prestamo['estado_prestamo']?['nombre']?.toString().toUpperCase() ??
          'SIN ESTADO';
      data[estado] = (data[estado] ?? 0) + 1;
    }
    return data;
  }

  Map<String, double> get carteraPorTipo {
    final data = <String, double>{};
    for (final prestamo in prestamosFiltrados) {
      final tipo =
          prestamo['tipo_prestamo']?['nombre']?.toString() ?? 'Sin tipo';
      final idPrestamo = prestamo['id_prestamo'];
      final saldo = cuotasFiltradas
          .where((cuota) => _toInt(cuota['id_prestamo']) == _toInt(idPrestamo))
          .where((cuota) => !_cuotaPagada(cuota))
          .fold<double>(0, (total, cuota) => total + _saldoCuota(cuota));

      data[tipo] =
          (data[tipo] ?? 0) + (saldo > 0 ? saldo : _num(prestamo['monto']));
    }
    return data;
  }

  List<Map<String, dynamic>> get pagosRecientes {
    return pagosFiltrados.take(8).toList();
  }

  String csvClientesMorosos() {
    final rows = [
      'CI,Cliente,Cuotas vencidas,Saldo',
      ...clientesMorosos.map((item) {
        final cliente = item['cliente'];
        return [
          cliente?['ci_persona'] ?? '',
          _nombreCliente(cliente),
          item['cuotas_vencidas'],
          (item['saldo'] as double).toStringAsFixed(2),
        ].map(_csvCell).join(',');
      }),
    ];

    return rows.join('\n');
  }

  String nombreClienteFromPago(Map<String, dynamic> pago) {
    return _nombreCliente(pago['cuota']?['prestamo']?['cliente']);
  }

  String nombreCliente(Map<String, dynamic>? cliente) {
    return _nombreCliente(cliente);
  }

  bool _cuotaPagada(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    final saldo = _saldoCuota(cuota);
    return estado == 'PAGADA' || estado == 'PAGADO' || saldo <= 0;
  }

  bool _prestamoActivo(Map<String, dynamic> prestamo) {
    final estado =
        prestamo['estado_prestamo']?['nombre']?.toString().toUpperCase() ?? '';
    return estado.isEmpty || estado == 'ACTIVO' || estado == 'MORA';
  }

  bool _cuotaEnMora(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado == 'MORA') return true;
    if (_cuotaPagada(cuota)) return false;

    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return false;

    final hoy = DateTime.now();
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    final fechaSinHora = DateTime(fecha.year, fecha.month, fecha.day);
    return fechaSinHora.isBefore(hoySinHora);
  }

  double _saldoCuota(Map<String, dynamic> cuota) {
    final saldo = _num(cuota['saldo_pendiente'] ?? cuota['saldo_restante']);
    if (saldo > 0) return saldo;
    return _num(cuota['monto_cuota'] ?? cuota['monto_total']);
  }

  String _nombreCliente(Map<String, dynamic>? cliente) {
    if (cliente == null) return 'Sin cliente';

    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombre = '$nombres $paterno $materno'.trim();

    return nombre.isEmpty ? cliente['ci_persona'] ?? 'Sin cliente' : nombre;
  }

  String _csvCell(Object? value) {
    final text = value?.toString().replaceAll('"', '""') ?? '';
    return '"$text"';
  }

  double _num(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
