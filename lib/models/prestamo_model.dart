class PrestamoModel {
  final int? idPrestamo;

  final int idCliente;

  final int? idCobrador;

  final int idTipo;

  final int idEstado;

  final int? idGarantia;

  final int? prestamoOrigen;

  final bool esRefinanciamiento;

  final double monto;

  final double interes;

  final String fechaInicio;

  final String? fechaFin;

  PrestamoModel({
    this.idPrestamo,

    required this.idCliente,

    this.idCobrador,

    required this.idTipo,

    required this.idEstado,

    this.idGarantia,

    this.prestamoOrigen,

    required this.esRefinanciamiento,

    required this.monto,

    required this.interes,

    required this.fechaInicio,

    this.fechaFin,
  });

  factory PrestamoModel.fromJson(Map<String, dynamic> json) {
    return PrestamoModel(
      idPrestamo: json['id_prestamo'],

      idCliente: json['id_cliente'],

      idCobrador: json['id_cobrador'],

      idTipo: json['id_tipo'],

      idEstado: json['id_estado'],

      idGarantia: json['id_garantia'],

      prestamoOrigen: json['prestamo_origen'],

      esRefinanciamiento: json['es_refinanciamiento'] ?? false,

      monto: double.parse(json['monto'].toString()),

      interes: double.parse(json['interes'].toString()),

      fechaInicio: json['fecha_inicio'],

      fechaFin: json['fecha_fin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cliente': idCliente,

      'id_cobrador': idCobrador,

      'id_tipo': idTipo,

      'id_estado': idEstado,

      'id_garantia': idGarantia,

      'prestamo_origen': prestamoOrigen,

      'es_refinanciamiento': esRefinanciamiento,

      'monto': monto,

      'interes': interes,

      'fecha_inicio': fechaInicio,

      'fecha_fin': fechaFin,
    };
  }
}
