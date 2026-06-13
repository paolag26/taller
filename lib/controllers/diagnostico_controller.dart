import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/diagnostico_service.dart';

class DiagnosticoController extends ChangeNotifier {
  final service = DiagnosticoService();

  bool loading = false;
  String? error;

  List<Map<String, dynamic>> roles = [];
  List<Map<String, dynamic>> usuarios = [];
  List<Map<String, dynamic>> personas = [];
  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> planes = [];
  List<Map<String, dynamic>> cuotas = [];
  List<Map<String, dynamic>> pagos = [];
  List<Map<String, dynamic>> conceptosGasto = [];
  List<Map<String, dynamic>> egresos = [];
  String? conceptoGastoError;

  Future<void> cargar() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      final data = await service.cargarDiagnostico();
      roles = _rows(data['roles']);
      usuarios = _rows(data['usuarios']);
      personas = _rows(data['personas']);
      prestamos = _rows(data['prestamos']);
      planes = _rows(data['planes']);
      cuotas = _rows(data['cuotas']);
      pagos = _rows(data['pagos']);
      conceptosGasto = _rows(data['conceptos_gasto']);
      egresos = _rows(data['egresos']);
      conceptoGastoError = data['concepto_gasto_error']?.toString();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  List<String> get rolesFaltantes {
    final existentes = roles
        .map((rol) => rol['nombre']?.toString().trim().toUpperCase())
        .whereType<String>()
        .toSet();
    return [
      'ADMIN',
      'CLIENTE',
      'COBRADOR',
    ].where((rol) => !existentes.contains(rol)).toList();
  }

  List<Map<String, dynamic>> get usuariosDiagnostico {
    final rolesById = _byKey(roles, 'id_rol');
    final personasByCi = _personasByCi(personas);

    return usuarios.map((usuario) {
      final persona = personasByCi[usuario['ci_persona']?.toString() ?? ''];
      final rol = rolesById[usuario['id_rol']?.toString() ?? ''];
      return {
        'persona': _nombrePersona(persona),
        'ci_persona': usuario['ci_persona'],
        'rol': rol?['nombre'] ?? 'Sin rol',
        'username': usuario['username'] ?? usuario['email'] ?? '',
        'estado': usuario['estado'] == false ? 'INACTIVO' : 'ACTIVO',
        'id_usuario': usuario['id_usuario'],
      };
    }).toList();
  }

  List<Map<String, dynamic>> get prestamosDiagnostico {
    final planesByPrestamo = <String, List<Map<String, dynamic>>>{};
    for (final plan in planes) {
      final idPrestamo = plan['id_prestamo']?.toString();
      if (idPrestamo == null || idPrestamo.isEmpty) continue;
      planesByPrestamo.putIfAbsent(idPrestamo, () => []).add(plan);
    }

    final cuotasByPrestamo = <String, List<Map<String, dynamic>>>{};
    for (final cuota in cuotasNormalizadas) {
      final idPrestamo = cuota['id_prestamo']?.toString();
      if (idPrestamo == null || idPrestamo.isEmpty) continue;
      cuotasByPrestamo.putIfAbsent(idPrestamo, () => []).add(cuota);
    }

    return prestamos.map((prestamo) {
      final id = prestamo['id_prestamo']?.toString() ?? '';
      final cuotasPrestamo = cuotasByPrestamo[id] ?? [];
      final pagadas = cuotasPrestamo.where(_cuotaPagada).length;
      final mora = cuotasPrestamo.where(_cuotaMora).length;
      final pendientes = cuotasPrestamo.length - pagadas - mora;
      final saldo = cuotasPrestamo
          .where((cuota) => !_cuotaPagada(cuota))
          .fold(0.0, (total, cuota) => total + _saldoCuota(cuota));

      return {
        'id_prestamo': id,
        'planes': planesByPrestamo[id]?.length ?? 0,
        'cuotas': cuotasPrestamo.length,
        'pendientes': pendientes,
        'pagadas': pagadas,
        'mora': mora,
        'saldo': saldo,
      };
    }).toList();
  }

  List<Map<String, dynamic>> get cuotasNormalizadas {
    final planesById = _byKey(planes, 'id_plan');

    return cuotas.map((cuotaOriginal) {
      final cuota = Map<String, dynamic>.from(cuotaOriginal);
      final plan = planesById[cuota['id_plan']?.toString() ?? ''];
      cuota['id_prestamo'] ??= plan?['id_prestamo'];
      cuota['monto_cuota'] ??= cuota['monto_total'] ?? cuota['monto'];
      cuota['saldo_pendiente'] ??=
          cuota['saldo_restante'] ?? cuota['saldo'] ?? cuota['monto_cuota'];
      cuota['estado'] ??= _saldoCuota(cuota) <= 0 ? 'PAGADO' : 'PENDIENTE';
      return cuota;
    }).toList();
  }

  List<Map<String, dynamic>> get cuotasPendientesDiagnostico {
    return cuotasNormalizadas.where((cuota) => !_cuotaPagada(cuota)).map((
      cuota,
    ) {
      return {
        'id_prestamo': cuota['id_prestamo'],
        'id_cuota': cuota['id_cuota'],
        'estado': _estadoCuota(cuota),
        'saldo_pendiente': _saldoCuota(cuota),
      };
    }).toList();
  }

  List<Map<String, dynamic>> get coordenadasDiagnostico {
    return personas
        .where((persona) {
          return _toDouble(persona['latitud']) != null &&
              _toDouble(persona['longitud']) != null;
        })
        .map((persona) {
          return {
            'persona': _nombrePersona(persona),
            'latitud': persona['latitud'],
            'longitud': persona['longitud'],
          };
        })
        .toList();
  }

  bool get conceptoGastoTieneErrorRls {
    final text = conceptoGastoError?.toLowerCase() ?? '';
    return text.contains('row-level security') ||
        text.contains('permission') ||
        text.contains('42501');
  }

  List<Map<String, dynamic>> _rows(dynamic value) {
    return List<Map<String, dynamic>>.from(value as List? ?? []);
  }

  Map<String, Map<String, dynamic>> _byKey(
    List<Map<String, dynamic>> rows,
    String key,
  ) {
    return {
      for (final row in rows)
        if (row[key] != null) row[key].toString(): row,
    };
  }

  Map<String, Map<String, dynamic>> _personasByCi(
    List<Map<String, dynamic>> rows,
  ) {
    return {
      for (final row in rows)
        if (row['ci'] != null) row['ci'].toString(): row,
      for (final row in rows)
        if (row['ci_persona'] != null) row['ci_persona'].toString(): row,
    };
  }

  String _nombrePersona(Map<String, dynamic>? persona) {
    if (persona == null) return 'Sin persona';
    final nombres = persona['nombres'] ?? '';
    final paterno = persona['apellido_paterno'] ?? '';
    final materno = persona['apellido_materno'] ?? '';
    final ci = persona['ci_persona'] ?? persona['ci'] ?? '';
    final nombre = '$nombres $paterno $materno'.trim();
    return nombre.isEmpty ? ci.toString() : '$nombre - $ci';
  }

  String _estadoCuota(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado.isNotEmpty) return estado;
    return _saldoCuota(cuota) <= 0 ? 'PAGADO' : 'PENDIENTE';
  }

  bool _cuotaPagada(Map<String, dynamic> cuota) {
    final estado = _estadoCuota(cuota);
    return estado == 'PAGADO' || estado == 'PAGADA' || _saldoCuota(cuota) <= 0;
  }

  bool _cuotaMora(Map<String, dynamic> cuota) {
    final estado = _estadoCuota(cuota);
    if (estado == 'MORA') return true;
    if (_cuotaPagada(cuota)) return false;
    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return false;
    final hoy = DateTime.now();
    return DateTime(
      fecha.year,
      fecha.month,
      fecha.day,
    ).isBefore(DateTime(hoy.year, hoy.month, hoy.day));
  }

  double _saldoCuota(Map<String, dynamic> cuota) {
    final saldo = _toDouble(
      cuota['saldo_pendiente'] ?? cuota['saldo_restante'] ?? cuota['saldo'],
    );
    if (saldo != null) return saldo;
    return _toDouble(
          cuota['monto_cuota'] ?? cuota['monto_total'] ?? cuota['monto'],
        ) ??
        0;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
