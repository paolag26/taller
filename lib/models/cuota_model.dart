class CuotaModel {
  final int? idCuota;

  final int idPrestamo;

  final int numeroCuota;

  final double montoCuota;

  final double capital;

  final double interes;

  final double saldoPendiente;

  final String fechaVencimiento;

  final String? fechaPago;

  final String estado;

  final bool mora;

  CuotaModel({
    this.idCuota,

    required this.idPrestamo,

    required this.numeroCuota,

    required this.montoCuota,

    required this.capital,

    required this.interes,

    required this.saldoPendiente,

    required this.fechaVencimiento,

    this.fechaPago,

    required this.estado,

    required this.mora,
  });

  factory CuotaModel.fromJson(Map<String, dynamic> json) {
    return CuotaModel(
      idCuota: json['id_cuota'],

      idPrestamo: json['id_prestamo'],

      numeroCuota: json['numero_cuota'],

      montoCuota: double.parse(json['monto_cuota'].toString()),

      capital: double.parse(json['capital'].toString()),

      interes: double.parse(json['interes'].toString()),

      saldoPendiente: double.parse(json['saldo_pendiente'].toString()),

      fechaVencimiento: json['fecha_vencimiento'],

      fechaPago: json['fecha_pago'],

      estado: json['estado'],

      mora: json['mora'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_prestamo': idPrestamo,

      'numero_cuota': numeroCuota,

      'monto_cuota': montoCuota,

      'capital': capital,

      'interes': interes,

      'saldo_pendiente': saldoPendiente,

      'fecha_vencimiento': fechaVencimiento,

      'fecha_pago': fechaPago,

      'estado': estado,

      'mora': mora,
    };
  }
}
