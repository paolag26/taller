import 'package:sist_prestamo/controllers/amortization_calculator.dart';

class MensualCalculator implements AmortizationCalculator {
  @override
  List<Map<String, dynamic>> calcularCuotas({
    required double capital,
    required double tasaInteresPercent,
    required DateTime fechaInicio,
    required int periodos, // Duración en meses
  }) {
    final int totalCuotas = periodos > 0 ? periodos : 1;
    final double interesMensual = (capital * (tasaInteresPercent / 100))
        .roundToDouble();

    final List<Map<String, dynamic>> cuotas = [];
    DateTime currentDate = fechaInicio;

    for (int i = 1; i <= totalCuotas; i++) {
      // Avanzar al mismo día del siguiente mes
      currentDate = DateTime(
        currentDate.year,
        currentDate.month + 1,
        currentDate.day,
      );

      final bool esUltima = i == totalCuotas;
      final double capitalCuota = esUltima ? capital : 0.0;
      final double montoCuota = interesMensual + capitalCuota;

      cuotas.add({
        'numero_cuota': i,
        'monto_cuota': montoCuota,
        'capital': capitalCuota,
        'interes': interesMensual,
        'saldo_pendiente': montoCuota,
        'fecha_vencimiento': currentDate.toIso8601String().substring(0, 10),
        'estado': 'PENDIENTE',
        'mora': false,
      });
    }

    return cuotas;
  }
}
