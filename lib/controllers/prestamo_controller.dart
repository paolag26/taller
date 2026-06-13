import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/prestamo_factory.dart';
import 'package:sist_prestamo/controllers/prestamo_strategy.dart';
import 'package:sist_prestamo/models/calculadora_model.dart';
import 'package:sist_prestamo/controllers/cliente_service.dart';
import 'package:sist_prestamo/models/prestamo_model.dart';
import 'package:sist_prestamo/controllers/prestamo_service.dart';

class PrestamoController extends ChangeNotifier {
  final service = PrestamoService();
  final clienteService = ClienteService();

  bool loading = false;
  List<Map<String, dynamic>> prestamos = [];
  List<Map<String, dynamic>> tiposPrestamo = [];
  List<Map<String, dynamic>> estadosPrestamo = [];
  String query = '';
  String estadoFiltro = 'TODOS';

  Future<void> cargarPrestamos() async {
    try {
      loading = true;
      notifyListeners();
      prestamos = await service.listarPrestamos();
    } catch (e) {
      debugPrint('ERROR CONTROLLER: $e');
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> insertarPrestamo(
    PrestamoModel prestamo, {
    List<Map<String, dynamic>> garantes = const [],
    List<Map<String, dynamic>> articulos = const [],
    required int plazo,
  }) async {
    try {
      _validarInteresPermitido(prestamo.interes);
      final prestamoConEstadoActivo = _prestamoConEstadoAutomatico(prestamo);
      final fechaInicio = DateTime.now();
      final frecuencia = _frecuenciaDesdeTipo(prestamoConEstadoActivo.idTipo);
      final periodos = _periodosDesdePlazo(plazo, frecuencia);
      final fechaFin = _calcularFechaFin(fechaInicio, plazo, frecuencia);
      final prestamoAutomatico = _prestamoConFechasAutomaticas(
        prestamoConEstadoActivo,
        fechaInicio,
        fechaFin,
      );

      await _validarPrestamoNuevo(prestamoAutomatico, garantes);

      final idPrestamo = await service.insertarPrestamo(prestamoAutomatico);
      if (idPrestamo == null) {
        throw Exception('No se pudo crear el prestamo.');
      }

      final idPlan = await service.crearPlanPagos(
        idPrestamo: idPrestamo,
        numeroCuotas: periodos,
        frecuenciaPago: frecuencia.name.toUpperCase(),
      );

      final cuotas = _generarCuotasAutomaticas(
        idPrestamo: idPrestamo,
        idPlan: idPlan,
        monto: prestamoAutomatico.monto,
        interesPercent: prestamoAutomatico.interes,
        periodos: periodos,
        idTipoPrestamo: prestamoAutomatico.idTipo,
        frecuencia: frecuencia,
        fechaInicio: fechaInicio,
        fechaFin: fechaFin,
      );

      await service.insertarCuotas(cuotas);
      await service.actualizarEstadoAutomaticoPrestamo(idPrestamo);

      if (garantes.isNotEmpty) {
        await service.registrarGarantes(idPrestamo, garantes);
      }

      if (articulos.isNotEmpty) {
        await service.registrarArticulosGarantia(idPrestamo, articulos);
      }

      await cargarPrestamos();
    } catch (e) {
      debugPrint('ERROR INSERTAR CONTROLLER: $e');
      rethrow;
    }
  }

  Future<void> actualizarPrestamo(PrestamoModel prestamo) async {
    try {
      _validarInteresPermitido(prestamo.interes);
      await service.actualizarPrestamo(prestamo);
      await cargarPrestamos();
    } catch (e) {
      debugPrint('ERROR ACTUALIZAR CONTROLLER: $e');
    }
  }

  Future<void> eliminarPrestamo(int idPrestamo) async {
    try {
      await service.eliminarPrestamo(idPrestamo);
      await cargarPrestamos();
    } catch (e) {
      debugPrint('ERROR ELIMINAR CONTROLLER: $e');
    }
  }

  Future<PrestamoFormData> cargarDatosFormulario() async {
    final clientesResponse = await clienteService.listarClientes();
    var tiposResponse = await service.listarTiposPrestamo();
    var estadosResponse = await service.listarEstadosPrestamo();
    String? catalogosError;

    if (tiposResponse.isEmpty || estadosResponse.isEmpty) {
      try {
        await service.asegurarCatalogosBase();
        tiposResponse = await service.listarTiposPrestamo();
        estadosResponse = await service.listarEstadosPrestamo();
      } catch (_) {
        catalogosError =
            'No se pudieron cargar tipos o estados. Revise RLS/permisos de tipo_prestamo y estado_prestamo.';
      }
    }

    tiposPrestamo = tiposResponse;
    estadosPrestamo = estadosResponse;

    return PrestamoFormData(
      clientes: clientesResponse,
      tipos: tiposResponse,
      estados: estadosResponse,
      catalogosError: catalogosError,
    );
  }

  Future<void> _validarPrestamoNuevo(
    PrestamoModel prestamo,
    List<Map<String, dynamic>> garantes,
  ) async {
    final activos = await service.contarPrestamosActivosCliente(
      prestamo.idCliente,
    );
    if (activos >= 2) {
      throw Exception(
        'El cliente ya tiene 2 prestamos activos. No se puede crear otro prestamo.',
      );
    }

    if (garantes.length > 2) {
      throw Exception('Solo se permiten maximo 2 garantes por prestamo.');
    }

    final ids = <int>{};
    for (final garante in garantes) {
      final idGarante = _toInt(garante['id_cliente']);
      if (idGarante == null) {
        throw Exception('Seleccione un cliente valido como garante.');
      }
      if (idGarante == prestamo.idCliente) {
        throw Exception('Un cliente no puede ser garante de si mismo.');
      }
      if (!ids.add(idGarante)) {
        throw Exception('No se puede repetir el mismo garante.');
      }
    }
  }

  // ======================================
  // REGLA DE NEGOCIO
  // El interés permitido debe estar
  // entre 0% y 20%.
  // ======================================
  void _validarInteresPermitido(double interes) {
    if (interes < 0) {
      throw Exception('El interés no puede ser negativo.');
    }
    if (interes > 20) {
      throw Exception('El interés máximo permitido es 20%.');
    }
  }

  PrestamoModel _prestamoConEstadoAutomatico(PrestamoModel prestamo) {
    final idActivo = _idEstadoPrestamo('ACTIVO') ?? prestamo.idEstado;
    return PrestamoModel(
      idPrestamo: prestamo.idPrestamo,
      idCliente: prestamo.idCliente,
      idCobrador: prestamo.idCobrador,
      idTipo: prestamo.idTipo,
      idEstado: idActivo,
      idGarantia: prestamo.idGarantia,
      prestamoOrigen: prestamo.prestamoOrigen,
      esRefinanciamiento: prestamo.esRefinanciamiento,
      monto: prestamo.monto,
      interes: prestamo.interes,
      fechaInicio: prestamo.fechaInicio,
      fechaFin: prestamo.fechaFin,
    );
  }

  int? _idEstadoPrestamo(String nombre) {
    final buscado = nombre.trim().toUpperCase();
    for (final estado in estadosPrestamo) {
      if (estado['nombre']?.toString().trim().toUpperCase() == buscado) {
        return _toInt(estado['id_estado']);
      }
    }
    return null;
  }

  SimulacionPrestamo simularPrestamo({
    required double monto,
    required double interesPercent,
    required int plazo,
    required int idTipoPrestamo,
  }) {
    _validarInteresPermitido(interesPercent);
    final fechaInicio = DateTime.now();
    final frecuencia = _frecuenciaDesdeTipo(idTipoPrestamo);
    final periodos = _periodosDesdePlazo(plazo, frecuencia);
    final tipo = _tipoDesdeIdPrestamo(idTipoPrestamo);
    final strategy = PrestamoStrategyFactory.obtener(tipo);
    final cuotas = strategy.generarPlan(
      monto: monto,
      interesPercent: interesPercent,
      periodos: periodos,
      frecuencia: frecuencia,
      fechaInicio: fechaInicio,
    );

    return SimulacionPrestamo(
      monto: monto,
      interesPercent: interesPercent,
      numeroCuotas: periodos,
      frecuencia: frecuencia,
      tipo: tipo,
      fechaInicio: fechaInicio,
      cuotas: cuotas,
    );
  }

  DateTime fechaInicioAutomatica() => DateTime.now();

  DateTime calcularFechaFinAutomatica({
    required int idTipoPrestamo,
    required int plazo,
    DateTime? fechaInicio,
  }) {
    return _calcularFechaFin(
      fechaInicio ?? DateTime.now(),
      plazo,
      _frecuenciaDesdeTipo(idTipoPrestamo),
    );
  }

  Map<String, dynamic> validarYGarantiaDesdeCliente({
    required List<Map<String, dynamic>> clientes,
    required int? idClientePrestamo,
    required int idGarante,
    required List<Map<String, dynamic>> garantesActuales,
  }) {
    if (idClientePrestamo == null) {
      throw Exception('Seleccione primero el cliente del prestamo.');
    }
    if (idGarante == idClientePrestamo) {
      throw Exception('Un cliente no puede ser garante de si mismo.');
    }
    if (garantesActuales.length >= 2) {
      throw Exception('Solo se permiten maximo 2 garantes.');
    }
    if (garantesActuales.any(
      (item) => _toInt(item['id_cliente']) == idGarante,
    )) {
      throw Exception('Este garante ya fue agregado.');
    }

    final cliente = clientes.firstWhere(
      (item) => _toInt(item['id_cliente']) == idGarante,
      orElse: () => <String, dynamic>{},
    );
    if (cliente.isEmpty) {
      throw Exception('Cliente garante no encontrado.');
    }

    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombre = '$nombres $paterno $materno'.trim();

    return {
      'id_cliente': idGarante,
      'ci_persona': cliente['ci_persona'],
      'nombre_completo': nombre.isEmpty ? 'Cliente #$idGarante' : nombre,
      'telefono': persona?['telefono'] ?? '',
      'direccion': persona?['direccion_domicilio'] ?? '',
    };
  }

  List<Map<String, dynamic>> get prestamosFiltrados {
    return prestamos.where((prestamo) {
      final coincideEstado =
          estadoFiltro == 'TODOS' || _estadoPrestamo(prestamo) == estadoFiltro;
      final coincideBusqueda = _coincideBusqueda(prestamo);
      return coincideEstado && coincideBusqueda;
    }).toList();
  }

  void cambiarBusqueda(String value) {
    query = value;
    notifyListeners();
  }

  void cambiarEstado(String value) {
    estadoFiltro = value;
    notifyListeners();
  }

  Future<void> cancelarPrestamo(int idPrestamo) async {
    try {
      await service.cancelarPrestamo(idPrestamo);
      await cargarPrestamos();
    } catch (e) {
      debugPrint('ERROR CANCELAR CONTROLLER: $e');
      rethrow;
    }
  }

  bool _coincideBusqueda(Map<String, dynamic> prestamo) {
    final text = query.trim().toLowerCase();
    if (text.isEmpty) return true;

    final cliente = prestamo['cliente'];
    final persona = cliente?['persona'];
    final nombre =
        '${persona?['nombres'] ?? ''} ${persona?['apellido_paterno'] ?? ''} ${persona?['apellido_materno'] ?? ''}'
            .toLowerCase();
    final ci = cliente?['ci_persona']?.toString().toLowerCase() ?? '';
    final codigo = prestamo['id_prestamo']?.toString() ?? '';

    return nombre.contains(text) || ci.contains(text) || codigo.contains(text);
  }

  String _estadoPrestamo(Map<String, dynamic> prestamo) {
    return prestamo['estado_prestamo']?['nombre']?.toString().toUpperCase() ??
        '';
  }

  PrestamoModel _prestamoConFechasAutomaticas(
    PrestamoModel prestamo,
    DateTime fechaInicio,
    DateTime fechaFin,
  ) {
    if (fechaFin.isBefore(fechaInicio)) {
      throw Exception('La fecha final no puede ser menor a la fecha inicio.');
    }

    return PrestamoFactory.desdeBaseConFechas(
      prestamo: prestamo,
      fechaInicio: _date(fechaInicio),
      fechaFin: _date(fechaFin),
    );
  }

  List<Map<String, dynamic>> _generarCuotasAutomaticas({
    required int idPrestamo,
    required int idPlan,
    required double monto,
    required double interesPercent,
    required int periodos,
    required int idTipoPrestamo,
    required FrecuenciaPago frecuencia,
    required DateTime fechaInicio,
    required DateTime fechaFin,
  }) {
    final tipo = _tipoDesdeIdPrestamo(idTipoPrestamo);
    final strategy = PrestamoStrategyFactory.obtener(tipo);
    final cuotas = strategy.generarPlan(
      monto: monto,
      interesPercent: interesPercent,
      periodos: periodos,
      frecuencia: frecuencia,
      fechaInicio: fechaInicio,
    );

    _validarCuotasGeneradas(cuotas, fechaInicio, fechaFin);

    return cuotas.map((cuota) {
      final data = {
        'id_prestamo': idPrestamo,
        'numero_cuota': cuota.numero,
        'fecha_vencimiento': _date(cuota.fecha),
        'monto_cuota': cuota.total,
        'monto_total': cuota.total,
        'capital': cuota.capital,
        'monto_capital': cuota.capital,
        'interes': cuota.interes,
        'monto_interes': cuota.interes,
        'saldo_pendiente': cuota.total,
        'saldo_restante': cuota.total,
        'estado': _estadoCuota(cuota.fecha, cuota.total),
      };
      data['id_plan'] = idPlan;
      return data;
    }).toList();
  }

  void _validarCuotasGeneradas(
    List<CuotaCalculada> cuotas,
    DateTime fechaInicio,
    DateTime fechaFin,
  ) {
    final fechas = <String>{};
    final inicio = DateTime(
      fechaInicio.year,
      fechaInicio.month,
      fechaInicio.day,
    );
    final fin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day);

    for (final cuota in cuotas) {
      final fecha = DateTime(
        cuota.fecha.year,
        cuota.fecha.month,
        cuota.fecha.day,
      );
      final key = _date(fecha);

      if (!fechas.add(key)) {
        throw Exception('No se permiten cuotas con fechas duplicadas.');
      }
      if (fecha.isBefore(inicio) || fecha.isAfter(fin)) {
        throw Exception('Hay cuotas fuera del rango del prestamo.');
      }
    }
  }

  FrecuenciaPago _frecuenciaDesdeTipo(int idTipoPrestamo) {
    final tipo = tiposPrestamo.firstWhere(
      (item) => _toInt(item['id_tipo']) == idTipoPrestamo,
      orElse: () => <String, dynamic>{},
    );
    final nombre = tipo['nombre']?.toString().toLowerCase() ?? '';

    if (nombre.contains('diario') || nombre.contains('gota')) {
      return FrecuenciaPago.diario;
    }
    if (nombre.contains('semanal')) {
      return FrecuenciaPago.semanal;
    }
    if (nombre.contains('quincenal')) {
      return FrecuenciaPago.quincenal;
    }

    return switch (idTipoPrestamo) {
      1 => FrecuenciaPago.diario,
      2 => FrecuenciaPago.mensual,
      3 => FrecuenciaPago.mensual,
      4 => FrecuenciaPago.mensual,
      5 => FrecuenciaPago.quincenal,
      6 => FrecuenciaPago.semanal,
      _ => FrecuenciaPago.mensual,
    };
  }

  TipoPrestamoCalculadora _tipoDesdeIdPrestamo(int idTipoPrestamo) {
    return switch (idTipoPrestamo) {
      1 => TipoPrestamoCalculadora.gotaAGota,
      2 => TipoPrestamoCalculadora.interesMensual,
      3 => TipoPrestamoCalculadora.frances,
      _ => TipoPrestamoCalculadora.universal,
    };
  }

  int _periodosDesdePlazo(int plazo, FrecuenciaPago frecuencia) {
    if (plazo <= 0) throw Exception('El plazo debe ser mayor a cero.');
    return plazo;
  }

  DateTime _calcularFechaFin(
    DateTime fechaInicio,
    int plazo,
    FrecuenciaPago frecuencia,
  ) {
    if (plazo <= 0) throw Exception('El plazo debe ser mayor a cero.');
    return switch (frecuencia) {
      FrecuenciaPago.diario => fechaInicio.add(Duration(days: plazo)),
      FrecuenciaPago.semanal => fechaInicio.add(Duration(days: 7 * plazo)),
      FrecuenciaPago.quincenal => fechaInicio.add(Duration(days: 15 * plazo)),
      FrecuenciaPago.mensual => DateTime(
        fechaInicio.year,
        fechaInicio.month + plazo,
        fechaInicio.day,
        fechaInicio.hour,
        fechaInicio.minute,
        fechaInicio.second,
        fechaInicio.millisecond,
        fechaInicio.microsecond,
      ),
    };
  }

  String _estadoCuota(DateTime fechaVencimiento, double saldo) {
    if (saldo <= 0) return 'PAGADO';

    final hoy = DateTime.now();
    final actual = DateTime(hoy.year, hoy.month, hoy.day);
    final vencimiento = DateTime(
      fechaVencimiento.year,
      fechaVencimiento.month,
      fechaVencimiento.day,
    );

    return actual.isAfter(vencimiento) ? 'MORA' : 'PENDIENTE';
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

class PrestamoFormData {
  final List<Map<String, dynamic>> clientes;
  final List<Map<String, dynamic>> tipos;
  final List<Map<String, dynamic>> estados;
  final String? catalogosError;

  const PrestamoFormData({
    required this.clientes,
    required this.tipos,
    required this.estados,
    required this.catalogosError,
  });
}
