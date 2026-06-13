class ConceptoGastoModel {
  final int? id;
  final String nombre;
  final String descripcion;
  final bool activo;

  const ConceptoGastoModel({
    this.id,
    required this.nombre,
    this.descripcion = '',
    this.activo = true,
  });

  factory ConceptoGastoModel.fromJson(Map<String, dynamic> json) {
    return ConceptoGastoModel(
      id: _toInt(json['id_categoria'] ?? json['id_concepto'] ?? json['id']),
      nombre: (json['nombre'] ?? '').toString(),
      descripcion: (json['descripcion'] ?? '').toString(),
      activo: json['activo'] != false && json['estado'] != false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'nombre': nombre, 'descripcion': descripcion, 'activo': activo};
  }
}

class EgresoModel {
  final int? idEgreso;
  final String fecha;
  final String concepto;
  final String descripcion;
  final double monto;
  final int? idConcepto;
  final String conceptoNombre;
  final String? idUsuario;
  final String usuarioNombre;
  final String observaciones;
  final bool estado;

  const EgresoModel({
    this.idEgreso,
    required this.fecha,
    required this.concepto,
    required this.descripcion,
    required this.monto,
    this.idConcepto,
    this.conceptoNombre = '',
    this.idUsuario,
    this.usuarioNombre = '',
    this.observaciones = '',
    this.estado = true,
  });

  factory EgresoModel.fromJson(Map<String, dynamic> json) {
    final usuario = json['usuario'];
    final persona = usuario is Map ? usuario['persona'] : null;
    final nombres = persona is Map ? persona['nombres'] ?? '' : '';
    final paterno = persona is Map ? persona['apellido_paterno'] ?? '' : '';
    final username = usuario is Map ? usuario['username'] ?? '' : '';
    final usuarioNombre = '$nombres $paterno'.trim();

    return EgresoModel(
      idEgreso: _toInt(json['id_egreso'] ?? json['id']),
      fecha: (json['fecha'] ?? '').toString(),
      concepto: (json['concepto'] ?? json['descripcion'] ?? '').toString(),
      descripcion: (json['descripcion'] ?? '').toString(),
      monto: _toDouble(json['monto']),
      idConcepto: _toInt(json['id_categoria'] ?? json['id_concepto']),
      conceptoNombre: (json['concepto_nombre']?.toString().isNotEmpty == true)
          ? json['concepto_nombre'].toString()
          : (json['concepto'] ?? '').toString(),
      idUsuario: json['id_usuario']?.toString(),
      usuarioNombre: (json['usuario_nombre']?.toString().isNotEmpty == true)
          ? json['usuario_nombre'].toString()
          : usuarioNombre.isEmpty
          ? username.toString()
          : usuarioNombre,
      observaciones: (json['observaciones'] ?? '').toString(),
      estado: json['estado'] != false,
    );
  }

  Map<String, dynamic> toInsertJson({String? currentUserId}) {
    return {
      'fecha': fecha,
      'id_categoria': idConcepto,
      'concepto': concepto,
      'descripcion': descripcion,
      'monto': monto,
      'id_usuario': currentUserId,
      'observaciones': observaciones,
      'estado': estado,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'fecha': fecha,
      'id_categoria': idConcepto,
      'concepto': concepto,
      'descripcion': descripcion,
      'monto': monto,
      'observaciones': observaciones,
      'estado': estado,
    };
  }

  EgresoModel copyWith({
    int? idEgreso,
    String? fecha,
    String? concepto,
    String? descripcion,
    double? monto,
    int? idConcepto,
    String? conceptoNombre,
    String? idUsuario,
    String? usuarioNombre,
    String? observaciones,
    bool? estado,
  }) {
    return EgresoModel(
      idEgreso: idEgreso ?? this.idEgreso,
      fecha: fecha ?? this.fecha,
      concepto: concepto ?? this.concepto,
      descripcion: descripcion ?? this.descripcion,
      monto: monto ?? this.monto,
      idConcepto: idConcepto ?? this.idConcepto,
      conceptoNombre: conceptoNombre ?? this.conceptoNombre,
      idUsuario: idUsuario ?? this.idUsuario,
      usuarioNombre: usuarioNombre ?? this.usuarioNombre,
      observaciones: observaciones ?? this.observaciones,
      estado: estado ?? this.estado,
    );
  }
}

class EgresoFilters {
  final String query;
  final int? idConcepto;
  final String? idUsuario;
  final DateTime? desde;
  final DateTime? hasta;
  final bool incluirInactivos;
  final int page;
  final int pageSize;

  const EgresoFilters({
    this.query = '',
    this.idConcepto,
    this.idUsuario,
    this.desde,
    this.hasta,
    this.incluirInactivos = false,
    this.page = 0,
    this.pageSize = 10,
  });

  EgresoFilters copyWith({
    String? query,
    int? idConcepto,
    bool clearConcepto = false,
    String? idUsuario,
    bool clearUsuario = false,
    DateTime? desde,
    bool clearDesde = false,
    DateTime? hasta,
    bool clearHasta = false,
    bool? incluirInactivos,
    int? page,
    int? pageSize,
  }) {
    return EgresoFilters(
      query: query ?? this.query,
      idConcepto: clearConcepto ? null : idConcepto ?? this.idConcepto,
      idUsuario: clearUsuario ? null : idUsuario ?? this.idUsuario,
      desde: clearDesde ? null : desde ?? this.desde,
      hasta: clearHasta ? null : hasta ?? this.hasta,
      incluirInactivos: incluirInactivos ?? this.incluirInactivos,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

class UsuarioEgresoModel {
  final String idUsuario;
  final String nombre;

  const UsuarioEgresoModel({required this.idUsuario, required this.nombre});

  factory UsuarioEgresoModel.fromJson(Map<String, dynamic> json) {
    final persona = json['persona'];
    final nombres = persona is Map ? persona['nombres'] ?? '' : '';
    final paterno = persona is Map ? persona['apellido_paterno'] ?? '' : '';
    final username = json['username'] ?? '';
    final nombre = '$nombres $paterno'.trim();

    return UsuarioEgresoModel(
      idUsuario: json['id_usuario'].toString(),
      nombre: nombre.isEmpty ? username.toString() : nombre,
    );
  }
}

double _toDouble(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

int? _toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  return int.tryParse(value.toString());
}
