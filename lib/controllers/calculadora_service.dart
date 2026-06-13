import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/models/calculadora_model.dart';

class CalculadoraService {
  final localDb = DatabaseConfig.client;

  Future<List<Map<String, dynamic>>> listarClientes() async {
    final clientes = await localDb.from('cliente').select().order('id_cliente');
    final personas = await _listarSeguro('persona');
    final personasByCi = {
      for (final persona in personas)
        if (persona['ci'] != null) persona['ci'].toString(): persona,
      for (final persona in personas)
        if (persona['ci_persona'] != null)
          persona['ci_persona'].toString(): persona,
    };

    return List<Map<String, dynamic>>.from(
      clientes,
    ).where((cliente) => cliente['estado'] != false).map((cliente) {
      return {
        ...cliente,
        'persona': personasByCi[cliente['ci_persona']?.toString() ?? ''],
      };
    }).toList();
  }

  SimulacionPrestamo simular({
    required double monto,
    required double interesPercent,
    required int numeroCuotas,
    required FrecuenciaPago frecuencia,
    required TipoPrestamoCalculadora tipo,
    required DateTime fechaInicio,
  }) {
    final cuotas = switch (tipo) {
      TipoPrestamoCalculadora.gotaAGota => _gotaAGota(
        monto,
        interesPercent,
        numeroCuotas,
        frecuencia,
        fechaInicio,
      ),
      TipoPrestamoCalculadora.interesMensual => _interesMensual(
        monto,
        interesPercent,
        numeroCuotas,
        frecuencia,
        fechaInicio,
      ),
      TipoPrestamoCalculadora.frances => _frances(
        monto,
        interesPercent,
        numeroCuotas,
        frecuencia,
        fechaInicio,
      ),
      TipoPrestamoCalculadora.universal => _universal(
        monto,
        interesPercent,
        numeroCuotas,
        frecuencia,
        fechaInicio,
      ),
    };

    return SimulacionPrestamo(
      monto: monto,
      interesPercent: interesPercent,
      numeroCuotas: numeroCuotas,
      frecuencia: frecuencia,
      tipo: tipo,
      fechaInicio: fechaInicio,
      cuotas: cuotas,
    );
  }

  TipoPrestamoCalculadora tipoDesdeIdPrestamo(int idTipoPrestamo) {
    return switch (idTipoPrestamo) {
      1 => TipoPrestamoCalculadora.gotaAGota,
      2 => TipoPrestamoCalculadora.interesMensual,
      3 => TipoPrestamoCalculadora.frances,
      _ => TipoPrestamoCalculadora.universal,
    };
  }

  int idTipoDesdeTipoCalculadora(TipoPrestamoCalculadora tipo) {
    return switch (tipo) {
      TipoPrestamoCalculadora.gotaAGota => 1,
      TipoPrestamoCalculadora.interesMensual => 2,
      TipoPrestamoCalculadora.frances => 3,
      TipoPrestamoCalculadora.universal => 4,
    };
  }

  List<CuotaCalculada> _gotaAGota(
    double monto,
    double interesPercent,
    int numeroCuotas,
    FrecuenciaPago frecuencia,
    DateTime fechaInicio,
  ) {
    final total = monto * (1 + interesPercent / 100);
    final cuotaBase = total / numeroCuotas;
    final capitalBase = monto / numeroCuotas;
    var saldo = total;

    return List.generate(numeroCuotas, (index) {
      final numero = index + 1;
      final fecha = _fechaCuota(fechaInicio, frecuencia, index);
      final cuotaTotal = numero == numeroCuotas ? saldo : cuotaBase;
      final capital = numero == numeroCuotas
          ? monto - (capitalBase * index)
          : capitalBase;
      final interes = (cuotaTotal - capital).clamp(0.0, double.infinity);
      saldo = (saldo - cuotaTotal).clamp(0.0, double.infinity);

      return CuotaCalculada(
        numero: numero,
        fecha: fecha,
        capital: _round(capital),
        interes: _round(interes),
        total: _round(cuotaTotal),
        saldoRestante: _round(saldo),
      );
    });
  }

  List<CuotaCalculada> _interesMensual(
    double monto,
    double interesPercent,
    int numeroCuotas,
    FrecuenciaPago frecuencia,
    DateTime fechaInicio,
  ) {
    final interesPeriodo = monto * (interesPercent / 100);
    var saldoCapital = monto;

    return List.generate(numeroCuotas, (index) {
      final numero = index + 1;
      final fecha = _fechaCuota(fechaInicio, frecuencia, index);
      final esUltima = numero == numeroCuotas;
      final capital = esUltima ? saldoCapital : 0.0;
      final total = interesPeriodo + capital;

      if (esUltima) {
        saldoCapital = 0;
      }

      return CuotaCalculada(
        numero: numero,
        fecha: fecha,
        capital: _round(capital),
        interes: _round(interesPeriodo),
        total: _round(total),
        saldoRestante: _round(saldoCapital),
      );
    });
  }

  List<CuotaCalculada> _frances(
    double monto,
    double interesPercent,
    int numeroCuotas,
    FrecuenciaPago frecuencia,
    DateTime fechaInicio,
  ) {
    final tasa = interesPercent / 100;
    final cuotaFija = tasa == 0
        ? monto / numeroCuotas
        : monto *
              (tasa * _pow(1 + tasa, numeroCuotas)) /
              (_pow(1 + tasa, numeroCuotas) - 1);
    var saldo = monto;

    return List.generate(numeroCuotas, (index) {
      final numero = index + 1;
      final fecha = _fechaCuota(fechaInicio, frecuencia, index);
      final interes = saldo * tasa;
      var capital = cuotaFija - interes;
      var total = cuotaFija;

      if (numero == numeroCuotas) {
        capital = saldo;
        total = capital + interes;
      }

      saldo = (saldo - capital).clamp(0.0, double.infinity);

      return CuotaCalculada(
        numero: numero,
        fecha: fecha,
        capital: _round(capital),
        interes: _round(interes),
        total: _round(total),
        saldoRestante: _round(saldo),
      );
    });
  }

  List<CuotaCalculada> _universal(
    double monto,
    double interesPercent,
    int numeroCuotas,
    FrecuenciaPago frecuencia,
    DateTime fechaInicio,
  ) {
    final capitalBase = monto / numeroCuotas;
    final tasa = interesPercent / 100;
    var saldo = monto;

    return List.generate(numeroCuotas, (index) {
      final numero = index + 1;
      final fecha = _fechaCuota(fechaInicio, frecuencia, index);
      final interes = saldo * tasa;
      final capital = numero == numeroCuotas ? saldo : capitalBase;
      final total = capital + interes;
      saldo = (saldo - capital).clamp(0.0, double.infinity);

      return CuotaCalculada(
        numero: numero,
        fecha: fecha,
        capital: _round(capital),
        interes: _round(interes),
        total: _round(total),
        saldoRestante: _round(saldo),
      );
    });
  }

  DateTime _fechaCuota(
    DateTime fechaInicio,
    FrecuenciaPago frecuencia,
    int index,
  ) {
    if (frecuencia == FrecuenciaPago.diario) {
      var fecha = fechaInicio;
      while (fecha.weekday == DateTime.sunday) {
        fecha = fecha.add(const Duration(days: 1));
      }

      var cuotasAvanzadas = 0;
      while (cuotasAvanzadas < index) {
        fecha = fecha.add(const Duration(days: 1));
        if (fecha.weekday != DateTime.sunday) {
          cuotasAvanzadas++;
        }
      }
      return fecha;
    }

    final fecha = switch (frecuencia) {
      FrecuenciaPago.diario => fechaInicio,
      FrecuenciaPago.semanal => fechaInicio.add(Duration(days: 7 * index)),
      FrecuenciaPago.quincenal => fechaInicio.add(Duration(days: 15 * index)),
      FrecuenciaPago.mensual => DateTime(
        fechaInicio.year,
        fechaInicio.month + index,
        fechaInicio.day,
      ),
    };
    return fecha;
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

  Future<List<Map<String, dynamic>>> _listarSeguro(String table) async {
    try {
      final response = await localDb.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }
}
