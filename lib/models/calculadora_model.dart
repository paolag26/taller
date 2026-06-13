enum TipoPrestamoCalculadora { gotaAGota, interesMensual, frances, universal }

enum FrecuenciaPago { diario, semanal, quincenal, mensual }

class CuotaCalculada {
  final int numero;
  final DateTime fecha;
  final double capital;
  final double interes;
  final double total;
  final double saldoRestante;

  const CuotaCalculada({
    required this.numero,
    required this.fecha,
    required this.capital,
    required this.interes,
    required this.total,
    required this.saldoRestante,
  });

  Map<String, dynamic> toCuotaJson() {
    return {
      'numero_cuota': numero,
      'monto_cuota': total,
      'capital': capital,
      'interes': interes,
      'saldo_pendiente': total,
      'fecha_vencimiento': _date(fecha),
      'estado': 'PENDIENTE',
      'observaciones': '',
      'mora': false,
    };
  }

  String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}

class SimulacionPrestamo {
  final double monto;
  final double interesPercent;
  final int numeroCuotas;
  final FrecuenciaPago frecuencia;
  final TipoPrestamoCalculadora tipo;
  final DateTime fechaInicio;
  final List<CuotaCalculada> cuotas;

  const SimulacionPrestamo({
    required this.monto,
    required this.interesPercent,
    required this.numeroCuotas,
    required this.frecuencia,
    required this.tipo,
    required this.fechaInicio,
    required this.cuotas,
  });

  double get totalACobrar {
    return cuotas.fold(0, (total, cuota) => total + cuota.total);
  }

  double get interesTotal {
    return cuotas.fold(0, (total, cuota) => total + cuota.interes);
  }

  double get valorCuota {
    if (cuotas.isEmpty) return 0;
    return cuotas.first.total;
  }
}
