import 'package:sist_prestamo/models/persona_model.dart';

class ClienteModel {
  final int idCliente;

  final String ciPersona;

  final String estadoCredito;

  final bool estado;

  final PersonaModel? persona;

  ClienteModel({
    required this.idCliente,

    required this.ciPersona,

    required this.estadoCredito,

    required this.estado,

    this.persona,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      idCliente: json['id_cliente'],

      ciPersona: json['ci_persona'],

      estadoCredito: json['estado_credito'] ?? '',

      estado: json['estado'] ?? true,

      persona: json['persona'] != null
          ? PersonaModel.fromJson(json['persona'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ci_persona': ciPersona,

      'estado_credito': estadoCredito,

      'estado': estado,
    };
  }
}
