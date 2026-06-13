import 'package:sist_prestamo/controllers/amortization_calculator.dart';

class GotaAGotaCalculator implements AmortizationCalculator {
  @override
  List<Map<String, dynamic>> calcularCuotas({
    required double capital,
    required double tasaInteresPercent,
    required DateTime fechaInicio,
    required int periodos,
  }) {
    final double totalACobrar = capital * (1 + tasaInteresPercent / 100);
    final int totalCuotas = periodos > 0 ? periodos : 24;
    final double cuotaExacta = totalACobrar / totalCuotas;
    final double cuotaRedondeada = cuotaExacta.roundToDouble();
    final double capitalPorCuota = capital / totalCuotas;

    final cuotas = <Map<String, dynamic>>[];
    DateTime fechaVencimiento = fechaInicio;

    for (int i = 1; i <= totalCuotas; i++) {
      if (i == 1) {
        while (fechaVencimiento.weekday == DateTime.sunday) {
          fechaVencimiento = fechaVencimiento.add(const Duration(days: 1));
        }
      } else {
        do {
          fechaVencimiento = fechaVencimiento.add(const Duration(days: 1));
        } while (fechaVencimiento.weekday == DateTime.sunday);
      }

      var montoCuota = cuotaRedondeada;
      if (i == totalCuotas) {
        final acumuladoAnterior = cuotaRedondeada * (totalCuotas - 1);
        montoCuota = totalACobrar - acumuladoAnterior;
      }

      cuotas.add({
        'numero_cuota': i,
        'monto_cuota': montoCuota,
        'capital': capitalPorCuota,
        'interes': (montoCuota - capitalPorCuota).clamp(0.0, double.infinity),
        'saldo_pendiente': montoCuota.clamp(0.0, double.infinity),
        'fecha_vencimiento': fechaVencimiento.toIso8601String().substring(
          0,
          10,
        ),
        'estado': 'PENDIENTE',
        'mora': false,
      });
    }

    return cuotas;
  }
}
