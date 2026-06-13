import 'package:sist_prestamo/models/calculadora_model.dart';

// ==============================
// PATRON STRATEGY
// Permite cambiar algoritmos
// de calculo sin modificar
// el controlador.
// Defensa: Patron Comportamiento.
// Razon en Cuentas Claras: cada tipo
// de prestamo calcula cuotas de forma
// distinta, pero el controller usa
// una interfaz comun.
// ==============================
abstract class PrestamoStrategy {
  List<CuotaCalculada> generarPlan({
    required double monto,
    required double interesPercent,
    required int periodos,
    required FrecuenciaPago frecuencia,
    required DateTime fechaInicio,
  });
}

class GotaAGotaStrategy implements PrestamoStrategy {
  @override
  List<CuotaCalculada> generarPlan({
    required double monto,
    required double interesPercent,
    required int periodos,
    required FrecuenciaPago frecuencia,
    required DateTime fechaInicio,
  }) {
    final total = monto * (1 + interesPercent / 100);
    final cuotaBase = total / periodos;
    final capitalBase = monto / periodos;
    var saldo = total;

    return List.generate(periodos, (index) {
      final numero = index + 1;
      final totalCuota = numero == periodos ? saldo : cuotaBase;
      final capital = numero == periodos
          ? monto - (capitalBase * index)
          : capitalBase;
      final interes = (totalCuota - capital).clamp(0.0, double.infinity);
      saldo = (saldo - totalCuota).clamp(0.0, double.infinity);

      return CuotaCalculada(
        numero: numero,
        fecha: _fechaVencimiento(fechaInicio, frecuencia, numero),
        capital: _round(capital),
        interes: _round(interes),
        total: _round(totalCuota),
        saldoRestante: _round(saldo),
      );
    });
  }
}

class InteresMensualStrategy implements PrestamoStrategy {
  @override
  List<CuotaCalculada> generarPlan({
    required double monto,
    required double interesPercent,
    required int periodos,
    required FrecuenciaPago frecuencia,
    required DateTime fechaInicio,
  }) {
    final interesPeriodo = monto * (interesPercent / 100);
    var saldoCapital = monto;

    return List.generate(periodos, (index) {
      final numero = index + 1;
      final esUltima = numero == periodos;
      final capital = esUltima ? saldoCapital : 0.0;
      final total = capital + interesPeriodo;
      if (esUltima) saldoCapital = 0;

      return CuotaCalculada(
        numero: numero,
        fecha: _fechaVencimiento(fechaInicio, frecuencia, numero),
        capital: _round(capital),
        interes: _round(interesPeriodo),
        total: _round(total),
        saldoRestante: _round(saldoCapital),
      );
    });
  }
}

class FrancesStrategy implements PrestamoStrategy {
  @override
  List<CuotaCalculada> generarPlan({
    required double monto,
    required double interesPercent,
    required int periodos,
    required FrecuenciaPago frecuencia,
    required DateTime fechaInicio,
  }) {
    final tasa = interesPercent / 100;
    final cuotaFija = tasa == 0
        ? monto / periodos
        : monto *
              (tasa * _pow(1 + tasa, periodos)) /
              (_pow(1 + tasa, periodos) - 1);
    var saldo = monto;

    return List.generate(periodos, (index) {
      final numero = index + 1;
      final interes = saldo * tasa;
      var capital = cuotaFija - interes;
      var total = cuotaFija;
      if (numero == periodos) {
        capital = saldo;
        total = capital + interes;
      }
      saldo = (saldo - capital).clamp(0.0, double.infinity);

      return CuotaCalculada(
        numero: numero,
        fecha: _fechaVencimiento(fechaInicio, frecuencia, numero),
        capital: _round(capital),
        interes: _round(interes),
        total: _round(total),
        saldoRestante: _round(saldo),
      );
    });
  }
}

class UniversalStrategy implements PrestamoStrategy {
  @override
  List<CuotaCalculada> generarPlan({
    required double monto,
    required double interesPercent,
    required int periodos,
    required FrecuenciaPago frecuencia,
    required DateTime fechaInicio,
  }) {
    final capitalBase = monto / periodos;
    final tasa = interesPercent / 100;
    var saldo = monto;

    return List.generate(periodos, (index) {
      final numero = index + 1;
      final interes = saldo * tasa;
      final capital = numero == periodos ? saldo : capitalBase;
      final total = capital + interes;
      saldo = (saldo - capital).clamp(0.0, double.infinity);

      return CuotaCalculada(
        numero: numero,
        fecha: _fechaVencimiento(fechaInicio, frecuencia, numero),
        capital: _round(capital),
        interes: _round(interes),
        total: _round(total),
        saldoRestante: _round(saldo),
      );
    });
  }
}

class PrestamoStrategyFactory {
  static PrestamoStrategy obtener(TipoPrestamoCalculadora tipo) {
    return switch (tipo) {
      TipoPrestamoCalculadora.gotaAGota => GotaAGotaStrategy(),
      TipoPrestamoCalculadora.interesMensual => InteresMensualStrategy(),
      TipoPrestamoCalculadora.frances => FrancesStrategy(),
      TipoPrestamoCalculadora.universal => UniversalStrategy(),
    };
  }
}

DateTime _fechaVencimiento(
  DateTime fechaInicio,
  FrecuenciaPago frecuencia,
  int numeroCuota,
) {
  return switch (frecuencia) {
    FrecuenciaPago.diario => fechaInicio.add(Duration(days: numeroCuota)),
    FrecuenciaPago.semanal => fechaInicio.add(Duration(days: 7 * numeroCuota)),
    FrecuenciaPago.quincenal => fechaInicio.add(
      Duration(days: 15 * numeroCuota),
    ),
    FrecuenciaPago.mensual => DateTime(
      fechaInicio.year,
      fechaInicio.month + numeroCuota,
      fechaInicio.day,
      fechaInicio.hour,
      fechaInicio.minute,
      fechaInicio.second,
      fechaInicio.millisecond,
      fechaInicio.microsecond,
    ),
  };
}

double _pow(double base, int exponent) {
  var result = 1.0;
  for (var i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

double _round(double value) {
  return double.parse(value.toStringAsFixed(2));
}
