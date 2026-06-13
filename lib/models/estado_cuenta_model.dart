class EstadoCuentaModel {
  final int idEstadoCuenta;
  final int idPrestamo;
  final String fechaCorte;
  final double saldoCapital;
  final double interesAcumulado;
  final double mora;
  final double totalAdeudado;
  final int estado;

  EstadoCuentaModel({
    required this.idEstadoCuenta,
    required this.idPrestamo,
    required this.fechaCorte,
    required this.saldoCapital,
    required this.interesAcumulado,
    required this.mora,
    required this.totalAdeudado,
    required this.estado,
  });
}
