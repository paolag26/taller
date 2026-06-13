class PersonaModel {
  final String ciPersona;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String telefono;
  final String correo;
  final String direccionDomicilio;
  final String direccionTrabajo;
  final double? latitud;
  final double? longitud;

  PersonaModel({
    required this.ciPersona,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.telefono,
    required this.correo,
    required this.direccionDomicilio,
    required this.direccionTrabajo,
    this.latitud,
    this.longitud,
  });

  factory PersonaModel.fromJson(Map<String, dynamic> json) {
    return PersonaModel(
      ciPersona: json['ci_persona'],
      nombres: json['nombres'],
      apellidoPaterno: json['apellido_paterno'] ?? '',
      apellidoMaterno: json['apellido_materno'] ?? '',
      telefono: json['telefono'] ?? '',
      correo: json['correo'] ?? '',
      direccionDomicilio: json['direccion_domicilio'] ?? '',
      direccionTrabajo: json['direccion_trabajo'] ?? '',
      latitud: json['latitud'] != null
          ? double.tryParse(json['latitud'].toString())
          : null,
      longitud: json['longitud'] != null
          ? double.tryParse(json['longitud'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ci_persona': ciPersona,
      'nombres': nombres,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'telefono': telefono,
      'correo': correo,
      'direccion_domicilio': direccionDomicilio,
      'direccion_trabajo': direccionTrabajo,
      'latitud': latitud,
      'longitud': longitud,
    };
  }
}
