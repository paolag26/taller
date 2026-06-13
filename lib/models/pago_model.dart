class PagoModel {
  final int? id;
  final int cuotaId;
  final int? prestamoId;
  final double monto;
  final String fecha;
  final String metodoPago;
  final String observacion;
  final bool pagoCompleto;
  final String tipoPago;
  final String estadoPago;
  final List<int> cuotasIds;
  final double mora;
  final double descuento;

  PagoModel({
    this.id,
    required this.cuotaId,
    this.prestamoId,
    required this.monto,
    required this.fecha,
    required this.metodoPago,
    required this.observacion,
    required this.pagoCompleto,
    this.tipoPago = 'NORMAL',
    this.estadoPago = 'COMPLETO',
    this.cuotasIds = const [],
    required this.mora,
    required this.descuento,
  });

  // =========================
  // FROM JSON
  // =========================

  factory PagoModel.fromJson(Map<String, dynamic> json) {
    return PagoModel(
      id: json['id_pago'],
      cuotaId: json['id_cuota'],
      prestamoId: json['id_prestamo'],
      monto: double.parse(json['monto'].toString()),
      fecha: json['fecha_pago'],
      metodoPago: json['metodo_pago'] ?? '',
      observacion: json['observacion'] ?? '',
      pagoCompleto: json['pago_completo'] ?? false,
      tipoPago: json['tipo_pago'] ?? 'NORMAL',
      estadoPago: json['estado_pago'] ?? 'COMPLETO',
      cuotasIds: _parseCuotasIds(json['cuotas_ids']),

      mora: double.parse(json['mora'].toString()),

      descuento: double.parse(json['descuento'].toString()),
    );
  }

  // =========================
  // TO JSON
  // =========================

  Map<String, dynamic> toJson() {
    return {
      'id_cuota': cuotaId,

      'id_prestamo': prestamoId,

      'monto': monto,

      'fecha_pago': fecha,

      'metodo_pago': metodoPago,

      'observacion': observacion,

      'pago_completo': pagoCompleto,

      'tipo_pago': tipoPago,

      'estado_pago': estadoPago,

      'cuotas_ids': cuotasIds,

      'mora': mora,

      'descuento': descuento,
    };
  }

  static List<int> _parseCuotasIds(dynamic value) {
    if (value is List) {
      return value
          .map((item) => int.tryParse(item.toString()))
          .whereType<int>()
          .toList();
    }
    return [];
  }
}
