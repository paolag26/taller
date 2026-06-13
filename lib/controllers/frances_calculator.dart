import 'dart:math';
import 'package:sist_prestamo/controllers/amortization_calculator.dart';

class FrancesCalculator implements AmortizationCalculator {
  @override
  List<Map<String, dynamic>> calcularCuotas({
    required double capital,
    required double tasaInteresPercent,
    required DateTime fechaInicio,
    required int periodos, // Duración en meses
  }) {
    final int totalCuotas = periodos > 0 ? periodos : 12;
    final double tasaMensual = tasaInteresPercent / 100;

    double cuotaFija;
    if (tasaMensual == 0) {
      cuotaFija = capital / totalCuotas;
    } else {
      cuotaFija =
          capital *
          (tasaMensual * pow(1 + tasaMensual, totalCuotas)) /
          (pow(1 + tasaMensual, totalCuotas) - 1);
    }
    cuotaFija = cuotaFija.roundToDouble();

    final List<Map<String, dynamic>> cuotas = [];
    double saldoRestante = capital;
    DateTime currentDate = fechaInicio;

    for (int i = 1; i <= totalCuotas; i++) {
      currentDate = DateTime(
        currentDate.year,
        currentDate.month + 1,
        currentDate.day,
      );

      final double interesCuota = (saldoRestante * tasaMensual).roundToDouble();
      double capitalCuota = cuotaFija - interesCuota;
      double montoCuota = cuotaFija;

      if (i == totalCuotas) {
        capitalCuota = saldoRestante;
        montoCuota = capitalCuota + interesCuota;
        saldoRestante = 0.0;
      } else {
        saldoRestante -= capitalCuota;
      }

      cuotas.add({
        'numero_cuota': i,
        'monto_cuota': montoCuota,
        'capital': capitalCuota.clamp(0.0, double.infinity),
        'interes': interesCuota.clamp(0.0, double.infinity),
        'saldo_pendiente': montoCuota.clamp(0.0, double.infinity),
        'fecha_vencimiento': currentDate.toIso8601String().substring(0, 10),
        'estado': 'PENDIENTE',
        'mora': false,
      });
    }

    return cuotas;
  }
}
