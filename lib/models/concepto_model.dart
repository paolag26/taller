class ConceptoModel {
  final int idConcepto;
  final String nombre;
  final String? descripcion;
  final int estado;

  ConceptoModel({
    required this.idConcepto,
    required this.nombre,
    this.descripcion,
    required this.estado,
  });
}
