import 'package:flutter/material.dart';

import 'package:sist_prestamo/models/calculadora_model.dart';
import 'package:sist_prestamo/controllers/calculadora_service.dart';
import 'package:sist_prestamo/controllers/prestamo_controller.dart';
import 'package:sist_prestamo/models/prestamo_model.dart';

class CalculadoraController extends ChangeNotifier {
  final service = CalculadoraService();
  final prestamoController = PrestamoController();

  double monto = 1000;
  double interes = 10;
  int numeroCuotas = 24;
  FrecuenciaPago frecuencia = FrecuenciaPago.diario;
  TipoPrestamoCalculadora tipo = TipoPrestamoCalculadora.gotaAGota;
  DateTime fechaInicio = DateTime.now();
  List<Map<String, dynamic>> clientes = [];
  int? idCliente;
  SimulacionPrestamo? simulacion;
  String? error;
  bool loading = false;

  CalculadoraController() {
    simular();
  }

  Future<void> cargarClientes() async {
    try {
      loading = true;
      notifyListeners();

      clientes = await service.listarClientes();
      idCliente ??= clientes.isNotEmpty ? clientes.first['id_cliente'] : null;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void actualizarCliente(int? value) {
    idCliente = value;
    notifyListeners();
  }

  void actualizarMonto(String value) {
    monto = double.tryParse(value.trim()) ?? 0;
    simular();
  }

  void actualizarInteres(String value) {
    interes = double.tryParse(value.trim()) ?? 0;
    simular();
  }

  void actualizarCuotas(String value) {
    numeroCuotas = int.tryParse(value.trim()) ?? 0;
    simular();
  }

  void actualizarFrecuencia(FrecuenciaPago value) {
    frecuencia = value;
    simular();
  }

  void actualizarTipo(TipoPrestamoCalculadora value) {
    tipo = value;
    if (value == TipoPrestamoCalculadora.gotaAGota) {
      frecuencia = FrecuenciaPago.diario;
    } else if (frecuencia == FrecuenciaPago.diario) {
      frecuencia = FrecuenciaPago.mensual;
    }
    simular();
  }

  void simular() {
    fechaInicio = DateTime.now();

    if (monto <= 0 || interes < 0 || numeroCuotas <= 0) {
      error = 'Ingrese monto, interes y cuotas validas';
      simulacion = null;
      notifyListeners();
      return;
    }

    error = null;
    simulacion = service.simular(
      monto: monto,
      interesPercent: interes,
      numeroCuotas: numeroCuotas,
      frecuencia: frecuencia,
      tipo: tipo,
      fechaInicio: fechaInicio,
    );
    notifyListeners();
  }

  Future<void> guardarSimulacion() async {
    final actual = simulacion;
    if (actual == null) {
      throw Exception('No existe una simulacion valida');
    }

    throw Exception(
      'La base oficial no tiene una tabla para guardar simulaciones. Confirme el prestamo para registrar datos reales.',
    );
  }

  Future<void> confirmarPrestamo() async {
    final actual = simulacion;
    final cliente = idCliente;

    if (cliente == null) {
      throw Exception('Seleccione un cliente antes de confirmar');
    }
    if (actual == null) {
      throw Exception('No existe un plan de pagos valido');
    }

    final data = await prestamoController.cargarDatosFormulario();
    final estadoActivo = data.estados.firstWhere(
      (estado) => estado['nombre']?.toString().toUpperCase() == 'ACTIVO',
      orElse: () => data.estados.isNotEmpty ? data.estados.first : {},
    );
    final idEstado = estadoActivo['id_estado'];
    if (idEstado == null) {
      throw Exception('No existe el estado ACTIVO en estado_prestamo');
    }

    await prestamoController.insertarPrestamo(
      PrestamoModel(
        idCliente: cliente,
        idTipo: _idTipoDesdeTipoCalculadora(actual.tipo),
        idEstado: idEstado,
        esRefinanciamiento: false,
        monto: actual.monto,
        interes: actual.interesPercent,
        fechaInicio: '',
        fechaFin: null,
      ),
      plazo: actual.numeroCuotas,
    );
  }

  String get tipoLabel => labelTipo(tipo);

  static String labelTipo(TipoPrestamoCalculadora tipo) {
    return switch (tipo) {
      TipoPrestamoCalculadora.gotaAGota => 'Gota a Gota',
      TipoPrestamoCalculadora.interesMensual => 'Interes Mensual',
      TipoPrestamoCalculadora.frances => 'Sistema Frances',
      TipoPrestamoCalculadora.universal => 'Amortizacion Universal',
    };
  }

  static String labelFrecuencia(FrecuenciaPago frecuencia) {
    return switch (frecuencia) {
      FrecuenciaPago.diario => 'Diario',
      FrecuenciaPago.semanal => 'Semanal',
      FrecuenciaPago.quincenal => 'Quincenal',
      FrecuenciaPago.mensual => 'Mensual',
    };
  }

  int _idTipoDesdeTipoCalculadora(TipoPrestamoCalculadora tipo) {
    return switch (tipo) {
      TipoPrestamoCalculadora.gotaAGota => 1,
      TipoPrestamoCalculadora.interesMensual => 2,
      TipoPrestamoCalculadora.frances => 3,
      TipoPrestamoCalculadora.universal => 4,
    };
  }
}
