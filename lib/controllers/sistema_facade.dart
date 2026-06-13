import 'package:sist_prestamo/controllers/cliente_service.dart';
import 'package:sist_prestamo/controllers/pago_service.dart';
import 'package:sist_prestamo/controllers/prestamo_service.dart';
import 'package:sist_prestamo/models/cliente_model.dart';
import 'package:sist_prestamo/models/pago_model.dart';
import 'package:sist_prestamo/models/persona_model.dart';
import 'package:sist_prestamo/models/prestamo_model.dart';

// ==============================
// PATRON FACADE
// Oculta la complejidad del sistema
// mediante una interfaz simplificada.
// Defensa: Patron Estructural.
// Razon en Cuentas Claras: operaciones
// completas como registrar cliente,
// crear prestamo o registrar pago
// requieren varios services coordinados.
// ==============================
class SistemaFacade {
  final ClienteService _clienteService;
  final PrestamoService _prestamoService;
  final PagoService _pagoService;

  SistemaFacade({
    ClienteService? clienteService,
    PrestamoService? prestamoService,
    PagoService? pagoService,
  }) : _clienteService = clienteService ?? ClienteService(),
       _prestamoService = prestamoService ?? PrestamoService(),
       _pagoService = pagoService ?? PagoService();

  Future<void> registrarClienteCompleto({
    required PersonaModel persona,
    required ClienteModel cliente,
    required String tipoUsuario,
    required String username,
    required String password,
  }) {
    return _clienteService.insertarClienteConPersona(
      persona,
      cliente,
      tipoUsuario: tipoUsuario,
      username: username,
      password: password,
    );
  }

  Future<int?> crearPrestamoCompleto(PrestamoModel prestamo) {
    return _prestamoService.insertarPrestamo(prestamo);
  }

  Future<void> registrarPagoCompleto(PagoModel pago) {
    return _pagoService.insertarPago(pago);
  }
}
