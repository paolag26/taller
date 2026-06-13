import 'package:sist_prestamo/models/prestamo_model.dart';

// ==============================
// PATRON FACTORY METHOD
// Se encapsula la creacion de objetos
// evitando multiples condicionales.
// Defensa: Patron Creacional.
// Razon en Cuentas Claras: centraliza
// la construccion de prestamos segun tipo
// y evita duplicar constructores en vistas.
// ==============================
class PrestamoFactory {
  static PrestamoModel crearFrances({
    required int idCliente,
    required int? idCobrador,
    required int idEstado,
    required double monto,
    required double interes,
    required String fechaInicio,
    required String? fechaFin,
  }) {
    return _crearPrestamo(
      idCliente: idCliente,
      idCobrador: idCobrador,
      idTipo: 3,
      idEstado: idEstado,
      monto: monto,
      interes: interes,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
    );
  }

  static PrestamoModel crearGotaAGota({
    required int idCliente,
    required int? idCobrador,
    required int idEstado,
    required double monto,
    required double interes,
    required String fechaInicio,
    required String? fechaFin,
  }) {
    return _crearPrestamo(
      idCliente: idCliente,
      idCobrador: idCobrador,
      idTipo: 1,
      idEstado: idEstado,
      monto: monto,
      interes: interes,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
    );
  }

  static PrestamoModel desdeBaseConFechas({
    required PrestamoModel prestamo,
    required String fechaInicio,
    required String? fechaFin,
  }) {
    return PrestamoModel(
      idPrestamo: prestamo.idPrestamo,
      idCliente: prestamo.idCliente,
      idCobrador: prestamo.idCobrador,
      idTipo: prestamo.idTipo,
      idEstado: prestamo.idEstado,
      idGarantia: prestamo.idGarantia,
      prestamoOrigen: prestamo.prestamoOrigen,
      esRefinanciamiento: prestamo.esRefinanciamiento,
      monto: prestamo.monto,
      interes: prestamo.interes,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
    );
  }

  static PrestamoModel _crearPrestamo({
    required int idCliente,
    required int? idCobrador,
    required int idTipo,
    required int idEstado,
    required double monto,
    required double interes,
    required String fechaInicio,
    required String? fechaFin,
  }) {
    return PrestamoModel(
      idCliente: idCliente,
      idCobrador: idCobrador,
      idTipo: idTipo,
      idEstado: idEstado,
      esRefinanciamiento: false,
      monto: monto,
      interes: interes,
      fechaInicio: fechaInicio,
      fechaFin: fechaFin,
    );
  }
}
