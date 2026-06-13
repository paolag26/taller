import 'package:sist_prestamo/controllers/mapa_cliente_adapter.dart';
import 'package:sist_prestamo/controllers/role_service.dart';
import 'package:sist_prestamo/controllers/database_config.dart';

class MapaService {
  final localDb = DatabaseConfig.client;
  final roleService = RoleService();

  Future<List<Map<String, dynamic>>> listarClientesConPersona() async {
    try {
      final access = await roleService.currentAccess();
      final clientesResponse = await localDb.from('cliente').select();
      final personasResponse = await localDb.from('persona').select();
      final prestamosResponse = await localDb.from('prestamo').select();
      final clientesPermitidos = access.isCobrador
          ? List<Map<String, dynamic>>.from(prestamosResponse)
                .where(
                  (prestamo) =>
                      _toInt(prestamo['id_cobrador']) == access.idCobrador,
                )
                .map((prestamo) => _toInt(prestamo['id_cliente']))
                .whereType<int>()
                .toSet()
          : <int>{};
      final personas = {
        for (final persona in List<Map<String, dynamic>>.from(personasResponse))
          if (persona['ci'] != null) persona['ci'].toString(): persona,
        for (final persona in List<Map<String, dynamic>>.from(personasResponse))
          if (persona['ci_persona'] != null)
            persona['ci_persona'].toString(): persona,
      };

      return List<Map<String, dynamic>>.from(clientesResponse)
          .where((cliente) {
            return !access.isCobrador ||
                clientesPermitidos.contains(_toInt(cliente['id_cliente']));
          })
          .map((cliente) {
            final enlazado = {
              ...cliente,
              'persona': personas[cliente['ci_persona']?.toString()],
            };
            return MapaClienteAdapter.desdeLocal(enlazado).toMap();
          })
          .toList();
    } catch (e) {
      return [];
    }
  }

  int? _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '');
  }
}
