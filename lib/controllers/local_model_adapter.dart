// ==============================
// PATRON ADAPTER
// Convierte datos externos
// a estructuras internas.
// Defensa: Patron Estructural.
// Razon en Cuentas Claras: Base local puede
// devolver columnas historicas y nuevas; el
// adapter entrega un mapa normalizado al app.
// ==============================
class LocalModelAdapter {
  static Map<String, dynamic> cuotaDesdeLocal(
    Map<String, dynamic> cuota, {
    Map<String, dynamic>? plan,
    Map<String, dynamic>? estado,
  }) {
    final copy = Map<String, dynamic>.from(cuota);
    copy['id_prestamo'] ??= plan?['id_prestamo'];
    copy['monto_cuota'] ??= copy['monto_total'];
    copy['monto_cuota'] ??= copy['monto'];
    copy['capital'] ??= copy['monto_capital'];
    copy['interes'] ??= copy['monto_interes'];
    copy['saldo_pendiente'] ??= copy['saldo_restante'];
    copy['saldo_pendiente'] ??= copy['saldo'];
    copy['estado'] = (copy['estado']?.toString().isNotEmpty == true)
        ? copy['estado']
        : estado?['nombre'] ?? 'PENDIENTE';
    return copy;
  }
}
