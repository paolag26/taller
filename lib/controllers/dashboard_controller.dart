import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_role.dart';
import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/dashboard_service.dart';

class DashboardController extends ChangeNotifier {
  final service = DashboardService();
  final roleService = RoleService();

  bool loading = false;
  String? error;
  AppRole role = AppRole.admin;

  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> clientes = [];
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagosHoy = [];
  List<Map<String, dynamic>> pagosMes = [];

  Future<void> cargarDashboard() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      role = (await roleService.currentAccess()).role;
      final data = await service.cargarDashboard();
      prestamos = data['prestamos'];
      clientes = data['clientes'];
      cuotas = data['cuotas'];
      pagosHoy = data['pagos_hoy'];
      pagosMes = data['pagos_mes'];
    } catch (e) {
      error = 'No se pudo cargar el dashboard: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  bool get isCobrador => role == AppRole.cobrador;

  int get prestamosActivos {
    return prestamos.where((prestamo) {
      final estado =
          prestamo['estado_prestamo']?['nombre']?.toString().toUpperCase() ??
          '';
      return estado == 'ACTIVO' || estado == 'MORA';
    }).length;
  }

  int get clientesActivos {
    return clientes.where((cliente) => cliente['estado'] != false).length;
  }

  int get cuotasVencidas => cuotas.where(_cuotaEnMora).length;

  int get cuotasPagadas => cuotas.where(_cuotaPagada).length;

  int get cuotasPendientes {
    return cuotas.where((cuota) {
      return !_cuotaPagada(cuota) && !_cuotaEnMora(cuota);
    }).length;
  }

  double get riesgoMora {
    return cuotas
        .where(_cuotaEnMora)
        .fold<double>(0, (total, cuota) => total + _saldoCuota(cuota));
  }

  int get cuotasVencenHoy {
    final hoy = DateTime.now();
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    return cuotas.where((cuota) {
      if (_cuotaPagada(cuota)) return false;
      final fecha = DateTime.tryParse(
        cuota['fecha_vencimiento']?.toString() ?? '',
      );
      if (fecha == null) return false;
      final fechaSinHora = DateTime(fecha.year, fecha.month, fecha.day);
      return fechaSinHora == hoySinHora;
    }).length;
  }

  double get cobradoHoy {
    return pagosHoy.fold<double>(
      0,
      (total, pago) => total + _num(pago['monto'] ?? pago['monto_pagado']),
    );
  }

  double get cobradoMes {
    return pagosMes.fold<double>(
      0,
      (total, pago) => total + _num(pago['monto'] ?? pago['monto_pagado']),
    );
  }

  int get cobrosRealizadosHoy => pagosHoy.length;

  int get clientesPendientesVisita {
    final ids = <String>{};
    for (final cuota in cuotas) {
      if (_cuotaPagada(cuota)) continue;
      final cliente = cuota['prestamo']?['cliente'];
      final idCliente = cliente?['id_cliente']?.toString();
      if (idCliente != null && idCliente.isNotEmpty) ids.add(idCliente);
    }
    return ids.length;
  }

  double get carteraPendiente {
    return cuotas
        .where((cuota) => !_cuotaPagada(cuota))
        .fold<double>(0, (total, cuota) => total + _saldoCuota(cuota));
  }

  List<Map<String, dynamic>> get alertas {
    final items = <Map<String, dynamic>>[];

    if (cuotasVencidas > 0) {
      items.add({
        'icon': Icons.warning,
        'color': const Color(0xffdc2626),
        'title': '$cuotasVencidas cuotas vencidas',
        'subtitle': 'Revisar cobranza y clientes en mora',
      });
    }

    if (cuotasVencenHoy > 0) {
      items.add({
        'icon': Icons.event,
        'color': const Color(0xffd97706),
        'title': '$cuotasVencenHoy cuotas vencen hoy',
        'subtitle': 'Programar cobro del dia',
      });
    }

    return items;
  }

  List<Map<String, dynamic>> get proximasCuotas {
    final pendientes = cuotas.where((cuota) => !_cuotaPagada(cuota)).toList();
    pendientes.sort((a, b) {
      final fechaA =
          DateTime.tryParse(a['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      final fechaB =
          DateTime.tryParse(b['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      return fechaA.compareTo(fechaB);
    });
    return pendientes.take(6).toList();
  }

  String nombreCliente(Map<String, dynamic> cuota) {
    final cliente = cuota['prestamo']?['cliente'];
    final persona = cliente?['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombre = '$nombres $paterno $materno'.trim();
    return nombre.isEmpty ? (cliente?['ci_persona'] ?? 'Sin cliente') : nombre;
  }

  double saldoCuota(Map<String, dynamic> cuota) => _saldoCuota(cuota);

  bool _cuotaPagada(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    final saldo = _saldoCuota(cuota);
    return estado == 'PAGADA' || estado == 'PAGADO' || saldo <= 0;
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
    final saldo = _num(cuota['saldo_pendiente']);
    if (saldo > 0) return saldo;
    return _num(cuota['monto_cuota'] ?? cuota['monto_total']);
  }

  double _num(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
