class TipoPrestamoModel {
  final int idTipo;
  final String nombre;
  final String? descripcion;
  final int estado;

  TipoPrestamoModel({
    required this.idTipo,
    required this.nombre,
    this.descripcion,
    required this.estado,
  });
}
