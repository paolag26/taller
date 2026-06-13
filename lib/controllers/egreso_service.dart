import 'package:flutter/foundation.dart';

import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/models/egreso_model.dart';

class EgresoService {
  final localDb = DatabaseConfig.client;

  Future<List<EgresoModel>> listarEgresos() async {
    final egresos = await localDb
        .from('egreso')
        .select()
        .order('fecha', ascending: false)
        .order('id_egreso', ascending: false);

    final usuarios = await _listarSeguro('usuario');
    final personas = await _listarSeguro('persona');
    final conceptos = await listarConceptos();

    final conceptosByName = {
      for (final concepto in conceptos)
        concepto.nombre.trim().toLowerCase(): concepto,
    };
    final usuariosById = {
      for (final usuario in usuarios)
        usuario['id_usuario']?.toString() ?? '': usuario,
    };
    final personasByCi = _personasPorCi(personas);

    return List<Map<String, dynamic>>.from(egresos).map((egreso) {
      final usuario = usuariosById[egreso['id_usuario']?.toString() ?? ''];
      final persona = personasByCi[usuario?['ci_persona']?.toString() ?? ''];
      final concepto =
          conceptosByName[egreso['concepto']?.toString().trim().toLowerCase() ??
              ''];

      return EgresoModel.fromJson({
        ...egreso,
        'id_categoria': egreso['id_categoria'] ?? concepto?.id,
        'concepto_nombre':
            concepto?.nombre ?? egreso['concepto'] ?? 'Sin concepto',
        'usuario_nombre': _nombreUsuario(usuario, persona),
      });
    }).toList();
  }

  Future<List<UsuarioEgresoModel>> listarUsuarios() async {
    final usuarios = await _listarSeguro('usuario');
    final personas = await _listarSeguro('persona');
    final personasByCi = _personasPorCi(personas);

    return usuarios.map((usuario) {
      return UsuarioEgresoModel(
        idUsuario: usuario['id_usuario'].toString(),
        nombre: _nombreUsuario(
          usuario,
          personasByCi[usuario['ci_persona']?.toString() ?? ''],
        ),
      );
    }).toList();
  }

  Future<List<ConceptoGastoModel>> listarConceptos() async {
    try {
      final response = await localDb
          .from('concepto_gasto')
          .select()
          .order('nombre');
      return List<Map<String, dynamic>>.from(
        response,
      ).map(ConceptoGastoModel.fromJson).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> insertarEgreso(EgresoModel egreso) async {
    await _validarConcepto(egreso.concepto);
    final userId = localDb.auth.currentUser?.id;
    await localDb
        .from('egreso')
        .insert(egreso.toInsertJson(currentUserId: userId));
    debugPrint('EGRESO CREADO');
  }

  Future<void> actualizarEgreso(EgresoModel egreso) async {
    await _validarConcepto(egreso.concepto);
    await localDb
        .from('egreso')
        .update(egreso.toUpdateJson())
        .eq('id_egreso', egreso.idEgreso!);
  }

  Future<void> _validarConcepto(String nombre) async {
    final conceptos = await listarConceptos();
    final existe = conceptos.any((concepto) {
      return concepto.nombre.trim().toLowerCase() ==
          nombre.trim().toLowerCase();
    });
    if (!existe) {
      throw Exception('Seleccione un concepto de gasto registrado.');
    }
  }

  Future<void> eliminarEgreso(int idEgreso) async {
    await localDb
        .from('egreso')
        .update({'estado': false})
        .eq('id_egreso', idEgreso);
  }

  Future<void> guardarConcepto(ConceptoGastoModel concepto) async {
    if (concepto.id == null) {
      await localDb.from('concepto_gasto').insert(concepto.toJson());
      debugPrint('CONCEPTO CREADO');
      return;
    }

    await localDb
        .from('concepto_gasto')
        .update(concepto.toJson())
        .eq('id_categoria', concepto.id!);
  }

  Future<void> cambiarEstadoConcepto(int idConcepto, bool activo) async {
    await localDb
        .from('concepto_gasto')
        .update({'activo': activo})
        .eq('id_categoria', idConcepto);
  }

  Future<List<Map<String, dynamic>>> _listarSeguro(String table) async {
    try {
      final response = await localDb.from(table).select();
      return List<Map<String, dynamic>>.from(response);
    } catch (_) {
      return [];
    }
  }

  String _nombreUsuario(
    Map<String, dynamic>? usuario,
    Map<String, dynamic>? persona,
  ) {
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final materno = persona?['apellido_materno'] ?? '';
    final nombre = '$nombres $paterno $materno'.trim();
    if (nombre.isNotEmpty) return nombre;
    if (usuario?['username'] != null) return usuario!['username'].toString();
    return usuario?['id_usuario']?.toString() ?? 'Sistema';
  }

  Map<String, Map<String, dynamic>> _personasPorCi(
    List<Map<String, dynamic>> personas,
  ) {
    return {
      for (final persona in personas)
        if (persona['ci'] != null) persona['ci'].toString(): persona,
      for (final persona in personas)
        if (persona['ci_persona'] != null)
          persona['ci_persona'].toString(): persona,
    };
  }
}
