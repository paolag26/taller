import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/models/persona_model.dart';

class PersonaService {
  final localDb = DatabaseConfig.client;

  // =========================
  // INSERTAR
  // =========================
  Future<void> insertarPersona(PersonaModel persona) async {
    await localDb.from('persona').insert(persona.toJson());
  }

  Future<void> guardarPersona(PersonaModel persona) async {
    await localDb
        .from('persona')
        .upsert(persona.toJson(), onConflict: 'ci_persona');
  }

  // =========================
  // LISTAR
  // =========================
  Future<List<PersonaModel>> listarPersonas() async {
    final response = await localDb.from('persona').select();
    return response
        .map<PersonaModel>((json) => PersonaModel.fromJson(json))
        .toList();
  }

  // =========================
  // ACTUALIZAR
  // =========================
  Future<void> actualizarPersona(PersonaModel persona) async {
    await localDb
        .from('persona')
        .update(persona.toJson())
        .eq('ci_persona', persona.ciPersona);
  }

  // =========================
  // ELIMINAR
  // =========================

  Future<void> eliminarPersona(String ciPersona) async {
    await localDb.from('persona').delete().eq('ci_persona', ciPersona);
  }
}
