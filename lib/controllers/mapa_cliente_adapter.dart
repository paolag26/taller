// ==============================
// PATRON ADAPTER
// Convierte datos externos
// a estructuras internas.
// Defensa: Patron Estructural.
// Razon en Cuentas Claras: el mapa consume
// datos combinados de cliente/persona y los
// transforma en un modelo estable para UI.
// ==============================
class ClienteMapaModel {
  final int? idCliente;
  final String ciPersona;
  final String nombre;
  final double? latitud;
  final double? longitud;
  final Map<String, dynamic> raw;

  const ClienteMapaModel({
    required this.idCliente,
    required this.ciPersona,
    required this.nombre,
    required this.latitud,
    required this.longitud,
    required this.raw,
  });

  Map<String, dynamic> toMap() {
    return {
      ...raw,
      'mapa_cliente': {
        'id_cliente': idCliente,
        'ci_persona': ciPersona,
        'nombre': nombre,
        'latitud': latitud,
        'longitud': longitud,
      },
    };
  }
}

class MapaClienteAdapter {
  static ClienteMapaModel desdeLocal(Map<String, dynamic> cliente) {
    final persona = cliente['persona'] as Map<String, dynamic>? ?? {};
    final nombres = persona['nombres']?.toString() ?? '';
    final paterno = persona['apellido_paterno']?.toString() ?? '';
    final materno = persona['apellido_materno']?.toString() ?? '';
    final ciPersona = cliente['ci_persona']?.toString() ?? '';
    final nombre = '$nombres $paterno $materno'.trim();

    return ClienteMapaModel(
      idCliente: _toInt(cliente['id_cliente']),
      ciPersona: ciPersona,
      nombre: nombre.isEmpty ? 'Cliente $ciPersona' : nombre,
      latitud: _toDouble(persona['latitud']),
      longitud: _toDouble(persona['longitud']),
      raw: cliente,
    );
  }

  static int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }
}
