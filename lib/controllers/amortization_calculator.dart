import 'package:sist_prestamo/controllers/gota_a_gota_calculator.dart';
import 'package:sist_prestamo/controllers/mensual_calculator.dart';
import 'package:sist_prestamo/controllers/frances_calculator.dart';

abstract class AmortizationCalculator {
  List<Map<String, dynamic>> calcularCuotas({
    required double capital,
    required double tasaInteresPercent,
    required DateTime fechaInicio,
    required int periodos, // Duración en días o meses
  });
}

class AmortizationFactory {
  static AmortizationCalculator getCalculator(int idTipo) {
    switch (idTipo) {
      case 1: // Gota a gota (Diario)
        return GotaAGotaCalculator();
      case 2: // Mensual (Interés mensual, Capital al final)
        return MensualCalculator();
      case 3: // Francés (Amortización progresiva)
        return FrancesCalculator();
      default:
        throw Exception('Tipo de préstamo no soportado: $idTipo');
    }
  }
}
