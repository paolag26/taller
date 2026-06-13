import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/cuota_model.dart';
import 'package:sist_prestamo/controllers/cuota_service.dart';

class CuotaController extends ChangeNotifier {
  final service = CuotaService();

  bool loading = false;
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> clientesEncontrados = [];
  String query = '';
  String estadoFiltro = 'TODOS';
  Map<String, dynamic>? clienteEncontrado;
  List<Map<String, dynamic>> prestamosCliente = [];
  Map<String, dynamic>? prestamoSeleccionado;
  String? errorBusqueda;

  Future<void> cargarCuotas() async {
    try {
      loading = true;
      notifyListeners();
      cuotas = await service.listarCuotas();
    } catch (e) {
      debugPrint('ERROR CONTROLLER: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> buscarClientes(String value) async {
    try {
      query = value;
      errorBusqueda = null;
      clienteEncontrado = null;
      prestamosCliente = [];
      prestamoSeleccionado = null;
      loading = true;
      notifyListeners();

      clientesEncontrados = await service.buscarClientes(value);

      if (clientesEncontrados.isEmpty) {
        errorBusqueda = 'No se encontro un cliente con ese criterio';
      } else if (clientesEncontrados.length == 1) {
        await seleccionarCliente(clientesEncontrados.first);
        return;
      }
    } catch (e) {
      errorBusqueda = 'No se pudo buscar el cliente: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> buscarPorCarnet(String value) async {
    await buscarClientes(value);
  }

  Future<void> seleccionarCliente(Map<String, dynamic> cliente) async {
    try {
      loading = true;
      errorBusqueda = null;
      notifyListeners();

      final data = await service.cargarClienteCompleto(cliente['id_cliente']);
      clienteEncontrado = data;
      clientesEncontrados = data == null ? [] : [data];
      prestamosCliente = List<Map<String, dynamic>>.from(
        data?['prestamos'] ?? [],
      );
      prestamoSeleccionado = prestamosCliente.isNotEmpty
          ? prestamosCliente.first
          : null;

      if (data == null) {
        errorBusqueda = 'No se pudo cargar el cliente seleccionado';
      } else if (prestamosCliente.isEmpty) {
        errorBusqueda = 'El cliente no tiene prestamos registrados.';
      }
    } catch (e) {
      errorBusqueda = 'No se pudo cargar el cliente: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void seleccionarPrestamo(Map<String, dynamic> prestamo) {
    prestamoSeleccionado = prestamo;
    notifyListeners();
  }

  List<Map<String, dynamic>> get cuotasPrestamoSeleccionado {
    final list = List<Map<String, dynamic>>.from(
      prestamoSeleccionado?['cuotas'] ?? [],
    );
    list.sort((a, b) {
      final fechaA =
          DateTime.tryParse(a['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      final fechaB =
          DateTime.tryParse(b['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      final byDate = fechaA.compareTo(fechaB);
      if (byDate != 0) return byDate;
      return (a['numero_cuota'] ?? 0).compareTo(b['numero_cuota'] ?? 0);
    });
    return list;
  }

  List<Map<String, dynamic>> get cuotasFiltradas {
    return cuotas.where((cuota) {
      final coincideEstado = _coincideFiltroEstado(cuota);
      final coincideBusqueda = _coincideBusqueda(cuota);
      return coincideEstado && coincideBusqueda;
    }).toList();
  }

  List<Map<String, dynamic>> filtrarCuotasPlan(
    List<Map<String, dynamic>> source,
  ) {
    return source.where(_coincideFiltroEstado).toList();
  }

  double get montoPrestamo {
    return _toDouble(prestamoSeleccionado?['monto']);
  }

  double get totalPagado {
    return cuotasPrestamoSeleccionado.fold<double>(0, (total, cuota) {
      final monto = montoCuota(cuota);
      final saldo = saldoCuota(cuota);
      final pagado = (monto - saldo).clamp(0, monto);
      return total + pagado;
    });
  }

  double get saldoPendiente {
    return cuotasPrestamoSeleccionado.fold<double>(
      0,
      (total, cuota) => total + saldoCuota(cuota),
    );
  }

  int get cuotasPagadas {
    return cuotasPrestamoSeleccionado
        .where((cuota) => estadoCuota(cuota) == 'PAGADO')
        .length;
  }

  int get cuotasPendientes {
    return cuotasPrestamoSeleccionado
        .where((cuota) => estadoCuota(cuota) == 'PENDIENTE')
        .length;
  }

  int get cuotasMora {
    return cuotasPrestamoSeleccionado
        .where((cuota) => estadoCuota(cuota) == 'MORA')
        .length;
  }

  void cambiarBusqueda(String value) {
    query = value;
    notifyListeners();
  }

  void cambiarEstado(String value) {
    estadoFiltro = value;
    notifyListeners();
  }

  bool _coincideFiltroEstado(Map<String, dynamic> cuota) {
    if (estadoFiltro == 'TODOS') return true;
    if (estadoFiltro == 'HOY') return cuotaVenceHoy(cuota);
    return estadoCuota(cuota) == estadoFiltro;
  }

  bool cuotaVenceHoy(Map<String, dynamic> cuota) {
    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return false;
    final hoy = DateTime.now();
    return DateTime(fecha.year, fecha.month, fecha.day) ==
        DateTime(hoy.year, hoy.month, hoy.day);
  }

  String estadoCuota(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado == 'PAGADA' || estado == 'PAGADO') return 'PAGADO';
    if (estado == 'MORA') return 'MORA';

    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (saldoCuota(cuota) > 0 && fecha != null) {
      final hoy = DateTime.now();
      final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
      final fechaSinHora = DateTime(fecha.year, fecha.month, fecha.day);
      if (fechaSinHora.isBefore(hoySinHora)) return 'MORA';
    }

    return 'PENDIENTE';
  }

  double montoCuota(Map<String, dynamic> cuota) {
    final monto = _toDouble(cuota['monto_cuota']);
    if (monto > 0) return monto;
    return _toDouble(cuota['monto_total']);
  }

  double saldoCuota(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado == 'PAGADA' || estado == 'PAGADO') return 0;

    final saldo = _toDouble(
      cuota['saldo_pendiente'] ?? cuota['saldo_restante'],
    );
    if (saldo > 0) return saldo;
    return montoCuota(cuota);
  }

  String tipoPagoCuota(Map<String, dynamic> cuota) {
    final pagos = List<Map<String, dynamic>>.from(cuota['pagos'] ?? []);
    if (pagos.isEmpty) return 'SIN PAGO';

    final tipos = pagos.map((pago) {
      return pago['tipo_pago']?.toString().toUpperCase() ?? 'NORMAL';
    }).toSet();

    if (tipos.contains('AMORTIZACION')) return 'AMORTIZACION';
    if (tipos.contains('ADELANTADO')) return 'ADELANTADO';
    if (tipos.contains('MORA')) return 'MORA';
    return 'NORMAL';
  }

  String money(dynamic value) {
    return 'Bs ${_toDouble(value).toStringAsFixed(2)}';
  }

  bool _coincideBusqueda(Map<String, dynamic> cuota) {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return true;

    final cliente = cuota['prestamo']?['cliente'];
    final persona = cliente?['persona'];
    final ci = cliente?['ci_persona']?.toString().toLowerCase() ?? '';
    final telefono = persona?['telefono']?.toString().toLowerCase() ?? '';
    final nombre =
        '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''} ${persona?['apellido_materno'] ?? ''}'
            .toLowerCase();
    final prestamo = cuota['id_prestamo']?.toString() ?? '';

    return ci.contains(text) ||
        telefono.contains(text) ||
        nombre.contains(text) ||
        prestamo.contains(text);
  }

  Future<void> insertarCuota(CuotaModel cuota) async {
    await service.insertarCuota(cuota);
    await cargarCuotas();
  }

  Future<void> actualizarCuota(CuotaModel cuota) async {
    await service.actualizarCuota(cuota);
    await cargarCuotas();
  }

  Future<void> eliminarCuota(int idCuota) async {
    await service.eliminarCuota(idCuota);
    await cargarCuotas();
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
