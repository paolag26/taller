import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/models/egreso_model.dart';

class ConceptoGastoService {
  final localDb = DatabaseConfig.client;

  Future<List<ConceptoGastoModel>> listarConceptos() async {
    final response = await localDb
        .from('concepto_gasto')
        .select()
        .order('nombre');

    return List<Map<String, dynamic>>.from(
      response,
    ).map(ConceptoGastoModel.fromJson).toList();
  }

  Future<void> guardarConcepto(ConceptoGastoModel concepto) async {
    if (concepto.id == null) {
      await localDb.from('concepto_gasto').insert(concepto.toJson());
      return;
    }

    await localDb
        .from('concepto_gasto')
        .update(concepto.toJson())
        .eq('id_concepto', concepto.id!);
  }

  Future<void> cambiarEstado(int id, bool activo) async {
    await localDb
        .from('concepto_gasto')
        .update({'estado': activo})
        .eq('id_concepto', id);
  }
}
