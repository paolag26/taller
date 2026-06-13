import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/egreso_model.dart';
import 'package:sist_prestamo/controllers/egreso_service.dart';

class EgresoController extends ChangeNotifier {
  final service = EgresoService();

  bool loading = false;
  String? error;
  EgresoFilters filters = const EgresoFilters();

  List<EgresoModel> egresos = [];
  List<ConceptoGastoModel> conceptos = [];
  List<UsuarioEgresoModel> usuarios = [];

  Future<void> cargarEgresos() async {
    try {
      loading = true;
      error = null;
      notifyListeners();

      final data = await Future.wait([
        service.listarEgresos(),
        service.listarConceptos(),
        service.listarUsuarios(),
      ]);

      egresos = data[0] as List<EgresoModel>;
      conceptos = data[1] as List<ConceptoGastoModel>;
      usuarios = data[2] as List<UsuarioEgresoModel>;
    } catch (e) {
      error = 'No se pudieron cargar los egresos: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> guardarEgreso(EgresoModel egreso) async {
    try {
      if (egreso.idEgreso == null) {
        await service.insertarEgreso(egreso);
      } else {
        await service.actualizarEgreso(egreso);
      }

      await cargarEgresos();
    } catch (e) {
      error = _mensajeError('No se pudo guardar el egreso', e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> eliminarEgreso(int idEgreso) async {
    try {
      await service.eliminarEgreso(idEgreso);
      await cargarEgresos();
    } catch (e) {
      error = _mensajeError('No se pudo eliminar el egreso', e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> guardarConcepto(ConceptoGastoModel concepto) async {
    try {
      await service.guardarConcepto(concepto);
      conceptos = await service.listarConceptos();
      notifyListeners();
    } catch (e) {
      error = _mensajeError('No se pudo guardar el concepto de gasto', e);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> cambiarEstadoConcepto(
    ConceptoGastoModel concepto,
    bool activo,
  ) async {
    if (concepto.id == null) return;

    try {
      await service.cambiarEstadoConcepto(concepto.id!, activo);
      conceptos = await service.listarConceptos();
      notifyListeners();
    } catch (e) {
      error = _mensajeError('No se pudo cambiar el concepto de gasto', e);
      notifyListeners();
      rethrow;
    }
  }

  String _mensajeError(String prefix, Object error) {
    final text = error.toString().toLowerCase();
    debugPrint('$prefix: $error');
    if (text.contains('row-level security') || text.contains('42501')) {
      return '$prefix: La tabla tiene restricciones RLS configuradas en Base local.';
    }
    return '$prefix: $error';
  }

  void cambiarBusqueda(String value) {
    filters = filters.copyWith(query: value, page: 0);
    notifyListeners();
  }

  void cambiarConcepto(int? idConcepto) {
    filters = filters.copyWith(
      idConcepto: idConcepto,
      clearConcepto: idConcepto == null,
      page: 0,
    );
    notifyListeners();
  }

  void cambiarUsuario(String? idUsuario) {
    filters = filters.copyWith(
      idUsuario: idUsuario,
      clearUsuario: idUsuario == null,
      page: 0,
    );
    notifyListeners();
  }

  void cambiarRango(DateTime? desde, DateTime? hasta) {
    filters = filters.copyWith(
      desde: desde,
      hasta: hasta,
      clearDesde: desde == null,
      clearHasta: hasta == null,
      page: 0,
    );
    notifyListeners();
  }

  void cambiarIncluirInactivos(bool value) {
    filters = filters.copyWith(incluirInactivos: value, page: 0);
    notifyListeners();
  }

  void irPagina(int page) {
    if (page < 0 || page >= totalPaginas) return;
    filters = filters.copyWith(page: page);
    notifyListeners();
  }

  List<EgresoModel> get egresosFiltrados {
    final text = filters.query.trim().toLowerCase();

    return egresos.where((egreso) {
      if (!filters.incluirInactivos && !egreso.estado) return false;
      if (filters.idConcepto != null &&
          egreso.idConcepto != filters.idConcepto) {
        return false;
      }
      if (filters.idUsuario != null && egreso.idUsuario != filters.idUsuario) {
        return false;
      }

      final fecha = DateTime.tryParse(egreso.fecha);
      if (filters.desde != null && fecha != null) {
        final desde = _dateOnly(filters.desde!);
        if (_dateOnly(fecha).isBefore(desde)) return false;
      }
      if (filters.hasta != null && fecha != null) {
        final hasta = _dateOnly(filters.hasta!);
        if (_dateOnly(fecha).isAfter(hasta)) return false;
      }

      if (text.isEmpty) return true;

      return egreso.concepto.toLowerCase().contains(text) ||
          egreso.descripcion.toLowerCase().contains(text) ||
          egreso.conceptoNombre.toLowerCase().contains(text) ||
          egreso.usuarioNombre.toLowerCase().contains(text) ||
          egreso.fecha.contains(text) ||
          egreso.monto.toStringAsFixed(2).contains(text);
    }).toList();
  }

  List<EgresoModel> get egresosPaginados {
    final start = filters.page * filters.pageSize;
    final end = start + filters.pageSize;
    final list = egresosFiltrados;
    if (start >= list.length) return [];
    return list.sublist(start, end > list.length ? list.length : end);
  }

  int get totalPaginas {
    final total = egresosFiltrados.length;
    if (total == 0) return 1;
    return (total / filters.pageSize).ceil();
  }

  double get totalDia {
    final hoy = _dateOnly(DateTime.now());
    return _sumWhere((egreso) {
      final fecha = DateTime.tryParse(egreso.fecha);
      return fecha != null && _dateOnly(fecha) == hoy;
    });
  }

  double get totalMesActual {
    final hoy = DateTime.now();
    return _sumWhere((egreso) {
      final fecha = DateTime.tryParse(egreso.fecha);
      return fecha != null &&
          fecha.year == hoy.year &&
          fecha.month == hoy.month;
    });
  }

  double get totalAnioActual {
    final hoy = DateTime.now();
    return _sumWhere((egreso) {
      final fecha = DateTime.tryParse(egreso.fecha);
      return fecha != null && fecha.year == hoy.year;
    });
  }

  double get totalFiltrado {
    return egresosFiltrados.fold<double>(0, (total, egreso) {
      return total + (egreso.estado ? egreso.monto : 0);
    });
  }

  String get conceptoMayorGasto {
    final data = gastosPorConcepto;
    if (data.isEmpty) return 'Sin egresos';

    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries.first.key;
  }

  Map<String, double> get gastosPorConcepto {
    return _groupBy(
      (egreso) => egreso.conceptoNombre.trim().isEmpty
          ? 'Sin concepto'
          : egreso.conceptoNombre.trim(),
    );
  }

  Map<String, double> get gastosPorUsuario {
    return _groupBy(
      (egreso) => egreso.usuarioNombre.trim().isEmpty
          ? 'Sin usuario'
          : egreso.usuarioNombre.trim(),
    );
  }

  Map<String, double> get gastosPorFecha {
    return _groupBy((egreso) => egreso.fecha);
  }

  Map<String, double> get gastosPorMes {
    return _groupBy((egreso) {
      final fecha = DateTime.tryParse(egreso.fecha);
      if (fecha == null) return 'Sin fecha';
      return '${fecha.year}-${fecha.month.toString().padLeft(2, '0')}';
    });
  }

  Map<String, double> get gastosPorAnio {
    return _groupBy((egreso) {
      final fecha = DateTime.tryParse(egreso.fecha);
      if (fecha == null) return 'Sin fecha';
      return fecha.year.toString();
    });
  }

  Map<String, dynamic> get powerBiData {
    return {
      'gastos_por_concepto': gastosPorConcepto,
      'gastos_por_mes': gastosPorMes,
      'gastos_por_usuario': gastosPorUsuario,
      'comparativo_mensual': gastosPorMes,
    };
  }

  double _sumWhere(bool Function(EgresoModel egreso) test) {
    return egresos
        .where((egreso) {
          return egreso.estado && test(egreso);
        })
        .fold<double>(0, (total, egreso) => total + egreso.monto);
  }

  Map<String, double> _groupBy(String Function(EgresoModel egreso) keyBuilder) {
    final result = <String, double>{};

    for (final egreso in egresosFiltrados) {
      if (!egreso.estado) continue;
      final key = keyBuilder(egreso);
      result[key] = (result[key] ?? 0) + egreso.monto;
    }

    return result;
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
