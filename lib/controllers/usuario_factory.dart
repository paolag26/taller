// ==============================
// PATRON FACTORY METHOD
// Se encapsula la creacion de objetos
// evitando multiples condicionales.
// Defensa: Patron Creacional.
// Razon en Cuentas Claras: usuario local
// se crea distinto para CLIENTE y COBRADOR,
// pero mantiene el mismo contrato de Base local.
// ==============================
class UsuarioFactory {
  static Map<String, dynamic> crearCliente({
    required String ciPersona,
    required dynamic idRol,
    required String username,
    bool estado = true,
  }) {
    return _crearUsuarioBase(
      ciPersona: ciPersona,
      idRol: idRol,
      username: username,
      estado: estado,
    );
  }

  static Map<String, dynamic> crearCobrador({
    required String ciPersona,
    required dynamic idRol,
    required String username,
    bool estado = true,
  }) {
    return _crearUsuarioBase(
      ciPersona: ciPersona,
      idRol: idRol,
      username: username,
      estado: estado,
    );
  }

  static Map<String, dynamic> _crearUsuarioBase({
    required String ciPersona,
    required dynamic idRol,
    required String username,
    required bool estado,
  }) {
    return {
      'ci_persona': ciPersona,
      'id_rol': idRol,
      'username': username.trim(),
      'estado': estado,
    };
  }
}
