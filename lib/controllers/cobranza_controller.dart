import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/cobranza_service.dart';
import 'package:sist_prestamo/controllers/app_formatters.dart';

class CobranzaController extends ChangeNotifier {
  final service = CobranzaService();

  bool loading = false;
  String? error;
  String query = '';
  String filtro = 'TODAS';

  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagos = [];

  Future<void> cargarCobranza() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final data = await Future.wait([
        service.listarCuotasCobranza(),
        service.listarPagos(),
      ]);

      cuotas = data[0];
      pagos = data[1];
    } catch (e) {
      error = 'No se pudo cargar cobranza: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void cambiarBusqueda(String value) {
    query = value;
    notifyListeners();
  }

  void cambiarFiltro(String value) {
    filtro = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> get cuotasFiltradas {
    return cuotas.where((cuota) {
      if (!_coincideBusqueda(cuota)) return false;

      switch (filtro) {
        case 'MORA':
          return estadoCuota(cuota) == 'MORA';
        case 'HOY':
          return venceHoy(cuota);
        case 'PENDIENTE':
          return estadoCuota(cuota) == 'PENDIENTE';
        case 'CON_UBICACION':
          return tieneUbicacion(cuota);
        case 'SIN_UBICACION':
          return !tieneUbicacion(cuota);
        default:
          return true;
      }
    }).toList();
  }

  List<Map<String, dynamic>> prestamosDesdeCuotas(
    List<Map<String, dynamic>> source,
  ) {
    final agrupados = <String, Map<String, dynamic>>{};

    for (final cuota in source) {
      final idPrestamo = cuota['id_prestamo']?.toString();
      if (idPrestamo == null || idPrestamo.isEmpty) continue;

      final item = agrupados.putIfAbsent(idPrestamo, () {
        return {
          'id_prestamo': cuota['id_prestamo'],
          'prestamo': cuota['prestamo'],
          'cuotas': <Map<String, dynamic>>[],
        };
      });
      (item['cuotas'] as List<Map<String, dynamic>>).add(cuota);
    }

    final result = agrupados.values.toList();
    for (final item in result) {
      final cuotasPrestamo = cuotasPrestamoItem(item);
      cuotasPrestamo.sort((a, b) {
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
    }
    result.sort((a, b) {
      final moraA = cuotasMoraPrestamo(a);
      final moraB = cuotasMoraPrestamo(b);
      if (moraA != moraB) return moraB.compareTo(moraA);
      return saldoPendientePrestamo(b).compareTo(saldoPendientePrestamo(a));
    });
    return result;
  }

  List<Map<String, dynamic>> cuotasPrestamoItem(Map<String, dynamic> item) {
    return List<Map<String, dynamic>>.from(item['cuotas'] as List? ?? const []);
  }

  double saldoPendientePrestamo(Map<String, dynamic> item) {
    return cuotasPrestamoItem(
      item,
    ).fold<double>(0, (total, cuota) => total + montoCuota(cuota));
  }

  int cuotasPendientesPrestamo(Map<String, dynamic> item) {
    return cuotasPrestamoItem(
      item,
    ).where((cuota) => estadoCuota(cuota) == 'PENDIENTE').length;
  }

  int cuotasMoraPrestamo(Map<String, dynamic> item) {
    return cuotasPrestamoItem(
      item,
    ).where((cuota) => estadoCuota(cuota) == 'MORA').length;
  }

  String estadoPrestamoCobranza(Map<String, dynamic> item) {
    if (cuotasMoraPrestamo(item) > 0) return 'MORA';
    if (saldoPendientePrestamo(item) <= 0) return 'PAGADO';
    final estado = item['prestamo']?['estado_prestamo']?['nombre']
        ?.toString()
        .toUpperCase();
    return estado?.isNotEmpty == true ? estado! : 'ACTIVO';
  }

  Map<String, dynamic>? proximaCuotaPrestamo(Map<String, dynamic> item) {
    final pendientes = cuotasPrestamoItem(
      item,
    ).where((cuota) => estadoCuota(cuota) != 'PAGADO').toList();
    if (pendientes.isEmpty) return null;
    pendientes.sort((a, b) {
      final fechaA =
          DateTime.tryParse(a['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      final fechaB =
          DateTime.tryParse(b['fecha_vencimiento']?.toString() ?? '') ??
          DateTime(2100);
      return fechaA.compareTo(fechaB);
    });
    return pendientes.first;
  }

  Map<String, dynamic>? ultimoPagoPrestamo(Map<String, dynamic> item) {
    final idPrestamo = item['id_prestamo']?.toString();
    if (idPrestamo == null) return null;
    final pagosPrestamo = pagos.where((pago) {
      final pagoPrestamo =
          pago['id_prestamo']?.toString() ??
          pago['cuota']?['id_prestamo']?.toString();
      return pagoPrestamo == idPrestamo;
    }).toList();
    if (pagosPrestamo.isEmpty) return null;
    pagosPrestamo.sort((a, b) {
      final fechaA =
          DateTime.tryParse(a['fecha_pago']?.toString() ?? '') ??
          DateTime(1900);
      final fechaB =
          DateTime.tryParse(b['fecha_pago']?.toString() ?? '') ??
          DateTime(1900);
      return fechaB.compareTo(fechaA);
    });
    return pagosPrestamo.first;
  }

  List<Map<String, dynamic>> get cuotasDeHoy {
    return cuotas.where(venceHoy).toList();
  }

  List<Map<String, dynamic>> get cuotasVencidas {
    return cuotas.where((cuota) => estadoCuota(cuota) == 'MORA').toList();
  }

  List<Map<String, dynamic>> get cuotasPendientes {
    return cuotas.where((cuota) => estadoCuota(cuota) == 'PENDIENTE').toList();
  }

  List<Map<String, dynamic>> get cuotasConUbicacion {
    return cuotasFiltradas.where(tieneUbicacion).toList();
  }

  List<Map<String, dynamic>> get clientesConUbicacionConsolidados {
    final clientes = <int, Map<String, dynamic>>{};

    for (final cuota in cuotasConUbicacion) {
      final cliente = cuota['prestamo']?['cliente'];
      final idCliente = cliente?['id_cliente'];
      if (idCliente is! int) continue;

      final item = clientes.putIfAbsent(idCliente, () {
        return {
          'id_cliente': idCliente,
          'cliente': cliente,
          'cuota_representativa': cuota,
          'cuotas': <Map<String, dynamic>>[],
          'total_pendiente': 0.0,
          'cuotas_mora': 0,
          'cuotas_pendientes': 0,
        };
      });

      final cuotasCliente = item['cuotas'] as List<Map<String, dynamic>>;
      cuotasCliente.add(cuota);
      item['total_pendiente'] =
          (item['total_pendiente'] as double) + montoCuota(cuota);
      if (estadoCuota(cuota) == 'MORA') {
        item['cuotas_mora'] = (item['cuotas_mora'] as int) + 1;
      } else {
        item['cuotas_pendientes'] = (item['cuotas_pendientes'] as int) + 1;
      }
    }

    final result = clientes.values.toList();
    result.sort((a, b) {
      final moraA = a['cuotas_mora'] as int;
      final moraB = b['cuotas_mora'] as int;
      if (moraA != moraB) return moraB.compareTo(moraA);
      return ((b['total_pendiente'] as double).compareTo(
        a['total_pendiente'] as double,
      ));
    });
    return result;
  }

  double get totalACobrarHoy {
    return cuotasDeHoy.fold(0, (total, cuota) => total + montoCuota(cuota));
  }

  double get totalPendienteHoy {
    return totalACobrarHoy - totalCobradoHoy;
  }

  double get totalCobradoHoy {
    final hoy = fechaSinHora(DateTime.now());
    return pagos
        .where((pago) {
          final fecha = DateTime.tryParse(pago['fecha_pago']?.toString() ?? '');
          return fecha != null && fechaSinHora(fecha).isAtSameMomentAs(hoy);
        })
        .fold(0, (total, pago) {
          return total + _toDouble(pago['monto'] ?? pago['monto_pagado']);
        });
  }

  double get totalPendienteGeneral {
    return cuotasFiltradas.fold(0, (total, cuota) => total + montoCuota(cuota));
  }

  int get clientesAVisitarHoy {
    return cuotasDeHoy
        .map((cuota) {
          return cuota['prestamo']?['cliente']?['id_cliente'];
        })
        .whereType<int>()
        .toSet()
        .length;
  }

  int get clientesEnMora {
    return cuotasVencidas
        .map((cuota) {
          return cuota['prestamo']?['cliente']?['id_cliente'];
        })
        .whereType<int>()
        .toSet()
        .length;
  }

  int get clientesAlDia {
    final clientesConPendiente = cuotas
        .map((cuota) {
          return cuota['prestamo']?['cliente']?['id_cliente'];
        })
        .whereType<int>()
        .toSet();

    final clientesMora = cuotasVencidas
        .map((cuota) {
          return cuota['prestamo']?['cliente']?['id_cliente'];
        })
        .whereType<int>()
        .toSet();

    return clientesConPendiente.difference(clientesMora).length;
  }

  double get porcentajeRecuperacion {
    final esperado = totalACobrarHoy + totalCobradoHoy;
    if (esperado <= 0) return 0;
    return (totalCobradoHoy / esperado).clamp(0, 1);
  }

  List<Map<String, dynamic>> buscarCuotasCliente(String text) {
    final original = query;
    query = text;
    final result = cuotasFiltradas;
    query = original;
    return result;
  }

  List<Map<String, dynamic>> pagosCliente(dynamic idCliente) {
    return pagos.where((pago) {
      final pagoCliente = pago['cuota']?['prestamo']?['cliente']?['id_cliente'];
      return pagoCliente == idCliente;
    }).toList();
  }

  Map<String, double> get reporteDiario => _groupByFecha((date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  });

  Map<String, double> get reporteSemanal => _groupByFecha((date) {
    final firstDay = date.subtract(Duration(days: date.weekday - 1));
    return 'Semana ${firstDay.day.toString().padLeft(2, '0')}/${firstDay.month.toString().padLeft(2, '0')}';
  });

  Map<String, double> get reporteMensual => _groupByFecha((date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  });

  List<Map<String, dynamic>> get clientesConMasAtraso {
    final data = <int, Map<String, dynamic>>{};

    for (final cuota in cuotasVencidas) {
      final cliente = cuota['prestamo']?['cliente'];
      final id = cliente?['id_cliente'];
      if (id is! int) continue;

      data.putIfAbsent(id, () {
        return {
          'cliente': cliente,
          'nombre': nombreCliente(cuota),
          'dias': 0,
          'saldo': 0.0,
        };
      });

      data[id]!['dias'] = (data[id]!['dias'] as int) + diasAtraso(cuota);
      data[id]!['saldo'] = (data[id]!['saldo'] as double) + montoCuota(cuota);
    }

    final result = data.values.toList()
      ..sort((a, b) => (b['dias'] as int).compareTo(a['dias'] as int));
    return result.take(10).toList();
  }

  String estadoCuota(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado == 'PAGADA' || estado == 'PAGADO') return 'PAGADO';
    if (estado == 'MORA') return 'MORA';
    return diasAtraso(cuota) > 0 ? 'MORA' : 'PENDIENTE';
  }

  int diasAtraso(Map<String, dynamic> cuota) {
    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return 0;
    final diff = fechaSinHora(DateTime.now()).difference(fechaSinHora(fecha));
    return diff.inDays > 0 ? diff.inDays : 0;
  }

  bool venceHoy(Map<String, dynamic> cuota) {
    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return false;
    return fechaSinHora(fecha).isAtSameMomentAs(fechaSinHora(DateTime.now()));
  }

  bool tieneUbicacion(Map<String, dynamic> cuota) {
    final persona = cuota['prestamo']?['cliente']?['persona'];
    return _toDouble(persona?['latitud']) != 0 &&
        _toDouble(persona?['longitud']) != 0;
  }

  String nombreCliente(Map<String, dynamic> cuota) {
    final persona = cuota['prestamo']?['cliente']?['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombre = '$nombres $paterno $materno'.trim();
    return nombre.isEmpty ? 'Cliente sin nombre' : nombre;
  }

  String nombreClienteConsolidado(Map<String, dynamic> item) {
    final cuota = item['cuota_representativa'];
    if (cuota is Map<String, dynamic>) return nombreCliente(cuota);
    return 'Cliente sin nombre';
  }

  double montoCuota(Map<String, dynamic> cuota) {
    final saldo = _toDouble(cuota['saldo_pendiente']);
    if (saldo > 0) return saldo;
    return _toDouble(cuota['monto_cuota']);
  }

  double saldoPrestamo(Map<String, dynamic> cuota) {
    return _toDouble(
      cuota['prestamo']?['saldo_pendiente_calculado'] ??
          cuota['prestamo']?['saldo_pendiente'],
    );
  }

  String money(dynamic value) => AppFormatters.money(value);

  DateTime fechaSinHora(DateTime fecha) {
    return DateTime(fecha.year, fecha.month, fecha.day);
  }

  bool _coincideBusqueda(Map<String, dynamic> cuota) {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return true;

    final persona = cuota['prestamo']?['cliente']?['persona'];
    final nombre =
        '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''} ${persona?['apellido_materno'] ?? ''}'
            .toLowerCase();
    final ci =
        cuota['prestamo']?['cliente']?['ci_persona']
            ?.toString()
            .toLowerCase() ??
        '';
    final telefono = persona?['telefono']?.toString().toLowerCase() ?? '';
    final prestamo = cuota['id_prestamo']?.toString() ?? '';

    return nombre.contains(text) ||
        ci.contains(text) ||
        telefono.contains(text) ||
        prestamo.contains(text);
  }

  Map<String, double> _groupByFecha(String Function(DateTime date) keyBuilder) {
    final result = <String, double>{};

    for (final pago in pagos) {
      final fecha = DateTime.tryParse(pago['fecha_pago']?.toString() ?? '');
      if (fecha == null) continue;
      final key = keyBuilder(fecha);
      result[key] =
          (result[key] ?? 0) + _toDouble(pago['monto'] ?? pago['monto_pagado']);
    }

    return result;
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
