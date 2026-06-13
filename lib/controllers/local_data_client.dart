import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:sist_prestamo/database/database.dart';

class LocalUser {
  const LocalUser({required this.id, required this.email});

  final String id;
  final String? email;
}

class LocalSession {
  const LocalSession({required this.user, this.refreshToken});

  final LocalUser user;
  final String? refreshToken;
}

class LocalAuthResponse {
  const LocalAuthResponse({required this.user, required this.session});

  final LocalUser user;
  final LocalSession session;
}

class LocalUserAttributes {
  const LocalUserAttributes({this.password});

  final String? password;
}

class LocalAuthClient {
  LocalAuthClient(this._client);

  final LocalDataClient _client;
  LocalUser? currentUser;
  LocalSession? currentSession;

  Future<LocalAuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    await _client.ensureReady();
    final users = await _client
        .from('usuario')
        .select()
        .eq('username', email)
        .limit(1);

    Map<String, dynamic>? user = users.isEmpty ? null : users.first;
    if (user == null) {
      final personas = await _client
          .from('persona')
          .select()
          .eq('correo', email)
          .limit(1);
      if (personas.isNotEmpty) {
        final persona = personas.first;
        final generatedId = 'local-${DateTime.now().microsecondsSinceEpoch}';
        await _client.from('usuario').insert({
          'id_usuario': generatedId,
          'ci_persona': persona['ci_persona'],
          'id_rol': 1,
          'username': email,
          'password': password,
          'estado': true,
        });
        user = (await _client
            .from('usuario')
            .select()
            .eq('id_usuario', generatedId)
            .single());
      }
    }

    if (user == null) {
      throw Exception('Usuario o contrasena incorrectos.');
    }
    final storedPassword = user['password']?.toString() ?? '';
    if (storedPassword.isNotEmpty && storedPassword != password) {
      throw Exception('Usuario o contrasena incorrectos.');
    }

    currentUser = LocalUser(
      id: user['id_usuario'].toString(),
      email: user['username']?.toString(),
    );
    currentSession = LocalSession(
      user: currentUser!,
      refreshToken: 'local-session-${currentUser!.id}',
    );
    return LocalAuthResponse(user: currentUser!, session: currentSession!);
  }

  Future<void> signOut() async {
    currentUser = null;
    currentSession = null;
  }

  Future<void> updateUser(LocalUserAttributes attributes) async {
    final user = currentUser;
    if (user == null || attributes.password == null) return;
    await _client
        .from('usuario')
        .update({'password': attributes.password})
        .eq('id_usuario', user.id);
  }

  Future<void> setSession(String refreshToken) async {}

  Future<LocalAuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    await _client.ensureReady();
    final id = 'local-${DateTime.now().microsecondsSinceEpoch}';
    await _client.from('usuario').insert({
      'id_usuario': id,
      'id_rol': 2,
      'username': email,
      'password': password,
      'estado': true,
    });
    currentUser = LocalUser(id: id, email: email);
    currentSession = LocalSession(
      user: currentUser!,
      refreshToken: 'local-session-$id',
    );
    return LocalAuthResponse(user: currentUser!, session: currentSession!);
  }
}

class LocalDataClient {
  static LocalDataClient create(AppDatabase db) {
    final client = LocalDataClient._(db);
    return client;
  }

  LocalDataClient._(this.db) {
    auth = LocalAuthClient(this);
  }

  final AppDatabase db;
  late final LocalAuthClient auth;
  bool _ready = false;
  bool _initializing = false;

  Future<void> ensureReady() async {
    if (_ready) return;
    if (_initializing) return;
    _initializing = true;
    try {
      await db.seedCatalogosBase();
      await _ensureDefaultAdmin();
      _ready = true;
    } finally {
      _initializing = false;
    }
  }

  LocalTableQuery from(String table) => LocalTableQuery(this, table);

  Future<void> _ensureDefaultAdmin() async {
    final existing = await from(
      'usuario',
    ).select().eq('username', 'admin@local').limit(1);
    if (existing.isNotEmpty) return;
    await from('usuario').insert({
      'id_usuario': 'local-admin',
      'id_rol': 1,
      'username': 'admin@local',
      'password': 'admin',
      'estado': true,
    });
  }
}

class LocalTableQuery implements Future<dynamic> {
  LocalTableQuery(this.client, this.table);

  final LocalDataClient client;
  final String table;
  String _action = 'select';
  dynamic _payload;
  final _filters = <_Filter>[];
  String? _orderBy;
  bool _ascending = true;
  int? _limit;
  bool _returnSingle = false;
  bool _returnMaybeSingle = false;
  bool _returning = false;

  LocalTableQuery select([String columns = '*']) {
    _action = _action == 'insert' || _action == 'upsert' ? _action : 'select';
    _returning = true;
    return this;
  }

  LocalTableQuery insert(dynamic payload) {
    _action = 'insert';
    _payload = payload;
    return this;
  }

  LocalTableQuery upsert(dynamic payload, {String? onConflict}) {
    _action = 'upsert';
    _payload = payload;
    return this;
  }

  LocalTableQuery update(Map<String, dynamic> payload) {
    _action = 'update';
    _payload = payload;
    return this;
  }

  LocalTableQuery delete() {
    _action = 'delete';
    return this;
  }

  LocalTableQuery eq(String column, dynamic value) {
    _filters.add(_Filter(column, '=', value));
    return this;
  }

  LocalTableQuery gte(String column, dynamic value) {
    _filters.add(_Filter(column, '>=', value));
    return this;
  }

  LocalTableQuery lte(String column, dynamic value) {
    _filters.add(_Filter(column, '<=', value));
    return this;
  }

  LocalTableQuery inFilter(String column, List<dynamic> values) {
    _filters.add(_Filter(column, 'in', values));
    return this;
  }

  LocalTableQuery isFilter(String column, dynamic value) {
    _filters.add(_Filter(column, value == null ? 'is null' : '=', value));
    return this;
  }

  LocalTableQuery order(
    String column, {
    bool ascending = true,
    bool? nullsFirst,
  }) {
    _orderBy = column;
    _ascending = ascending;
    return this;
  }

  LocalTableQuery limit(int count) {
    _limit = count;
    return this;
  }

  Future<Map<String, dynamic>> single() async {
    _returnSingle = true;
    final result = await _execute();
    if (result is List && result.isNotEmpty) {
      return Map<String, dynamic>.from(result.first);
    }
    if (result is Map<String, dynamic>) return result;
    throw Exception('No se encontro ningun registro en $table.');
  }

  Future<Map<String, dynamic>?> maybeSingle() async {
    _returnMaybeSingle = true;
    final result = await _execute();
    if (result is List && result.isNotEmpty) {
      return Map<String, dynamic>.from(result.first);
    }
    if (result is Map<String, dynamic>) return result;
    return null;
  }

  Future<dynamic> _execute() async {
    await client.ensureReady();
    switch (_action) {
      case 'insert':
        return _insert(replace: false);
      case 'upsert':
        return _insert(replace: true);
      case 'update':
        return _update();
      case 'delete':
        return _delete();
      default:
        return _select();
    }
  }

  Future<dynamic> _insert({required bool replace}) async {
    final items = _payload is List
        ? List<Map<String, dynamic>>.from(_payload)
        : [Map<String, dynamic>.from(_payload as Map)];
    final inserted = <Map<String, dynamic>>[];
    for (final item in items) {
      final normalized = _normalizePayload(item);
      final columns = normalized.keys.map(_id).join(', ');
      final placeholders = List.filled(normalized.length, '?').join(', ');
      final verb = replace ? 'insert or replace' : 'insert';
      final sql =
          '$verb into ${_id(_physicalTable(table))} ($columns) values ($placeholders)';
      final id = await client.db.customInsert(
        sql,
        variables: normalized.values.map(_variable).toList(),
      );
      inserted.add(await _rowAfterInsert(id, normalized));
    }
    if (_returnSingle || _returnMaybeSingle) {
      return inserted.isEmpty ? null : inserted.first;
    }
    if (_returning) return inserted;
    return null;
  }

  Future<List<Map<String, dynamic>>> _select() async {
    final args = <Variable>[];
    final where = _whereSql(args);
    final order = _orderBy == null
        ? ''
        : ' order by ${_id(_orderBy!)} ${_ascending ? 'asc' : 'desc'}';
    final limit = _limit == null ? '' : ' limit $_limit';
    final rows = await client.db
        .customSelect(
          'select * from ${_id(_physicalTable(table))}$where$order$limit',
          variables: args,
        )
        .get();
    return rows.map((row) => _normalizeRow(table, row.data)).toList();
  }

  Future<int> _update() async {
    final payload = _normalizePayload(
      Map<String, dynamic>.from(_payload as Map),
    );
    final args = payload.values.map(_variable).toList();
    final setSql = payload.keys.map((key) => '${_id(key)} = ?').join(', ');
    final where = _whereSql(args);
    return client.db.customUpdate(
      'update ${_id(_physicalTable(table))} set $setSql$where',
      variables: args,
      updates: {_tableInfo(table)},
    );
  }

  Future<int> _delete() async {
    final args = <Variable>[];
    final where = _whereSql(args);
    return client.db.customUpdate(
      'delete from ${_id(_physicalTable(table))}$where',
      variables: args,
      updates: {_tableInfo(table)},
    );
  }

  Future<Map<String, dynamic>> _rowAfterInsert(
    int rowId,
    Map<String, dynamic> payload,
  ) async {
    final idColumn = _idColumns[table];
    if (idColumn == null) return payload;
    final id = payload[idColumn] ?? rowId;
    final rows = await client.from(table).select().eq(idColumn, id).limit(1);
    if (rows.isEmpty) return {...payload, idColumn: id};
    return rows.first;
  }

  String _whereSql(List<Variable> args) {
    if (_filters.isEmpty) return '';
    final clauses = <String>[];
    for (final filter in _filters) {
      if (filter.operatorName == 'is null') {
        clauses.add('${_id(filter.column)} is null');
      } else if (filter.operatorName == 'in') {
        final values = List<dynamic>.from(filter.value as List);
        if (values.isEmpty) {
          clauses.add('1 = 0');
        } else {
          clauses.add(
            '${_id(filter.column)} in (${List.filled(values.length, '?').join(', ')})',
          );
          args.addAll(values.map(_variable));
        }
      } else {
        clauses.add('${_id(filter.column)} ${filter.operatorName} ?');
        args.add(_variable(filter.value));
      }
    }
    return ' where ${clauses.join(' and ')}';
  }

  @override
  Stream<dynamic> asStream() => _execute().asStream();

  @override
  Future<dynamic> catchError(
    Function onError, {
    bool Function(Object error)? test,
  }) => _execute().catchError(onError, test: test);

  @override
  Future<R> then<R>(
    FutureOr<R> Function(dynamic value) onValue, {
    Function? onError,
  }) => _execute().then(onValue, onError: onError);

  @override
  Future<dynamic> timeout(
    Duration timeLimit, {
    FutureOr<dynamic> Function()? onTimeout,
  }) => _execute().timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<dynamic> whenComplete(FutureOr<void> Function() action) =>
      _execute().whenComplete(action);
}

class _Filter {
  const _Filter(this.column, this.operatorName, this.value);

  final String column;
  final String operatorName;
  final dynamic value;
}

String _id(String value) => '"${value.replaceAll('"', '""')}"';

String _physicalTable(String table) {
  return switch (table) {
    'rol' => 'rol_usuario',
    'concepto_gasto' => 'categoria_egreso',
    _ => table,
  };
}

Variable _variable(dynamic value) {
  if (value == null) return const Variable(null);
  if (value is bool) return Variable<int>(value ? 1 : 0);
  if (value is DateTime) return Variable<String>(value.toIso8601String());
  if (value is List || value is Map) return Variable<String>(jsonEncode(value));
  return Variable(value);
}

Map<String, dynamic> _normalizePayload(Map<String, dynamic> payload) {
  return payload.map((key, value) {
    if (value is DateTime) return MapEntry(key, value.toIso8601String());
    if (value is List || value is Map) return MapEntry(key, jsonEncode(value));
    return MapEntry(key, value);
  })..removeWhere(
    (key, value) => value == null && !_nullableColumns.contains(key),
  );
}

Map<String, dynamic> _normalizeRow(String table, Map<String, dynamic> row) {
  final bools = _boolColumns[table] ?? const <String>{};
  return row.map((key, value) {
    if (bools.contains(key) && value is int) return MapEntry(key, value == 1);
    if (value is DateTime) return MapEntry(key, value.toIso8601String());
    return MapEntry(key, value);
  });
}

final _idColumns = <String, String>{
  'cliente': 'id_cliente',
  'rol_usuario': 'id_rol',
  'rol': 'id_rol',
  'usuario': 'id_usuario',
  'moneda': 'id_moneda',
  'cobrador': 'id_cobrador',
  'garante': 'id_garante',
  'garantia': 'id_garantia',
  'tipo_prestamo': 'id_tipo',
  'estado_prestamo': 'id_estado',
  'prestamo': 'id_prestamo',
  'prestamo_garante': 'id',
  'prestamo_garantia': 'id',
  'cuota': 'id_cuota',
  'pago': 'id_pago',
  'metodo_pago': 'id_metodo',
  'categoria_egreso': 'id_categoria',
  'concepto_gasto': 'id_categoria',
  'egreso': 'id_egreso',
  'plan_pagos': 'id_plan',
  'simulacion_prestamo': 'id_simulacion',
};

final _boolColumns = <String, Set<String>>{
  'cliente': {'estado'},
  'rol_usuario': {'activo'},
  'rol': {'activo'},
  'usuario': {'estado'},
  'moneda': {'activo'},
  'cobrador': {'estado'},
  'garante': {'estado'},
  'garantia': {'estado'},
  'tipo_prestamo': {'activo', 'visible_cliente'},
  'estado_prestamo': {'activo', 'visible_cliente'},
  'prestamo': {'es_refinanciamiento'},
  'cuota': {'mora'},
  'pago': {'pago_completo'},
  'metodo_pago': {'estado'},
  'categoria_egreso': {'activo'},
  'concepto_gasto': {'activo'},
  'egreso': {'estado'},
};

TableInfo _tableInfo(String table) {
  final db = LocalDatabaseRegistry.instance;
  switch (table) {
    case 'persona':
      return db.personas;
    case 'cliente':
      return db.clientes;
    case 'rol':
    case 'rol_usuario':
      return db.rolUsuarios;
    case 'usuario':
      return db.usuarios;
    case 'moneda':
      return db.monedas;
    case 'configuracion':
      return db.configuraciones;
    case 'cobrador':
      return db.cobradores;
    case 'garante':
      return db.garantes;
    case 'garantia':
      return db.garantias;
    case 'tipo_prestamo':
      return db.tipoPrestamos;
    case 'estado_prestamo':
      return db.estadoPrestamos;
    case 'prestamo':
      return db.prestamos;
    case 'prestamo_garante':
      return db.prestamoGarantes;
    case 'prestamo_garantia':
      return db.prestamoGarantias;
    case 'cuota':
      return db.cuotas;
    case 'pago':
      return db.pagos;
    case 'metodo_pago':
      return db.metodoPagos;
    case 'concepto_gasto':
    case 'categoria_egreso':
      return db.categoriaEgresos;
    case 'egreso':
      return db.egresos;
    case 'plan_pagos':
      return db.planPagos;
    case 'simulacion_prestamo':
      return db.simulacionPrestamos;
    default:
      throw Exception('Tabla local no registrada: $table');
  }
}

class LocalDatabaseRegistry {
  static late AppDatabase instance;
}

const _nullableColumns = <String>{};
