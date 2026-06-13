import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/pago_model.dart';

import 'package:sist_prestamo/controllers/pago_service.dart';

class PagoController extends ChangeNotifier {
  final _service = PagoService();

  // =========================
  // VARIABLES
  // =========================

  bool loading = false;

  List<Map<String, dynamic>> pagos = [];

  // =========================
  // LISTAR PAGOS
  // =========================

  Future<void> cargarPagos() async {
    try {
      loading = true;

      notifyListeners();

      pagos = await _service.listarPagos();
    } catch (e) {
      debugPrint('ERROR CARGAR PAGOS: $e');
    } finally {
      loading = false;

      notifyListeners();
    }
  }

  // =========================
  // INSERTAR PAGO
  // =========================

  Future<void> insertarPago(PagoModel pago) async {
    try {
      loading = true;

      notifyListeners();

      await _service.insertarPago(pago);

      await cargarPagos();
    } catch (e) {
      debugPrint('ERROR INSERTAR PAGO: $e');
    } finally {
      loading = false;

      notifyListeners();
    }
  }

  Future<void> registrarPagosCuotas({
    required List<Map<String, dynamic>> cuotas,
    required double montoTotal,
    required String fecha,
    required String metodoPago,
    required String observacion,
    String tipoPago = 'NORMAL',
  }) async {
    await _service.registrarPagosCuotas(
      cuotas: cuotas,
      montoTotal: montoTotal,
      fecha: fecha,
      metodoPago: metodoPago,
      observacion: observacion,
      tipoPago: tipoPago,
    );

    await cargarPagos();
  }

  Future<void> registrarAmortizacion({
    required int idPrestamo,
    required double monto,
    required String fecha,
    required String metodoPago,
    required String observacion,
  }) async {
    await _service.registrarAmortizacion(
      idPrestamo: idPrestamo,
      monto: monto,
      fecha: fecha,
      metodoPago: metodoPago,
      observacion: observacion,
    );

    await cargarPagos();
  }

  // =========================
  // ACTUALIZAR PAGO
  // =========================

  Future<void> actualizarPago(PagoModel pago) async {
    try {
      loading = true;

      notifyListeners();

      await _service.actualizarPago(pago);

      await cargarPagos();
    } catch (e) {
      debugPrint('ERROR ACTUALIZAR PAGO: $e');
    } finally {
      loading = false;

      notifyListeners();
    }
  }

  // =========================
  // ELIMINAR PAGO
  // =========================

  Future<void> eliminarPago(int idPago) async {
    try {
      loading = true;

      notifyListeners();

      await _service.eliminarPago(idPago);

      await cargarPagos();
    } catch (e) {
      debugPrint('ERROR ELIMINAR PAGO: $e');
    } finally {
      loading = false;

      notifyListeners();
    }
  }

  Future<List<Map<String, dynamic>>> listarClientesConCuotas() {
    return _service.listarClientesConCuotas();
  }

  List<Map<String, dynamic>> cuotasCliente(Map<String, dynamic>? cliente) {
    if (cliente == null) return [];

    final cuotas = List<Map<String, dynamic>>.from(
      cliente['cuotas_pendientes'] ?? [],
    );
    cuotas.sort(compararCuotas);
    return cuotas;
  }

  List<Map<String, dynamic>> prestamosCliente(Map<String, dynamic>? cliente) {
    if (cliente == null) return [];
    final prestamos = List<Map<String, dynamic>>.from(
      cliente['prestamos_activos'] ?? [],
    );
    prestamos.sort((a, b) {
      return (a['id_prestamo'] ?? 0).compareTo(b['id_prestamo'] ?? 0);
    });
    return prestamos;
  }

  List<Map<String, dynamic>> cuotasPrestamo(
    Map<String, dynamic>? cliente,
    Map<String, dynamic>? prestamo,
  ) {
    final cuotasPrestamo = cuotasPrestamoTodas(
      cliente,
      prestamo,
    ).where(_cuotaCobrable).toList();
    cuotasPrestamo.sort(compararCuotas);
    return cuotasPrestamo;
  }

  List<Map<String, dynamic>> cuotasPrestamoTodas(
    Map<String, dynamic>? cliente,
    Map<String, dynamic>? prestamo,
  ) {
    if (prestamo == null) return cuotasCliente(cliente);

    final idPrestamo = _toInt(prestamo['id_prestamo']);
    final cuotasPrestamo = List<Map<String, dynamic>>.from(
      prestamo['cuotas'] ?? [],
    );
    if (cuotasPrestamo.isNotEmpty) {
      cuotasPrestamo.sort(compararCuotas);
      return cuotasPrestamo;
    }

    return cuotasCliente(
        cliente,
      ).where((cuota) => _toInt(cuota['id_prestamo']) == idPrestamo).toList()
      ..sort(compararCuotas);
  }

  bool _cuotaCobrable(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    return estado != 'PAGADA' && estado != 'PAGADO' && saldoCuota(cuota) > 0;
  }

  List<Map<String, dynamic>> cuotasSeleccionadas({
    required Map<String, dynamic>? cliente,
    required Map<String, dynamic>? prestamo,
    required Set<int> selectedCuotaIds,
  }) {
    return cuotasPrestamo(cliente, prestamo).where((cuota) {
      return selectedCuotaIds.contains(cuota['id_cuota']);
    }).toList();
  }

  double saldoCuota(Map<String, dynamic> cuota) {
    final saldo = _toDouble(
      cuota['saldo_pendiente'] ?? cuota['saldo_restante'] ?? cuota['saldo'],
    );
    if (saldo > 0) return saldo;
    return _toDouble(
      cuota['monto_cuota'] ?? cuota['monto_total'] ?? cuota['monto'],
    );
  }

  double totalCuotas(List<Map<String, dynamic>> cuotas) {
    return cuotas.fold<double>(0, (sum, cuota) {
      return sum + saldoCuota(cuota);
    });
  }

  int compararCuotas(Map<String, dynamic> a, Map<String, dynamic> b) {
    final fechaA =
        DateTime.tryParse(a['fecha_vencimiento']?.toString() ?? '') ??
        DateTime(2100);
    final fechaB =
        DateTime.tryParse(b['fecha_vencimiento']?.toString() ?? '') ??
        DateTime(2100);
    final byDate = fechaA.compareTo(fechaB);
    if (byDate != 0) return byDate;
    return (a['numero_cuota'] ?? 0).compareTo(b['numero_cuota'] ?? 0);
  }

  String tipoPagoParaCuotas(
    List<Map<String, dynamic>> cuotas,
    String tipoPago,
  ) {
    if (tipoPago == 'ADELANTADA') return 'ADELANTADO';
    final hoy = DateTime.now();
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    final tieneMora = cuotas.any((cuota) {
      final fecha = DateTime.tryParse(
        cuota['fecha_vencimiento']?.toString() ?? '',
      );
      return fecha != null &&
          DateTime(fecha.year, fecha.month, fecha.day).isBefore(hoySinHora);
    });
    return tieneMora ? 'MORA' : 'NORMAL';
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
