// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PersonasTable extends Personas with TableInfo<$PersonasTable, Persona> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ciPersonaMeta = const VerificationMeta(
    'ciPersona',
  );
  @override
  late final GeneratedColumn<String> ciPersona = GeneratedColumn<String>(
    'ci_persona',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombresMeta = const VerificationMeta(
    'nombres',
  );
  @override
  late final GeneratedColumn<String> nombres = GeneratedColumn<String>(
    'nombres',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _apellidoPaternoMeta = const VerificationMeta(
    'apellidoPaterno',
  );
  @override
  late final GeneratedColumn<String> apellidoPaterno = GeneratedColumn<String>(
    'apellido_paterno',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _apellidoMaternoMeta = const VerificationMeta(
    'apellidoMaterno',
  );
  @override
  late final GeneratedColumn<String> apellidoMaterno = GeneratedColumn<String>(
    'apellido_materno',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _correoMeta = const VerificationMeta('correo');
  @override
  late final GeneratedColumn<String> correo = GeneratedColumn<String>(
    'correo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _direccionDomicilioMeta =
      const VerificationMeta('direccionDomicilio');
  @override
  late final GeneratedColumn<String> direccionDomicilio =
      GeneratedColumn<String>(
        'direccion_domicilio',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _direccionTrabajoMeta = const VerificationMeta(
    'direccionTrabajo',
  );
  @override
  late final GeneratedColumn<String> direccionTrabajo = GeneratedColumn<String>(
    'direccion_trabajo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _latitudMeta = const VerificationMeta(
    'latitud',
  );
  @override
  late final GeneratedColumn<double> latitud = GeneratedColumn<double>(
    'latitud',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudMeta = const VerificationMeta(
    'longitud',
  );
  @override
  late final GeneratedColumn<double> longitud = GeneratedColumn<double>(
    'longitud',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ciPersona,
    nombres,
    apellidoPaterno,
    apellidoMaterno,
    telefono,
    correo,
    direccionDomicilio,
    direccionTrabajo,
    latitud,
    longitud,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persona';
  @override
  VerificationContext validateIntegrity(
    Insertable<Persona> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ci_persona')) {
      context.handle(
        _ciPersonaMeta,
        ciPersona.isAcceptableOrUnknown(data['ci_persona']!, _ciPersonaMeta),
      );
    } else if (isInserting) {
      context.missing(_ciPersonaMeta);
    }
    if (data.containsKey('nombres')) {
      context.handle(
        _nombresMeta,
        nombres.isAcceptableOrUnknown(data['nombres']!, _nombresMeta),
      );
    } else if (isInserting) {
      context.missing(_nombresMeta);
    }
    if (data.containsKey('apellido_paterno')) {
      context.handle(
        _apellidoPaternoMeta,
        apellidoPaterno.isAcceptableOrUnknown(
          data['apellido_paterno']!,
          _apellidoPaternoMeta,
        ),
      );
    }
    if (data.containsKey('apellido_materno')) {
      context.handle(
        _apellidoMaternoMeta,
        apellidoMaterno.isAcceptableOrUnknown(
          data['apellido_materno']!,
          _apellidoMaternoMeta,
        ),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('correo')) {
      context.handle(
        _correoMeta,
        correo.isAcceptableOrUnknown(data['correo']!, _correoMeta),
      );
    }
    if (data.containsKey('direccion_domicilio')) {
      context.handle(
        _direccionDomicilioMeta,
        direccionDomicilio.isAcceptableOrUnknown(
          data['direccion_domicilio']!,
          _direccionDomicilioMeta,
        ),
      );
    }
    if (data.containsKey('direccion_trabajo')) {
      context.handle(
        _direccionTrabajoMeta,
        direccionTrabajo.isAcceptableOrUnknown(
          data['direccion_trabajo']!,
          _direccionTrabajoMeta,
        ),
      );
    }
    if (data.containsKey('latitud')) {
      context.handle(
        _latitudMeta,
        latitud.isAcceptableOrUnknown(data['latitud']!, _latitudMeta),
      );
    }
    if (data.containsKey('longitud')) {
      context.handle(
        _longitudMeta,
        longitud.isAcceptableOrUnknown(data['longitud']!, _longitudMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ciPersona};
  @override
  Persona map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Persona(
      ciPersona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ci_persona'],
      )!,
      nombres: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombres'],
      )!,
      apellidoPaterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido_paterno'],
      )!,
      apellidoMaterno: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}apellido_materno'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      correo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correo'],
      )!,
      direccionDomicilio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion_domicilio'],
      )!,
      direccionTrabajo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion_trabajo'],
      )!,
      latitud: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitud'],
      ),
      longitud: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitud'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PersonasTable createAlias(String alias) {
    return $PersonasTable(attachedDatabase, alias);
  }
}

class Persona extends DataClass implements Insertable<Persona> {
  final String ciPersona;
  final String nombres;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String telefono;
  final String correo;
  final String direccionDomicilio;
  final String direccionTrabajo;
  final double? latitud;
  final double? longitud;
  final DateTime createdAt;
  const Persona({
    required this.ciPersona,
    required this.nombres,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.telefono,
    required this.correo,
    required this.direccionDomicilio,
    required this.direccionTrabajo,
    this.latitud,
    this.longitud,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ci_persona'] = Variable<String>(ciPersona);
    map['nombres'] = Variable<String>(nombres);
    map['apellido_paterno'] = Variable<String>(apellidoPaterno);
    map['apellido_materno'] = Variable<String>(apellidoMaterno);
    map['telefono'] = Variable<String>(telefono);
    map['correo'] = Variable<String>(correo);
    map['direccion_domicilio'] = Variable<String>(direccionDomicilio);
    map['direccion_trabajo'] = Variable<String>(direccionTrabajo);
    if (!nullToAbsent || latitud != null) {
      map['latitud'] = Variable<double>(latitud);
    }
    if (!nullToAbsent || longitud != null) {
      map['longitud'] = Variable<double>(longitud);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PersonasCompanion toCompanion(bool nullToAbsent) {
    return PersonasCompanion(
      ciPersona: Value(ciPersona),
      nombres: Value(nombres),
      apellidoPaterno: Value(apellidoPaterno),
      apellidoMaterno: Value(apellidoMaterno),
      telefono: Value(telefono),
      correo: Value(correo),
      direccionDomicilio: Value(direccionDomicilio),
      direccionTrabajo: Value(direccionTrabajo),
      latitud: latitud == null && nullToAbsent
          ? const Value.absent()
          : Value(latitud),
      longitud: longitud == null && nullToAbsent
          ? const Value.absent()
          : Value(longitud),
      createdAt: Value(createdAt),
    );
  }

  factory Persona.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Persona(
      ciPersona: serializer.fromJson<String>(json['ciPersona']),
      nombres: serializer.fromJson<String>(json['nombres']),
      apellidoPaterno: serializer.fromJson<String>(json['apellidoPaterno']),
      apellidoMaterno: serializer.fromJson<String>(json['apellidoMaterno']),
      telefono: serializer.fromJson<String>(json['telefono']),
      correo: serializer.fromJson<String>(json['correo']),
      direccionDomicilio: serializer.fromJson<String>(
        json['direccionDomicilio'],
      ),
      direccionTrabajo: serializer.fromJson<String>(json['direccionTrabajo']),
      latitud: serializer.fromJson<double?>(json['latitud']),
      longitud: serializer.fromJson<double?>(json['longitud']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ciPersona': serializer.toJson<String>(ciPersona),
      'nombres': serializer.toJson<String>(nombres),
      'apellidoPaterno': serializer.toJson<String>(apellidoPaterno),
      'apellidoMaterno': serializer.toJson<String>(apellidoMaterno),
      'telefono': serializer.toJson<String>(telefono),
      'correo': serializer.toJson<String>(correo),
      'direccionDomicilio': serializer.toJson<String>(direccionDomicilio),
      'direccionTrabajo': serializer.toJson<String>(direccionTrabajo),
      'latitud': serializer.toJson<double?>(latitud),
      'longitud': serializer.toJson<double?>(longitud),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Persona copyWith({
    String? ciPersona,
    String? nombres,
    String? apellidoPaterno,
    String? apellidoMaterno,
    String? telefono,
    String? correo,
    String? direccionDomicilio,
    String? direccionTrabajo,
    Value<double?> latitud = const Value.absent(),
    Value<double?> longitud = const Value.absent(),
    DateTime? createdAt,
  }) => Persona(
    ciPersona: ciPersona ?? this.ciPersona,
    nombres: nombres ?? this.nombres,
    apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
    apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
    telefono: telefono ?? this.telefono,
    correo: correo ?? this.correo,
    direccionDomicilio: direccionDomicilio ?? this.direccionDomicilio,
    direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
    latitud: latitud.present ? latitud.value : this.latitud,
    longitud: longitud.present ? longitud.value : this.longitud,
    createdAt: createdAt ?? this.createdAt,
  );
  Persona copyWithCompanion(PersonasCompanion data) {
    return Persona(
      ciPersona: data.ciPersona.present ? data.ciPersona.value : this.ciPersona,
      nombres: data.nombres.present ? data.nombres.value : this.nombres,
      apellidoPaterno: data.apellidoPaterno.present
          ? data.apellidoPaterno.value
          : this.apellidoPaterno,
      apellidoMaterno: data.apellidoMaterno.present
          ? data.apellidoMaterno.value
          : this.apellidoMaterno,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      correo: data.correo.present ? data.correo.value : this.correo,
      direccionDomicilio: data.direccionDomicilio.present
          ? data.direccionDomicilio.value
          : this.direccionDomicilio,
      direccionTrabajo: data.direccionTrabajo.present
          ? data.direccionTrabajo.value
          : this.direccionTrabajo,
      latitud: data.latitud.present ? data.latitud.value : this.latitud,
      longitud: data.longitud.present ? data.longitud.value : this.longitud,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Persona(')
          ..write('ciPersona: $ciPersona, ')
          ..write('nombres: $nombres, ')
          ..write('apellidoPaterno: $apellidoPaterno, ')
          ..write('apellidoMaterno: $apellidoMaterno, ')
          ..write('telefono: $telefono, ')
          ..write('correo: $correo, ')
          ..write('direccionDomicilio: $direccionDomicilio, ')
          ..write('direccionTrabajo: $direccionTrabajo, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ciPersona,
    nombres,
    apellidoPaterno,
    apellidoMaterno,
    telefono,
    correo,
    direccionDomicilio,
    direccionTrabajo,
    latitud,
    longitud,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Persona &&
          other.ciPersona == this.ciPersona &&
          other.nombres == this.nombres &&
          other.apellidoPaterno == this.apellidoPaterno &&
          other.apellidoMaterno == this.apellidoMaterno &&
          other.telefono == this.telefono &&
          other.correo == this.correo &&
          other.direccionDomicilio == this.direccionDomicilio &&
          other.direccionTrabajo == this.direccionTrabajo &&
          other.latitud == this.latitud &&
          other.longitud == this.longitud &&
          other.createdAt == this.createdAt);
}

class PersonasCompanion extends UpdateCompanion<Persona> {
  final Value<String> ciPersona;
  final Value<String> nombres;
  final Value<String> apellidoPaterno;
  final Value<String> apellidoMaterno;
  final Value<String> telefono;
  final Value<String> correo;
  final Value<String> direccionDomicilio;
  final Value<String> direccionTrabajo;
  final Value<double?> latitud;
  final Value<double?> longitud;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PersonasCompanion({
    this.ciPersona = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidoPaterno = const Value.absent(),
    this.apellidoMaterno = const Value.absent(),
    this.telefono = const Value.absent(),
    this.correo = const Value.absent(),
    this.direccionDomicilio = const Value.absent(),
    this.direccionTrabajo = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonasCompanion.insert({
    required String ciPersona,
    required String nombres,
    this.apellidoPaterno = const Value.absent(),
    this.apellidoMaterno = const Value.absent(),
    this.telefono = const Value.absent(),
    this.correo = const Value.absent(),
    this.direccionDomicilio = const Value.absent(),
    this.direccionTrabajo = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ciPersona = Value(ciPersona),
       nombres = Value(nombres);
  static Insertable<Persona> custom({
    Expression<String>? ciPersona,
    Expression<String>? nombres,
    Expression<String>? apellidoPaterno,
    Expression<String>? apellidoMaterno,
    Expression<String>? telefono,
    Expression<String>? correo,
    Expression<String>? direccionDomicilio,
    Expression<String>? direccionTrabajo,
    Expression<double>? latitud,
    Expression<double>? longitud,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ciPersona != null) 'ci_persona': ciPersona,
      if (nombres != null) 'nombres': nombres,
      if (apellidoPaterno != null) 'apellido_paterno': apellidoPaterno,
      if (apellidoMaterno != null) 'apellido_materno': apellidoMaterno,
      if (telefono != null) 'telefono': telefono,
      if (correo != null) 'correo': correo,
      if (direccionDomicilio != null) 'direccion_domicilio': direccionDomicilio,
      if (direccionTrabajo != null) 'direccion_trabajo': direccionTrabajo,
      if (latitud != null) 'latitud': latitud,
      if (longitud != null) 'longitud': longitud,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonasCompanion copyWith({
    Value<String>? ciPersona,
    Value<String>? nombres,
    Value<String>? apellidoPaterno,
    Value<String>? apellidoMaterno,
    Value<String>? telefono,
    Value<String>? correo,
    Value<String>? direccionDomicilio,
    Value<String>? direccionTrabajo,
    Value<double?>? latitud,
    Value<double?>? longitud,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PersonasCompanion(
      ciPersona: ciPersona ?? this.ciPersona,
      nombres: nombres ?? this.nombres,
      apellidoPaterno: apellidoPaterno ?? this.apellidoPaterno,
      apellidoMaterno: apellidoMaterno ?? this.apellidoMaterno,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
      direccionDomicilio: direccionDomicilio ?? this.direccionDomicilio,
      direccionTrabajo: direccionTrabajo ?? this.direccionTrabajo,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ciPersona.present) {
      map['ci_persona'] = Variable<String>(ciPersona.value);
    }
    if (nombres.present) {
      map['nombres'] = Variable<String>(nombres.value);
    }
    if (apellidoPaterno.present) {
      map['apellido_paterno'] = Variable<String>(apellidoPaterno.value);
    }
    if (apellidoMaterno.present) {
      map['apellido_materno'] = Variable<String>(apellidoMaterno.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (correo.present) {
      map['correo'] = Variable<String>(correo.value);
    }
    if (direccionDomicilio.present) {
      map['direccion_domicilio'] = Variable<String>(direccionDomicilio.value);
    }
    if (direccionTrabajo.present) {
      map['direccion_trabajo'] = Variable<String>(direccionTrabajo.value);
    }
    if (latitud.present) {
      map['latitud'] = Variable<double>(latitud.value);
    }
    if (longitud.present) {
      map['longitud'] = Variable<double>(longitud.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonasCompanion(')
          ..write('ciPersona: $ciPersona, ')
          ..write('nombres: $nombres, ')
          ..write('apellidoPaterno: $apellidoPaterno, ')
          ..write('apellidoMaterno: $apellidoMaterno, ')
          ..write('telefono: $telefono, ')
          ..write('correo: $correo, ')
          ..write('direccionDomicilio: $direccionDomicilio, ')
          ..write('direccionTrabajo: $direccionTrabajo, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idClienteMeta = const VerificationMeta(
    'idCliente',
  );
  @override
  late final GeneratedColumn<int> idCliente = GeneratedColumn<int>(
    'id_cliente',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ciPersonaMeta = const VerificationMeta(
    'ciPersona',
  );
  @override
  late final GeneratedColumn<String> ciPersona = GeneratedColumn<String>(
    'ci_persona',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoCreditoMeta = const VerificationMeta(
    'estadoCredito',
  );
  @override
  late final GeneratedColumn<String> estadoCredito = GeneratedColumn<String>(
    'estado_credito',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('BUENO'),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idCliente,
    ciPersona,
    estadoCredito,
    estado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cliente';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cliente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_cliente')) {
      context.handle(
        _idClienteMeta,
        idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta),
      );
    }
    if (data.containsKey('ci_persona')) {
      context.handle(
        _ciPersonaMeta,
        ciPersona.isAcceptableOrUnknown(data['ci_persona']!, _ciPersonaMeta),
      );
    }
    if (data.containsKey('estado_credito')) {
      context.handle(
        _estadoCreditoMeta,
        estadoCredito.isAcceptableOrUnknown(
          data['estado_credito']!,
          _estadoCreditoMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idCliente};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      idCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cliente'],
      )!,
      ciPersona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ci_persona'],
      ),
      estadoCredito: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado_credito'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int idCliente;
  final String? ciPersona;
  final String estadoCredito;
  final bool estado;
  final DateTime createdAt;
  const Cliente({
    required this.idCliente,
    this.ciPersona,
    required this.estadoCredito,
    required this.estado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_cliente'] = Variable<int>(idCliente);
    if (!nullToAbsent || ciPersona != null) {
      map['ci_persona'] = Variable<String>(ciPersona);
    }
    map['estado_credito'] = Variable<String>(estadoCredito);
    map['estado'] = Variable<bool>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      idCliente: Value(idCliente),
      ciPersona: ciPersona == null && nullToAbsent
          ? const Value.absent()
          : Value(ciPersona),
      estadoCredito: Value(estadoCredito),
      estado: Value(estado),
      createdAt: Value(createdAt),
    );
  }

  factory Cliente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      idCliente: serializer.fromJson<int>(json['idCliente']),
      ciPersona: serializer.fromJson<String?>(json['ciPersona']),
      estadoCredito: serializer.fromJson<String>(json['estadoCredito']),
      estado: serializer.fromJson<bool>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idCliente': serializer.toJson<int>(idCliente),
      'ciPersona': serializer.toJson<String?>(ciPersona),
      'estadoCredito': serializer.toJson<String>(estadoCredito),
      'estado': serializer.toJson<bool>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Cliente copyWith({
    int? idCliente,
    Value<String?> ciPersona = const Value.absent(),
    String? estadoCredito,
    bool? estado,
    DateTime? createdAt,
  }) => Cliente(
    idCliente: idCliente ?? this.idCliente,
    ciPersona: ciPersona.present ? ciPersona.value : this.ciPersona,
    estadoCredito: estadoCredito ?? this.estadoCredito,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
  );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      idCliente: data.idCliente.present ? data.idCliente.value : this.idCliente,
      ciPersona: data.ciPersona.present ? data.ciPersona.value : this.ciPersona,
      estadoCredito: data.estadoCredito.present
          ? data.estadoCredito.value
          : this.estadoCredito,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('idCliente: $idCliente, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('estadoCredito: $estadoCredito, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idCliente, ciPersona, estadoCredito, estado, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.idCliente == this.idCliente &&
          other.ciPersona == this.ciPersona &&
          other.estadoCredito == this.estadoCredito &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> idCliente;
  final Value<String?> ciPersona;
  final Value<String> estadoCredito;
  final Value<bool> estado;
  final Value<DateTime> createdAt;
  const ClientesCompanion({
    this.idCliente = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.estadoCredito = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.idCliente = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.estadoCredito = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Cliente> custom({
    Expression<int>? idCliente,
    Expression<String>? ciPersona,
    Expression<String>? estadoCredito,
    Expression<bool>? estado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idCliente != null) 'id_cliente': idCliente,
      if (ciPersona != null) 'ci_persona': ciPersona,
      if (estadoCredito != null) 'estado_credito': estadoCredito,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ClientesCompanion copyWith({
    Value<int>? idCliente,
    Value<String?>? ciPersona,
    Value<String>? estadoCredito,
    Value<bool>? estado,
    Value<DateTime>? createdAt,
  }) {
    return ClientesCompanion(
      idCliente: idCliente ?? this.idCliente,
      ciPersona: ciPersona ?? this.ciPersona,
      estadoCredito: estadoCredito ?? this.estadoCredito,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idCliente.present) {
      map['id_cliente'] = Variable<int>(idCliente.value);
    }
    if (ciPersona.present) {
      map['ci_persona'] = Variable<String>(ciPersona.value);
    }
    if (estadoCredito.present) {
      map['estado_credito'] = Variable<String>(estadoCredito.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('idCliente: $idCliente, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('estadoCredito: $estadoCredito, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RolUsuariosTable extends RolUsuarios
    with TableInfo<$RolUsuariosTable, RolUsuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RolUsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idRolMeta = const VerificationMeta('idRol');
  @override
  late final GeneratedColumn<int> idRol = GeneratedColumn<int>(
    'id_rol',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [idRol, nombre, descripcion, activo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rol_usuario';
  @override
  VerificationContext validateIntegrity(
    Insertable<RolUsuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_rol')) {
      context.handle(
        _idRolMeta,
        idRol.isAcceptableOrUnknown(data['id_rol']!, _idRolMeta),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idRol};
  @override
  RolUsuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RolUsuario(
      idRol: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_rol'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $RolUsuariosTable createAlias(String alias) {
    return $RolUsuariosTable(attachedDatabase, alias);
  }
}

class RolUsuario extends DataClass implements Insertable<RolUsuario> {
  final int idRol;
  final String nombre;
  final String descripcion;
  final bool activo;
  const RolUsuario({
    required this.idRol,
    required this.nombre,
    required this.descripcion,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_rol'] = Variable<int>(idRol);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  RolUsuariosCompanion toCompanion(bool nullToAbsent) {
    return RolUsuariosCompanion(
      idRol: Value(idRol),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      activo: Value(activo),
    );
  }

  factory RolUsuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RolUsuario(
      idRol: serializer.fromJson<int>(json['idRol']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idRol': serializer.toJson<int>(idRol),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  RolUsuario copyWith({
    int? idRol,
    String? nombre,
    String? descripcion,
    bool? activo,
  }) => RolUsuario(
    idRol: idRol ?? this.idRol,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    activo: activo ?? this.activo,
  );
  RolUsuario copyWithCompanion(RolUsuariosCompanion data) {
    return RolUsuario(
      idRol: data.idRol.present ? data.idRol.value : this.idRol,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RolUsuario(')
          ..write('idRol: $idRol, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idRol, nombre, descripcion, activo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RolUsuario &&
          other.idRol == this.idRol &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.activo == this.activo);
}

class RolUsuariosCompanion extends UpdateCompanion<RolUsuario> {
  final Value<int> idRol;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<bool> activo;
  const RolUsuariosCompanion({
    this.idRol = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
  });
  RolUsuariosCompanion.insert({
    this.idRol = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<RolUsuario> custom({
    Expression<int>? idRol,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (idRol != null) 'id_rol': idRol,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (activo != null) 'activo': activo,
    });
  }

  RolUsuariosCompanion copyWith({
    Value<int>? idRol,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<bool>? activo,
  }) {
    return RolUsuariosCompanion(
      idRol: idRol ?? this.idRol,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idRol.present) {
      map['id_rol'] = Variable<int>(idRol.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RolUsuariosCompanion(')
          ..write('idRol: $idRol, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idUsuarioMeta = const VerificationMeta(
    'idUsuario',
  );
  @override
  late final GeneratedColumn<String> idUsuario = GeneratedColumn<String>(
    'id_usuario',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ciPersonaMeta = const VerificationMeta(
    'ciPersona',
  );
  @override
  late final GeneratedColumn<String> ciPersona = GeneratedColumn<String>(
    'ci_persona',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idRolMeta = const VerificationMeta('idRol');
  @override
  late final GeneratedColumn<int> idRol = GeneratedColumn<int>(
    'id_rol',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idUsuario,
    ciPersona,
    idRol,
    username,
    password,
    estado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_usuario')) {
      context.handle(
        _idUsuarioMeta,
        idUsuario.isAcceptableOrUnknown(data['id_usuario']!, _idUsuarioMeta),
      );
    } else if (isInserting) {
      context.missing(_idUsuarioMeta);
    }
    if (data.containsKey('ci_persona')) {
      context.handle(
        _ciPersonaMeta,
        ciPersona.isAcceptableOrUnknown(data['ci_persona']!, _ciPersonaMeta),
      );
    }
    if (data.containsKey('id_rol')) {
      context.handle(
        _idRolMeta,
        idRol.isAcceptableOrUnknown(data['id_rol']!, _idRolMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idUsuario};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      idUsuario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_usuario'],
      )!,
      ciPersona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ci_persona'],
      ),
      idRol: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_rol'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final String idUsuario;
  final String? ciPersona;
  final int? idRol;
  final String username;
  final String password;
  final bool estado;
  final DateTime createdAt;
  const Usuario({
    required this.idUsuario,
    this.ciPersona,
    this.idRol,
    required this.username,
    required this.password,
    required this.estado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_usuario'] = Variable<String>(idUsuario);
    if (!nullToAbsent || ciPersona != null) {
      map['ci_persona'] = Variable<String>(ciPersona);
    }
    if (!nullToAbsent || idRol != null) {
      map['id_rol'] = Variable<int>(idRol);
    }
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['estado'] = Variable<bool>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      idUsuario: Value(idUsuario),
      ciPersona: ciPersona == null && nullToAbsent
          ? const Value.absent()
          : Value(ciPersona),
      idRol: idRol == null && nullToAbsent
          ? const Value.absent()
          : Value(idRol),
      username: Value(username),
      password: Value(password),
      estado: Value(estado),
      createdAt: Value(createdAt),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      idUsuario: serializer.fromJson<String>(json['idUsuario']),
      ciPersona: serializer.fromJson<String?>(json['ciPersona']),
      idRol: serializer.fromJson<int?>(json['idRol']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      estado: serializer.fromJson<bool>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idUsuario': serializer.toJson<String>(idUsuario),
      'ciPersona': serializer.toJson<String?>(ciPersona),
      'idRol': serializer.toJson<int?>(idRol),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'estado': serializer.toJson<bool>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Usuario copyWith({
    String? idUsuario,
    Value<String?> ciPersona = const Value.absent(),
    Value<int?> idRol = const Value.absent(),
    String? username,
    String? password,
    bool? estado,
    DateTime? createdAt,
  }) => Usuario(
    idUsuario: idUsuario ?? this.idUsuario,
    ciPersona: ciPersona.present ? ciPersona.value : this.ciPersona,
    idRol: idRol.present ? idRol.value : this.idRol,
    username: username ?? this.username,
    password: password ?? this.password,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      idUsuario: data.idUsuario.present ? data.idUsuario.value : this.idUsuario,
      ciPersona: data.ciPersona.present ? data.ciPersona.value : this.ciPersona,
      idRol: data.idRol.present ? data.idRol.value : this.idRol,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('idUsuario: $idUsuario, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('idRol: $idRol, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idUsuario,
    ciPersona,
    idRol,
    username,
    password,
    estado,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.idUsuario == this.idUsuario &&
          other.ciPersona == this.ciPersona &&
          other.idRol == this.idRol &&
          other.username == this.username &&
          other.password == this.password &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<String> idUsuario;
  final Value<String?> ciPersona;
  final Value<int?> idRol;
  final Value<String> username;
  final Value<String> password;
  final Value<bool> estado;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsuariosCompanion({
    this.idUsuario = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.idRol = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosCompanion.insert({
    required String idUsuario,
    this.ciPersona = const Value.absent(),
    this.idRol = const Value.absent(),
    required String username,
    this.password = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idUsuario = Value(idUsuario),
       username = Value(username);
  static Insertable<Usuario> custom({
    Expression<String>? idUsuario,
    Expression<String>? ciPersona,
    Expression<int>? idRol,
    Expression<String>? username,
    Expression<String>? password,
    Expression<bool>? estado,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idUsuario != null) 'id_usuario': idUsuario,
      if (ciPersona != null) 'ci_persona': ciPersona,
      if (idRol != null) 'id_rol': idRol,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosCompanion copyWith({
    Value<String>? idUsuario,
    Value<String?>? ciPersona,
    Value<int?>? idRol,
    Value<String>? username,
    Value<String>? password,
    Value<bool>? estado,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsuariosCompanion(
      idUsuario: idUsuario ?? this.idUsuario,
      ciPersona: ciPersona ?? this.ciPersona,
      idRol: idRol ?? this.idRol,
      username: username ?? this.username,
      password: password ?? this.password,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idUsuario.present) {
      map['id_usuario'] = Variable<String>(idUsuario.value);
    }
    if (ciPersona.present) {
      map['ci_persona'] = Variable<String>(ciPersona.value);
    }
    if (idRol.present) {
      map['id_rol'] = Variable<int>(idRol.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('idUsuario: $idUsuario, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('idRol: $idRol, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonedasTable extends Monedas with TableInfo<$MonedasTable, Moneda> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonedasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMonedaMeta = const VerificationMeta(
    'idMoneda',
  );
  @override
  late final GeneratedColumn<int> idMoneda = GeneratedColumn<int>(
    'id_moneda',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [idMoneda, nombre, descripcion, activo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moneda';
  @override
  VerificationContext validateIntegrity(
    Insertable<Moneda> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_moneda')) {
      context.handle(
        _idMonedaMeta,
        idMoneda.isAcceptableOrUnknown(data['id_moneda']!, _idMonedaMeta),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idMoneda};
  @override
  Moneda map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Moneda(
      idMoneda: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_moneda'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
    );
  }

  @override
  $MonedasTable createAlias(String alias) {
    return $MonedasTable(attachedDatabase, alias);
  }
}

class Moneda extends DataClass implements Insertable<Moneda> {
  final int idMoneda;
  final String nombre;
  final String descripcion;
  final bool activo;
  const Moneda({
    required this.idMoneda,
    required this.nombre,
    required this.descripcion,
    required this.activo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_moneda'] = Variable<int>(idMoneda);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['activo'] = Variable<bool>(activo);
    return map;
  }

  MonedasCompanion toCompanion(bool nullToAbsent) {
    return MonedasCompanion(
      idMoneda: Value(idMoneda),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      activo: Value(activo),
    );
  }

  factory Moneda.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Moneda(
      idMoneda: serializer.fromJson<int>(json['idMoneda']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      activo: serializer.fromJson<bool>(json['activo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idMoneda': serializer.toJson<int>(idMoneda),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'activo': serializer.toJson<bool>(activo),
    };
  }

  Moneda copyWith({
    int? idMoneda,
    String? nombre,
    String? descripcion,
    bool? activo,
  }) => Moneda(
    idMoneda: idMoneda ?? this.idMoneda,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    activo: activo ?? this.activo,
  );
  Moneda copyWithCompanion(MonedasCompanion data) {
    return Moneda(
      idMoneda: data.idMoneda.present ? data.idMoneda.value : this.idMoneda,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      activo: data.activo.present ? data.activo.value : this.activo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Moneda(')
          ..write('idMoneda: $idMoneda, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idMoneda, nombre, descripcion, activo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Moneda &&
          other.idMoneda == this.idMoneda &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.activo == this.activo);
}

class MonedasCompanion extends UpdateCompanion<Moneda> {
  final Value<int> idMoneda;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<bool> activo;
  const MonedasCompanion({
    this.idMoneda = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
  });
  MonedasCompanion.insert({
    this.idMoneda = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Moneda> custom({
    Expression<int>? idMoneda,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<bool>? activo,
  }) {
    return RawValuesInsertable({
      if (idMoneda != null) 'id_moneda': idMoneda,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (activo != null) 'activo': activo,
    });
  }

  MonedasCompanion copyWith({
    Value<int>? idMoneda,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<bool>? activo,
  }) {
    return MonedasCompanion(
      idMoneda: idMoneda ?? this.idMoneda,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idMoneda.present) {
      map['id_moneda'] = Variable<int>(idMoneda.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonedasCompanion(')
          ..write('idMoneda: $idMoneda, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo')
          ..write(')'))
        .toString();
  }
}

class $ConfiguracionesTable extends Configuraciones
    with TableInfo<$ConfiguracionesTable, Configuracione> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfiguracionesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
    'clave',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
    'valor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [clave, valor, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuracion';
  @override
  VerificationContext validateIntegrity(
    Insertable<Configuracione> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
        _claveMeta,
        clave.isAcceptableOrUnknown(data['clave']!, _claveMeta),
      );
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  Configuracione map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Configuracione(
      clave: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clave'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConfiguracionesTable createAlias(String alias) {
    return $ConfiguracionesTable(attachedDatabase, alias);
  }
}

class Configuracione extends DataClass implements Insertable<Configuracione> {
  final String clave;
  final String? valor;
  final DateTime updatedAt;
  const Configuracione({
    required this.clave,
    this.valor,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    if (!nullToAbsent || valor != null) {
      map['valor'] = Variable<String>(valor);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConfiguracionesCompanion toCompanion(bool nullToAbsent) {
    return ConfiguracionesCompanion(
      clave: Value(clave),
      valor: valor == null && nullToAbsent
          ? const Value.absent()
          : Value(valor),
      updatedAt: Value(updatedAt),
    );
  }

  factory Configuracione.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Configuracione(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String?>(json['valor']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String?>(valor),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Configuracione copyWith({
    String? clave,
    Value<String?> valor = const Value.absent(),
    DateTime? updatedAt,
  }) => Configuracione(
    clave: clave ?? this.clave,
    valor: valor.present ? valor.value : this.valor,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Configuracione copyWithCompanion(ConfiguracionesCompanion data) {
    return Configuracione(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Configuracione(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Configuracione &&
          other.clave == this.clave &&
          other.valor == this.valor &&
          other.updatedAt == this.updatedAt);
}

class ConfiguracionesCompanion extends UpdateCompanion<Configuracione> {
  final Value<String> clave;
  final Value<String?> valor;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ConfiguracionesCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfiguracionesCompanion.insert({
    required String clave,
    this.valor = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clave = Value(clave);
  static Insertable<Configuracione> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfiguracionesCompanion copyWith({
    Value<String>? clave,
    Value<String?>? valor,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ConfiguracionesCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfiguracionesCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CobradoresTable extends Cobradores
    with TableInfo<$CobradoresTable, Cobradore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CobradoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idCobradorMeta = const VerificationMeta(
    'idCobrador',
  );
  @override
  late final GeneratedColumn<int> idCobrador = GeneratedColumn<int>(
    'id_cobrador',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ciPersonaMeta = const VerificationMeta(
    'ciPersona',
  );
  @override
  late final GeneratedColumn<String> ciPersona = GeneratedColumn<String>(
    'ci_persona',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _zonaMeta = const VerificationMeta('zona');
  @override
  late final GeneratedColumn<String> zona = GeneratedColumn<String>(
    'zona',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idCobrador,
    ciPersona,
    zona,
    estado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cobrador';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cobradore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_cobrador')) {
      context.handle(
        _idCobradorMeta,
        idCobrador.isAcceptableOrUnknown(data['id_cobrador']!, _idCobradorMeta),
      );
    }
    if (data.containsKey('ci_persona')) {
      context.handle(
        _ciPersonaMeta,
        ciPersona.isAcceptableOrUnknown(data['ci_persona']!, _ciPersonaMeta),
      );
    }
    if (data.containsKey('zona')) {
      context.handle(
        _zonaMeta,
        zona.isAcceptableOrUnknown(data['zona']!, _zonaMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idCobrador};
  @override
  Cobradore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cobradore(
      idCobrador: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cobrador'],
      )!,
      ciPersona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ci_persona'],
      ),
      zona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zona'],
      ),
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CobradoresTable createAlias(String alias) {
    return $CobradoresTable(attachedDatabase, alias);
  }
}

class Cobradore extends DataClass implements Insertable<Cobradore> {
  final int idCobrador;
  final String? ciPersona;
  final String? zona;
  final bool estado;
  final DateTime createdAt;
  const Cobradore({
    required this.idCobrador,
    this.ciPersona,
    this.zona,
    required this.estado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_cobrador'] = Variable<int>(idCobrador);
    if (!nullToAbsent || ciPersona != null) {
      map['ci_persona'] = Variable<String>(ciPersona);
    }
    if (!nullToAbsent || zona != null) {
      map['zona'] = Variable<String>(zona);
    }
    map['estado'] = Variable<bool>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CobradoresCompanion toCompanion(bool nullToAbsent) {
    return CobradoresCompanion(
      idCobrador: Value(idCobrador),
      ciPersona: ciPersona == null && nullToAbsent
          ? const Value.absent()
          : Value(ciPersona),
      zona: zona == null && nullToAbsent ? const Value.absent() : Value(zona),
      estado: Value(estado),
      createdAt: Value(createdAt),
    );
  }

  factory Cobradore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cobradore(
      idCobrador: serializer.fromJson<int>(json['idCobrador']),
      ciPersona: serializer.fromJson<String?>(json['ciPersona']),
      zona: serializer.fromJson<String?>(json['zona']),
      estado: serializer.fromJson<bool>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idCobrador': serializer.toJson<int>(idCobrador),
      'ciPersona': serializer.toJson<String?>(ciPersona),
      'zona': serializer.toJson<String?>(zona),
      'estado': serializer.toJson<bool>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Cobradore copyWith({
    int? idCobrador,
    Value<String?> ciPersona = const Value.absent(),
    Value<String?> zona = const Value.absent(),
    bool? estado,
    DateTime? createdAt,
  }) => Cobradore(
    idCobrador: idCobrador ?? this.idCobrador,
    ciPersona: ciPersona.present ? ciPersona.value : this.ciPersona,
    zona: zona.present ? zona.value : this.zona,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
  );
  Cobradore copyWithCompanion(CobradoresCompanion data) {
    return Cobradore(
      idCobrador: data.idCobrador.present
          ? data.idCobrador.value
          : this.idCobrador,
      ciPersona: data.ciPersona.present ? data.ciPersona.value : this.ciPersona,
      zona: data.zona.present ? data.zona.value : this.zona,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cobradore(')
          ..write('idCobrador: $idCobrador, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('zona: $zona, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idCobrador, ciPersona, zona, estado, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cobradore &&
          other.idCobrador == this.idCobrador &&
          other.ciPersona == this.ciPersona &&
          other.zona == this.zona &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt);
}

class CobradoresCompanion extends UpdateCompanion<Cobradore> {
  final Value<int> idCobrador;
  final Value<String?> ciPersona;
  final Value<String?> zona;
  final Value<bool> estado;
  final Value<DateTime> createdAt;
  const CobradoresCompanion({
    this.idCobrador = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.zona = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CobradoresCompanion.insert({
    this.idCobrador = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.zona = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Cobradore> custom({
    Expression<int>? idCobrador,
    Expression<String>? ciPersona,
    Expression<String>? zona,
    Expression<bool>? estado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idCobrador != null) 'id_cobrador': idCobrador,
      if (ciPersona != null) 'ci_persona': ciPersona,
      if (zona != null) 'zona': zona,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CobradoresCompanion copyWith({
    Value<int>? idCobrador,
    Value<String?>? ciPersona,
    Value<String?>? zona,
    Value<bool>? estado,
    Value<DateTime>? createdAt,
  }) {
    return CobradoresCompanion(
      idCobrador: idCobrador ?? this.idCobrador,
      ciPersona: ciPersona ?? this.ciPersona,
      zona: zona ?? this.zona,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idCobrador.present) {
      map['id_cobrador'] = Variable<int>(idCobrador.value);
    }
    if (ciPersona.present) {
      map['ci_persona'] = Variable<String>(ciPersona.value);
    }
    if (zona.present) {
      map['zona'] = Variable<String>(zona.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CobradoresCompanion(')
          ..write('idCobrador: $idCobrador, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('zona: $zona, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GarantesTable extends Garantes with TableInfo<$GarantesTable, Garante> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GarantesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idGaranteMeta = const VerificationMeta(
    'idGarante',
  );
  @override
  late final GeneratedColumn<int> idGarante = GeneratedColumn<int>(
    'id_garante',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ciPersonaMeta = const VerificationMeta(
    'ciPersona',
  );
  @override
  late final GeneratedColumn<String> ciPersona = GeneratedColumn<String>(
    'ci_persona',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingresoMensualMeta = const VerificationMeta(
    'ingresoMensual',
  );
  @override
  late final GeneratedColumn<double> ingresoMensual = GeneratedColumn<double>(
    'ingreso_mensual',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocupacionMeta = const VerificationMeta(
    'ocupacion',
  );
  @override
  late final GeneratedColumn<String> ocupacion = GeneratedColumn<String>(
    'ocupacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idGarante,
    ciPersona,
    ingresoMensual,
    ocupacion,
    estado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garante';
  @override
  VerificationContext validateIntegrity(
    Insertable<Garante> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_garante')) {
      context.handle(
        _idGaranteMeta,
        idGarante.isAcceptableOrUnknown(data['id_garante']!, _idGaranteMeta),
      );
    }
    if (data.containsKey('ci_persona')) {
      context.handle(
        _ciPersonaMeta,
        ciPersona.isAcceptableOrUnknown(data['ci_persona']!, _ciPersonaMeta),
      );
    }
    if (data.containsKey('ingreso_mensual')) {
      context.handle(
        _ingresoMensualMeta,
        ingresoMensual.isAcceptableOrUnknown(
          data['ingreso_mensual']!,
          _ingresoMensualMeta,
        ),
      );
    }
    if (data.containsKey('ocupacion')) {
      context.handle(
        _ocupacionMeta,
        ocupacion.isAcceptableOrUnknown(data['ocupacion']!, _ocupacionMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idGarante};
  @override
  Garante map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Garante(
      idGarante: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_garante'],
      )!,
      ciPersona: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ci_persona'],
      ),
      ingresoMensual: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ingreso_mensual'],
      ),
      ocupacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocupacion'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GarantesTable createAlias(String alias) {
    return $GarantesTable(attachedDatabase, alias);
  }
}

class Garante extends DataClass implements Insertable<Garante> {
  final int idGarante;
  final String? ciPersona;
  final double? ingresoMensual;
  final String ocupacion;
  final bool estado;
  final DateTime createdAt;
  const Garante({
    required this.idGarante,
    this.ciPersona,
    this.ingresoMensual,
    required this.ocupacion,
    required this.estado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_garante'] = Variable<int>(idGarante);
    if (!nullToAbsent || ciPersona != null) {
      map['ci_persona'] = Variable<String>(ciPersona);
    }
    if (!nullToAbsent || ingresoMensual != null) {
      map['ingreso_mensual'] = Variable<double>(ingresoMensual);
    }
    map['ocupacion'] = Variable<String>(ocupacion);
    map['estado'] = Variable<bool>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GarantesCompanion toCompanion(bool nullToAbsent) {
    return GarantesCompanion(
      idGarante: Value(idGarante),
      ciPersona: ciPersona == null && nullToAbsent
          ? const Value.absent()
          : Value(ciPersona),
      ingresoMensual: ingresoMensual == null && nullToAbsent
          ? const Value.absent()
          : Value(ingresoMensual),
      ocupacion: Value(ocupacion),
      estado: Value(estado),
      createdAt: Value(createdAt),
    );
  }

  factory Garante.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Garante(
      idGarante: serializer.fromJson<int>(json['idGarante']),
      ciPersona: serializer.fromJson<String?>(json['ciPersona']),
      ingresoMensual: serializer.fromJson<double?>(json['ingresoMensual']),
      ocupacion: serializer.fromJson<String>(json['ocupacion']),
      estado: serializer.fromJson<bool>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idGarante': serializer.toJson<int>(idGarante),
      'ciPersona': serializer.toJson<String?>(ciPersona),
      'ingresoMensual': serializer.toJson<double?>(ingresoMensual),
      'ocupacion': serializer.toJson<String>(ocupacion),
      'estado': serializer.toJson<bool>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Garante copyWith({
    int? idGarante,
    Value<String?> ciPersona = const Value.absent(),
    Value<double?> ingresoMensual = const Value.absent(),
    String? ocupacion,
    bool? estado,
    DateTime? createdAt,
  }) => Garante(
    idGarante: idGarante ?? this.idGarante,
    ciPersona: ciPersona.present ? ciPersona.value : this.ciPersona,
    ingresoMensual: ingresoMensual.present
        ? ingresoMensual.value
        : this.ingresoMensual,
    ocupacion: ocupacion ?? this.ocupacion,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
  );
  Garante copyWithCompanion(GarantesCompanion data) {
    return Garante(
      idGarante: data.idGarante.present ? data.idGarante.value : this.idGarante,
      ciPersona: data.ciPersona.present ? data.ciPersona.value : this.ciPersona,
      ingresoMensual: data.ingresoMensual.present
          ? data.ingresoMensual.value
          : this.ingresoMensual,
      ocupacion: data.ocupacion.present ? data.ocupacion.value : this.ocupacion,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Garante(')
          ..write('idGarante: $idGarante, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('ingresoMensual: $ingresoMensual, ')
          ..write('ocupacion: $ocupacion, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idGarante,
    ciPersona,
    ingresoMensual,
    ocupacion,
    estado,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Garante &&
          other.idGarante == this.idGarante &&
          other.ciPersona == this.ciPersona &&
          other.ingresoMensual == this.ingresoMensual &&
          other.ocupacion == this.ocupacion &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt);
}

class GarantesCompanion extends UpdateCompanion<Garante> {
  final Value<int> idGarante;
  final Value<String?> ciPersona;
  final Value<double?> ingresoMensual;
  final Value<String> ocupacion;
  final Value<bool> estado;
  final Value<DateTime> createdAt;
  const GarantesCompanion({
    this.idGarante = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.ingresoMensual = const Value.absent(),
    this.ocupacion = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GarantesCompanion.insert({
    this.idGarante = const Value.absent(),
    this.ciPersona = const Value.absent(),
    this.ingresoMensual = const Value.absent(),
    this.ocupacion = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Garante> custom({
    Expression<int>? idGarante,
    Expression<String>? ciPersona,
    Expression<double>? ingresoMensual,
    Expression<String>? ocupacion,
    Expression<bool>? estado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idGarante != null) 'id_garante': idGarante,
      if (ciPersona != null) 'ci_persona': ciPersona,
      if (ingresoMensual != null) 'ingreso_mensual': ingresoMensual,
      if (ocupacion != null) 'ocupacion': ocupacion,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GarantesCompanion copyWith({
    Value<int>? idGarante,
    Value<String?>? ciPersona,
    Value<double?>? ingresoMensual,
    Value<String>? ocupacion,
    Value<bool>? estado,
    Value<DateTime>? createdAt,
  }) {
    return GarantesCompanion(
      idGarante: idGarante ?? this.idGarante,
      ciPersona: ciPersona ?? this.ciPersona,
      ingresoMensual: ingresoMensual ?? this.ingresoMensual,
      ocupacion: ocupacion ?? this.ocupacion,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idGarante.present) {
      map['id_garante'] = Variable<int>(idGarante.value);
    }
    if (ciPersona.present) {
      map['ci_persona'] = Variable<String>(ciPersona.value);
    }
    if (ingresoMensual.present) {
      map['ingreso_mensual'] = Variable<double>(ingresoMensual.value);
    }
    if (ocupacion.present) {
      map['ocupacion'] = Variable<String>(ocupacion.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GarantesCompanion(')
          ..write('idGarante: $idGarante, ')
          ..write('ciPersona: $ciPersona, ')
          ..write('ingresoMensual: $ingresoMensual, ')
          ..write('ocupacion: $ocupacion, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $GarantiasTable extends Garantias
    with TableInfo<$GarantiasTable, Garantia> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GarantiasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idGarantiaMeta = const VerificationMeta(
    'idGarantia',
  );
  @override
  late final GeneratedColumn<int> idGarantia = GeneratedColumn<int>(
    'id_garantia',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fotografiaMeta = const VerificationMeta(
    'fotografia',
  );
  @override
  late final GeneratedColumn<String> fotografia = GeneratedColumn<String>(
    'fotografia',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urlReferenciaMeta = const VerificationMeta(
    'urlReferencia',
  );
  @override
  late final GeneratedColumn<String> urlReferencia = GeneratedColumn<String>(
    'url_referencia',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valorEstimadoMeta = const VerificationMeta(
    'valorEstimado',
  );
  @override
  late final GeneratedColumn<double> valorEstimado = GeneratedColumn<double>(
    'valor_estimado',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idGarantia,
    descripcion,
    fotografia,
    urlReferencia,
    valorEstimado,
    estado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'garantia';
  @override
  VerificationContext validateIntegrity(
    Insertable<Garantia> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_garantia')) {
      context.handle(
        _idGarantiaMeta,
        idGarantia.isAcceptableOrUnknown(data['id_garantia']!, _idGarantiaMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('fotografia')) {
      context.handle(
        _fotografiaMeta,
        fotografia.isAcceptableOrUnknown(data['fotografia']!, _fotografiaMeta),
      );
    }
    if (data.containsKey('url_referencia')) {
      context.handle(
        _urlReferenciaMeta,
        urlReferencia.isAcceptableOrUnknown(
          data['url_referencia']!,
          _urlReferenciaMeta,
        ),
      );
    }
    if (data.containsKey('valor_estimado')) {
      context.handle(
        _valorEstimadoMeta,
        valorEstimado.isAcceptableOrUnknown(
          data['valor_estimado']!,
          _valorEstimadoMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idGarantia};
  @override
  Garantia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Garantia(
      idGarantia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_garantia'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      fotografia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fotografia'],
      ),
      urlReferencia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url_referencia'],
      ),
      valorEstimado: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valor_estimado'],
      ),
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GarantiasTable createAlias(String alias) {
    return $GarantiasTable(attachedDatabase, alias);
  }
}

class Garantia extends DataClass implements Insertable<Garantia> {
  final int idGarantia;
  final String? descripcion;
  final String? fotografia;
  final String? urlReferencia;
  final double? valorEstimado;
  final bool estado;
  final DateTime createdAt;
  const Garantia({
    required this.idGarantia,
    this.descripcion,
    this.fotografia,
    this.urlReferencia,
    this.valorEstimado,
    required this.estado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_garantia'] = Variable<int>(idGarantia);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || fotografia != null) {
      map['fotografia'] = Variable<String>(fotografia);
    }
    if (!nullToAbsent || urlReferencia != null) {
      map['url_referencia'] = Variable<String>(urlReferencia);
    }
    if (!nullToAbsent || valorEstimado != null) {
      map['valor_estimado'] = Variable<double>(valorEstimado);
    }
    map['estado'] = Variable<bool>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GarantiasCompanion toCompanion(bool nullToAbsent) {
    return GarantiasCompanion(
      idGarantia: Value(idGarantia),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      fotografia: fotografia == null && nullToAbsent
          ? const Value.absent()
          : Value(fotografia),
      urlReferencia: urlReferencia == null && nullToAbsent
          ? const Value.absent()
          : Value(urlReferencia),
      valorEstimado: valorEstimado == null && nullToAbsent
          ? const Value.absent()
          : Value(valorEstimado),
      estado: Value(estado),
      createdAt: Value(createdAt),
    );
  }

  factory Garantia.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Garantia(
      idGarantia: serializer.fromJson<int>(json['idGarantia']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      fotografia: serializer.fromJson<String?>(json['fotografia']),
      urlReferencia: serializer.fromJson<String?>(json['urlReferencia']),
      valorEstimado: serializer.fromJson<double?>(json['valorEstimado']),
      estado: serializer.fromJson<bool>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idGarantia': serializer.toJson<int>(idGarantia),
      'descripcion': serializer.toJson<String?>(descripcion),
      'fotografia': serializer.toJson<String?>(fotografia),
      'urlReferencia': serializer.toJson<String?>(urlReferencia),
      'valorEstimado': serializer.toJson<double?>(valorEstimado),
      'estado': serializer.toJson<bool>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Garantia copyWith({
    int? idGarantia,
    Value<String?> descripcion = const Value.absent(),
    Value<String?> fotografia = const Value.absent(),
    Value<String?> urlReferencia = const Value.absent(),
    Value<double?> valorEstimado = const Value.absent(),
    bool? estado,
    DateTime? createdAt,
  }) => Garantia(
    idGarantia: idGarantia ?? this.idGarantia,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    fotografia: fotografia.present ? fotografia.value : this.fotografia,
    urlReferencia: urlReferencia.present
        ? urlReferencia.value
        : this.urlReferencia,
    valorEstimado: valorEstimado.present
        ? valorEstimado.value
        : this.valorEstimado,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
  );
  Garantia copyWithCompanion(GarantiasCompanion data) {
    return Garantia(
      idGarantia: data.idGarantia.present
          ? data.idGarantia.value
          : this.idGarantia,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      fotografia: data.fotografia.present
          ? data.fotografia.value
          : this.fotografia,
      urlReferencia: data.urlReferencia.present
          ? data.urlReferencia.value
          : this.urlReferencia,
      valorEstimado: data.valorEstimado.present
          ? data.valorEstimado.value
          : this.valorEstimado,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Garantia(')
          ..write('idGarantia: $idGarantia, ')
          ..write('descripcion: $descripcion, ')
          ..write('fotografia: $fotografia, ')
          ..write('urlReferencia: $urlReferencia, ')
          ..write('valorEstimado: $valorEstimado, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idGarantia,
    descripcion,
    fotografia,
    urlReferencia,
    valorEstimado,
    estado,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Garantia &&
          other.idGarantia == this.idGarantia &&
          other.descripcion == this.descripcion &&
          other.fotografia == this.fotografia &&
          other.urlReferencia == this.urlReferencia &&
          other.valorEstimado == this.valorEstimado &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt);
}

class GarantiasCompanion extends UpdateCompanion<Garantia> {
  final Value<int> idGarantia;
  final Value<String?> descripcion;
  final Value<String?> fotografia;
  final Value<String?> urlReferencia;
  final Value<double?> valorEstimado;
  final Value<bool> estado;
  final Value<DateTime> createdAt;
  const GarantiasCompanion({
    this.idGarantia = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fotografia = const Value.absent(),
    this.urlReferencia = const Value.absent(),
    this.valorEstimado = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GarantiasCompanion.insert({
    this.idGarantia = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fotografia = const Value.absent(),
    this.urlReferencia = const Value.absent(),
    this.valorEstimado = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Garantia> custom({
    Expression<int>? idGarantia,
    Expression<String>? descripcion,
    Expression<String>? fotografia,
    Expression<String>? urlReferencia,
    Expression<double>? valorEstimado,
    Expression<bool>? estado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idGarantia != null) 'id_garantia': idGarantia,
      if (descripcion != null) 'descripcion': descripcion,
      if (fotografia != null) 'fotografia': fotografia,
      if (urlReferencia != null) 'url_referencia': urlReferencia,
      if (valorEstimado != null) 'valor_estimado': valorEstimado,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GarantiasCompanion copyWith({
    Value<int>? idGarantia,
    Value<String?>? descripcion,
    Value<String?>? fotografia,
    Value<String?>? urlReferencia,
    Value<double?>? valorEstimado,
    Value<bool>? estado,
    Value<DateTime>? createdAt,
  }) {
    return GarantiasCompanion(
      idGarantia: idGarantia ?? this.idGarantia,
      descripcion: descripcion ?? this.descripcion,
      fotografia: fotografia ?? this.fotografia,
      urlReferencia: urlReferencia ?? this.urlReferencia,
      valorEstimado: valorEstimado ?? this.valorEstimado,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idGarantia.present) {
      map['id_garantia'] = Variable<int>(idGarantia.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fotografia.present) {
      map['fotografia'] = Variable<String>(fotografia.value);
    }
    if (urlReferencia.present) {
      map['url_referencia'] = Variable<String>(urlReferencia.value);
    }
    if (valorEstimado.present) {
      map['valor_estimado'] = Variable<double>(valorEstimado.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GarantiasCompanion(')
          ..write('idGarantia: $idGarantia, ')
          ..write('descripcion: $descripcion, ')
          ..write('fotografia: $fotografia, ')
          ..write('urlReferencia: $urlReferencia, ')
          ..write('valorEstimado: $valorEstimado, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TipoPrestamosTable extends TipoPrestamos
    with TableInfo<$TipoPrestamosTable, TipoPrestamo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TipoPrestamosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idTipoMeta = const VerificationMeta('idTipo');
  @override
  late final GeneratedColumn<int> idTipo = GeneratedColumn<int>(
    'id_tipo',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _visibleClienteMeta = const VerificationMeta(
    'visibleCliente',
  );
  @override
  late final GeneratedColumn<bool> visibleCliente = GeneratedColumn<bool>(
    'visible_cliente',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("visible_cliente" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    idTipo,
    nombre,
    descripcion,
    activo,
    visibleCliente,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tipo_prestamo';
  @override
  VerificationContext validateIntegrity(
    Insertable<TipoPrestamo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_tipo')) {
      context.handle(
        _idTipoMeta,
        idTipo.isAcceptableOrUnknown(data['id_tipo']!, _idTipoMeta),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('visible_cliente')) {
      context.handle(
        _visibleClienteMeta,
        visibleCliente.isAcceptableOrUnknown(
          data['visible_cliente']!,
          _visibleClienteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idTipo};
  @override
  TipoPrestamo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TipoPrestamo(
      idTipo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_tipo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      visibleCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}visible_cliente'],
      )!,
    );
  }

  @override
  $TipoPrestamosTable createAlias(String alias) {
    return $TipoPrestamosTable(attachedDatabase, alias);
  }
}

class TipoPrestamo extends DataClass implements Insertable<TipoPrestamo> {
  final int idTipo;
  final String nombre;
  final String descripcion;
  final bool activo;
  final bool visibleCliente;
  const TipoPrestamo({
    required this.idTipo,
    required this.nombre,
    required this.descripcion,
    required this.activo,
    required this.visibleCliente,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_tipo'] = Variable<int>(idTipo);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['activo'] = Variable<bool>(activo);
    map['visible_cliente'] = Variable<bool>(visibleCliente);
    return map;
  }

  TipoPrestamosCompanion toCompanion(bool nullToAbsent) {
    return TipoPrestamosCompanion(
      idTipo: Value(idTipo),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      activo: Value(activo),
      visibleCliente: Value(visibleCliente),
    );
  }

  factory TipoPrestamo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TipoPrestamo(
      idTipo: serializer.fromJson<int>(json['idTipo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      activo: serializer.fromJson<bool>(json['activo']),
      visibleCliente: serializer.fromJson<bool>(json['visibleCliente']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idTipo': serializer.toJson<int>(idTipo),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'activo': serializer.toJson<bool>(activo),
      'visibleCliente': serializer.toJson<bool>(visibleCliente),
    };
  }

  TipoPrestamo copyWith({
    int? idTipo,
    String? nombre,
    String? descripcion,
    bool? activo,
    bool? visibleCliente,
  }) => TipoPrestamo(
    idTipo: idTipo ?? this.idTipo,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    activo: activo ?? this.activo,
    visibleCliente: visibleCliente ?? this.visibleCliente,
  );
  TipoPrestamo copyWithCompanion(TipoPrestamosCompanion data) {
    return TipoPrestamo(
      idTipo: data.idTipo.present ? data.idTipo.value : this.idTipo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      activo: data.activo.present ? data.activo.value : this.activo,
      visibleCliente: data.visibleCliente.present
          ? data.visibleCliente.value
          : this.visibleCliente,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TipoPrestamo(')
          ..write('idTipo: $idTipo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo, ')
          ..write('visibleCliente: $visibleCliente')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idTipo, nombre, descripcion, activo, visibleCliente);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TipoPrestamo &&
          other.idTipo == this.idTipo &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.activo == this.activo &&
          other.visibleCliente == this.visibleCliente);
}

class TipoPrestamosCompanion extends UpdateCompanion<TipoPrestamo> {
  final Value<int> idTipo;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<bool> activo;
  final Value<bool> visibleCliente;
  const TipoPrestamosCompanion({
    this.idTipo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
    this.visibleCliente = const Value.absent(),
  });
  TipoPrestamosCompanion.insert({
    this.idTipo = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
    this.visibleCliente = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<TipoPrestamo> custom({
    Expression<int>? idTipo,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<bool>? activo,
    Expression<bool>? visibleCliente,
  }) {
    return RawValuesInsertable({
      if (idTipo != null) 'id_tipo': idTipo,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (activo != null) 'activo': activo,
      if (visibleCliente != null) 'visible_cliente': visibleCliente,
    });
  }

  TipoPrestamosCompanion copyWith({
    Value<int>? idTipo,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<bool>? activo,
    Value<bool>? visibleCliente,
  }) {
    return TipoPrestamosCompanion(
      idTipo: idTipo ?? this.idTipo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
      visibleCliente: visibleCliente ?? this.visibleCliente,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idTipo.present) {
      map['id_tipo'] = Variable<int>(idTipo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (visibleCliente.present) {
      map['visible_cliente'] = Variable<bool>(visibleCliente.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TipoPrestamosCompanion(')
          ..write('idTipo: $idTipo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo, ')
          ..write('visibleCliente: $visibleCliente')
          ..write(')'))
        .toString();
  }
}

class $EstadoPrestamosTable extends EstadoPrestamos
    with TableInfo<$EstadoPrestamosTable, EstadoPrestamo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstadoPrestamosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idEstadoMeta = const VerificationMeta(
    'idEstado',
  );
  @override
  late final GeneratedColumn<int> idEstado = GeneratedColumn<int>(
    'id_estado',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _visibleClienteMeta = const VerificationMeta(
    'visibleCliente',
  );
  @override
  late final GeneratedColumn<bool> visibleCliente = GeneratedColumn<bool>(
    'visible_cliente',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("visible_cliente" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    idEstado,
    nombre,
    descripcion,
    activo,
    visibleCliente,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'estado_prestamo';
  @override
  VerificationContext validateIntegrity(
    Insertable<EstadoPrestamo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_estado')) {
      context.handle(
        _idEstadoMeta,
        idEstado.isAcceptableOrUnknown(data['id_estado']!, _idEstadoMeta),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('visible_cliente')) {
      context.handle(
        _visibleClienteMeta,
        visibleCliente.isAcceptableOrUnknown(
          data['visible_cliente']!,
          _visibleClienteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idEstado};
  @override
  EstadoPrestamo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EstadoPrestamo(
      idEstado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_estado'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      visibleCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}visible_cliente'],
      )!,
    );
  }

  @override
  $EstadoPrestamosTable createAlias(String alias) {
    return $EstadoPrestamosTable(attachedDatabase, alias);
  }
}

class EstadoPrestamo extends DataClass implements Insertable<EstadoPrestamo> {
  final int idEstado;
  final String nombre;
  final String descripcion;
  final bool activo;
  final bool visibleCliente;
  const EstadoPrestamo({
    required this.idEstado,
    required this.nombre,
    required this.descripcion,
    required this.activo,
    required this.visibleCliente,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_estado'] = Variable<int>(idEstado);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['activo'] = Variable<bool>(activo);
    map['visible_cliente'] = Variable<bool>(visibleCliente);
    return map;
  }

  EstadoPrestamosCompanion toCompanion(bool nullToAbsent) {
    return EstadoPrestamosCompanion(
      idEstado: Value(idEstado),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      activo: Value(activo),
      visibleCliente: Value(visibleCliente),
    );
  }

  factory EstadoPrestamo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstadoPrestamo(
      idEstado: serializer.fromJson<int>(json['idEstado']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      activo: serializer.fromJson<bool>(json['activo']),
      visibleCliente: serializer.fromJson<bool>(json['visibleCliente']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idEstado': serializer.toJson<int>(idEstado),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'activo': serializer.toJson<bool>(activo),
      'visibleCliente': serializer.toJson<bool>(visibleCliente),
    };
  }

  EstadoPrestamo copyWith({
    int? idEstado,
    String? nombre,
    String? descripcion,
    bool? activo,
    bool? visibleCliente,
  }) => EstadoPrestamo(
    idEstado: idEstado ?? this.idEstado,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    activo: activo ?? this.activo,
    visibleCliente: visibleCliente ?? this.visibleCliente,
  );
  EstadoPrestamo copyWithCompanion(EstadoPrestamosCompanion data) {
    return EstadoPrestamo(
      idEstado: data.idEstado.present ? data.idEstado.value : this.idEstado,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      activo: data.activo.present ? data.activo.value : this.activo,
      visibleCliente: data.visibleCliente.present
          ? data.visibleCliente.value
          : this.visibleCliente,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EstadoPrestamo(')
          ..write('idEstado: $idEstado, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo, ')
          ..write('visibleCliente: $visibleCliente')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idEstado, nombre, descripcion, activo, visibleCliente);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstadoPrestamo &&
          other.idEstado == this.idEstado &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.activo == this.activo &&
          other.visibleCliente == this.visibleCliente);
}

class EstadoPrestamosCompanion extends UpdateCompanion<EstadoPrestamo> {
  final Value<int> idEstado;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<bool> activo;
  final Value<bool> visibleCliente;
  const EstadoPrestamosCompanion({
    this.idEstado = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
    this.visibleCliente = const Value.absent(),
  });
  EstadoPrestamosCompanion.insert({
    this.idEstado = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
    this.visibleCliente = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<EstadoPrestamo> custom({
    Expression<int>? idEstado,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<bool>? activo,
    Expression<bool>? visibleCliente,
  }) {
    return RawValuesInsertable({
      if (idEstado != null) 'id_estado': idEstado,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (activo != null) 'activo': activo,
      if (visibleCliente != null) 'visible_cliente': visibleCliente,
    });
  }

  EstadoPrestamosCompanion copyWith({
    Value<int>? idEstado,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<bool>? activo,
    Value<bool>? visibleCliente,
  }) {
    return EstadoPrestamosCompanion(
      idEstado: idEstado ?? this.idEstado,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
      visibleCliente: visibleCliente ?? this.visibleCliente,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idEstado.present) {
      map['id_estado'] = Variable<int>(idEstado.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (visibleCliente.present) {
      map['visible_cliente'] = Variable<bool>(visibleCliente.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstadoPrestamosCompanion(')
          ..write('idEstado: $idEstado, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo, ')
          ..write('visibleCliente: $visibleCliente')
          ..write(')'))
        .toString();
  }
}

class $PrestamosTable extends Prestamos
    with TableInfo<$PrestamosTable, Prestamo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrestamosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idPrestamoMeta = const VerificationMeta(
    'idPrestamo',
  );
  @override
  late final GeneratedColumn<int> idPrestamo = GeneratedColumn<int>(
    'id_prestamo',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idClienteMeta = const VerificationMeta(
    'idCliente',
  );
  @override
  late final GeneratedColumn<int> idCliente = GeneratedColumn<int>(
    'id_cliente',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idCobradorMeta = const VerificationMeta(
    'idCobrador',
  );
  @override
  late final GeneratedColumn<int> idCobrador = GeneratedColumn<int>(
    'id_cobrador',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idTipoMeta = const VerificationMeta('idTipo');
  @override
  late final GeneratedColumn<int> idTipo = GeneratedColumn<int>(
    'id_tipo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idEstadoMeta = const VerificationMeta(
    'idEstado',
  );
  @override
  late final GeneratedColumn<int> idEstado = GeneratedColumn<int>(
    'id_estado',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idGarantiaMeta = const VerificationMeta(
    'idGarantia',
  );
  @override
  late final GeneratedColumn<int> idGarantia = GeneratedColumn<int>(
    'id_garantia',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prestamoOrigenMeta = const VerificationMeta(
    'prestamoOrigen',
  );
  @override
  late final GeneratedColumn<int> prestamoOrigen = GeneratedColumn<int>(
    'prestamo_origen',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _esRefinanciamientoMeta =
      const VerificationMeta('esRefinanciamiento');
  @override
  late final GeneratedColumn<bool> esRefinanciamiento = GeneratedColumn<bool>(
    'es_refinanciamiento',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("es_refinanciamiento" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interesMeta = const VerificationMeta(
    'interes',
  );
  @override
  late final GeneratedColumn<double> interes = GeneratedColumn<double>(
    'interes',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaInicioMeta = const VerificationMeta(
    'fechaInicio',
  );
  @override
  late final GeneratedColumn<DateTime> fechaInicio = GeneratedColumn<DateTime>(
    'fecha_inicio',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaFinMeta = const VerificationMeta(
    'fechaFin',
  );
  @override
  late final GeneratedColumn<DateTime> fechaFin = GeneratedColumn<DateTime>(
    'fecha_fin',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idPrestamo,
    idCliente,
    idCobrador,
    idTipo,
    idEstado,
    idGarantia,
    prestamoOrigen,
    esRefinanciamiento,
    monto,
    interes,
    fechaInicio,
    fechaFin,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prestamo';
  @override
  VerificationContext validateIntegrity(
    Insertable<Prestamo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_prestamo')) {
      context.handle(
        _idPrestamoMeta,
        idPrestamo.isAcceptableOrUnknown(data['id_prestamo']!, _idPrestamoMeta),
      );
    }
    if (data.containsKey('id_cliente')) {
      context.handle(
        _idClienteMeta,
        idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta),
      );
    }
    if (data.containsKey('id_cobrador')) {
      context.handle(
        _idCobradorMeta,
        idCobrador.isAcceptableOrUnknown(data['id_cobrador']!, _idCobradorMeta),
      );
    }
    if (data.containsKey('id_tipo')) {
      context.handle(
        _idTipoMeta,
        idTipo.isAcceptableOrUnknown(data['id_tipo']!, _idTipoMeta),
      );
    }
    if (data.containsKey('id_estado')) {
      context.handle(
        _idEstadoMeta,
        idEstado.isAcceptableOrUnknown(data['id_estado']!, _idEstadoMeta),
      );
    }
    if (data.containsKey('id_garantia')) {
      context.handle(
        _idGarantiaMeta,
        idGarantia.isAcceptableOrUnknown(data['id_garantia']!, _idGarantiaMeta),
      );
    }
    if (data.containsKey('prestamo_origen')) {
      context.handle(
        _prestamoOrigenMeta,
        prestamoOrigen.isAcceptableOrUnknown(
          data['prestamo_origen']!,
          _prestamoOrigenMeta,
        ),
      );
    }
    if (data.containsKey('es_refinanciamiento')) {
      context.handle(
        _esRefinanciamientoMeta,
        esRefinanciamiento.isAcceptableOrUnknown(
          data['es_refinanciamiento']!,
          _esRefinanciamientoMeta,
        ),
      );
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('interes')) {
      context.handle(
        _interesMeta,
        interes.isAcceptableOrUnknown(data['interes']!, _interesMeta),
      );
    } else if (isInserting) {
      context.missing(_interesMeta);
    }
    if (data.containsKey('fecha_inicio')) {
      context.handle(
        _fechaInicioMeta,
        fechaInicio.isAcceptableOrUnknown(
          data['fecha_inicio']!,
          _fechaInicioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaInicioMeta);
    }
    if (data.containsKey('fecha_fin')) {
      context.handle(
        _fechaFinMeta,
        fechaFin.isAcceptableOrUnknown(data['fecha_fin']!, _fechaFinMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idPrestamo};
  @override
  Prestamo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prestamo(
      idPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_prestamo'],
      )!,
      idCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cliente'],
      ),
      idCobrador: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cobrador'],
      ),
      idTipo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_tipo'],
      ),
      idEstado: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_estado'],
      ),
      idGarantia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_garantia'],
      ),
      prestamoOrigen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prestamo_origen'],
      ),
      esRefinanciamiento: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}es_refinanciamiento'],
      )!,
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      )!,
      interes: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interes'],
      )!,
      fechaInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_inicio'],
      )!,
      fechaFin: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_fin'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PrestamosTable createAlias(String alias) {
    return $PrestamosTable(attachedDatabase, alias);
  }
}

class Prestamo extends DataClass implements Insertable<Prestamo> {
  final int idPrestamo;
  final int? idCliente;
  final int? idCobrador;
  final int? idTipo;
  final int? idEstado;
  final int? idGarantia;
  final int? prestamoOrigen;
  final bool esRefinanciamiento;
  final double monto;
  final double interes;
  final DateTime fechaInicio;
  final DateTime? fechaFin;
  final DateTime createdAt;
  const Prestamo({
    required this.idPrestamo,
    this.idCliente,
    this.idCobrador,
    this.idTipo,
    this.idEstado,
    this.idGarantia,
    this.prestamoOrigen,
    required this.esRefinanciamiento,
    required this.monto,
    required this.interes,
    required this.fechaInicio,
    this.fechaFin,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_prestamo'] = Variable<int>(idPrestamo);
    if (!nullToAbsent || idCliente != null) {
      map['id_cliente'] = Variable<int>(idCliente);
    }
    if (!nullToAbsent || idCobrador != null) {
      map['id_cobrador'] = Variable<int>(idCobrador);
    }
    if (!nullToAbsent || idTipo != null) {
      map['id_tipo'] = Variable<int>(idTipo);
    }
    if (!nullToAbsent || idEstado != null) {
      map['id_estado'] = Variable<int>(idEstado);
    }
    if (!nullToAbsent || idGarantia != null) {
      map['id_garantia'] = Variable<int>(idGarantia);
    }
    if (!nullToAbsent || prestamoOrigen != null) {
      map['prestamo_origen'] = Variable<int>(prestamoOrigen);
    }
    map['es_refinanciamiento'] = Variable<bool>(esRefinanciamiento);
    map['monto'] = Variable<double>(monto);
    map['interes'] = Variable<double>(interes);
    map['fecha_inicio'] = Variable<DateTime>(fechaInicio);
    if (!nullToAbsent || fechaFin != null) {
      map['fecha_fin'] = Variable<DateTime>(fechaFin);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PrestamosCompanion toCompanion(bool nullToAbsent) {
    return PrestamosCompanion(
      idPrestamo: Value(idPrestamo),
      idCliente: idCliente == null && nullToAbsent
          ? const Value.absent()
          : Value(idCliente),
      idCobrador: idCobrador == null && nullToAbsent
          ? const Value.absent()
          : Value(idCobrador),
      idTipo: idTipo == null && nullToAbsent
          ? const Value.absent()
          : Value(idTipo),
      idEstado: idEstado == null && nullToAbsent
          ? const Value.absent()
          : Value(idEstado),
      idGarantia: idGarantia == null && nullToAbsent
          ? const Value.absent()
          : Value(idGarantia),
      prestamoOrigen: prestamoOrigen == null && nullToAbsent
          ? const Value.absent()
          : Value(prestamoOrigen),
      esRefinanciamiento: Value(esRefinanciamiento),
      monto: Value(monto),
      interes: Value(interes),
      fechaInicio: Value(fechaInicio),
      fechaFin: fechaFin == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaFin),
      createdAt: Value(createdAt),
    );
  }

  factory Prestamo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prestamo(
      idPrestamo: serializer.fromJson<int>(json['idPrestamo']),
      idCliente: serializer.fromJson<int?>(json['idCliente']),
      idCobrador: serializer.fromJson<int?>(json['idCobrador']),
      idTipo: serializer.fromJson<int?>(json['idTipo']),
      idEstado: serializer.fromJson<int?>(json['idEstado']),
      idGarantia: serializer.fromJson<int?>(json['idGarantia']),
      prestamoOrigen: serializer.fromJson<int?>(json['prestamoOrigen']),
      esRefinanciamiento: serializer.fromJson<bool>(json['esRefinanciamiento']),
      monto: serializer.fromJson<double>(json['monto']),
      interes: serializer.fromJson<double>(json['interes']),
      fechaInicio: serializer.fromJson<DateTime>(json['fechaInicio']),
      fechaFin: serializer.fromJson<DateTime?>(json['fechaFin']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idPrestamo': serializer.toJson<int>(idPrestamo),
      'idCliente': serializer.toJson<int?>(idCliente),
      'idCobrador': serializer.toJson<int?>(idCobrador),
      'idTipo': serializer.toJson<int?>(idTipo),
      'idEstado': serializer.toJson<int?>(idEstado),
      'idGarantia': serializer.toJson<int?>(idGarantia),
      'prestamoOrigen': serializer.toJson<int?>(prestamoOrigen),
      'esRefinanciamiento': serializer.toJson<bool>(esRefinanciamiento),
      'monto': serializer.toJson<double>(monto),
      'interes': serializer.toJson<double>(interes),
      'fechaInicio': serializer.toJson<DateTime>(fechaInicio),
      'fechaFin': serializer.toJson<DateTime?>(fechaFin),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Prestamo copyWith({
    int? idPrestamo,
    Value<int?> idCliente = const Value.absent(),
    Value<int?> idCobrador = const Value.absent(),
    Value<int?> idTipo = const Value.absent(),
    Value<int?> idEstado = const Value.absent(),
    Value<int?> idGarantia = const Value.absent(),
    Value<int?> prestamoOrigen = const Value.absent(),
    bool? esRefinanciamiento,
    double? monto,
    double? interes,
    DateTime? fechaInicio,
    Value<DateTime?> fechaFin = const Value.absent(),
    DateTime? createdAt,
  }) => Prestamo(
    idPrestamo: idPrestamo ?? this.idPrestamo,
    idCliente: idCliente.present ? idCliente.value : this.idCliente,
    idCobrador: idCobrador.present ? idCobrador.value : this.idCobrador,
    idTipo: idTipo.present ? idTipo.value : this.idTipo,
    idEstado: idEstado.present ? idEstado.value : this.idEstado,
    idGarantia: idGarantia.present ? idGarantia.value : this.idGarantia,
    prestamoOrigen: prestamoOrigen.present
        ? prestamoOrigen.value
        : this.prestamoOrigen,
    esRefinanciamiento: esRefinanciamiento ?? this.esRefinanciamiento,
    monto: monto ?? this.monto,
    interes: interes ?? this.interes,
    fechaInicio: fechaInicio ?? this.fechaInicio,
    fechaFin: fechaFin.present ? fechaFin.value : this.fechaFin,
    createdAt: createdAt ?? this.createdAt,
  );
  Prestamo copyWithCompanion(PrestamosCompanion data) {
    return Prestamo(
      idPrestamo: data.idPrestamo.present
          ? data.idPrestamo.value
          : this.idPrestamo,
      idCliente: data.idCliente.present ? data.idCliente.value : this.idCliente,
      idCobrador: data.idCobrador.present
          ? data.idCobrador.value
          : this.idCobrador,
      idTipo: data.idTipo.present ? data.idTipo.value : this.idTipo,
      idEstado: data.idEstado.present ? data.idEstado.value : this.idEstado,
      idGarantia: data.idGarantia.present
          ? data.idGarantia.value
          : this.idGarantia,
      prestamoOrigen: data.prestamoOrigen.present
          ? data.prestamoOrigen.value
          : this.prestamoOrigen,
      esRefinanciamiento: data.esRefinanciamiento.present
          ? data.esRefinanciamiento.value
          : this.esRefinanciamiento,
      monto: data.monto.present ? data.monto.value : this.monto,
      interes: data.interes.present ? data.interes.value : this.interes,
      fechaInicio: data.fechaInicio.present
          ? data.fechaInicio.value
          : this.fechaInicio,
      fechaFin: data.fechaFin.present ? data.fechaFin.value : this.fechaFin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prestamo(')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idCliente: $idCliente, ')
          ..write('idCobrador: $idCobrador, ')
          ..write('idTipo: $idTipo, ')
          ..write('idEstado: $idEstado, ')
          ..write('idGarantia: $idGarantia, ')
          ..write('prestamoOrigen: $prestamoOrigen, ')
          ..write('esRefinanciamiento: $esRefinanciamiento, ')
          ..write('monto: $monto, ')
          ..write('interes: $interes, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idPrestamo,
    idCliente,
    idCobrador,
    idTipo,
    idEstado,
    idGarantia,
    prestamoOrigen,
    esRefinanciamiento,
    monto,
    interes,
    fechaInicio,
    fechaFin,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prestamo &&
          other.idPrestamo == this.idPrestamo &&
          other.idCliente == this.idCliente &&
          other.idCobrador == this.idCobrador &&
          other.idTipo == this.idTipo &&
          other.idEstado == this.idEstado &&
          other.idGarantia == this.idGarantia &&
          other.prestamoOrigen == this.prestamoOrigen &&
          other.esRefinanciamiento == this.esRefinanciamiento &&
          other.monto == this.monto &&
          other.interes == this.interes &&
          other.fechaInicio == this.fechaInicio &&
          other.fechaFin == this.fechaFin &&
          other.createdAt == this.createdAt);
}

class PrestamosCompanion extends UpdateCompanion<Prestamo> {
  final Value<int> idPrestamo;
  final Value<int?> idCliente;
  final Value<int?> idCobrador;
  final Value<int?> idTipo;
  final Value<int?> idEstado;
  final Value<int?> idGarantia;
  final Value<int?> prestamoOrigen;
  final Value<bool> esRefinanciamiento;
  final Value<double> monto;
  final Value<double> interes;
  final Value<DateTime> fechaInicio;
  final Value<DateTime?> fechaFin;
  final Value<DateTime> createdAt;
  const PrestamosCompanion({
    this.idPrestamo = const Value.absent(),
    this.idCliente = const Value.absent(),
    this.idCobrador = const Value.absent(),
    this.idTipo = const Value.absent(),
    this.idEstado = const Value.absent(),
    this.idGarantia = const Value.absent(),
    this.prestamoOrigen = const Value.absent(),
    this.esRefinanciamiento = const Value.absent(),
    this.monto = const Value.absent(),
    this.interes = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.fechaFin = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PrestamosCompanion.insert({
    this.idPrestamo = const Value.absent(),
    this.idCliente = const Value.absent(),
    this.idCobrador = const Value.absent(),
    this.idTipo = const Value.absent(),
    this.idEstado = const Value.absent(),
    this.idGarantia = const Value.absent(),
    this.prestamoOrigen = const Value.absent(),
    this.esRefinanciamiento = const Value.absent(),
    required double monto,
    required double interes,
    required DateTime fechaInicio,
    this.fechaFin = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : monto = Value(monto),
       interes = Value(interes),
       fechaInicio = Value(fechaInicio);
  static Insertable<Prestamo> custom({
    Expression<int>? idPrestamo,
    Expression<int>? idCliente,
    Expression<int>? idCobrador,
    Expression<int>? idTipo,
    Expression<int>? idEstado,
    Expression<int>? idGarantia,
    Expression<int>? prestamoOrigen,
    Expression<bool>? esRefinanciamiento,
    Expression<double>? monto,
    Expression<double>? interes,
    Expression<DateTime>? fechaInicio,
    Expression<DateTime>? fechaFin,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idPrestamo != null) 'id_prestamo': idPrestamo,
      if (idCliente != null) 'id_cliente': idCliente,
      if (idCobrador != null) 'id_cobrador': idCobrador,
      if (idTipo != null) 'id_tipo': idTipo,
      if (idEstado != null) 'id_estado': idEstado,
      if (idGarantia != null) 'id_garantia': idGarantia,
      if (prestamoOrigen != null) 'prestamo_origen': prestamoOrigen,
      if (esRefinanciamiento != null) 'es_refinanciamiento': esRefinanciamiento,
      if (monto != null) 'monto': monto,
      if (interes != null) 'interes': interes,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (fechaFin != null) 'fecha_fin': fechaFin,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PrestamosCompanion copyWith({
    Value<int>? idPrestamo,
    Value<int?>? idCliente,
    Value<int?>? idCobrador,
    Value<int?>? idTipo,
    Value<int?>? idEstado,
    Value<int?>? idGarantia,
    Value<int?>? prestamoOrigen,
    Value<bool>? esRefinanciamiento,
    Value<double>? monto,
    Value<double>? interes,
    Value<DateTime>? fechaInicio,
    Value<DateTime?>? fechaFin,
    Value<DateTime>? createdAt,
  }) {
    return PrestamosCompanion(
      idPrestamo: idPrestamo ?? this.idPrestamo,
      idCliente: idCliente ?? this.idCliente,
      idCobrador: idCobrador ?? this.idCobrador,
      idTipo: idTipo ?? this.idTipo,
      idEstado: idEstado ?? this.idEstado,
      idGarantia: idGarantia ?? this.idGarantia,
      prestamoOrigen: prestamoOrigen ?? this.prestamoOrigen,
      esRefinanciamiento: esRefinanciamiento ?? this.esRefinanciamiento,
      monto: monto ?? this.monto,
      interes: interes ?? this.interes,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idPrestamo.present) {
      map['id_prestamo'] = Variable<int>(idPrestamo.value);
    }
    if (idCliente.present) {
      map['id_cliente'] = Variable<int>(idCliente.value);
    }
    if (idCobrador.present) {
      map['id_cobrador'] = Variable<int>(idCobrador.value);
    }
    if (idTipo.present) {
      map['id_tipo'] = Variable<int>(idTipo.value);
    }
    if (idEstado.present) {
      map['id_estado'] = Variable<int>(idEstado.value);
    }
    if (idGarantia.present) {
      map['id_garantia'] = Variable<int>(idGarantia.value);
    }
    if (prestamoOrigen.present) {
      map['prestamo_origen'] = Variable<int>(prestamoOrigen.value);
    }
    if (esRefinanciamiento.present) {
      map['es_refinanciamiento'] = Variable<bool>(esRefinanciamiento.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (interes.present) {
      map['interes'] = Variable<double>(interes.value);
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<DateTime>(fechaInicio.value);
    }
    if (fechaFin.present) {
      map['fecha_fin'] = Variable<DateTime>(fechaFin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrestamosCompanion(')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idCliente: $idCliente, ')
          ..write('idCobrador: $idCobrador, ')
          ..write('idTipo: $idTipo, ')
          ..write('idEstado: $idEstado, ')
          ..write('idGarantia: $idGarantia, ')
          ..write('prestamoOrigen: $prestamoOrigen, ')
          ..write('esRefinanciamiento: $esRefinanciamiento, ')
          ..write('monto: $monto, ')
          ..write('interes: $interes, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('fechaFin: $fechaFin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PrestamoGarantesTable extends PrestamoGarantes
    with TableInfo<$PrestamoGarantesTable, PrestamoGarante> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrestamoGarantesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idPrestamoMeta = const VerificationMeta(
    'idPrestamo',
  );
  @override
  late final GeneratedColumn<int> idPrestamo = GeneratedColumn<int>(
    'id_prestamo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idGaranteMeta = const VerificationMeta(
    'idGarante',
  );
  @override
  late final GeneratedColumn<int> idGarante = GeneratedColumn<int>(
    'id_garante',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idClienteMeta = const VerificationMeta(
    'idCliente',
  );
  @override
  late final GeneratedColumn<int> idCliente = GeneratedColumn<int>(
    'id_cliente',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, idPrestamo, idGarante, idCliente];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prestamo_garante';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrestamoGarante> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_prestamo')) {
      context.handle(
        _idPrestamoMeta,
        idPrestamo.isAcceptableOrUnknown(data['id_prestamo']!, _idPrestamoMeta),
      );
    } else if (isInserting) {
      context.missing(_idPrestamoMeta);
    }
    if (data.containsKey('id_garante')) {
      context.handle(
        _idGaranteMeta,
        idGarante.isAcceptableOrUnknown(data['id_garante']!, _idGaranteMeta),
      );
    }
    if (data.containsKey('id_cliente')) {
      context.handle(
        _idClienteMeta,
        idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrestamoGarante map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrestamoGarante(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_prestamo'],
      )!,
      idGarante: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_garante'],
      ),
      idCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cliente'],
      ),
    );
  }

  @override
  $PrestamoGarantesTable createAlias(String alias) {
    return $PrestamoGarantesTable(attachedDatabase, alias);
  }
}

class PrestamoGarante extends DataClass implements Insertable<PrestamoGarante> {
  final int id;
  final int idPrestamo;
  final int? idGarante;
  final int? idCliente;
  const PrestamoGarante({
    required this.id,
    required this.idPrestamo,
    this.idGarante,
    this.idCliente,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_prestamo'] = Variable<int>(idPrestamo);
    if (!nullToAbsent || idGarante != null) {
      map['id_garante'] = Variable<int>(idGarante);
    }
    if (!nullToAbsent || idCliente != null) {
      map['id_cliente'] = Variable<int>(idCliente);
    }
    return map;
  }

  PrestamoGarantesCompanion toCompanion(bool nullToAbsent) {
    return PrestamoGarantesCompanion(
      id: Value(id),
      idPrestamo: Value(idPrestamo),
      idGarante: idGarante == null && nullToAbsent
          ? const Value.absent()
          : Value(idGarante),
      idCliente: idCliente == null && nullToAbsent
          ? const Value.absent()
          : Value(idCliente),
    );
  }

  factory PrestamoGarante.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrestamoGarante(
      id: serializer.fromJson<int>(json['id']),
      idPrestamo: serializer.fromJson<int>(json['idPrestamo']),
      idGarante: serializer.fromJson<int?>(json['idGarante']),
      idCliente: serializer.fromJson<int?>(json['idCliente']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idPrestamo': serializer.toJson<int>(idPrestamo),
      'idGarante': serializer.toJson<int?>(idGarante),
      'idCliente': serializer.toJson<int?>(idCliente),
    };
  }

  PrestamoGarante copyWith({
    int? id,
    int? idPrestamo,
    Value<int?> idGarante = const Value.absent(),
    Value<int?> idCliente = const Value.absent(),
  }) => PrestamoGarante(
    id: id ?? this.id,
    idPrestamo: idPrestamo ?? this.idPrestamo,
    idGarante: idGarante.present ? idGarante.value : this.idGarante,
    idCliente: idCliente.present ? idCliente.value : this.idCliente,
  );
  PrestamoGarante copyWithCompanion(PrestamoGarantesCompanion data) {
    return PrestamoGarante(
      id: data.id.present ? data.id.value : this.id,
      idPrestamo: data.idPrestamo.present
          ? data.idPrestamo.value
          : this.idPrestamo,
      idGarante: data.idGarante.present ? data.idGarante.value : this.idGarante,
      idCliente: data.idCliente.present ? data.idCliente.value : this.idCliente,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrestamoGarante(')
          ..write('id: $id, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idGarante: $idGarante, ')
          ..write('idCliente: $idCliente')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idPrestamo, idGarante, idCliente);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrestamoGarante &&
          other.id == this.id &&
          other.idPrestamo == this.idPrestamo &&
          other.idGarante == this.idGarante &&
          other.idCliente == this.idCliente);
}

class PrestamoGarantesCompanion extends UpdateCompanion<PrestamoGarante> {
  final Value<int> id;
  final Value<int> idPrestamo;
  final Value<int?> idGarante;
  final Value<int?> idCliente;
  const PrestamoGarantesCompanion({
    this.id = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.idGarante = const Value.absent(),
    this.idCliente = const Value.absent(),
  });
  PrestamoGarantesCompanion.insert({
    this.id = const Value.absent(),
    required int idPrestamo,
    this.idGarante = const Value.absent(),
    this.idCliente = const Value.absent(),
  }) : idPrestamo = Value(idPrestamo);
  static Insertable<PrestamoGarante> custom({
    Expression<int>? id,
    Expression<int>? idPrestamo,
    Expression<int>? idGarante,
    Expression<int>? idCliente,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idPrestamo != null) 'id_prestamo': idPrestamo,
      if (idGarante != null) 'id_garante': idGarante,
      if (idCliente != null) 'id_cliente': idCliente,
    });
  }

  PrestamoGarantesCompanion copyWith({
    Value<int>? id,
    Value<int>? idPrestamo,
    Value<int?>? idGarante,
    Value<int?>? idCliente,
  }) {
    return PrestamoGarantesCompanion(
      id: id ?? this.id,
      idPrestamo: idPrestamo ?? this.idPrestamo,
      idGarante: idGarante ?? this.idGarante,
      idCliente: idCliente ?? this.idCliente,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idPrestamo.present) {
      map['id_prestamo'] = Variable<int>(idPrestamo.value);
    }
    if (idGarante.present) {
      map['id_garante'] = Variable<int>(idGarante.value);
    }
    if (idCliente.present) {
      map['id_cliente'] = Variable<int>(idCliente.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrestamoGarantesCompanion(')
          ..write('id: $id, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idGarante: $idGarante, ')
          ..write('idCliente: $idCliente')
          ..write(')'))
        .toString();
  }
}

class $PrestamoGarantiasTable extends PrestamoGarantias
    with TableInfo<$PrestamoGarantiasTable, PrestamoGarantia> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrestamoGarantiasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idPrestamoMeta = const VerificationMeta(
    'idPrestamo',
  );
  @override
  late final GeneratedColumn<int> idPrestamo = GeneratedColumn<int>(
    'id_prestamo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idGarantiaMeta = const VerificationMeta(
    'idGarantia',
  );
  @override
  late final GeneratedColumn<int> idGarantia = GeneratedColumn<int>(
    'id_garantia',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, idPrestamo, idGarantia];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prestamo_garantia';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrestamoGarantia> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_prestamo')) {
      context.handle(
        _idPrestamoMeta,
        idPrestamo.isAcceptableOrUnknown(data['id_prestamo']!, _idPrestamoMeta),
      );
    } else if (isInserting) {
      context.missing(_idPrestamoMeta);
    }
    if (data.containsKey('id_garantia')) {
      context.handle(
        _idGarantiaMeta,
        idGarantia.isAcceptableOrUnknown(data['id_garantia']!, _idGarantiaMeta),
      );
    } else if (isInserting) {
      context.missing(_idGarantiaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrestamoGarantia map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrestamoGarantia(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_prestamo'],
      )!,
      idGarantia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_garantia'],
      )!,
    );
  }

  @override
  $PrestamoGarantiasTable createAlias(String alias) {
    return $PrestamoGarantiasTable(attachedDatabase, alias);
  }
}

class PrestamoGarantia extends DataClass
    implements Insertable<PrestamoGarantia> {
  final int id;
  final int idPrestamo;
  final int idGarantia;
  const PrestamoGarantia({
    required this.id,
    required this.idPrestamo,
    required this.idGarantia,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_prestamo'] = Variable<int>(idPrestamo);
    map['id_garantia'] = Variable<int>(idGarantia);
    return map;
  }

  PrestamoGarantiasCompanion toCompanion(bool nullToAbsent) {
    return PrestamoGarantiasCompanion(
      id: Value(id),
      idPrestamo: Value(idPrestamo),
      idGarantia: Value(idGarantia),
    );
  }

  factory PrestamoGarantia.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrestamoGarantia(
      id: serializer.fromJson<int>(json['id']),
      idPrestamo: serializer.fromJson<int>(json['idPrestamo']),
      idGarantia: serializer.fromJson<int>(json['idGarantia']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idPrestamo': serializer.toJson<int>(idPrestamo),
      'idGarantia': serializer.toJson<int>(idGarantia),
    };
  }

  PrestamoGarantia copyWith({int? id, int? idPrestamo, int? idGarantia}) =>
      PrestamoGarantia(
        id: id ?? this.id,
        idPrestamo: idPrestamo ?? this.idPrestamo,
        idGarantia: idGarantia ?? this.idGarantia,
      );
  PrestamoGarantia copyWithCompanion(PrestamoGarantiasCompanion data) {
    return PrestamoGarantia(
      id: data.id.present ? data.id.value : this.id,
      idPrestamo: data.idPrestamo.present
          ? data.idPrestamo.value
          : this.idPrestamo,
      idGarantia: data.idGarantia.present
          ? data.idGarantia.value
          : this.idGarantia,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrestamoGarantia(')
          ..write('id: $id, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idGarantia: $idGarantia')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idPrestamo, idGarantia);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrestamoGarantia &&
          other.id == this.id &&
          other.idPrestamo == this.idPrestamo &&
          other.idGarantia == this.idGarantia);
}

class PrestamoGarantiasCompanion extends UpdateCompanion<PrestamoGarantia> {
  final Value<int> id;
  final Value<int> idPrestamo;
  final Value<int> idGarantia;
  const PrestamoGarantiasCompanion({
    this.id = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.idGarantia = const Value.absent(),
  });
  PrestamoGarantiasCompanion.insert({
    this.id = const Value.absent(),
    required int idPrestamo,
    required int idGarantia,
  }) : idPrestamo = Value(idPrestamo),
       idGarantia = Value(idGarantia);
  static Insertable<PrestamoGarantia> custom({
    Expression<int>? id,
    Expression<int>? idPrestamo,
    Expression<int>? idGarantia,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idPrestamo != null) 'id_prestamo': idPrestamo,
      if (idGarantia != null) 'id_garantia': idGarantia,
    });
  }

  PrestamoGarantiasCompanion copyWith({
    Value<int>? id,
    Value<int>? idPrestamo,
    Value<int>? idGarantia,
  }) {
    return PrestamoGarantiasCompanion(
      id: id ?? this.id,
      idPrestamo: idPrestamo ?? this.idPrestamo,
      idGarantia: idGarantia ?? this.idGarantia,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idPrestamo.present) {
      map['id_prestamo'] = Variable<int>(idPrestamo.value);
    }
    if (idGarantia.present) {
      map['id_garantia'] = Variable<int>(idGarantia.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrestamoGarantiasCompanion(')
          ..write('id: $id, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idGarantia: $idGarantia')
          ..write(')'))
        .toString();
  }
}

class $CuotasTable extends Cuotas with TableInfo<$CuotasTable, Cuota> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CuotasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idCuotaMeta = const VerificationMeta(
    'idCuota',
  );
  @override
  late final GeneratedColumn<int> idCuota = GeneratedColumn<int>(
    'id_cuota',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idPrestamoMeta = const VerificationMeta(
    'idPrestamo',
  );
  @override
  late final GeneratedColumn<int> idPrestamo = GeneratedColumn<int>(
    'id_prestamo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idPlanMeta = const VerificationMeta('idPlan');
  @override
  late final GeneratedColumn<int> idPlan = GeneratedColumn<int>(
    'id_plan',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numeroCuotaMeta = const VerificationMeta(
    'numeroCuota',
  );
  @override
  late final GeneratedColumn<int> numeroCuota = GeneratedColumn<int>(
    'numero_cuota',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoCuotaMeta = const VerificationMeta(
    'montoCuota',
  );
  @override
  late final GeneratedColumn<double> montoCuota = GeneratedColumn<double>(
    'monto_cuota',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoTotalMeta = const VerificationMeta(
    'montoTotal',
  );
  @override
  late final GeneratedColumn<double> montoTotal = GeneratedColumn<double>(
    'monto_total',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _capitalMeta = const VerificationMeta(
    'capital',
  );
  @override
  late final GeneratedColumn<double> capital = GeneratedColumn<double>(
    'capital',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoCapitalMeta = const VerificationMeta(
    'montoCapital',
  );
  @override
  late final GeneratedColumn<double> montoCapital = GeneratedColumn<double>(
    'monto_capital',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _interesMeta = const VerificationMeta(
    'interes',
  );
  @override
  late final GeneratedColumn<double> interes = GeneratedColumn<double>(
    'interes',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoInteresMeta = const VerificationMeta(
    'montoInteres',
  );
  @override
  late final GeneratedColumn<double> montoInteres = GeneratedColumn<double>(
    'monto_interes',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saldoPendienteMeta = const VerificationMeta(
    'saldoPendiente',
  );
  @override
  late final GeneratedColumn<double> saldoPendiente = GeneratedColumn<double>(
    'saldo_pendiente',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saldoRestanteMeta = const VerificationMeta(
    'saldoRestante',
  );
  @override
  late final GeneratedColumn<double> saldoRestante = GeneratedColumn<double>(
    'saldo_restante',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaVencimientoMeta = const VerificationMeta(
    'fechaVencimiento',
  );
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>(
        'fecha_vencimiento',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _fechaPagoMeta = const VerificationMeta(
    'fechaPago',
  );
  @override
  late final GeneratedColumn<DateTime> fechaPago = GeneratedColumn<DateTime>(
    'fecha_pago',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDIENTE'),
  );
  static const VerificationMeta _observacionesMeta = const VerificationMeta(
    'observaciones',
  );
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
    'observaciones',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _moraMeta = const VerificationMeta('mora');
  @override
  late final GeneratedColumn<bool> mora = GeneratedColumn<bool>(
    'mora',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mora" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _moraMontoMeta = const VerificationMeta(
    'moraMonto',
  );
  @override
  late final GeneratedColumn<double> moraMonto = GeneratedColumn<double>(
    'mora_monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idCuota,
    idPrestamo,
    idPlan,
    numeroCuota,
    montoCuota,
    montoTotal,
    capital,
    montoCapital,
    interes,
    montoInteres,
    saldoPendiente,
    saldoRestante,
    fechaVencimiento,
    fechaPago,
    estado,
    observaciones,
    mora,
    moraMonto,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cuota';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cuota> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_cuota')) {
      context.handle(
        _idCuotaMeta,
        idCuota.isAcceptableOrUnknown(data['id_cuota']!, _idCuotaMeta),
      );
    }
    if (data.containsKey('id_prestamo')) {
      context.handle(
        _idPrestamoMeta,
        idPrestamo.isAcceptableOrUnknown(data['id_prestamo']!, _idPrestamoMeta),
      );
    }
    if (data.containsKey('id_plan')) {
      context.handle(
        _idPlanMeta,
        idPlan.isAcceptableOrUnknown(data['id_plan']!, _idPlanMeta),
      );
    }
    if (data.containsKey('numero_cuota')) {
      context.handle(
        _numeroCuotaMeta,
        numeroCuota.isAcceptableOrUnknown(
          data['numero_cuota']!,
          _numeroCuotaMeta,
        ),
      );
    }
    if (data.containsKey('monto_cuota')) {
      context.handle(
        _montoCuotaMeta,
        montoCuota.isAcceptableOrUnknown(data['monto_cuota']!, _montoCuotaMeta),
      );
    }
    if (data.containsKey('monto_total')) {
      context.handle(
        _montoTotalMeta,
        montoTotal.isAcceptableOrUnknown(data['monto_total']!, _montoTotalMeta),
      );
    }
    if (data.containsKey('capital')) {
      context.handle(
        _capitalMeta,
        capital.isAcceptableOrUnknown(data['capital']!, _capitalMeta),
      );
    }
    if (data.containsKey('monto_capital')) {
      context.handle(
        _montoCapitalMeta,
        montoCapital.isAcceptableOrUnknown(
          data['monto_capital']!,
          _montoCapitalMeta,
        ),
      );
    }
    if (data.containsKey('interes')) {
      context.handle(
        _interesMeta,
        interes.isAcceptableOrUnknown(data['interes']!, _interesMeta),
      );
    }
    if (data.containsKey('monto_interes')) {
      context.handle(
        _montoInteresMeta,
        montoInteres.isAcceptableOrUnknown(
          data['monto_interes']!,
          _montoInteresMeta,
        ),
      );
    }
    if (data.containsKey('saldo_pendiente')) {
      context.handle(
        _saldoPendienteMeta,
        saldoPendiente.isAcceptableOrUnknown(
          data['saldo_pendiente']!,
          _saldoPendienteMeta,
        ),
      );
    }
    if (data.containsKey('saldo_restante')) {
      context.handle(
        _saldoRestanteMeta,
        saldoRestante.isAcceptableOrUnknown(
          data['saldo_restante']!,
          _saldoRestanteMeta,
        ),
      );
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
        _fechaVencimientoMeta,
        fechaVencimiento.isAcceptableOrUnknown(
          data['fecha_vencimiento']!,
          _fechaVencimientoMeta,
        ),
      );
    }
    if (data.containsKey('fecha_pago')) {
      context.handle(
        _fechaPagoMeta,
        fechaPago.isAcceptableOrUnknown(data['fecha_pago']!, _fechaPagoMeta),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('observaciones')) {
      context.handle(
        _observacionesMeta,
        observaciones.isAcceptableOrUnknown(
          data['observaciones']!,
          _observacionesMeta,
        ),
      );
    }
    if (data.containsKey('mora')) {
      context.handle(
        _moraMeta,
        mora.isAcceptableOrUnknown(data['mora']!, _moraMeta),
      );
    }
    if (data.containsKey('mora_monto')) {
      context.handle(
        _moraMontoMeta,
        moraMonto.isAcceptableOrUnknown(data['mora_monto']!, _moraMontoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idCuota};
  @override
  Cuota map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cuota(
      idCuota: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cuota'],
      )!,
      idPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_prestamo'],
      ),
      idPlan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_plan'],
      ),
      numeroCuota: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero_cuota'],
      ),
      montoCuota: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto_cuota'],
      ),
      montoTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto_total'],
      ),
      capital: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}capital'],
      ),
      montoCapital: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto_capital'],
      ),
      interes: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interes'],
      ),
      montoInteres: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto_interes'],
      ),
      saldoPendiente: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saldo_pendiente'],
      ),
      saldoRestante: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}saldo_restante'],
      ),
      fechaVencimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_vencimiento'],
      ),
      fechaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_pago'],
      ),
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      observaciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observaciones'],
      )!,
      mora: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mora'],
      )!,
      moraMonto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mora_monto'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CuotasTable createAlias(String alias) {
    return $CuotasTable(attachedDatabase, alias);
  }
}

class Cuota extends DataClass implements Insertable<Cuota> {
  final int idCuota;
  final int? idPrestamo;
  final int? idPlan;
  final int? numeroCuota;
  final double? montoCuota;
  final double? montoTotal;
  final double? capital;
  final double? montoCapital;
  final double? interes;
  final double? montoInteres;
  final double? saldoPendiente;
  final double? saldoRestante;
  final DateTime? fechaVencimiento;
  final DateTime? fechaPago;
  final String estado;
  final String observaciones;
  final bool mora;
  final double moraMonto;
  final DateTime createdAt;
  const Cuota({
    required this.idCuota,
    this.idPrestamo,
    this.idPlan,
    this.numeroCuota,
    this.montoCuota,
    this.montoTotal,
    this.capital,
    this.montoCapital,
    this.interes,
    this.montoInteres,
    this.saldoPendiente,
    this.saldoRestante,
    this.fechaVencimiento,
    this.fechaPago,
    required this.estado,
    required this.observaciones,
    required this.mora,
    required this.moraMonto,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_cuota'] = Variable<int>(idCuota);
    if (!nullToAbsent || idPrestamo != null) {
      map['id_prestamo'] = Variable<int>(idPrestamo);
    }
    if (!nullToAbsent || idPlan != null) {
      map['id_plan'] = Variable<int>(idPlan);
    }
    if (!nullToAbsent || numeroCuota != null) {
      map['numero_cuota'] = Variable<int>(numeroCuota);
    }
    if (!nullToAbsent || montoCuota != null) {
      map['monto_cuota'] = Variable<double>(montoCuota);
    }
    if (!nullToAbsent || montoTotal != null) {
      map['monto_total'] = Variable<double>(montoTotal);
    }
    if (!nullToAbsent || capital != null) {
      map['capital'] = Variable<double>(capital);
    }
    if (!nullToAbsent || montoCapital != null) {
      map['monto_capital'] = Variable<double>(montoCapital);
    }
    if (!nullToAbsent || interes != null) {
      map['interes'] = Variable<double>(interes);
    }
    if (!nullToAbsent || montoInteres != null) {
      map['monto_interes'] = Variable<double>(montoInteres);
    }
    if (!nullToAbsent || saldoPendiente != null) {
      map['saldo_pendiente'] = Variable<double>(saldoPendiente);
    }
    if (!nullToAbsent || saldoRestante != null) {
      map['saldo_restante'] = Variable<double>(saldoRestante);
    }
    if (!nullToAbsent || fechaVencimiento != null) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    }
    if (!nullToAbsent || fechaPago != null) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago);
    }
    map['estado'] = Variable<String>(estado);
    map['observaciones'] = Variable<String>(observaciones);
    map['mora'] = Variable<bool>(mora);
    map['mora_monto'] = Variable<double>(moraMonto);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CuotasCompanion toCompanion(bool nullToAbsent) {
    return CuotasCompanion(
      idCuota: Value(idCuota),
      idPrestamo: idPrestamo == null && nullToAbsent
          ? const Value.absent()
          : Value(idPrestamo),
      idPlan: idPlan == null && nullToAbsent
          ? const Value.absent()
          : Value(idPlan),
      numeroCuota: numeroCuota == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroCuota),
      montoCuota: montoCuota == null && nullToAbsent
          ? const Value.absent()
          : Value(montoCuota),
      montoTotal: montoTotal == null && nullToAbsent
          ? const Value.absent()
          : Value(montoTotal),
      capital: capital == null && nullToAbsent
          ? const Value.absent()
          : Value(capital),
      montoCapital: montoCapital == null && nullToAbsent
          ? const Value.absent()
          : Value(montoCapital),
      interes: interes == null && nullToAbsent
          ? const Value.absent()
          : Value(interes),
      montoInteres: montoInteres == null && nullToAbsent
          ? const Value.absent()
          : Value(montoInteres),
      saldoPendiente: saldoPendiente == null && nullToAbsent
          ? const Value.absent()
          : Value(saldoPendiente),
      saldoRestante: saldoRestante == null && nullToAbsent
          ? const Value.absent()
          : Value(saldoRestante),
      fechaVencimiento: fechaVencimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaVencimiento),
      fechaPago: fechaPago == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaPago),
      estado: Value(estado),
      observaciones: Value(observaciones),
      mora: Value(mora),
      moraMonto: Value(moraMonto),
      createdAt: Value(createdAt),
    );
  }

  factory Cuota.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cuota(
      idCuota: serializer.fromJson<int>(json['idCuota']),
      idPrestamo: serializer.fromJson<int?>(json['idPrestamo']),
      idPlan: serializer.fromJson<int?>(json['idPlan']),
      numeroCuota: serializer.fromJson<int?>(json['numeroCuota']),
      montoCuota: serializer.fromJson<double?>(json['montoCuota']),
      montoTotal: serializer.fromJson<double?>(json['montoTotal']),
      capital: serializer.fromJson<double?>(json['capital']),
      montoCapital: serializer.fromJson<double?>(json['montoCapital']),
      interes: serializer.fromJson<double?>(json['interes']),
      montoInteres: serializer.fromJson<double?>(json['montoInteres']),
      saldoPendiente: serializer.fromJson<double?>(json['saldoPendiente']),
      saldoRestante: serializer.fromJson<double?>(json['saldoRestante']),
      fechaVencimiento: serializer.fromJson<DateTime?>(
        json['fechaVencimiento'],
      ),
      fechaPago: serializer.fromJson<DateTime?>(json['fechaPago']),
      estado: serializer.fromJson<String>(json['estado']),
      observaciones: serializer.fromJson<String>(json['observaciones']),
      mora: serializer.fromJson<bool>(json['mora']),
      moraMonto: serializer.fromJson<double>(json['moraMonto']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idCuota': serializer.toJson<int>(idCuota),
      'idPrestamo': serializer.toJson<int?>(idPrestamo),
      'idPlan': serializer.toJson<int?>(idPlan),
      'numeroCuota': serializer.toJson<int?>(numeroCuota),
      'montoCuota': serializer.toJson<double?>(montoCuota),
      'montoTotal': serializer.toJson<double?>(montoTotal),
      'capital': serializer.toJson<double?>(capital),
      'montoCapital': serializer.toJson<double?>(montoCapital),
      'interes': serializer.toJson<double?>(interes),
      'montoInteres': serializer.toJson<double?>(montoInteres),
      'saldoPendiente': serializer.toJson<double?>(saldoPendiente),
      'saldoRestante': serializer.toJson<double?>(saldoRestante),
      'fechaVencimiento': serializer.toJson<DateTime?>(fechaVencimiento),
      'fechaPago': serializer.toJson<DateTime?>(fechaPago),
      'estado': serializer.toJson<String>(estado),
      'observaciones': serializer.toJson<String>(observaciones),
      'mora': serializer.toJson<bool>(mora),
      'moraMonto': serializer.toJson<double>(moraMonto),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Cuota copyWith({
    int? idCuota,
    Value<int?> idPrestamo = const Value.absent(),
    Value<int?> idPlan = const Value.absent(),
    Value<int?> numeroCuota = const Value.absent(),
    Value<double?> montoCuota = const Value.absent(),
    Value<double?> montoTotal = const Value.absent(),
    Value<double?> capital = const Value.absent(),
    Value<double?> montoCapital = const Value.absent(),
    Value<double?> interes = const Value.absent(),
    Value<double?> montoInteres = const Value.absent(),
    Value<double?> saldoPendiente = const Value.absent(),
    Value<double?> saldoRestante = const Value.absent(),
    Value<DateTime?> fechaVencimiento = const Value.absent(),
    Value<DateTime?> fechaPago = const Value.absent(),
    String? estado,
    String? observaciones,
    bool? mora,
    double? moraMonto,
    DateTime? createdAt,
  }) => Cuota(
    idCuota: idCuota ?? this.idCuota,
    idPrestamo: idPrestamo.present ? idPrestamo.value : this.idPrestamo,
    idPlan: idPlan.present ? idPlan.value : this.idPlan,
    numeroCuota: numeroCuota.present ? numeroCuota.value : this.numeroCuota,
    montoCuota: montoCuota.present ? montoCuota.value : this.montoCuota,
    montoTotal: montoTotal.present ? montoTotal.value : this.montoTotal,
    capital: capital.present ? capital.value : this.capital,
    montoCapital: montoCapital.present ? montoCapital.value : this.montoCapital,
    interes: interes.present ? interes.value : this.interes,
    montoInteres: montoInteres.present ? montoInteres.value : this.montoInteres,
    saldoPendiente: saldoPendiente.present
        ? saldoPendiente.value
        : this.saldoPendiente,
    saldoRestante: saldoRestante.present
        ? saldoRestante.value
        : this.saldoRestante,
    fechaVencimiento: fechaVencimiento.present
        ? fechaVencimiento.value
        : this.fechaVencimiento,
    fechaPago: fechaPago.present ? fechaPago.value : this.fechaPago,
    estado: estado ?? this.estado,
    observaciones: observaciones ?? this.observaciones,
    mora: mora ?? this.mora,
    moraMonto: moraMonto ?? this.moraMonto,
    createdAt: createdAt ?? this.createdAt,
  );
  Cuota copyWithCompanion(CuotasCompanion data) {
    return Cuota(
      idCuota: data.idCuota.present ? data.idCuota.value : this.idCuota,
      idPrestamo: data.idPrestamo.present
          ? data.idPrestamo.value
          : this.idPrestamo,
      idPlan: data.idPlan.present ? data.idPlan.value : this.idPlan,
      numeroCuota: data.numeroCuota.present
          ? data.numeroCuota.value
          : this.numeroCuota,
      montoCuota: data.montoCuota.present
          ? data.montoCuota.value
          : this.montoCuota,
      montoTotal: data.montoTotal.present
          ? data.montoTotal.value
          : this.montoTotal,
      capital: data.capital.present ? data.capital.value : this.capital,
      montoCapital: data.montoCapital.present
          ? data.montoCapital.value
          : this.montoCapital,
      interes: data.interes.present ? data.interes.value : this.interes,
      montoInteres: data.montoInteres.present
          ? data.montoInteres.value
          : this.montoInteres,
      saldoPendiente: data.saldoPendiente.present
          ? data.saldoPendiente.value
          : this.saldoPendiente,
      saldoRestante: data.saldoRestante.present
          ? data.saldoRestante.value
          : this.saldoRestante,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      fechaPago: data.fechaPago.present ? data.fechaPago.value : this.fechaPago,
      estado: data.estado.present ? data.estado.value : this.estado,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      mora: data.mora.present ? data.mora.value : this.mora,
      moraMonto: data.moraMonto.present ? data.moraMonto.value : this.moraMonto,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cuota(')
          ..write('idCuota: $idCuota, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idPlan: $idPlan, ')
          ..write('numeroCuota: $numeroCuota, ')
          ..write('montoCuota: $montoCuota, ')
          ..write('montoTotal: $montoTotal, ')
          ..write('capital: $capital, ')
          ..write('montoCapital: $montoCapital, ')
          ..write('interes: $interes, ')
          ..write('montoInteres: $montoInteres, ')
          ..write('saldoPendiente: $saldoPendiente, ')
          ..write('saldoRestante: $saldoRestante, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('fechaPago: $fechaPago, ')
          ..write('estado: $estado, ')
          ..write('observaciones: $observaciones, ')
          ..write('mora: $mora, ')
          ..write('moraMonto: $moraMonto, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idCuota,
    idPrestamo,
    idPlan,
    numeroCuota,
    montoCuota,
    montoTotal,
    capital,
    montoCapital,
    interes,
    montoInteres,
    saldoPendiente,
    saldoRestante,
    fechaVencimiento,
    fechaPago,
    estado,
    observaciones,
    mora,
    moraMonto,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cuota &&
          other.idCuota == this.idCuota &&
          other.idPrestamo == this.idPrestamo &&
          other.idPlan == this.idPlan &&
          other.numeroCuota == this.numeroCuota &&
          other.montoCuota == this.montoCuota &&
          other.montoTotal == this.montoTotal &&
          other.capital == this.capital &&
          other.montoCapital == this.montoCapital &&
          other.interes == this.interes &&
          other.montoInteres == this.montoInteres &&
          other.saldoPendiente == this.saldoPendiente &&
          other.saldoRestante == this.saldoRestante &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.fechaPago == this.fechaPago &&
          other.estado == this.estado &&
          other.observaciones == this.observaciones &&
          other.mora == this.mora &&
          other.moraMonto == this.moraMonto &&
          other.createdAt == this.createdAt);
}

class CuotasCompanion extends UpdateCompanion<Cuota> {
  final Value<int> idCuota;
  final Value<int?> idPrestamo;
  final Value<int?> idPlan;
  final Value<int?> numeroCuota;
  final Value<double?> montoCuota;
  final Value<double?> montoTotal;
  final Value<double?> capital;
  final Value<double?> montoCapital;
  final Value<double?> interes;
  final Value<double?> montoInteres;
  final Value<double?> saldoPendiente;
  final Value<double?> saldoRestante;
  final Value<DateTime?> fechaVencimiento;
  final Value<DateTime?> fechaPago;
  final Value<String> estado;
  final Value<String> observaciones;
  final Value<bool> mora;
  final Value<double> moraMonto;
  final Value<DateTime> createdAt;
  const CuotasCompanion({
    this.idCuota = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.idPlan = const Value.absent(),
    this.numeroCuota = const Value.absent(),
    this.montoCuota = const Value.absent(),
    this.montoTotal = const Value.absent(),
    this.capital = const Value.absent(),
    this.montoCapital = const Value.absent(),
    this.interes = const Value.absent(),
    this.montoInteres = const Value.absent(),
    this.saldoPendiente = const Value.absent(),
    this.saldoRestante = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.fechaPago = const Value.absent(),
    this.estado = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.mora = const Value.absent(),
    this.moraMonto = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CuotasCompanion.insert({
    this.idCuota = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.idPlan = const Value.absent(),
    this.numeroCuota = const Value.absent(),
    this.montoCuota = const Value.absent(),
    this.montoTotal = const Value.absent(),
    this.capital = const Value.absent(),
    this.montoCapital = const Value.absent(),
    this.interes = const Value.absent(),
    this.montoInteres = const Value.absent(),
    this.saldoPendiente = const Value.absent(),
    this.saldoRestante = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.fechaPago = const Value.absent(),
    this.estado = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.mora = const Value.absent(),
    this.moraMonto = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Cuota> custom({
    Expression<int>? idCuota,
    Expression<int>? idPrestamo,
    Expression<int>? idPlan,
    Expression<int>? numeroCuota,
    Expression<double>? montoCuota,
    Expression<double>? montoTotal,
    Expression<double>? capital,
    Expression<double>? montoCapital,
    Expression<double>? interes,
    Expression<double>? montoInteres,
    Expression<double>? saldoPendiente,
    Expression<double>? saldoRestante,
    Expression<DateTime>? fechaVencimiento,
    Expression<DateTime>? fechaPago,
    Expression<String>? estado,
    Expression<String>? observaciones,
    Expression<bool>? mora,
    Expression<double>? moraMonto,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idCuota != null) 'id_cuota': idCuota,
      if (idPrestamo != null) 'id_prestamo': idPrestamo,
      if (idPlan != null) 'id_plan': idPlan,
      if (numeroCuota != null) 'numero_cuota': numeroCuota,
      if (montoCuota != null) 'monto_cuota': montoCuota,
      if (montoTotal != null) 'monto_total': montoTotal,
      if (capital != null) 'capital': capital,
      if (montoCapital != null) 'monto_capital': montoCapital,
      if (interes != null) 'interes': interes,
      if (montoInteres != null) 'monto_interes': montoInteres,
      if (saldoPendiente != null) 'saldo_pendiente': saldoPendiente,
      if (saldoRestante != null) 'saldo_restante': saldoRestante,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (fechaPago != null) 'fecha_pago': fechaPago,
      if (estado != null) 'estado': estado,
      if (observaciones != null) 'observaciones': observaciones,
      if (mora != null) 'mora': mora,
      if (moraMonto != null) 'mora_monto': moraMonto,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CuotasCompanion copyWith({
    Value<int>? idCuota,
    Value<int?>? idPrestamo,
    Value<int?>? idPlan,
    Value<int?>? numeroCuota,
    Value<double?>? montoCuota,
    Value<double?>? montoTotal,
    Value<double?>? capital,
    Value<double?>? montoCapital,
    Value<double?>? interes,
    Value<double?>? montoInteres,
    Value<double?>? saldoPendiente,
    Value<double?>? saldoRestante,
    Value<DateTime?>? fechaVencimiento,
    Value<DateTime?>? fechaPago,
    Value<String>? estado,
    Value<String>? observaciones,
    Value<bool>? mora,
    Value<double>? moraMonto,
    Value<DateTime>? createdAt,
  }) {
    return CuotasCompanion(
      idCuota: idCuota ?? this.idCuota,
      idPrestamo: idPrestamo ?? this.idPrestamo,
      idPlan: idPlan ?? this.idPlan,
      numeroCuota: numeroCuota ?? this.numeroCuota,
      montoCuota: montoCuota ?? this.montoCuota,
      montoTotal: montoTotal ?? this.montoTotal,
      capital: capital ?? this.capital,
      montoCapital: montoCapital ?? this.montoCapital,
      interes: interes ?? this.interes,
      montoInteres: montoInteres ?? this.montoInteres,
      saldoPendiente: saldoPendiente ?? this.saldoPendiente,
      saldoRestante: saldoRestante ?? this.saldoRestante,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      fechaPago: fechaPago ?? this.fechaPago,
      estado: estado ?? this.estado,
      observaciones: observaciones ?? this.observaciones,
      mora: mora ?? this.mora,
      moraMonto: moraMonto ?? this.moraMonto,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idCuota.present) {
      map['id_cuota'] = Variable<int>(idCuota.value);
    }
    if (idPrestamo.present) {
      map['id_prestamo'] = Variable<int>(idPrestamo.value);
    }
    if (idPlan.present) {
      map['id_plan'] = Variable<int>(idPlan.value);
    }
    if (numeroCuota.present) {
      map['numero_cuota'] = Variable<int>(numeroCuota.value);
    }
    if (montoCuota.present) {
      map['monto_cuota'] = Variable<double>(montoCuota.value);
    }
    if (montoTotal.present) {
      map['monto_total'] = Variable<double>(montoTotal.value);
    }
    if (capital.present) {
      map['capital'] = Variable<double>(capital.value);
    }
    if (montoCapital.present) {
      map['monto_capital'] = Variable<double>(montoCapital.value);
    }
    if (interes.present) {
      map['interes'] = Variable<double>(interes.value);
    }
    if (montoInteres.present) {
      map['monto_interes'] = Variable<double>(montoInteres.value);
    }
    if (saldoPendiente.present) {
      map['saldo_pendiente'] = Variable<double>(saldoPendiente.value);
    }
    if (saldoRestante.present) {
      map['saldo_restante'] = Variable<double>(saldoRestante.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (fechaPago.present) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (mora.present) {
      map['mora'] = Variable<bool>(mora.value);
    }
    if (moraMonto.present) {
      map['mora_monto'] = Variable<double>(moraMonto.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CuotasCompanion(')
          ..write('idCuota: $idCuota, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('idPlan: $idPlan, ')
          ..write('numeroCuota: $numeroCuota, ')
          ..write('montoCuota: $montoCuota, ')
          ..write('montoTotal: $montoTotal, ')
          ..write('capital: $capital, ')
          ..write('montoCapital: $montoCapital, ')
          ..write('interes: $interes, ')
          ..write('montoInteres: $montoInteres, ')
          ..write('saldoPendiente: $saldoPendiente, ')
          ..write('saldoRestante: $saldoRestante, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('fechaPago: $fechaPago, ')
          ..write('estado: $estado, ')
          ..write('observaciones: $observaciones, ')
          ..write('mora: $mora, ')
          ..write('moraMonto: $moraMonto, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PagosTable extends Pagos with TableInfo<$PagosTable, Pago> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PagosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idPagoMeta = const VerificationMeta('idPago');
  @override
  late final GeneratedColumn<int> idPago = GeneratedColumn<int>(
    'id_pago',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idCuotaMeta = const VerificationMeta(
    'idCuota',
  );
  @override
  late final GeneratedColumn<int> idCuota = GeneratedColumn<int>(
    'id_cuota',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idPrestamoMeta = const VerificationMeta(
    'idPrestamo',
  );
  @override
  late final GeneratedColumn<int> idPrestamo = GeneratedColumn<int>(
    'id_prestamo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaPagoMeta = const VerificationMeta(
    'fechaPago',
  );
  @override
  late final GeneratedColumn<DateTime> fechaPago = GeneratedColumn<DateTime>(
    'fecha_pago',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _metodoPagoMeta = const VerificationMeta(
    'metodoPago',
  );
  @override
  late final GeneratedColumn<String> metodoPago = GeneratedColumn<String>(
    'metodo_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('EFECTIVO'),
  );
  static const VerificationMeta _observacionMeta = const VerificationMeta(
    'observacion',
  );
  @override
  late final GeneratedColumn<String> observacion = GeneratedColumn<String>(
    'observacion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _pagoCompletoMeta = const VerificationMeta(
    'pagoCompleto',
  );
  @override
  late final GeneratedColumn<bool> pagoCompleto = GeneratedColumn<bool>(
    'pago_completo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pago_completo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _tipoPagoMeta = const VerificationMeta(
    'tipoPago',
  );
  @override
  late final GeneratedColumn<String> tipoPago = GeneratedColumn<String>(
    'tipo_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NORMAL'),
  );
  static const VerificationMeta _estadoPagoMeta = const VerificationMeta(
    'estadoPago',
  );
  @override
  late final GeneratedColumn<String> estadoPago = GeneratedColumn<String>(
    'estado_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('COMPLETO'),
  );
  static const VerificationMeta _cuotasIdsMeta = const VerificationMeta(
    'cuotasIds',
  );
  @override
  late final GeneratedColumn<String> cuotasIds = GeneratedColumn<String>(
    'cuotas_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moraMeta = const VerificationMeta('mora');
  @override
  late final GeneratedColumn<double> mora = GeneratedColumn<double>(
    'mora',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _descuentoMeta = const VerificationMeta(
    'descuento',
  );
  @override
  late final GeneratedColumn<double> descuento = GeneratedColumn<double>(
    'descuento',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idPago,
    idCuota,
    idPrestamo,
    monto,
    fechaPago,
    metodoPago,
    observacion,
    pagoCompleto,
    tipoPago,
    estadoPago,
    cuotasIds,
    mora,
    descuento,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pago';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pago> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_pago')) {
      context.handle(
        _idPagoMeta,
        idPago.isAcceptableOrUnknown(data['id_pago']!, _idPagoMeta),
      );
    }
    if (data.containsKey('id_cuota')) {
      context.handle(
        _idCuotaMeta,
        idCuota.isAcceptableOrUnknown(data['id_cuota']!, _idCuotaMeta),
      );
    }
    if (data.containsKey('id_prestamo')) {
      context.handle(
        _idPrestamoMeta,
        idPrestamo.isAcceptableOrUnknown(data['id_prestamo']!, _idPrestamoMeta),
      );
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    }
    if (data.containsKey('fecha_pago')) {
      context.handle(
        _fechaPagoMeta,
        fechaPago.isAcceptableOrUnknown(data['fecha_pago']!, _fechaPagoMeta),
      );
    }
    if (data.containsKey('metodo_pago')) {
      context.handle(
        _metodoPagoMeta,
        metodoPago.isAcceptableOrUnknown(data['metodo_pago']!, _metodoPagoMeta),
      );
    }
    if (data.containsKey('observacion')) {
      context.handle(
        _observacionMeta,
        observacion.isAcceptableOrUnknown(
          data['observacion']!,
          _observacionMeta,
        ),
      );
    }
    if (data.containsKey('pago_completo')) {
      context.handle(
        _pagoCompletoMeta,
        pagoCompleto.isAcceptableOrUnknown(
          data['pago_completo']!,
          _pagoCompletoMeta,
        ),
      );
    }
    if (data.containsKey('tipo_pago')) {
      context.handle(
        _tipoPagoMeta,
        tipoPago.isAcceptableOrUnknown(data['tipo_pago']!, _tipoPagoMeta),
      );
    }
    if (data.containsKey('estado_pago')) {
      context.handle(
        _estadoPagoMeta,
        estadoPago.isAcceptableOrUnknown(data['estado_pago']!, _estadoPagoMeta),
      );
    }
    if (data.containsKey('cuotas_ids')) {
      context.handle(
        _cuotasIdsMeta,
        cuotasIds.isAcceptableOrUnknown(data['cuotas_ids']!, _cuotasIdsMeta),
      );
    }
    if (data.containsKey('mora')) {
      context.handle(
        _moraMeta,
        mora.isAcceptableOrUnknown(data['mora']!, _moraMeta),
      );
    }
    if (data.containsKey('descuento')) {
      context.handle(
        _descuentoMeta,
        descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idPago};
  @override
  Pago map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pago(
      idPago: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_pago'],
      )!,
      idCuota: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_cuota'],
      ),
      idPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_prestamo'],
      ),
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      ),
      fechaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_pago'],
      )!,
      metodoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metodo_pago'],
      )!,
      observacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observacion'],
      )!,
      pagoCompleto: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pago_completo'],
      )!,
      tipoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_pago'],
      )!,
      estadoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado_pago'],
      )!,
      cuotasIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cuotas_ids'],
      ),
      mora: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mora'],
      )!,
      descuento: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}descuento'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PagosTable createAlias(String alias) {
    return $PagosTable(attachedDatabase, alias);
  }
}

class Pago extends DataClass implements Insertable<Pago> {
  final int idPago;
  final int? idCuota;
  final int? idPrestamo;
  final double? monto;
  final DateTime fechaPago;
  final String metodoPago;
  final String observacion;
  final bool pagoCompleto;
  final String tipoPago;
  final String estadoPago;
  final String? cuotasIds;
  final double mora;
  final double descuento;
  final DateTime createdAt;
  const Pago({
    required this.idPago,
    this.idCuota,
    this.idPrestamo,
    this.monto,
    required this.fechaPago,
    required this.metodoPago,
    required this.observacion,
    required this.pagoCompleto,
    required this.tipoPago,
    required this.estadoPago,
    this.cuotasIds,
    required this.mora,
    required this.descuento,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_pago'] = Variable<int>(idPago);
    if (!nullToAbsent || idCuota != null) {
      map['id_cuota'] = Variable<int>(idCuota);
    }
    if (!nullToAbsent || idPrestamo != null) {
      map['id_prestamo'] = Variable<int>(idPrestamo);
    }
    if (!nullToAbsent || monto != null) {
      map['monto'] = Variable<double>(monto);
    }
    map['fecha_pago'] = Variable<DateTime>(fechaPago);
    map['metodo_pago'] = Variable<String>(metodoPago);
    map['observacion'] = Variable<String>(observacion);
    map['pago_completo'] = Variable<bool>(pagoCompleto);
    map['tipo_pago'] = Variable<String>(tipoPago);
    map['estado_pago'] = Variable<String>(estadoPago);
    if (!nullToAbsent || cuotasIds != null) {
      map['cuotas_ids'] = Variable<String>(cuotasIds);
    }
    map['mora'] = Variable<double>(mora);
    map['descuento'] = Variable<double>(descuento);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PagosCompanion toCompanion(bool nullToAbsent) {
    return PagosCompanion(
      idPago: Value(idPago),
      idCuota: idCuota == null && nullToAbsent
          ? const Value.absent()
          : Value(idCuota),
      idPrestamo: idPrestamo == null && nullToAbsent
          ? const Value.absent()
          : Value(idPrestamo),
      monto: monto == null && nullToAbsent
          ? const Value.absent()
          : Value(monto),
      fechaPago: Value(fechaPago),
      metodoPago: Value(metodoPago),
      observacion: Value(observacion),
      pagoCompleto: Value(pagoCompleto),
      tipoPago: Value(tipoPago),
      estadoPago: Value(estadoPago),
      cuotasIds: cuotasIds == null && nullToAbsent
          ? const Value.absent()
          : Value(cuotasIds),
      mora: Value(mora),
      descuento: Value(descuento),
      createdAt: Value(createdAt),
    );
  }

  factory Pago.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pago(
      idPago: serializer.fromJson<int>(json['idPago']),
      idCuota: serializer.fromJson<int?>(json['idCuota']),
      idPrestamo: serializer.fromJson<int?>(json['idPrestamo']),
      monto: serializer.fromJson<double?>(json['monto']),
      fechaPago: serializer.fromJson<DateTime>(json['fechaPago']),
      metodoPago: serializer.fromJson<String>(json['metodoPago']),
      observacion: serializer.fromJson<String>(json['observacion']),
      pagoCompleto: serializer.fromJson<bool>(json['pagoCompleto']),
      tipoPago: serializer.fromJson<String>(json['tipoPago']),
      estadoPago: serializer.fromJson<String>(json['estadoPago']),
      cuotasIds: serializer.fromJson<String?>(json['cuotasIds']),
      mora: serializer.fromJson<double>(json['mora']),
      descuento: serializer.fromJson<double>(json['descuento']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idPago': serializer.toJson<int>(idPago),
      'idCuota': serializer.toJson<int?>(idCuota),
      'idPrestamo': serializer.toJson<int?>(idPrestamo),
      'monto': serializer.toJson<double?>(monto),
      'fechaPago': serializer.toJson<DateTime>(fechaPago),
      'metodoPago': serializer.toJson<String>(metodoPago),
      'observacion': serializer.toJson<String>(observacion),
      'pagoCompleto': serializer.toJson<bool>(pagoCompleto),
      'tipoPago': serializer.toJson<String>(tipoPago),
      'estadoPago': serializer.toJson<String>(estadoPago),
      'cuotasIds': serializer.toJson<String?>(cuotasIds),
      'mora': serializer.toJson<double>(mora),
      'descuento': serializer.toJson<double>(descuento),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Pago copyWith({
    int? idPago,
    Value<int?> idCuota = const Value.absent(),
    Value<int?> idPrestamo = const Value.absent(),
    Value<double?> monto = const Value.absent(),
    DateTime? fechaPago,
    String? metodoPago,
    String? observacion,
    bool? pagoCompleto,
    String? tipoPago,
    String? estadoPago,
    Value<String?> cuotasIds = const Value.absent(),
    double? mora,
    double? descuento,
    DateTime? createdAt,
  }) => Pago(
    idPago: idPago ?? this.idPago,
    idCuota: idCuota.present ? idCuota.value : this.idCuota,
    idPrestamo: idPrestamo.present ? idPrestamo.value : this.idPrestamo,
    monto: monto.present ? monto.value : this.monto,
    fechaPago: fechaPago ?? this.fechaPago,
    metodoPago: metodoPago ?? this.metodoPago,
    observacion: observacion ?? this.observacion,
    pagoCompleto: pagoCompleto ?? this.pagoCompleto,
    tipoPago: tipoPago ?? this.tipoPago,
    estadoPago: estadoPago ?? this.estadoPago,
    cuotasIds: cuotasIds.present ? cuotasIds.value : this.cuotasIds,
    mora: mora ?? this.mora,
    descuento: descuento ?? this.descuento,
    createdAt: createdAt ?? this.createdAt,
  );
  Pago copyWithCompanion(PagosCompanion data) {
    return Pago(
      idPago: data.idPago.present ? data.idPago.value : this.idPago,
      idCuota: data.idCuota.present ? data.idCuota.value : this.idCuota,
      idPrestamo: data.idPrestamo.present
          ? data.idPrestamo.value
          : this.idPrestamo,
      monto: data.monto.present ? data.monto.value : this.monto,
      fechaPago: data.fechaPago.present ? data.fechaPago.value : this.fechaPago,
      metodoPago: data.metodoPago.present
          ? data.metodoPago.value
          : this.metodoPago,
      observacion: data.observacion.present
          ? data.observacion.value
          : this.observacion,
      pagoCompleto: data.pagoCompleto.present
          ? data.pagoCompleto.value
          : this.pagoCompleto,
      tipoPago: data.tipoPago.present ? data.tipoPago.value : this.tipoPago,
      estadoPago: data.estadoPago.present
          ? data.estadoPago.value
          : this.estadoPago,
      cuotasIds: data.cuotasIds.present ? data.cuotasIds.value : this.cuotasIds,
      mora: data.mora.present ? data.mora.value : this.mora,
      descuento: data.descuento.present ? data.descuento.value : this.descuento,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pago(')
          ..write('idPago: $idPago, ')
          ..write('idCuota: $idCuota, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('monto: $monto, ')
          ..write('fechaPago: $fechaPago, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('observacion: $observacion, ')
          ..write('pagoCompleto: $pagoCompleto, ')
          ..write('tipoPago: $tipoPago, ')
          ..write('estadoPago: $estadoPago, ')
          ..write('cuotasIds: $cuotasIds, ')
          ..write('mora: $mora, ')
          ..write('descuento: $descuento, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idPago,
    idCuota,
    idPrestamo,
    monto,
    fechaPago,
    metodoPago,
    observacion,
    pagoCompleto,
    tipoPago,
    estadoPago,
    cuotasIds,
    mora,
    descuento,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pago &&
          other.idPago == this.idPago &&
          other.idCuota == this.idCuota &&
          other.idPrestamo == this.idPrestamo &&
          other.monto == this.monto &&
          other.fechaPago == this.fechaPago &&
          other.metodoPago == this.metodoPago &&
          other.observacion == this.observacion &&
          other.pagoCompleto == this.pagoCompleto &&
          other.tipoPago == this.tipoPago &&
          other.estadoPago == this.estadoPago &&
          other.cuotasIds == this.cuotasIds &&
          other.mora == this.mora &&
          other.descuento == this.descuento &&
          other.createdAt == this.createdAt);
}

class PagosCompanion extends UpdateCompanion<Pago> {
  final Value<int> idPago;
  final Value<int?> idCuota;
  final Value<int?> idPrestamo;
  final Value<double?> monto;
  final Value<DateTime> fechaPago;
  final Value<String> metodoPago;
  final Value<String> observacion;
  final Value<bool> pagoCompleto;
  final Value<String> tipoPago;
  final Value<String> estadoPago;
  final Value<String?> cuotasIds;
  final Value<double> mora;
  final Value<double> descuento;
  final Value<DateTime> createdAt;
  const PagosCompanion({
    this.idPago = const Value.absent(),
    this.idCuota = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.monto = const Value.absent(),
    this.fechaPago = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.observacion = const Value.absent(),
    this.pagoCompleto = const Value.absent(),
    this.tipoPago = const Value.absent(),
    this.estadoPago = const Value.absent(),
    this.cuotasIds = const Value.absent(),
    this.mora = const Value.absent(),
    this.descuento = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PagosCompanion.insert({
    this.idPago = const Value.absent(),
    this.idCuota = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.monto = const Value.absent(),
    this.fechaPago = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.observacion = const Value.absent(),
    this.pagoCompleto = const Value.absent(),
    this.tipoPago = const Value.absent(),
    this.estadoPago = const Value.absent(),
    this.cuotasIds = const Value.absent(),
    this.mora = const Value.absent(),
    this.descuento = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Pago> custom({
    Expression<int>? idPago,
    Expression<int>? idCuota,
    Expression<int>? idPrestamo,
    Expression<double>? monto,
    Expression<DateTime>? fechaPago,
    Expression<String>? metodoPago,
    Expression<String>? observacion,
    Expression<bool>? pagoCompleto,
    Expression<String>? tipoPago,
    Expression<String>? estadoPago,
    Expression<String>? cuotasIds,
    Expression<double>? mora,
    Expression<double>? descuento,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idPago != null) 'id_pago': idPago,
      if (idCuota != null) 'id_cuota': idCuota,
      if (idPrestamo != null) 'id_prestamo': idPrestamo,
      if (monto != null) 'monto': monto,
      if (fechaPago != null) 'fecha_pago': fechaPago,
      if (metodoPago != null) 'metodo_pago': metodoPago,
      if (observacion != null) 'observacion': observacion,
      if (pagoCompleto != null) 'pago_completo': pagoCompleto,
      if (tipoPago != null) 'tipo_pago': tipoPago,
      if (estadoPago != null) 'estado_pago': estadoPago,
      if (cuotasIds != null) 'cuotas_ids': cuotasIds,
      if (mora != null) 'mora': mora,
      if (descuento != null) 'descuento': descuento,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PagosCompanion copyWith({
    Value<int>? idPago,
    Value<int?>? idCuota,
    Value<int?>? idPrestamo,
    Value<double?>? monto,
    Value<DateTime>? fechaPago,
    Value<String>? metodoPago,
    Value<String>? observacion,
    Value<bool>? pagoCompleto,
    Value<String>? tipoPago,
    Value<String>? estadoPago,
    Value<String?>? cuotasIds,
    Value<double>? mora,
    Value<double>? descuento,
    Value<DateTime>? createdAt,
  }) {
    return PagosCompanion(
      idPago: idPago ?? this.idPago,
      idCuota: idCuota ?? this.idCuota,
      idPrestamo: idPrestamo ?? this.idPrestamo,
      monto: monto ?? this.monto,
      fechaPago: fechaPago ?? this.fechaPago,
      metodoPago: metodoPago ?? this.metodoPago,
      observacion: observacion ?? this.observacion,
      pagoCompleto: pagoCompleto ?? this.pagoCompleto,
      tipoPago: tipoPago ?? this.tipoPago,
      estadoPago: estadoPago ?? this.estadoPago,
      cuotasIds: cuotasIds ?? this.cuotasIds,
      mora: mora ?? this.mora,
      descuento: descuento ?? this.descuento,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idPago.present) {
      map['id_pago'] = Variable<int>(idPago.value);
    }
    if (idCuota.present) {
      map['id_cuota'] = Variable<int>(idCuota.value);
    }
    if (idPrestamo.present) {
      map['id_prestamo'] = Variable<int>(idPrestamo.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fechaPago.present) {
      map['fecha_pago'] = Variable<DateTime>(fechaPago.value);
    }
    if (metodoPago.present) {
      map['metodo_pago'] = Variable<String>(metodoPago.value);
    }
    if (observacion.present) {
      map['observacion'] = Variable<String>(observacion.value);
    }
    if (pagoCompleto.present) {
      map['pago_completo'] = Variable<bool>(pagoCompleto.value);
    }
    if (tipoPago.present) {
      map['tipo_pago'] = Variable<String>(tipoPago.value);
    }
    if (estadoPago.present) {
      map['estado_pago'] = Variable<String>(estadoPago.value);
    }
    if (cuotasIds.present) {
      map['cuotas_ids'] = Variable<String>(cuotasIds.value);
    }
    if (mora.present) {
      map['mora'] = Variable<double>(mora.value);
    }
    if (descuento.present) {
      map['descuento'] = Variable<double>(descuento.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PagosCompanion(')
          ..write('idPago: $idPago, ')
          ..write('idCuota: $idCuota, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('monto: $monto, ')
          ..write('fechaPago: $fechaPago, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('observacion: $observacion, ')
          ..write('pagoCompleto: $pagoCompleto, ')
          ..write('tipoPago: $tipoPago, ')
          ..write('estadoPago: $estadoPago, ')
          ..write('cuotasIds: $cuotasIds, ')
          ..write('mora: $mora, ')
          ..write('descuento: $descuento, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MetodoPagosTable extends MetodoPagos
    with TableInfo<$MetodoPagosTable, MetodoPago> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetodoPagosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMetodoMeta = const VerificationMeta(
    'idMetodo',
  );
  @override
  late final GeneratedColumn<int> idMetodo = GeneratedColumn<int>(
    'id_metodo',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [idMetodo, nombre, descripcion, estado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metodo_pago';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetodoPago> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_metodo')) {
      context.handle(
        _idMetodoMeta,
        idMetodo.isAcceptableOrUnknown(data['id_metodo']!, _idMetodoMeta),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idMetodo};
  @override
  MetodoPago map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetodoPago(
      idMetodo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_metodo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
    );
  }

  @override
  $MetodoPagosTable createAlias(String alias) {
    return $MetodoPagosTable(attachedDatabase, alias);
  }
}

class MetodoPago extends DataClass implements Insertable<MetodoPago> {
  final int idMetodo;
  final String nombre;
  final String descripcion;
  final bool estado;
  const MetodoPago({
    required this.idMetodo,
    required this.nombre,
    required this.descripcion,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_metodo'] = Variable<int>(idMetodo);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['estado'] = Variable<bool>(estado);
    return map;
  }

  MetodoPagosCompanion toCompanion(bool nullToAbsent) {
    return MetodoPagosCompanion(
      idMetodo: Value(idMetodo),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      estado: Value(estado),
    );
  }

  factory MetodoPago.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetodoPago(
      idMetodo: serializer.fromJson<int>(json['idMetodo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      estado: serializer.fromJson<bool>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idMetodo': serializer.toJson<int>(idMetodo),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'estado': serializer.toJson<bool>(estado),
    };
  }

  MetodoPago copyWith({
    int? idMetodo,
    String? nombre,
    String? descripcion,
    bool? estado,
  }) => MetodoPago(
    idMetodo: idMetodo ?? this.idMetodo,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    estado: estado ?? this.estado,
  );
  MetodoPago copyWithCompanion(MetodoPagosCompanion data) {
    return MetodoPago(
      idMetodo: data.idMetodo.present ? data.idMetodo.value : this.idMetodo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetodoPago(')
          ..write('idMetodo: $idMetodo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(idMetodo, nombre, descripcion, estado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetodoPago &&
          other.idMetodo == this.idMetodo &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.estado == this.estado);
}

class MetodoPagosCompanion extends UpdateCompanion<MetodoPago> {
  final Value<int> idMetodo;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<bool> estado;
  const MetodoPagosCompanion({
    this.idMetodo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.estado = const Value.absent(),
  });
  MetodoPagosCompanion.insert({
    this.idMetodo = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.estado = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<MetodoPago> custom({
    Expression<int>? idMetodo,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<bool>? estado,
  }) {
    return RawValuesInsertable({
      if (idMetodo != null) 'id_metodo': idMetodo,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (estado != null) 'estado': estado,
    });
  }

  MetodoPagosCompanion copyWith({
    Value<int>? idMetodo,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<bool>? estado,
  }) {
    return MetodoPagosCompanion(
      idMetodo: idMetodo ?? this.idMetodo,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      estado: estado ?? this.estado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idMetodo.present) {
      map['id_metodo'] = Variable<int>(idMetodo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetodoPagosCompanion(')
          ..write('idMetodo: $idMetodo, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }
}

class $CategoriaEgresosTable extends CategoriaEgresos
    with TableInfo<$CategoriaEgresosTable, CategoriaEgreso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriaEgresosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idCategoriaMeta = const VerificationMeta(
    'idCategoria',
  );
  @override
  late final GeneratedColumn<int> idCategoria = GeneratedColumn<int>(
    'id_categoria',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idCategoria,
    nombre,
    descripcion,
    activo,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categoria_egreso';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriaEgreso> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_categoria')) {
      context.handle(
        _idCategoriaMeta,
        idCategoria.isAcceptableOrUnknown(
          data['id_categoria']!,
          _idCategoriaMeta,
        ),
      );
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idCategoria};
  @override
  CategoriaEgreso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriaEgreso(
      idCategoria: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_categoria'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CategoriaEgresosTable createAlias(String alias) {
    return $CategoriaEgresosTable(attachedDatabase, alias);
  }
}

class CategoriaEgreso extends DataClass implements Insertable<CategoriaEgreso> {
  final int idCategoria;
  final String nombre;
  final String descripcion;
  final bool activo;
  final DateTime createdAt;
  const CategoriaEgreso({
    required this.idCategoria,
    required this.nombre,
    required this.descripcion,
    required this.activo,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_categoria'] = Variable<int>(idCategoria);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['activo'] = Variable<bool>(activo);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoriaEgresosCompanion toCompanion(bool nullToAbsent) {
    return CategoriaEgresosCompanion(
      idCategoria: Value(idCategoria),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      activo: Value(activo),
      createdAt: Value(createdAt),
    );
  }

  factory CategoriaEgreso.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriaEgreso(
      idCategoria: serializer.fromJson<int>(json['idCategoria']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      activo: serializer.fromJson<bool>(json['activo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idCategoria': serializer.toJson<int>(idCategoria),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'activo': serializer.toJson<bool>(activo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CategoriaEgreso copyWith({
    int? idCategoria,
    String? nombre,
    String? descripcion,
    bool? activo,
    DateTime? createdAt,
  }) => CategoriaEgreso(
    idCategoria: idCategoria ?? this.idCategoria,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    activo: activo ?? this.activo,
    createdAt: createdAt ?? this.createdAt,
  );
  CategoriaEgreso copyWithCompanion(CategoriaEgresosCompanion data) {
    return CategoriaEgreso(
      idCategoria: data.idCategoria.present
          ? data.idCategoria.value
          : this.idCategoria,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      activo: data.activo.present ? data.activo.value : this.activo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaEgreso(')
          ..write('idCategoria: $idCategoria, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idCategoria, nombre, descripcion, activo, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriaEgreso &&
          other.idCategoria == this.idCategoria &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.activo == this.activo &&
          other.createdAt == this.createdAt);
}

class CategoriaEgresosCompanion extends UpdateCompanion<CategoriaEgreso> {
  final Value<int> idCategoria;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<bool> activo;
  final Value<DateTime> createdAt;
  const CategoriaEgresosCompanion({
    this.idCategoria = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CategoriaEgresosCompanion.insert({
    this.idCategoria = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.activo = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<CategoriaEgreso> custom({
    Expression<int>? idCategoria,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<bool>? activo,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idCategoria != null) 'id_categoria': idCategoria,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (activo != null) 'activo': activo,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CategoriaEgresosCompanion copyWith({
    Value<int>? idCategoria,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<bool>? activo,
    Value<DateTime>? createdAt,
  }) {
    return CategoriaEgresosCompanion(
      idCategoria: idCategoria ?? this.idCategoria,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idCategoria.present) {
      map['id_categoria'] = Variable<int>(idCategoria.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriaEgresosCompanion(')
          ..write('idCategoria: $idCategoria, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('activo: $activo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EgresosTable extends Egresos with TableInfo<$EgresosTable, Egreso> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EgresosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idEgresoMeta = const VerificationMeta(
    'idEgreso',
  );
  @override
  late final GeneratedColumn<int> idEgreso = GeneratedColumn<int>(
    'id_egreso',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idCategoriaMeta = const VerificationMeta(
    'idCategoria',
  );
  @override
  late final GeneratedColumn<int> idCategoria = GeneratedColumn<int>(
    'id_categoria',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idUsuarioMeta = const VerificationMeta(
    'idUsuario',
  );
  @override
  late final GeneratedColumn<String> idUsuario = GeneratedColumn<String>(
    'id_usuario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conceptoMeta = const VerificationMeta(
    'concepto',
  );
  @override
  late final GeneratedColumn<String> concepto = GeneratedColumn<String>(
    'concepto',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observacionesMeta = const VerificationMeta(
    'observaciones',
  );
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
    'observaciones',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<bool> estado = GeneratedColumn<bool>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("estado" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idEgreso,
    idCategoria,
    idUsuario,
    descripcion,
    concepto,
    monto,
    fecha,
    observaciones,
    estado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'egreso';
  @override
  VerificationContext validateIntegrity(
    Insertable<Egreso> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_egreso')) {
      context.handle(
        _idEgresoMeta,
        idEgreso.isAcceptableOrUnknown(data['id_egreso']!, _idEgresoMeta),
      );
    }
    if (data.containsKey('id_categoria')) {
      context.handle(
        _idCategoriaMeta,
        idCategoria.isAcceptableOrUnknown(
          data['id_categoria']!,
          _idCategoriaMeta,
        ),
      );
    }
    if (data.containsKey('id_usuario')) {
      context.handle(
        _idUsuarioMeta,
        idUsuario.isAcceptableOrUnknown(data['id_usuario']!, _idUsuarioMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('concepto')) {
      context.handle(
        _conceptoMeta,
        concepto.isAcceptableOrUnknown(data['concepto']!, _conceptoMeta),
      );
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    if (data.containsKey('observaciones')) {
      context.handle(
        _observacionesMeta,
        observaciones.isAcceptableOrUnknown(
          data['observaciones']!,
          _observacionesMeta,
        ),
      );
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idEgreso};
  @override
  Egreso map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Egreso(
      idEgreso: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_egreso'],
      )!,
      idCategoria: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_categoria'],
      ),
      idUsuario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_usuario'],
      ),
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      concepto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concepto'],
      ),
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      ),
      observaciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observaciones'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}estado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $EgresosTable createAlias(String alias) {
    return $EgresosTable(attachedDatabase, alias);
  }
}

class Egreso extends DataClass implements Insertable<Egreso> {
  final int idEgreso;
  final int? idCategoria;
  final String? idUsuario;
  final String? descripcion;
  final String? concepto;
  final double? monto;
  final DateTime? fecha;
  final String observaciones;
  final bool estado;
  final DateTime createdAt;
  const Egreso({
    required this.idEgreso,
    this.idCategoria,
    this.idUsuario,
    this.descripcion,
    this.concepto,
    this.monto,
    this.fecha,
    required this.observaciones,
    required this.estado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_egreso'] = Variable<int>(idEgreso);
    if (!nullToAbsent || idCategoria != null) {
      map['id_categoria'] = Variable<int>(idCategoria);
    }
    if (!nullToAbsent || idUsuario != null) {
      map['id_usuario'] = Variable<String>(idUsuario);
    }
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || concepto != null) {
      map['concepto'] = Variable<String>(concepto);
    }
    if (!nullToAbsent || monto != null) {
      map['monto'] = Variable<double>(monto);
    }
    if (!nullToAbsent || fecha != null) {
      map['fecha'] = Variable<DateTime>(fecha);
    }
    map['observaciones'] = Variable<String>(observaciones);
    map['estado'] = Variable<bool>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  EgresosCompanion toCompanion(bool nullToAbsent) {
    return EgresosCompanion(
      idEgreso: Value(idEgreso),
      idCategoria: idCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(idCategoria),
      idUsuario: idUsuario == null && nullToAbsent
          ? const Value.absent()
          : Value(idUsuario),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      concepto: concepto == null && nullToAbsent
          ? const Value.absent()
          : Value(concepto),
      monto: monto == null && nullToAbsent
          ? const Value.absent()
          : Value(monto),
      fecha: fecha == null && nullToAbsent
          ? const Value.absent()
          : Value(fecha),
      observaciones: Value(observaciones),
      estado: Value(estado),
      createdAt: Value(createdAt),
    );
  }

  factory Egreso.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Egreso(
      idEgreso: serializer.fromJson<int>(json['idEgreso']),
      idCategoria: serializer.fromJson<int?>(json['idCategoria']),
      idUsuario: serializer.fromJson<String?>(json['idUsuario']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      concepto: serializer.fromJson<String?>(json['concepto']),
      monto: serializer.fromJson<double?>(json['monto']),
      fecha: serializer.fromJson<DateTime?>(json['fecha']),
      observaciones: serializer.fromJson<String>(json['observaciones']),
      estado: serializer.fromJson<bool>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idEgreso': serializer.toJson<int>(idEgreso),
      'idCategoria': serializer.toJson<int?>(idCategoria),
      'idUsuario': serializer.toJson<String?>(idUsuario),
      'descripcion': serializer.toJson<String?>(descripcion),
      'concepto': serializer.toJson<String?>(concepto),
      'monto': serializer.toJson<double?>(monto),
      'fecha': serializer.toJson<DateTime?>(fecha),
      'observaciones': serializer.toJson<String>(observaciones),
      'estado': serializer.toJson<bool>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Egreso copyWith({
    int? idEgreso,
    Value<int?> idCategoria = const Value.absent(),
    Value<String?> idUsuario = const Value.absent(),
    Value<String?> descripcion = const Value.absent(),
    Value<String?> concepto = const Value.absent(),
    Value<double?> monto = const Value.absent(),
    Value<DateTime?> fecha = const Value.absent(),
    String? observaciones,
    bool? estado,
    DateTime? createdAt,
  }) => Egreso(
    idEgreso: idEgreso ?? this.idEgreso,
    idCategoria: idCategoria.present ? idCategoria.value : this.idCategoria,
    idUsuario: idUsuario.present ? idUsuario.value : this.idUsuario,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    concepto: concepto.present ? concepto.value : this.concepto,
    monto: monto.present ? monto.value : this.monto,
    fecha: fecha.present ? fecha.value : this.fecha,
    observaciones: observaciones ?? this.observaciones,
    estado: estado ?? this.estado,
    createdAt: createdAt ?? this.createdAt,
  );
  Egreso copyWithCompanion(EgresosCompanion data) {
    return Egreso(
      idEgreso: data.idEgreso.present ? data.idEgreso.value : this.idEgreso,
      idCategoria: data.idCategoria.present
          ? data.idCategoria.value
          : this.idCategoria,
      idUsuario: data.idUsuario.present ? data.idUsuario.value : this.idUsuario,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      concepto: data.concepto.present ? data.concepto.value : this.concepto,
      monto: data.monto.present ? data.monto.value : this.monto,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Egreso(')
          ..write('idEgreso: $idEgreso, ')
          ..write('idCategoria: $idCategoria, ')
          ..write('idUsuario: $idUsuario, ')
          ..write('descripcion: $descripcion, ')
          ..write('concepto: $concepto, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('observaciones: $observaciones, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idEgreso,
    idCategoria,
    idUsuario,
    descripcion,
    concepto,
    monto,
    fecha,
    observaciones,
    estado,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Egreso &&
          other.idEgreso == this.idEgreso &&
          other.idCategoria == this.idCategoria &&
          other.idUsuario == this.idUsuario &&
          other.descripcion == this.descripcion &&
          other.concepto == this.concepto &&
          other.monto == this.monto &&
          other.fecha == this.fecha &&
          other.observaciones == this.observaciones &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt);
}

class EgresosCompanion extends UpdateCompanion<Egreso> {
  final Value<int> idEgreso;
  final Value<int?> idCategoria;
  final Value<String?> idUsuario;
  final Value<String?> descripcion;
  final Value<String?> concepto;
  final Value<double?> monto;
  final Value<DateTime?> fecha;
  final Value<String> observaciones;
  final Value<bool> estado;
  final Value<DateTime> createdAt;
  const EgresosCompanion({
    this.idEgreso = const Value.absent(),
    this.idCategoria = const Value.absent(),
    this.idUsuario = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.concepto = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  EgresosCompanion.insert({
    this.idEgreso = const Value.absent(),
    this.idCategoria = const Value.absent(),
    this.idUsuario = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.concepto = const Value.absent(),
    this.monto = const Value.absent(),
    this.fecha = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Egreso> custom({
    Expression<int>? idEgreso,
    Expression<int>? idCategoria,
    Expression<String>? idUsuario,
    Expression<String>? descripcion,
    Expression<String>? concepto,
    Expression<double>? monto,
    Expression<DateTime>? fecha,
    Expression<String>? observaciones,
    Expression<bool>? estado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idEgreso != null) 'id_egreso': idEgreso,
      if (idCategoria != null) 'id_categoria': idCategoria,
      if (idUsuario != null) 'id_usuario': idUsuario,
      if (descripcion != null) 'descripcion': descripcion,
      if (concepto != null) 'concepto': concepto,
      if (monto != null) 'monto': monto,
      if (fecha != null) 'fecha': fecha,
      if (observaciones != null) 'observaciones': observaciones,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  EgresosCompanion copyWith({
    Value<int>? idEgreso,
    Value<int?>? idCategoria,
    Value<String?>? idUsuario,
    Value<String?>? descripcion,
    Value<String?>? concepto,
    Value<double?>? monto,
    Value<DateTime?>? fecha,
    Value<String>? observaciones,
    Value<bool>? estado,
    Value<DateTime>? createdAt,
  }) {
    return EgresosCompanion(
      idEgreso: idEgreso ?? this.idEgreso,
      idCategoria: idCategoria ?? this.idCategoria,
      idUsuario: idUsuario ?? this.idUsuario,
      descripcion: descripcion ?? this.descripcion,
      concepto: concepto ?? this.concepto,
      monto: monto ?? this.monto,
      fecha: fecha ?? this.fecha,
      observaciones: observaciones ?? this.observaciones,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idEgreso.present) {
      map['id_egreso'] = Variable<int>(idEgreso.value);
    }
    if (idCategoria.present) {
      map['id_categoria'] = Variable<int>(idCategoria.value);
    }
    if (idUsuario.present) {
      map['id_usuario'] = Variable<String>(idUsuario.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (concepto.present) {
      map['concepto'] = Variable<String>(concepto.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (estado.present) {
      map['estado'] = Variable<bool>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EgresosCompanion(')
          ..write('idEgreso: $idEgreso, ')
          ..write('idCategoria: $idCategoria, ')
          ..write('idUsuario: $idUsuario, ')
          ..write('descripcion: $descripcion, ')
          ..write('concepto: $concepto, ')
          ..write('monto: $monto, ')
          ..write('fecha: $fecha, ')
          ..write('observaciones: $observaciones, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SimulacionPrestamosTable extends SimulacionPrestamos
    with TableInfo<$SimulacionPrestamosTable, SimulacionPrestamo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SimulacionPrestamosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idSimulacionMeta = const VerificationMeta(
    'idSimulacion',
  );
  @override
  late final GeneratedColumn<int> idSimulacion = GeneratedColumn<int>(
    'id_simulacion',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idUsuarioMeta = const VerificationMeta(
    'idUsuario',
  );
  @override
  late final GeneratedColumn<String> idUsuario = GeneratedColumn<String>(
    'id_usuario',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _montoMeta = const VerificationMeta('monto');
  @override
  late final GeneratedColumn<double> monto = GeneratedColumn<double>(
    'monto',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interesMeta = const VerificationMeta(
    'interes',
  );
  @override
  late final GeneratedColumn<double> interes = GeneratedColumn<double>(
    'interes',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroCuotasMeta = const VerificationMeta(
    'numeroCuotas',
  );
  @override
  late final GeneratedColumn<int> numeroCuotas = GeneratedColumn<int>(
    'numero_cuotas',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frecuenciaPagoMeta = const VerificationMeta(
    'frecuenciaPago',
  );
  @override
  late final GeneratedColumn<String> frecuenciaPago = GeneratedColumn<String>(
    'frecuencia_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoPrestamoMeta = const VerificationMeta(
    'tipoPrestamo',
  );
  @override
  late final GeneratedColumn<String> tipoPrestamo = GeneratedColumn<String>(
    'tipo_prestamo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaInicioMeta = const VerificationMeta(
    'fechaInicio',
  );
  @override
  late final GeneratedColumn<DateTime> fechaInicio = GeneratedColumn<DateTime>(
    'fecha_inicio',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCobrarMeta = const VerificationMeta(
    'totalCobrar',
  );
  @override
  late final GeneratedColumn<double> totalCobrar = GeneratedColumn<double>(
    'total_cobrar',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _interesTotalMeta = const VerificationMeta(
    'interesTotal',
  );
  @override
  late final GeneratedColumn<double> interesTotal = GeneratedColumn<double>(
    'interes_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorCuotaMeta = const VerificationMeta(
    'valorCuota',
  );
  @override
  late final GeneratedColumn<double> valorCuota = GeneratedColumn<double>(
    'valor_cuota',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planPagosMeta = const VerificationMeta(
    'planPagos',
  );
  @override
  late final GeneratedColumn<String> planPagos = GeneratedColumn<String>(
    'plan_pagos',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idSimulacion,
    idUsuario,
    monto,
    interes,
    numeroCuotas,
    frecuenciaPago,
    tipoPrestamo,
    fechaInicio,
    totalCobrar,
    interesTotal,
    valorCuota,
    planPagos,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'simulacion_prestamo';
  @override
  VerificationContext validateIntegrity(
    Insertable<SimulacionPrestamo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_simulacion')) {
      context.handle(
        _idSimulacionMeta,
        idSimulacion.isAcceptableOrUnknown(
          data['id_simulacion']!,
          _idSimulacionMeta,
        ),
      );
    }
    if (data.containsKey('id_usuario')) {
      context.handle(
        _idUsuarioMeta,
        idUsuario.isAcceptableOrUnknown(data['id_usuario']!, _idUsuarioMeta),
      );
    }
    if (data.containsKey('monto')) {
      context.handle(
        _montoMeta,
        monto.isAcceptableOrUnknown(data['monto']!, _montoMeta),
      );
    } else if (isInserting) {
      context.missing(_montoMeta);
    }
    if (data.containsKey('interes')) {
      context.handle(
        _interesMeta,
        interes.isAcceptableOrUnknown(data['interes']!, _interesMeta),
      );
    } else if (isInserting) {
      context.missing(_interesMeta);
    }
    if (data.containsKey('numero_cuotas')) {
      context.handle(
        _numeroCuotasMeta,
        numeroCuotas.isAcceptableOrUnknown(
          data['numero_cuotas']!,
          _numeroCuotasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numeroCuotasMeta);
    }
    if (data.containsKey('frecuencia_pago')) {
      context.handle(
        _frecuenciaPagoMeta,
        frecuenciaPago.isAcceptableOrUnknown(
          data['frecuencia_pago']!,
          _frecuenciaPagoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frecuenciaPagoMeta);
    }
    if (data.containsKey('tipo_prestamo')) {
      context.handle(
        _tipoPrestamoMeta,
        tipoPrestamo.isAcceptableOrUnknown(
          data['tipo_prestamo']!,
          _tipoPrestamoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tipoPrestamoMeta);
    }
    if (data.containsKey('fecha_inicio')) {
      context.handle(
        _fechaInicioMeta,
        fechaInicio.isAcceptableOrUnknown(
          data['fecha_inicio']!,
          _fechaInicioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaInicioMeta);
    }
    if (data.containsKey('total_cobrar')) {
      context.handle(
        _totalCobrarMeta,
        totalCobrar.isAcceptableOrUnknown(
          data['total_cobrar']!,
          _totalCobrarMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCobrarMeta);
    }
    if (data.containsKey('interes_total')) {
      context.handle(
        _interesTotalMeta,
        interesTotal.isAcceptableOrUnknown(
          data['interes_total']!,
          _interesTotalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interesTotalMeta);
    }
    if (data.containsKey('valor_cuota')) {
      context.handle(
        _valorCuotaMeta,
        valorCuota.isAcceptableOrUnknown(data['valor_cuota']!, _valorCuotaMeta),
      );
    } else if (isInserting) {
      context.missing(_valorCuotaMeta);
    }
    if (data.containsKey('plan_pagos')) {
      context.handle(
        _planPagosMeta,
        planPagos.isAcceptableOrUnknown(data['plan_pagos']!, _planPagosMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idSimulacion};
  @override
  SimulacionPrestamo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SimulacionPrestamo(
      idSimulacion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_simulacion'],
      )!,
      idUsuario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_usuario'],
      ),
      monto: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monto'],
      )!,
      interes: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interes'],
      )!,
      numeroCuotas: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero_cuotas'],
      )!,
      frecuenciaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frecuencia_pago'],
      )!,
      tipoPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo_prestamo'],
      )!,
      fechaInicio: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_inicio'],
      )!,
      totalCobrar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cobrar'],
      )!,
      interesTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interes_total'],
      )!,
      valorCuota: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valor_cuota'],
      )!,
      planPagos: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_pagos'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SimulacionPrestamosTable createAlias(String alias) {
    return $SimulacionPrestamosTable(attachedDatabase, alias);
  }
}

class SimulacionPrestamo extends DataClass
    implements Insertable<SimulacionPrestamo> {
  final int idSimulacion;
  final String? idUsuario;
  final double monto;
  final double interes;
  final int numeroCuotas;
  final String frecuenciaPago;
  final String tipoPrestamo;
  final DateTime fechaInicio;
  final double totalCobrar;
  final double interesTotal;
  final double valorCuota;
  final String? planPagos;
  final DateTime createdAt;
  const SimulacionPrestamo({
    required this.idSimulacion,
    this.idUsuario,
    required this.monto,
    required this.interes,
    required this.numeroCuotas,
    required this.frecuenciaPago,
    required this.tipoPrestamo,
    required this.fechaInicio,
    required this.totalCobrar,
    required this.interesTotal,
    required this.valorCuota,
    this.planPagos,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_simulacion'] = Variable<int>(idSimulacion);
    if (!nullToAbsent || idUsuario != null) {
      map['id_usuario'] = Variable<String>(idUsuario);
    }
    map['monto'] = Variable<double>(monto);
    map['interes'] = Variable<double>(interes);
    map['numero_cuotas'] = Variable<int>(numeroCuotas);
    map['frecuencia_pago'] = Variable<String>(frecuenciaPago);
    map['tipo_prestamo'] = Variable<String>(tipoPrestamo);
    map['fecha_inicio'] = Variable<DateTime>(fechaInicio);
    map['total_cobrar'] = Variable<double>(totalCobrar);
    map['interes_total'] = Variable<double>(interesTotal);
    map['valor_cuota'] = Variable<double>(valorCuota);
    if (!nullToAbsent || planPagos != null) {
      map['plan_pagos'] = Variable<String>(planPagos);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SimulacionPrestamosCompanion toCompanion(bool nullToAbsent) {
    return SimulacionPrestamosCompanion(
      idSimulacion: Value(idSimulacion),
      idUsuario: idUsuario == null && nullToAbsent
          ? const Value.absent()
          : Value(idUsuario),
      monto: Value(monto),
      interes: Value(interes),
      numeroCuotas: Value(numeroCuotas),
      frecuenciaPago: Value(frecuenciaPago),
      tipoPrestamo: Value(tipoPrestamo),
      fechaInicio: Value(fechaInicio),
      totalCobrar: Value(totalCobrar),
      interesTotal: Value(interesTotal),
      valorCuota: Value(valorCuota),
      planPagos: planPagos == null && nullToAbsent
          ? const Value.absent()
          : Value(planPagos),
      createdAt: Value(createdAt),
    );
  }

  factory SimulacionPrestamo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SimulacionPrestamo(
      idSimulacion: serializer.fromJson<int>(json['idSimulacion']),
      idUsuario: serializer.fromJson<String?>(json['idUsuario']),
      monto: serializer.fromJson<double>(json['monto']),
      interes: serializer.fromJson<double>(json['interes']),
      numeroCuotas: serializer.fromJson<int>(json['numeroCuotas']),
      frecuenciaPago: serializer.fromJson<String>(json['frecuenciaPago']),
      tipoPrestamo: serializer.fromJson<String>(json['tipoPrestamo']),
      fechaInicio: serializer.fromJson<DateTime>(json['fechaInicio']),
      totalCobrar: serializer.fromJson<double>(json['totalCobrar']),
      interesTotal: serializer.fromJson<double>(json['interesTotal']),
      valorCuota: serializer.fromJson<double>(json['valorCuota']),
      planPagos: serializer.fromJson<String?>(json['planPagos']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idSimulacion': serializer.toJson<int>(idSimulacion),
      'idUsuario': serializer.toJson<String?>(idUsuario),
      'monto': serializer.toJson<double>(monto),
      'interes': serializer.toJson<double>(interes),
      'numeroCuotas': serializer.toJson<int>(numeroCuotas),
      'frecuenciaPago': serializer.toJson<String>(frecuenciaPago),
      'tipoPrestamo': serializer.toJson<String>(tipoPrestamo),
      'fechaInicio': serializer.toJson<DateTime>(fechaInicio),
      'totalCobrar': serializer.toJson<double>(totalCobrar),
      'interesTotal': serializer.toJson<double>(interesTotal),
      'valorCuota': serializer.toJson<double>(valorCuota),
      'planPagos': serializer.toJson<String?>(planPagos),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SimulacionPrestamo copyWith({
    int? idSimulacion,
    Value<String?> idUsuario = const Value.absent(),
    double? monto,
    double? interes,
    int? numeroCuotas,
    String? frecuenciaPago,
    String? tipoPrestamo,
    DateTime? fechaInicio,
    double? totalCobrar,
    double? interesTotal,
    double? valorCuota,
    Value<String?> planPagos = const Value.absent(),
    DateTime? createdAt,
  }) => SimulacionPrestamo(
    idSimulacion: idSimulacion ?? this.idSimulacion,
    idUsuario: idUsuario.present ? idUsuario.value : this.idUsuario,
    monto: monto ?? this.monto,
    interes: interes ?? this.interes,
    numeroCuotas: numeroCuotas ?? this.numeroCuotas,
    frecuenciaPago: frecuenciaPago ?? this.frecuenciaPago,
    tipoPrestamo: tipoPrestamo ?? this.tipoPrestamo,
    fechaInicio: fechaInicio ?? this.fechaInicio,
    totalCobrar: totalCobrar ?? this.totalCobrar,
    interesTotal: interesTotal ?? this.interesTotal,
    valorCuota: valorCuota ?? this.valorCuota,
    planPagos: planPagos.present ? planPagos.value : this.planPagos,
    createdAt: createdAt ?? this.createdAt,
  );
  SimulacionPrestamo copyWithCompanion(SimulacionPrestamosCompanion data) {
    return SimulacionPrestamo(
      idSimulacion: data.idSimulacion.present
          ? data.idSimulacion.value
          : this.idSimulacion,
      idUsuario: data.idUsuario.present ? data.idUsuario.value : this.idUsuario,
      monto: data.monto.present ? data.monto.value : this.monto,
      interes: data.interes.present ? data.interes.value : this.interes,
      numeroCuotas: data.numeroCuotas.present
          ? data.numeroCuotas.value
          : this.numeroCuotas,
      frecuenciaPago: data.frecuenciaPago.present
          ? data.frecuenciaPago.value
          : this.frecuenciaPago,
      tipoPrestamo: data.tipoPrestamo.present
          ? data.tipoPrestamo.value
          : this.tipoPrestamo,
      fechaInicio: data.fechaInicio.present
          ? data.fechaInicio.value
          : this.fechaInicio,
      totalCobrar: data.totalCobrar.present
          ? data.totalCobrar.value
          : this.totalCobrar,
      interesTotal: data.interesTotal.present
          ? data.interesTotal.value
          : this.interesTotal,
      valorCuota: data.valorCuota.present
          ? data.valorCuota.value
          : this.valorCuota,
      planPagos: data.planPagos.present ? data.planPagos.value : this.planPagos,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SimulacionPrestamo(')
          ..write('idSimulacion: $idSimulacion, ')
          ..write('idUsuario: $idUsuario, ')
          ..write('monto: $monto, ')
          ..write('interes: $interes, ')
          ..write('numeroCuotas: $numeroCuotas, ')
          ..write('frecuenciaPago: $frecuenciaPago, ')
          ..write('tipoPrestamo: $tipoPrestamo, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('totalCobrar: $totalCobrar, ')
          ..write('interesTotal: $interesTotal, ')
          ..write('valorCuota: $valorCuota, ')
          ..write('planPagos: $planPagos, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idSimulacion,
    idUsuario,
    monto,
    interes,
    numeroCuotas,
    frecuenciaPago,
    tipoPrestamo,
    fechaInicio,
    totalCobrar,
    interesTotal,
    valorCuota,
    planPagos,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SimulacionPrestamo &&
          other.idSimulacion == this.idSimulacion &&
          other.idUsuario == this.idUsuario &&
          other.monto == this.monto &&
          other.interes == this.interes &&
          other.numeroCuotas == this.numeroCuotas &&
          other.frecuenciaPago == this.frecuenciaPago &&
          other.tipoPrestamo == this.tipoPrestamo &&
          other.fechaInicio == this.fechaInicio &&
          other.totalCobrar == this.totalCobrar &&
          other.interesTotal == this.interesTotal &&
          other.valorCuota == this.valorCuota &&
          other.planPagos == this.planPagos &&
          other.createdAt == this.createdAt);
}

class SimulacionPrestamosCompanion extends UpdateCompanion<SimulacionPrestamo> {
  final Value<int> idSimulacion;
  final Value<String?> idUsuario;
  final Value<double> monto;
  final Value<double> interes;
  final Value<int> numeroCuotas;
  final Value<String> frecuenciaPago;
  final Value<String> tipoPrestamo;
  final Value<DateTime> fechaInicio;
  final Value<double> totalCobrar;
  final Value<double> interesTotal;
  final Value<double> valorCuota;
  final Value<String?> planPagos;
  final Value<DateTime> createdAt;
  const SimulacionPrestamosCompanion({
    this.idSimulacion = const Value.absent(),
    this.idUsuario = const Value.absent(),
    this.monto = const Value.absent(),
    this.interes = const Value.absent(),
    this.numeroCuotas = const Value.absent(),
    this.frecuenciaPago = const Value.absent(),
    this.tipoPrestamo = const Value.absent(),
    this.fechaInicio = const Value.absent(),
    this.totalCobrar = const Value.absent(),
    this.interesTotal = const Value.absent(),
    this.valorCuota = const Value.absent(),
    this.planPagos = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SimulacionPrestamosCompanion.insert({
    this.idSimulacion = const Value.absent(),
    this.idUsuario = const Value.absent(),
    required double monto,
    required double interes,
    required int numeroCuotas,
    required String frecuenciaPago,
    required String tipoPrestamo,
    required DateTime fechaInicio,
    required double totalCobrar,
    required double interesTotal,
    required double valorCuota,
    this.planPagos = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : monto = Value(monto),
       interes = Value(interes),
       numeroCuotas = Value(numeroCuotas),
       frecuenciaPago = Value(frecuenciaPago),
       tipoPrestamo = Value(tipoPrestamo),
       fechaInicio = Value(fechaInicio),
       totalCobrar = Value(totalCobrar),
       interesTotal = Value(interesTotal),
       valorCuota = Value(valorCuota);
  static Insertable<SimulacionPrestamo> custom({
    Expression<int>? idSimulacion,
    Expression<String>? idUsuario,
    Expression<double>? monto,
    Expression<double>? interes,
    Expression<int>? numeroCuotas,
    Expression<String>? frecuenciaPago,
    Expression<String>? tipoPrestamo,
    Expression<DateTime>? fechaInicio,
    Expression<double>? totalCobrar,
    Expression<double>? interesTotal,
    Expression<double>? valorCuota,
    Expression<String>? planPagos,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idSimulacion != null) 'id_simulacion': idSimulacion,
      if (idUsuario != null) 'id_usuario': idUsuario,
      if (monto != null) 'monto': monto,
      if (interes != null) 'interes': interes,
      if (numeroCuotas != null) 'numero_cuotas': numeroCuotas,
      if (frecuenciaPago != null) 'frecuencia_pago': frecuenciaPago,
      if (tipoPrestamo != null) 'tipo_prestamo': tipoPrestamo,
      if (fechaInicio != null) 'fecha_inicio': fechaInicio,
      if (totalCobrar != null) 'total_cobrar': totalCobrar,
      if (interesTotal != null) 'interes_total': interesTotal,
      if (valorCuota != null) 'valor_cuota': valorCuota,
      if (planPagos != null) 'plan_pagos': planPagos,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SimulacionPrestamosCompanion copyWith({
    Value<int>? idSimulacion,
    Value<String?>? idUsuario,
    Value<double>? monto,
    Value<double>? interes,
    Value<int>? numeroCuotas,
    Value<String>? frecuenciaPago,
    Value<String>? tipoPrestamo,
    Value<DateTime>? fechaInicio,
    Value<double>? totalCobrar,
    Value<double>? interesTotal,
    Value<double>? valorCuota,
    Value<String?>? planPagos,
    Value<DateTime>? createdAt,
  }) {
    return SimulacionPrestamosCompanion(
      idSimulacion: idSimulacion ?? this.idSimulacion,
      idUsuario: idUsuario ?? this.idUsuario,
      monto: monto ?? this.monto,
      interes: interes ?? this.interes,
      numeroCuotas: numeroCuotas ?? this.numeroCuotas,
      frecuenciaPago: frecuenciaPago ?? this.frecuenciaPago,
      tipoPrestamo: tipoPrestamo ?? this.tipoPrestamo,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      totalCobrar: totalCobrar ?? this.totalCobrar,
      interesTotal: interesTotal ?? this.interesTotal,
      valorCuota: valorCuota ?? this.valorCuota,
      planPagos: planPagos ?? this.planPagos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idSimulacion.present) {
      map['id_simulacion'] = Variable<int>(idSimulacion.value);
    }
    if (idUsuario.present) {
      map['id_usuario'] = Variable<String>(idUsuario.value);
    }
    if (monto.present) {
      map['monto'] = Variable<double>(monto.value);
    }
    if (interes.present) {
      map['interes'] = Variable<double>(interes.value);
    }
    if (numeroCuotas.present) {
      map['numero_cuotas'] = Variable<int>(numeroCuotas.value);
    }
    if (frecuenciaPago.present) {
      map['frecuencia_pago'] = Variable<String>(frecuenciaPago.value);
    }
    if (tipoPrestamo.present) {
      map['tipo_prestamo'] = Variable<String>(tipoPrestamo.value);
    }
    if (fechaInicio.present) {
      map['fecha_inicio'] = Variable<DateTime>(fechaInicio.value);
    }
    if (totalCobrar.present) {
      map['total_cobrar'] = Variable<double>(totalCobrar.value);
    }
    if (interesTotal.present) {
      map['interes_total'] = Variable<double>(interesTotal.value);
    }
    if (valorCuota.present) {
      map['valor_cuota'] = Variable<double>(valorCuota.value);
    }
    if (planPagos.present) {
      map['plan_pagos'] = Variable<String>(planPagos.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SimulacionPrestamosCompanion(')
          ..write('idSimulacion: $idSimulacion, ')
          ..write('idUsuario: $idUsuario, ')
          ..write('monto: $monto, ')
          ..write('interes: $interes, ')
          ..write('numeroCuotas: $numeroCuotas, ')
          ..write('frecuenciaPago: $frecuenciaPago, ')
          ..write('tipoPrestamo: $tipoPrestamo, ')
          ..write('fechaInicio: $fechaInicio, ')
          ..write('totalCobrar: $totalCobrar, ')
          ..write('interesTotal: $interesTotal, ')
          ..write('valorCuota: $valorCuota, ')
          ..write('planPagos: $planPagos, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PlanPagosTable extends PlanPagos
    with TableInfo<$PlanPagosTable, PlanPago> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanPagosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idPlanMeta = const VerificationMeta('idPlan');
  @override
  late final GeneratedColumn<int> idPlan = GeneratedColumn<int>(
    'id_plan',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idPrestamoMeta = const VerificationMeta(
    'idPrestamo',
  );
  @override
  late final GeneratedColumn<int> idPrestamo = GeneratedColumn<int>(
    'id_prestamo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _numeroCuotasMeta = const VerificationMeta(
    'numeroCuotas',
  );
  @override
  late final GeneratedColumn<int> numeroCuotas = GeneratedColumn<int>(
    'numero_cuotas',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frecuenciaPagoMeta = const VerificationMeta(
    'frecuenciaPago',
  );
  @override
  late final GeneratedColumn<String> frecuenciaPago = GeneratedColumn<String>(
    'frecuencia_pago',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idPlan,
    idPrestamo,
    numeroCuotas,
    frecuenciaPago,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_pagos';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanPago> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_plan')) {
      context.handle(
        _idPlanMeta,
        idPlan.isAcceptableOrUnknown(data['id_plan']!, _idPlanMeta),
      );
    }
    if (data.containsKey('id_prestamo')) {
      context.handle(
        _idPrestamoMeta,
        idPrestamo.isAcceptableOrUnknown(data['id_prestamo']!, _idPrestamoMeta),
      );
    }
    if (data.containsKey('numero_cuotas')) {
      context.handle(
        _numeroCuotasMeta,
        numeroCuotas.isAcceptableOrUnknown(
          data['numero_cuotas']!,
          _numeroCuotasMeta,
        ),
      );
    }
    if (data.containsKey('frecuencia_pago')) {
      context.handle(
        _frecuenciaPagoMeta,
        frecuenciaPago.isAcceptableOrUnknown(
          data['frecuencia_pago']!,
          _frecuenciaPagoMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idPlan};
  @override
  PlanPago map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanPago(
      idPlan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_plan'],
      )!,
      idPrestamo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_prestamo'],
      ),
      numeroCuotas: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}numero_cuotas'],
      ),
      frecuenciaPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frecuencia_pago'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlanPagosTable createAlias(String alias) {
    return $PlanPagosTable(attachedDatabase, alias);
  }
}

class PlanPago extends DataClass implements Insertable<PlanPago> {
  final int idPlan;
  final int? idPrestamo;
  final int? numeroCuotas;
  final String? frecuenciaPago;
  final DateTime createdAt;
  const PlanPago({
    required this.idPlan,
    this.idPrestamo,
    this.numeroCuotas,
    this.frecuenciaPago,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_plan'] = Variable<int>(idPlan);
    if (!nullToAbsent || idPrestamo != null) {
      map['id_prestamo'] = Variable<int>(idPrestamo);
    }
    if (!nullToAbsent || numeroCuotas != null) {
      map['numero_cuotas'] = Variable<int>(numeroCuotas);
    }
    if (!nullToAbsent || frecuenciaPago != null) {
      map['frecuencia_pago'] = Variable<String>(frecuenciaPago);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlanPagosCompanion toCompanion(bool nullToAbsent) {
    return PlanPagosCompanion(
      idPlan: Value(idPlan),
      idPrestamo: idPrestamo == null && nullToAbsent
          ? const Value.absent()
          : Value(idPrestamo),
      numeroCuotas: numeroCuotas == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroCuotas),
      frecuenciaPago: frecuenciaPago == null && nullToAbsent
          ? const Value.absent()
          : Value(frecuenciaPago),
      createdAt: Value(createdAt),
    );
  }

  factory PlanPago.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanPago(
      idPlan: serializer.fromJson<int>(json['idPlan']),
      idPrestamo: serializer.fromJson<int?>(json['idPrestamo']),
      numeroCuotas: serializer.fromJson<int?>(json['numeroCuotas']),
      frecuenciaPago: serializer.fromJson<String?>(json['frecuenciaPago']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idPlan': serializer.toJson<int>(idPlan),
      'idPrestamo': serializer.toJson<int?>(idPrestamo),
      'numeroCuotas': serializer.toJson<int?>(numeroCuotas),
      'frecuenciaPago': serializer.toJson<String?>(frecuenciaPago),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlanPago copyWith({
    int? idPlan,
    Value<int?> idPrestamo = const Value.absent(),
    Value<int?> numeroCuotas = const Value.absent(),
    Value<String?> frecuenciaPago = const Value.absent(),
    DateTime? createdAt,
  }) => PlanPago(
    idPlan: idPlan ?? this.idPlan,
    idPrestamo: idPrestamo.present ? idPrestamo.value : this.idPrestamo,
    numeroCuotas: numeroCuotas.present ? numeroCuotas.value : this.numeroCuotas,
    frecuenciaPago: frecuenciaPago.present
        ? frecuenciaPago.value
        : this.frecuenciaPago,
    createdAt: createdAt ?? this.createdAt,
  );
  PlanPago copyWithCompanion(PlanPagosCompanion data) {
    return PlanPago(
      idPlan: data.idPlan.present ? data.idPlan.value : this.idPlan,
      idPrestamo: data.idPrestamo.present
          ? data.idPrestamo.value
          : this.idPrestamo,
      numeroCuotas: data.numeroCuotas.present
          ? data.numeroCuotas.value
          : this.numeroCuotas,
      frecuenciaPago: data.frecuenciaPago.present
          ? data.frecuenciaPago.value
          : this.frecuenciaPago,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanPago(')
          ..write('idPlan: $idPlan, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('numeroCuotas: $numeroCuotas, ')
          ..write('frecuenciaPago: $frecuenciaPago, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idPlan, idPrestamo, numeroCuotas, frecuenciaPago, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanPago &&
          other.idPlan == this.idPlan &&
          other.idPrestamo == this.idPrestamo &&
          other.numeroCuotas == this.numeroCuotas &&
          other.frecuenciaPago == this.frecuenciaPago &&
          other.createdAt == this.createdAt);
}

class PlanPagosCompanion extends UpdateCompanion<PlanPago> {
  final Value<int> idPlan;
  final Value<int?> idPrestamo;
  final Value<int?> numeroCuotas;
  final Value<String?> frecuenciaPago;
  final Value<DateTime> createdAt;
  const PlanPagosCompanion({
    this.idPlan = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.numeroCuotas = const Value.absent(),
    this.frecuenciaPago = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlanPagosCompanion.insert({
    this.idPlan = const Value.absent(),
    this.idPrestamo = const Value.absent(),
    this.numeroCuotas = const Value.absent(),
    this.frecuenciaPago = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<PlanPago> custom({
    Expression<int>? idPlan,
    Expression<int>? idPrestamo,
    Expression<int>? numeroCuotas,
    Expression<String>? frecuenciaPago,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (idPlan != null) 'id_plan': idPlan,
      if (idPrestamo != null) 'id_prestamo': idPrestamo,
      if (numeroCuotas != null) 'numero_cuotas': numeroCuotas,
      if (frecuenciaPago != null) 'frecuencia_pago': frecuenciaPago,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlanPagosCompanion copyWith({
    Value<int>? idPlan,
    Value<int?>? idPrestamo,
    Value<int?>? numeroCuotas,
    Value<String?>? frecuenciaPago,
    Value<DateTime>? createdAt,
  }) {
    return PlanPagosCompanion(
      idPlan: idPlan ?? this.idPlan,
      idPrestamo: idPrestamo ?? this.idPrestamo,
      numeroCuotas: numeroCuotas ?? this.numeroCuotas,
      frecuenciaPago: frecuenciaPago ?? this.frecuenciaPago,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idPlan.present) {
      map['id_plan'] = Variable<int>(idPlan.value);
    }
    if (idPrestamo.present) {
      map['id_prestamo'] = Variable<int>(idPrestamo.value);
    }
    if (numeroCuotas.present) {
      map['numero_cuotas'] = Variable<int>(numeroCuotas.value);
    }
    if (frecuenciaPago.present) {
      map['frecuencia_pago'] = Variable<String>(frecuenciaPago.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanPagosCompanion(')
          ..write('idPlan: $idPlan, ')
          ..write('idPrestamo: $idPrestamo, ')
          ..write('numeroCuotas: $numeroCuotas, ')
          ..write('frecuenciaPago: $frecuenciaPago, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonasTable personas = $PersonasTable(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $RolUsuariosTable rolUsuarios = $RolUsuariosTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $MonedasTable monedas = $MonedasTable(this);
  late final $ConfiguracionesTable configuraciones = $ConfiguracionesTable(
    this,
  );
  late final $CobradoresTable cobradores = $CobradoresTable(this);
  late final $GarantesTable garantes = $GarantesTable(this);
  late final $GarantiasTable garantias = $GarantiasTable(this);
  late final $TipoPrestamosTable tipoPrestamos = $TipoPrestamosTable(this);
  late final $EstadoPrestamosTable estadoPrestamos = $EstadoPrestamosTable(
    this,
  );
  late final $PrestamosTable prestamos = $PrestamosTable(this);
  late final $PrestamoGarantesTable prestamoGarantes = $PrestamoGarantesTable(
    this,
  );
  late final $PrestamoGarantiasTable prestamoGarantias =
      $PrestamoGarantiasTable(this);
  late final $CuotasTable cuotas = $CuotasTable(this);
  late final $PagosTable pagos = $PagosTable(this);
  late final $MetodoPagosTable metodoPagos = $MetodoPagosTable(this);
  late final $CategoriaEgresosTable categoriaEgresos = $CategoriaEgresosTable(
    this,
  );
  late final $EgresosTable egresos = $EgresosTable(this);
  late final $SimulacionPrestamosTable simulacionPrestamos =
      $SimulacionPrestamosTable(this);
  late final $PlanPagosTable planPagos = $PlanPagosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    personas,
    clientes,
    rolUsuarios,
    usuarios,
    monedas,
    configuraciones,
    cobradores,
    garantes,
    garantias,
    tipoPrestamos,
    estadoPrestamos,
    prestamos,
    prestamoGarantes,
    prestamoGarantias,
    cuotas,
    pagos,
    metodoPagos,
    categoriaEgresos,
    egresos,
    simulacionPrestamos,
    planPagos,
  ];
}

typedef $$PersonasTableCreateCompanionBuilder = PersonasCompanion Function({
  required String ciPersona,
  required String nombres,
  Value<String> apellidoPaterno,
  Value<String> apellidoMaterno,
  Value<String> telefono,
  Value<String> correo,
  Value<String> direccionDomicilio,
  Value<String> direccionTrabajo,
  Value<double?> latitud,
  Value<double?> longitud,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$PersonasTableUpdateCompanionBuilder = PersonasCompanion Function({
  Value<String> ciPersona,
  Value<String> nombres,
  Value<String> apellidoPaterno,
  Value<String> apellidoMaterno,
  Value<String> telefono,
  Value<String> correo,
  Value<String> direccionDomicilio,
  Value<String> direccionTrabajo,
  Value<double?> latitud,
  Value<double?> longitud,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$PersonasTableFilterComposer
    extends Composer<_$AppDatabase, $PersonasTable> {
  $$PersonasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombres => $composableBuilder(
    column: $table.nombres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccionDomicilio => $composableBuilder(
    column: $table.direccionDomicilio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccionTrabajo => $composableBuilder(
    column: $table.direccionTrabajo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitud => $composableBuilder(
    column: $table.latitud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitud => $composableBuilder(
    column: $table.longitud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonasTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonasTable> {
  $$PersonasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombres => $composableBuilder(
    column: $table.nombres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccionDomicilio => $composableBuilder(
    column: $table.direccionDomicilio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccionTrabajo => $composableBuilder(
    column: $table.direccionTrabajo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitud => $composableBuilder(
    column: $table.latitud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitud => $composableBuilder(
    column: $table.longitud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonasTable> {
  $$PersonasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ciPersona =>
      $composableBuilder(column: $table.ciPersona, builder: (column) => column);

  GeneratedColumn<String> get nombres =>
      $composableBuilder(column: $table.nombres, builder: (column) => column);

  GeneratedColumn<String> get apellidoPaterno => $composableBuilder(
    column: $table.apellidoPaterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get apellidoMaterno => $composableBuilder(
    column: $table.apellidoMaterno,
    builder: (column) => column,
  );

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get correo =>
      $composableBuilder(column: $table.correo, builder: (column) => column);

  GeneratedColumn<String> get direccionDomicilio => $composableBuilder(
    column: $table.direccionDomicilio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direccionTrabajo => $composableBuilder(
    column: $table.direccionTrabajo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitud =>
      $composableBuilder(column: $table.latitud, builder: (column) => column);

  GeneratedColumn<double> get longitud =>
      $composableBuilder(column: $table.longitud, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PersonasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonasTable,
          Persona,
          $$PersonasTableFilterComposer,
          $$PersonasTableOrderingComposer,
          $$PersonasTableAnnotationComposer,
          $$PersonasTableCreateCompanionBuilder,
          $$PersonasTableUpdateCompanionBuilder,
          (Persona, BaseReferences<_$AppDatabase, $PersonasTable, Persona>),
          Persona,
          PrefetchHooks Function()
        > {
  $$PersonasTableTableManager(_$AppDatabase db, $PersonasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> ciPersona = const Value.absent(),
                Value<String> nombres = const Value.absent(),
                Value<String> apellidoPaterno = const Value.absent(),
                Value<String> apellidoMaterno = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> correo = const Value.absent(),
                Value<String> direccionDomicilio = const Value.absent(),
                Value<String> direccionTrabajo = const Value.absent(),
                Value<double?> latitud = const Value.absent(),
                Value<double?> longitud = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonasCompanion(
                ciPersona: ciPersona,
                nombres: nombres,
                apellidoPaterno: apellidoPaterno,
                apellidoMaterno: apellidoMaterno,
                telefono: telefono,
                correo: correo,
                direccionDomicilio: direccionDomicilio,
                direccionTrabajo: direccionTrabajo,
                latitud: latitud,
                longitud: longitud,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ciPersona,
                required String nombres,
                Value<String> apellidoPaterno = const Value.absent(),
                Value<String> apellidoMaterno = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> correo = const Value.absent(),
                Value<String> direccionDomicilio = const Value.absent(),
                Value<String> direccionTrabajo = const Value.absent(),
                Value<double?> latitud = const Value.absent(),
                Value<double?> longitud = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonasCompanion.insert(
                ciPersona: ciPersona,
                nombres: nombres,
                apellidoPaterno: apellidoPaterno,
                apellidoMaterno: apellidoMaterno,
                telefono: telefono,
                correo: correo,
                direccionDomicilio: direccionDomicilio,
                direccionTrabajo: direccionTrabajo,
                latitud: latitud,
                longitud: longitud,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonasTable,
      Persona,
      $$PersonasTableFilterComposer,
      $$PersonasTableOrderingComposer,
      $$PersonasTableAnnotationComposer,
      $$PersonasTableCreateCompanionBuilder,
      $$PersonasTableUpdateCompanionBuilder,
      (Persona, BaseReferences<_$AppDatabase, $PersonasTable, Persona>),
      Persona,
      PrefetchHooks Function()
    >;
typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  Value<int> idCliente,
  Value<String?> ciPersona,
  Value<String> estadoCredito,
  Value<bool> estado,
  Value<DateTime> createdAt,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<int> idCliente,
  Value<String?> ciPersona,
  Value<String> estadoCredito,
  Value<bool> estado,
  Value<DateTime> createdAt,
});

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estadoCredito => $composableBuilder(
    column: $table.estadoCredito,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadoCredito => $composableBuilder(
    column: $table.estadoCredito,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idCliente =>
      $composableBuilder(column: $table.idCliente, builder: (column) => column);

  GeneratedColumn<String> get ciPersona =>
      $composableBuilder(column: $table.ciPersona, builder: (column) => column);

  GeneratedColumn<String> get estadoCredito => $composableBuilder(
    column: $table.estadoCredito,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ClientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientesTable,
          Cliente,
          $$ClientesTableFilterComposer,
          $$ClientesTableOrderingComposer,
          $$ClientesTableAnnotationComposer,
          $$ClientesTableCreateCompanionBuilder,
          $$ClientesTableUpdateCompanionBuilder,
          (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
          Cliente,
          PrefetchHooks Function()
        > {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idCliente = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<String> estadoCredito = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ClientesCompanion(
                idCliente: idCliente,
                ciPersona: ciPersona,
                estadoCredito: estadoCredito,
                estado: estado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idCliente = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<String> estadoCredito = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ClientesCompanion.insert(
                idCliente: idCliente,
                ciPersona: ciPersona,
                estadoCredito: estadoCredito,
                estado: estado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientesTable,
      Cliente,
      $$ClientesTableFilterComposer,
      $$ClientesTableOrderingComposer,
      $$ClientesTableAnnotationComposer,
      $$ClientesTableCreateCompanionBuilder,
      $$ClientesTableUpdateCompanionBuilder,
      (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
      Cliente,
      PrefetchHooks Function()
    >;
typedef $$RolUsuariosTableCreateCompanionBuilder =
    RolUsuariosCompanion Function({
      Value<int> idRol,
      required String nombre,
      Value<String> descripcion,
      Value<bool> activo,
    });
typedef $$RolUsuariosTableUpdateCompanionBuilder =
    RolUsuariosCompanion Function({
      Value<int> idRol,
      Value<String> nombre,
      Value<String> descripcion,
      Value<bool> activo,
    });

class $$RolUsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $RolUsuariosTable> {
  $$RolUsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idRol => $composableBuilder(
    column: $table.idRol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RolUsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $RolUsuariosTable> {
  $$RolUsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idRol => $composableBuilder(
    column: $table.idRol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RolUsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RolUsuariosTable> {
  $$RolUsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idRol =>
      $composableBuilder(column: $table.idRol, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);
}

class $$RolUsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RolUsuariosTable,
          RolUsuario,
          $$RolUsuariosTableFilterComposer,
          $$RolUsuariosTableOrderingComposer,
          $$RolUsuariosTableAnnotationComposer,
          $$RolUsuariosTableCreateCompanionBuilder,
          $$RolUsuariosTableUpdateCompanionBuilder,
          (
            RolUsuario,
            BaseReferences<_$AppDatabase, $RolUsuariosTable, RolUsuario>,
          ),
          RolUsuario,
          PrefetchHooks Function()
        > {
  $$RolUsuariosTableTableManager(_$AppDatabase db, $RolUsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RolUsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RolUsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RolUsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idRol = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => RolUsuariosCompanion(
                idRol: idRol,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<int> idRol = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => RolUsuariosCompanion.insert(
                idRol: idRol,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RolUsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RolUsuariosTable,
      RolUsuario,
      $$RolUsuariosTableFilterComposer,
      $$RolUsuariosTableOrderingComposer,
      $$RolUsuariosTableAnnotationComposer,
      $$RolUsuariosTableCreateCompanionBuilder,
      $$RolUsuariosTableUpdateCompanionBuilder,
      (
        RolUsuario,
        BaseReferences<_$AppDatabase, $RolUsuariosTable, RolUsuario>,
      ),
      RolUsuario,
      PrefetchHooks Function()
    >;
typedef $$UsuariosTableCreateCompanionBuilder = UsuariosCompanion Function({
  required String idUsuario,
  Value<String?> ciPersona,
  Value<int?> idRol,
  required String username,
  Value<String> password,
  Value<bool> estado,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$UsuariosTableUpdateCompanionBuilder = UsuariosCompanion Function({
  Value<String> idUsuario,
  Value<String?> ciPersona,
  Value<int?> idRol,
  Value<String> username,
  Value<String> password,
  Value<bool> estado,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idUsuario => $composableBuilder(
    column: $table.idUsuario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idRol => $composableBuilder(
    column: $table.idRol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idUsuario => $composableBuilder(
    column: $table.idUsuario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idRol => $composableBuilder(
    column: $table.idRol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idUsuario =>
      $composableBuilder(column: $table.idUsuario, builder: (column) => column);

  GeneratedColumn<String> get ciPersona =>
      $composableBuilder(column: $table.ciPersona, builder: (column) => column);

  GeneratedColumn<int> get idRol =>
      $composableBuilder(column: $table.idRol, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, BaseReferences<_$AppDatabase, $UsuariosTable, Usuario>),
          Usuario,
          PrefetchHooks Function()
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idUsuario = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<int?> idRol = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion(
                idUsuario: idUsuario,
                ciPersona: ciPersona,
                idRol: idRol,
                username: username,
                password: password,
                estado: estado,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idUsuario,
                Value<String?> ciPersona = const Value.absent(),
                Value<int?> idRol = const Value.absent(),
                required String username,
                Value<String> password = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion.insert(
                idUsuario: idUsuario,
                ciPersona: ciPersona,
                idRol: idRol,
                username: username,
                password: password,
                estado: estado,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, BaseReferences<_$AppDatabase, $UsuariosTable, Usuario>),
      Usuario,
      PrefetchHooks Function()
    >;
typedef $$MonedasTableCreateCompanionBuilder = MonedasCompanion Function({
  Value<int> idMoneda,
  required String nombre,
  Value<String> descripcion,
  Value<bool> activo,
});
typedef $$MonedasTableUpdateCompanionBuilder = MonedasCompanion Function({
  Value<int> idMoneda,
  Value<String> nombre,
  Value<String> descripcion,
  Value<bool> activo,
});

class $$MonedasTableFilterComposer
    extends Composer<_$AppDatabase, $MonedasTable> {
  $$MonedasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idMoneda => $composableBuilder(
    column: $table.idMoneda,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MonedasTableOrderingComposer
    extends Composer<_$AppDatabase, $MonedasTable> {
  $$MonedasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idMoneda => $composableBuilder(
    column: $table.idMoneda,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonedasTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonedasTable> {
  $$MonedasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idMoneda =>
      $composableBuilder(column: $table.idMoneda, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);
}

class $$MonedasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonedasTable,
          Moneda,
          $$MonedasTableFilterComposer,
          $$MonedasTableOrderingComposer,
          $$MonedasTableAnnotationComposer,
          $$MonedasTableCreateCompanionBuilder,
          $$MonedasTableUpdateCompanionBuilder,
          (Moneda, BaseReferences<_$AppDatabase, $MonedasTable, Moneda>),
          Moneda,
          PrefetchHooks Function()
        > {
  $$MonedasTableTableManager(_$AppDatabase db, $MonedasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonedasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonedasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonedasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idMoneda = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => MonedasCompanion(
                idMoneda: idMoneda,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
              ),
          createCompanionCallback:
              ({
                Value<int> idMoneda = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
              }) => MonedasCompanion.insert(
                idMoneda: idMoneda,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MonedasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonedasTable,
      Moneda,
      $$MonedasTableFilterComposer,
      $$MonedasTableOrderingComposer,
      $$MonedasTableAnnotationComposer,
      $$MonedasTableCreateCompanionBuilder,
      $$MonedasTableUpdateCompanionBuilder,
      (Moneda, BaseReferences<_$AppDatabase, $MonedasTable, Moneda>),
      Moneda,
      PrefetchHooks Function()
    >;
typedef $$ConfiguracionesTableCreateCompanionBuilder =
    ConfiguracionesCompanion Function({
      required String clave,
      Value<String?> valor,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ConfiguracionesTableUpdateCompanionBuilder =
    ConfiguracionesCompanion Function({
      Value<String> clave,
      Value<String?> valor,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ConfiguracionesTableFilterComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ConfiguracionesTableOrderingComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConfiguracionesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConfiguracionesTable> {
  $$ConfiguracionesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ConfiguracionesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConfiguracionesTable,
          Configuracione,
          $$ConfiguracionesTableFilterComposer,
          $$ConfiguracionesTableOrderingComposer,
          $$ConfiguracionesTableAnnotationComposer,
          $$ConfiguracionesTableCreateCompanionBuilder,
          $$ConfiguracionesTableUpdateCompanionBuilder,
          (
            Configuracione,
            BaseReferences<
              _$AppDatabase,
              $ConfiguracionesTable,
              Configuracione
            >,
          ),
          Configuracione,
          PrefetchHooks Function()
        > {
  $$ConfiguracionesTableTableManager(
    _$AppDatabase db,
    $ConfiguracionesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfiguracionesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfiguracionesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfiguracionesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clave = const Value.absent(),
                Value<String?> valor = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion(
                clave: clave,
                valor: valor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clave,
                Value<String?> valor = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ConfiguracionesCompanion.insert(
                clave: clave,
                valor: valor,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ConfiguracionesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConfiguracionesTable,
      Configuracione,
      $$ConfiguracionesTableFilterComposer,
      $$ConfiguracionesTableOrderingComposer,
      $$ConfiguracionesTableAnnotationComposer,
      $$ConfiguracionesTableCreateCompanionBuilder,
      $$ConfiguracionesTableUpdateCompanionBuilder,
      (
        Configuracione,
        BaseReferences<_$AppDatabase, $ConfiguracionesTable, Configuracione>,
      ),
      Configuracione,
      PrefetchHooks Function()
    >;
typedef $$CobradoresTableCreateCompanionBuilder = CobradoresCompanion Function({
  Value<int> idCobrador,
  Value<String?> ciPersona,
  Value<String?> zona,
  Value<bool> estado,
  Value<DateTime> createdAt,
});
typedef $$CobradoresTableUpdateCompanionBuilder = CobradoresCompanion Function({
  Value<int> idCobrador,
  Value<String?> ciPersona,
  Value<String?> zona,
  Value<bool> estado,
  Value<DateTime> createdAt,
});

class $$CobradoresTableFilterComposer
    extends Composer<_$AppDatabase, $CobradoresTable> {
  $$CobradoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idCobrador => $composableBuilder(
    column: $table.idCobrador,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zona => $composableBuilder(
    column: $table.zona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CobradoresTableOrderingComposer
    extends Composer<_$AppDatabase, $CobradoresTable> {
  $$CobradoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idCobrador => $composableBuilder(
    column: $table.idCobrador,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zona => $composableBuilder(
    column: $table.zona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CobradoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $CobradoresTable> {
  $$CobradoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idCobrador => $composableBuilder(
    column: $table.idCobrador,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ciPersona =>
      $composableBuilder(column: $table.ciPersona, builder: (column) => column);

  GeneratedColumn<String> get zona =>
      $composableBuilder(column: $table.zona, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CobradoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CobradoresTable,
          Cobradore,
          $$CobradoresTableFilterComposer,
          $$CobradoresTableOrderingComposer,
          $$CobradoresTableAnnotationComposer,
          $$CobradoresTableCreateCompanionBuilder,
          $$CobradoresTableUpdateCompanionBuilder,
          (
            Cobradore,
            BaseReferences<_$AppDatabase, $CobradoresTable, Cobradore>,
          ),
          Cobradore,
          PrefetchHooks Function()
        > {
  $$CobradoresTableTableManager(_$AppDatabase db, $CobradoresTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CobradoresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CobradoresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CobradoresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idCobrador = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<String?> zona = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CobradoresCompanion(
                idCobrador: idCobrador,
                ciPersona: ciPersona,
                zona: zona,
                estado: estado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idCobrador = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<String?> zona = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CobradoresCompanion.insert(
                idCobrador: idCobrador,
                ciPersona: ciPersona,
                zona: zona,
                estado: estado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CobradoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CobradoresTable,
      Cobradore,
      $$CobradoresTableFilterComposer,
      $$CobradoresTableOrderingComposer,
      $$CobradoresTableAnnotationComposer,
      $$CobradoresTableCreateCompanionBuilder,
      $$CobradoresTableUpdateCompanionBuilder,
      (Cobradore, BaseReferences<_$AppDatabase, $CobradoresTable, Cobradore>),
      Cobradore,
      PrefetchHooks Function()
    >;
typedef $$GarantesTableCreateCompanionBuilder = GarantesCompanion Function({
  Value<int> idGarante,
  Value<String?> ciPersona,
  Value<double?> ingresoMensual,
  Value<String> ocupacion,
  Value<bool> estado,
  Value<DateTime> createdAt,
});
typedef $$GarantesTableUpdateCompanionBuilder = GarantesCompanion Function({
  Value<int> idGarante,
  Value<String?> ciPersona,
  Value<double?> ingresoMensual,
  Value<String> ocupacion,
  Value<bool> estado,
  Value<DateTime> createdAt,
});

class $$GarantesTableFilterComposer
    extends Composer<_$AppDatabase, $GarantesTable> {
  $$GarantesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idGarante => $composableBuilder(
    column: $table.idGarante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ingresoMensual => $composableBuilder(
    column: $table.ingresoMensual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocupacion => $composableBuilder(
    column: $table.ocupacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GarantesTableOrderingComposer
    extends Composer<_$AppDatabase, $GarantesTable> {
  $$GarantesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idGarante => $composableBuilder(
    column: $table.idGarante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciPersona => $composableBuilder(
    column: $table.ciPersona,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ingresoMensual => $composableBuilder(
    column: $table.ingresoMensual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocupacion => $composableBuilder(
    column: $table.ocupacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GarantesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GarantesTable> {
  $$GarantesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idGarante =>
      $composableBuilder(column: $table.idGarante, builder: (column) => column);

  GeneratedColumn<String> get ciPersona =>
      $composableBuilder(column: $table.ciPersona, builder: (column) => column);

  GeneratedColumn<double> get ingresoMensual => $composableBuilder(
    column: $table.ingresoMensual,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ocupacion =>
      $composableBuilder(column: $table.ocupacion, builder: (column) => column);

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GarantesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GarantesTable,
          Garante,
          $$GarantesTableFilterComposer,
          $$GarantesTableOrderingComposer,
          $$GarantesTableAnnotationComposer,
          $$GarantesTableCreateCompanionBuilder,
          $$GarantesTableUpdateCompanionBuilder,
          (Garante, BaseReferences<_$AppDatabase, $GarantesTable, Garante>),
          Garante,
          PrefetchHooks Function()
        > {
  $$GarantesTableTableManager(_$AppDatabase db, $GarantesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GarantesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GarantesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GarantesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idGarante = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<double?> ingresoMensual = const Value.absent(),
                Value<String> ocupacion = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GarantesCompanion(
                idGarante: idGarante,
                ciPersona: ciPersona,
                ingresoMensual: ingresoMensual,
                ocupacion: ocupacion,
                estado: estado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idGarante = const Value.absent(),
                Value<String?> ciPersona = const Value.absent(),
                Value<double?> ingresoMensual = const Value.absent(),
                Value<String> ocupacion = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GarantesCompanion.insert(
                idGarante: idGarante,
                ciPersona: ciPersona,
                ingresoMensual: ingresoMensual,
                ocupacion: ocupacion,
                estado: estado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GarantesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GarantesTable,
      Garante,
      $$GarantesTableFilterComposer,
      $$GarantesTableOrderingComposer,
      $$GarantesTableAnnotationComposer,
      $$GarantesTableCreateCompanionBuilder,
      $$GarantesTableUpdateCompanionBuilder,
      (Garante, BaseReferences<_$AppDatabase, $GarantesTable, Garante>),
      Garante,
      PrefetchHooks Function()
    >;
typedef $$GarantiasTableCreateCompanionBuilder = GarantiasCompanion Function({
  Value<int> idGarantia,
  Value<String?> descripcion,
  Value<String?> fotografia,
  Value<String?> urlReferencia,
  Value<double?> valorEstimado,
  Value<bool> estado,
  Value<DateTime> createdAt,
});
typedef $$GarantiasTableUpdateCompanionBuilder = GarantiasCompanion Function({
  Value<int> idGarantia,
  Value<String?> descripcion,
  Value<String?> fotografia,
  Value<String?> urlReferencia,
  Value<double?> valorEstimado,
  Value<bool> estado,
  Value<DateTime> createdAt,
});

class $$GarantiasTableFilterComposer
    extends Composer<_$AppDatabase, $GarantiasTable> {
  $$GarantiasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fotografia => $composableBuilder(
    column: $table.fotografia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urlReferencia => $composableBuilder(
    column: $table.urlReferencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get valorEstimado => $composableBuilder(
    column: $table.valorEstimado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GarantiasTableOrderingComposer
    extends Composer<_$AppDatabase, $GarantiasTable> {
  $$GarantiasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fotografia => $composableBuilder(
    column: $table.fotografia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urlReferencia => $composableBuilder(
    column: $table.urlReferencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get valorEstimado => $composableBuilder(
    column: $table.valorEstimado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GarantiasTableAnnotationComposer
    extends Composer<_$AppDatabase, $GarantiasTable> {
  $$GarantiasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fotografia => $composableBuilder(
    column: $table.fotografia,
    builder: (column) => column,
  );

  GeneratedColumn<String> get urlReferencia => $composableBuilder(
    column: $table.urlReferencia,
    builder: (column) => column,
  );

  GeneratedColumn<double> get valorEstimado => $composableBuilder(
    column: $table.valorEstimado,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GarantiasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GarantiasTable,
          Garantia,
          $$GarantiasTableFilterComposer,
          $$GarantiasTableOrderingComposer,
          $$GarantiasTableAnnotationComposer,
          $$GarantiasTableCreateCompanionBuilder,
          $$GarantiasTableUpdateCompanionBuilder,
          (Garantia, BaseReferences<_$AppDatabase, $GarantiasTable, Garantia>),
          Garantia,
          PrefetchHooks Function()
        > {
  $$GarantiasTableTableManager(_$AppDatabase db, $GarantiasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GarantiasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GarantiasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GarantiasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idGarantia = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String?> fotografia = const Value.absent(),
                Value<String?> urlReferencia = const Value.absent(),
                Value<double?> valorEstimado = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GarantiasCompanion(
                idGarantia: idGarantia,
                descripcion: descripcion,
                fotografia: fotografia,
                urlReferencia: urlReferencia,
                valorEstimado: valorEstimado,
                estado: estado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idGarantia = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String?> fotografia = const Value.absent(),
                Value<String?> urlReferencia = const Value.absent(),
                Value<double?> valorEstimado = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => GarantiasCompanion.insert(
                idGarantia: idGarantia,
                descripcion: descripcion,
                fotografia: fotografia,
                urlReferencia: urlReferencia,
                valorEstimado: valorEstimado,
                estado: estado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GarantiasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GarantiasTable,
      Garantia,
      $$GarantiasTableFilterComposer,
      $$GarantiasTableOrderingComposer,
      $$GarantiasTableAnnotationComposer,
      $$GarantiasTableCreateCompanionBuilder,
      $$GarantiasTableUpdateCompanionBuilder,
      (Garantia, BaseReferences<_$AppDatabase, $GarantiasTable, Garantia>),
      Garantia,
      PrefetchHooks Function()
    >;
typedef $$TipoPrestamosTableCreateCompanionBuilder =
    TipoPrestamosCompanion Function({
      Value<int> idTipo,
      required String nombre,
      Value<String> descripcion,
      Value<bool> activo,
      Value<bool> visibleCliente,
    });
typedef $$TipoPrestamosTableUpdateCompanionBuilder =
    TipoPrestamosCompanion Function({
      Value<int> idTipo,
      Value<String> nombre,
      Value<String> descripcion,
      Value<bool> activo,
      Value<bool> visibleCliente,
    });

class $$TipoPrestamosTableFilterComposer
    extends Composer<_$AppDatabase, $TipoPrestamosTable> {
  $$TipoPrestamosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idTipo => $composableBuilder(
    column: $table.idTipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get visibleCliente => $composableBuilder(
    column: $table.visibleCliente,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TipoPrestamosTableOrderingComposer
    extends Composer<_$AppDatabase, $TipoPrestamosTable> {
  $$TipoPrestamosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idTipo => $composableBuilder(
    column: $table.idTipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get visibleCliente => $composableBuilder(
    column: $table.visibleCliente,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TipoPrestamosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TipoPrestamosTable> {
  $$TipoPrestamosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idTipo =>
      $composableBuilder(column: $table.idTipo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<bool> get visibleCliente => $composableBuilder(
    column: $table.visibleCliente,
    builder: (column) => column,
  );
}

class $$TipoPrestamosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TipoPrestamosTable,
          TipoPrestamo,
          $$TipoPrestamosTableFilterComposer,
          $$TipoPrestamosTableOrderingComposer,
          $$TipoPrestamosTableAnnotationComposer,
          $$TipoPrestamosTableCreateCompanionBuilder,
          $$TipoPrestamosTableUpdateCompanionBuilder,
          (
            TipoPrestamo,
            BaseReferences<_$AppDatabase, $TipoPrestamosTable, TipoPrestamo>,
          ),
          TipoPrestamo,
          PrefetchHooks Function()
        > {
  $$TipoPrestamosTableTableManager(_$AppDatabase db, $TipoPrestamosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TipoPrestamosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TipoPrestamosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TipoPrestamosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idTipo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<bool> visibleCliente = const Value.absent(),
              }) => TipoPrestamosCompanion(
                idTipo: idTipo,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
                visibleCliente: visibleCliente,
              ),
          createCompanionCallback:
              ({
                Value<int> idTipo = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<bool> visibleCliente = const Value.absent(),
              }) => TipoPrestamosCompanion.insert(
                idTipo: idTipo,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
                visibleCliente: visibleCliente,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TipoPrestamosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TipoPrestamosTable,
      TipoPrestamo,
      $$TipoPrestamosTableFilterComposer,
      $$TipoPrestamosTableOrderingComposer,
      $$TipoPrestamosTableAnnotationComposer,
      $$TipoPrestamosTableCreateCompanionBuilder,
      $$TipoPrestamosTableUpdateCompanionBuilder,
      (
        TipoPrestamo,
        BaseReferences<_$AppDatabase, $TipoPrestamosTable, TipoPrestamo>,
      ),
      TipoPrestamo,
      PrefetchHooks Function()
    >;
typedef $$EstadoPrestamosTableCreateCompanionBuilder =
    EstadoPrestamosCompanion Function({
      Value<int> idEstado,
      required String nombre,
      Value<String> descripcion,
      Value<bool> activo,
      Value<bool> visibleCliente,
    });
typedef $$EstadoPrestamosTableUpdateCompanionBuilder =
    EstadoPrestamosCompanion Function({
      Value<int> idEstado,
      Value<String> nombre,
      Value<String> descripcion,
      Value<bool> activo,
      Value<bool> visibleCliente,
    });

class $$EstadoPrestamosTableFilterComposer
    extends Composer<_$AppDatabase, $EstadoPrestamosTable> {
  $$EstadoPrestamosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idEstado => $composableBuilder(
    column: $table.idEstado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get visibleCliente => $composableBuilder(
    column: $table.visibleCliente,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EstadoPrestamosTableOrderingComposer
    extends Composer<_$AppDatabase, $EstadoPrestamosTable> {
  $$EstadoPrestamosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idEstado => $composableBuilder(
    column: $table.idEstado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get visibleCliente => $composableBuilder(
    column: $table.visibleCliente,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EstadoPrestamosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EstadoPrestamosTable> {
  $$EstadoPrestamosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idEstado =>
      $composableBuilder(column: $table.idEstado, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<bool> get visibleCliente => $composableBuilder(
    column: $table.visibleCliente,
    builder: (column) => column,
  );
}

class $$EstadoPrestamosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EstadoPrestamosTable,
          EstadoPrestamo,
          $$EstadoPrestamosTableFilterComposer,
          $$EstadoPrestamosTableOrderingComposer,
          $$EstadoPrestamosTableAnnotationComposer,
          $$EstadoPrestamosTableCreateCompanionBuilder,
          $$EstadoPrestamosTableUpdateCompanionBuilder,
          (
            EstadoPrestamo,
            BaseReferences<
              _$AppDatabase,
              $EstadoPrestamosTable,
              EstadoPrestamo
            >,
          ),
          EstadoPrestamo,
          PrefetchHooks Function()
        > {
  $$EstadoPrestamosTableTableManager(
    _$AppDatabase db,
    $EstadoPrestamosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EstadoPrestamosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EstadoPrestamosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EstadoPrestamosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idEstado = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<bool> visibleCliente = const Value.absent(),
              }) => EstadoPrestamosCompanion(
                idEstado: idEstado,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
                visibleCliente: visibleCliente,
              ),
          createCompanionCallback:
              ({
                Value<int> idEstado = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<bool> visibleCliente = const Value.absent(),
              }) => EstadoPrestamosCompanion.insert(
                idEstado: idEstado,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
                visibleCliente: visibleCliente,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EstadoPrestamosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EstadoPrestamosTable,
      EstadoPrestamo,
      $$EstadoPrestamosTableFilterComposer,
      $$EstadoPrestamosTableOrderingComposer,
      $$EstadoPrestamosTableAnnotationComposer,
      $$EstadoPrestamosTableCreateCompanionBuilder,
      $$EstadoPrestamosTableUpdateCompanionBuilder,
      (
        EstadoPrestamo,
        BaseReferences<_$AppDatabase, $EstadoPrestamosTable, EstadoPrestamo>,
      ),
      EstadoPrestamo,
      PrefetchHooks Function()
    >;
typedef $$PrestamosTableCreateCompanionBuilder = PrestamosCompanion Function({
  Value<int> idPrestamo,
  Value<int?> idCliente,
  Value<int?> idCobrador,
  Value<int?> idTipo,
  Value<int?> idEstado,
  Value<int?> idGarantia,
  Value<int?> prestamoOrigen,
  Value<bool> esRefinanciamiento,
  required double monto,
  required double interes,
  required DateTime fechaInicio,
  Value<DateTime?> fechaFin,
  Value<DateTime> createdAt,
});
typedef $$PrestamosTableUpdateCompanionBuilder = PrestamosCompanion Function({
  Value<int> idPrestamo,
  Value<int?> idCliente,
  Value<int?> idCobrador,
  Value<int?> idTipo,
  Value<int?> idEstado,
  Value<int?> idGarantia,
  Value<int?> prestamoOrigen,
  Value<bool> esRefinanciamiento,
  Value<double> monto,
  Value<double> interes,
  Value<DateTime> fechaInicio,
  Value<DateTime?> fechaFin,
  Value<DateTime> createdAt,
});

class $$PrestamosTableFilterComposer
    extends Composer<_$AppDatabase, $PrestamosTable> {
  $$PrestamosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idCobrador => $composableBuilder(
    column: $table.idCobrador,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idTipo => $composableBuilder(
    column: $table.idTipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idEstado => $composableBuilder(
    column: $table.idEstado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prestamoOrigen => $composableBuilder(
    column: $table.prestamoOrigen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get esRefinanciamiento => $composableBuilder(
    column: $table.esRefinanciamiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interes => $composableBuilder(
    column: $table.interes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaFin => $composableBuilder(
    column: $table.fechaFin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrestamosTableOrderingComposer
    extends Composer<_$AppDatabase, $PrestamosTable> {
  $$PrestamosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idCobrador => $composableBuilder(
    column: $table.idCobrador,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idTipo => $composableBuilder(
    column: $table.idTipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idEstado => $composableBuilder(
    column: $table.idEstado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prestamoOrigen => $composableBuilder(
    column: $table.prestamoOrigen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get esRefinanciamiento => $composableBuilder(
    column: $table.esRefinanciamiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interes => $composableBuilder(
    column: $table.interes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaFin => $composableBuilder(
    column: $table.fechaFin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrestamosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrestamosTable> {
  $$PrestamosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idCliente =>
      $composableBuilder(column: $table.idCliente, builder: (column) => column);

  GeneratedColumn<int> get idCobrador => $composableBuilder(
    column: $table.idCobrador,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idTipo =>
      $composableBuilder(column: $table.idTipo, builder: (column) => column);

  GeneratedColumn<int> get idEstado =>
      $composableBuilder(column: $table.idEstado, builder: (column) => column);

  GeneratedColumn<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prestamoOrigen => $composableBuilder(
    column: $table.prestamoOrigen,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get esRefinanciamiento => $composableBuilder(
    column: $table.esRefinanciamiento,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<double> get interes =>
      $composableBuilder(column: $table.interes, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaFin =>
      $composableBuilder(column: $table.fechaFin, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PrestamosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrestamosTable,
          Prestamo,
          $$PrestamosTableFilterComposer,
          $$PrestamosTableOrderingComposer,
          $$PrestamosTableAnnotationComposer,
          $$PrestamosTableCreateCompanionBuilder,
          $$PrestamosTableUpdateCompanionBuilder,
          (Prestamo, BaseReferences<_$AppDatabase, $PrestamosTable, Prestamo>),
          Prestamo,
          PrefetchHooks Function()
        > {
  $$PrestamosTableTableManager(_$AppDatabase db, $PrestamosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrestamosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrestamosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrestamosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idPrestamo = const Value.absent(),
                Value<int?> idCliente = const Value.absent(),
                Value<int?> idCobrador = const Value.absent(),
                Value<int?> idTipo = const Value.absent(),
                Value<int?> idEstado = const Value.absent(),
                Value<int?> idGarantia = const Value.absent(),
                Value<int?> prestamoOrigen = const Value.absent(),
                Value<bool> esRefinanciamiento = const Value.absent(),
                Value<double> monto = const Value.absent(),
                Value<double> interes = const Value.absent(),
                Value<DateTime> fechaInicio = const Value.absent(),
                Value<DateTime?> fechaFin = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrestamosCompanion(
                idPrestamo: idPrestamo,
                idCliente: idCliente,
                idCobrador: idCobrador,
                idTipo: idTipo,
                idEstado: idEstado,
                idGarantia: idGarantia,
                prestamoOrigen: prestamoOrigen,
                esRefinanciamiento: esRefinanciamiento,
                monto: monto,
                interes: interes,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idPrestamo = const Value.absent(),
                Value<int?> idCliente = const Value.absent(),
                Value<int?> idCobrador = const Value.absent(),
                Value<int?> idTipo = const Value.absent(),
                Value<int?> idEstado = const Value.absent(),
                Value<int?> idGarantia = const Value.absent(),
                Value<int?> prestamoOrigen = const Value.absent(),
                Value<bool> esRefinanciamiento = const Value.absent(),
                required double monto,
                required double interes,
                required DateTime fechaInicio,
                Value<DateTime?> fechaFin = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PrestamosCompanion.insert(
                idPrestamo: idPrestamo,
                idCliente: idCliente,
                idCobrador: idCobrador,
                idTipo: idTipo,
                idEstado: idEstado,
                idGarantia: idGarantia,
                prestamoOrigen: prestamoOrigen,
                esRefinanciamiento: esRefinanciamiento,
                monto: monto,
                interes: interes,
                fechaInicio: fechaInicio,
                fechaFin: fechaFin,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrestamosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrestamosTable,
      Prestamo,
      $$PrestamosTableFilterComposer,
      $$PrestamosTableOrderingComposer,
      $$PrestamosTableAnnotationComposer,
      $$PrestamosTableCreateCompanionBuilder,
      $$PrestamosTableUpdateCompanionBuilder,
      (Prestamo, BaseReferences<_$AppDatabase, $PrestamosTable, Prestamo>),
      Prestamo,
      PrefetchHooks Function()
    >;
typedef $$PrestamoGarantesTableCreateCompanionBuilder =
    PrestamoGarantesCompanion Function({
      Value<int> id,
      required int idPrestamo,
      Value<int?> idGarante,
      Value<int?> idCliente,
    });
typedef $$PrestamoGarantesTableUpdateCompanionBuilder =
    PrestamoGarantesCompanion Function({
      Value<int> id,
      Value<int> idPrestamo,
      Value<int?> idGarante,
      Value<int?> idCliente,
    });

class $$PrestamoGarantesTableFilterComposer
    extends Composer<_$AppDatabase, $PrestamoGarantesTable> {
  $$PrestamoGarantesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idGarante => $composableBuilder(
    column: $table.idGarante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrestamoGarantesTableOrderingComposer
    extends Composer<_$AppDatabase, $PrestamoGarantesTable> {
  $$PrestamoGarantesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idGarante => $composableBuilder(
    column: $table.idGarante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrestamoGarantesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrestamoGarantesTable> {
  $$PrestamoGarantesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idGarante =>
      $composableBuilder(column: $table.idGarante, builder: (column) => column);

  GeneratedColumn<int> get idCliente =>
      $composableBuilder(column: $table.idCliente, builder: (column) => column);
}

class $$PrestamoGarantesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrestamoGarantesTable,
          PrestamoGarante,
          $$PrestamoGarantesTableFilterComposer,
          $$PrestamoGarantesTableOrderingComposer,
          $$PrestamoGarantesTableAnnotationComposer,
          $$PrestamoGarantesTableCreateCompanionBuilder,
          $$PrestamoGarantesTableUpdateCompanionBuilder,
          (
            PrestamoGarante,
            BaseReferences<
              _$AppDatabase,
              $PrestamoGarantesTable,
              PrestamoGarante
            >,
          ),
          PrestamoGarante,
          PrefetchHooks Function()
        > {
  $$PrestamoGarantesTableTableManager(
    _$AppDatabase db,
    $PrestamoGarantesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrestamoGarantesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrestamoGarantesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrestamoGarantesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idPrestamo = const Value.absent(),
                Value<int?> idGarante = const Value.absent(),
                Value<int?> idCliente = const Value.absent(),
              }) => PrestamoGarantesCompanion(
                id: id,
                idPrestamo: idPrestamo,
                idGarante: idGarante,
                idCliente: idCliente,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idPrestamo,
                Value<int?> idGarante = const Value.absent(),
                Value<int?> idCliente = const Value.absent(),
              }) => PrestamoGarantesCompanion.insert(
                id: id,
                idPrestamo: idPrestamo,
                idGarante: idGarante,
                idCliente: idCliente,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrestamoGarantesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrestamoGarantesTable,
      PrestamoGarante,
      $$PrestamoGarantesTableFilterComposer,
      $$PrestamoGarantesTableOrderingComposer,
      $$PrestamoGarantesTableAnnotationComposer,
      $$PrestamoGarantesTableCreateCompanionBuilder,
      $$PrestamoGarantesTableUpdateCompanionBuilder,
      (
        PrestamoGarante,
        BaseReferences<_$AppDatabase, $PrestamoGarantesTable, PrestamoGarante>,
      ),
      PrestamoGarante,
      PrefetchHooks Function()
    >;
typedef $$PrestamoGarantiasTableCreateCompanionBuilder =
    PrestamoGarantiasCompanion Function({
      Value<int> id,
      required int idPrestamo,
      required int idGarantia,
    });
typedef $$PrestamoGarantiasTableUpdateCompanionBuilder =
    PrestamoGarantiasCompanion Function({
      Value<int> id,
      Value<int> idPrestamo,
      Value<int> idGarantia,
    });

class $$PrestamoGarantiasTableFilterComposer
    extends Composer<_$AppDatabase, $PrestamoGarantiasTable> {
  $$PrestamoGarantiasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrestamoGarantiasTableOrderingComposer
    extends Composer<_$AppDatabase, $PrestamoGarantiasTable> {
  $$PrestamoGarantiasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrestamoGarantiasTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrestamoGarantiasTable> {
  $$PrestamoGarantiasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idGarantia => $composableBuilder(
    column: $table.idGarantia,
    builder: (column) => column,
  );
}

class $$PrestamoGarantiasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrestamoGarantiasTable,
          PrestamoGarantia,
          $$PrestamoGarantiasTableFilterComposer,
          $$PrestamoGarantiasTableOrderingComposer,
          $$PrestamoGarantiasTableAnnotationComposer,
          $$PrestamoGarantiasTableCreateCompanionBuilder,
          $$PrestamoGarantiasTableUpdateCompanionBuilder,
          (
            PrestamoGarantia,
            BaseReferences<
              _$AppDatabase,
              $PrestamoGarantiasTable,
              PrestamoGarantia
            >,
          ),
          PrestamoGarantia,
          PrefetchHooks Function()
        > {
  $$PrestamoGarantiasTableTableManager(
    _$AppDatabase db,
    $PrestamoGarantiasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrestamoGarantiasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrestamoGarantiasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrestamoGarantiasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idPrestamo = const Value.absent(),
                Value<int> idGarantia = const Value.absent(),
              }) => PrestamoGarantiasCompanion(
                id: id,
                idPrestamo: idPrestamo,
                idGarantia: idGarantia,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idPrestamo,
                required int idGarantia,
              }) => PrestamoGarantiasCompanion.insert(
                id: id,
                idPrestamo: idPrestamo,
                idGarantia: idGarantia,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrestamoGarantiasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrestamoGarantiasTable,
      PrestamoGarantia,
      $$PrestamoGarantiasTableFilterComposer,
      $$PrestamoGarantiasTableOrderingComposer,
      $$PrestamoGarantiasTableAnnotationComposer,
      $$PrestamoGarantiasTableCreateCompanionBuilder,
      $$PrestamoGarantiasTableUpdateCompanionBuilder,
      (
        PrestamoGarantia,
        BaseReferences<
          _$AppDatabase,
          $PrestamoGarantiasTable,
          PrestamoGarantia
        >,
      ),
      PrestamoGarantia,
      PrefetchHooks Function()
    >;
typedef $$CuotasTableCreateCompanionBuilder = CuotasCompanion Function({
  Value<int> idCuota,
  Value<int?> idPrestamo,
  Value<int?> idPlan,
  Value<int?> numeroCuota,
  Value<double?> montoCuota,
  Value<double?> montoTotal,
  Value<double?> capital,
  Value<double?> montoCapital,
  Value<double?> interes,
  Value<double?> montoInteres,
  Value<double?> saldoPendiente,
  Value<double?> saldoRestante,
  Value<DateTime?> fechaVencimiento,
  Value<DateTime?> fechaPago,
  Value<String> estado,
  Value<String> observaciones,
  Value<bool> mora,
  Value<double> moraMonto,
  Value<DateTime> createdAt,
});
typedef $$CuotasTableUpdateCompanionBuilder = CuotasCompanion Function({
  Value<int> idCuota,
  Value<int?> idPrestamo,
  Value<int?> idPlan,
  Value<int?> numeroCuota,
  Value<double?> montoCuota,
  Value<double?> montoTotal,
  Value<double?> capital,
  Value<double?> montoCapital,
  Value<double?> interes,
  Value<double?> montoInteres,
  Value<double?> saldoPendiente,
  Value<double?> saldoRestante,
  Value<DateTime?> fechaVencimiento,
  Value<DateTime?> fechaPago,
  Value<String> estado,
  Value<String> observaciones,
  Value<bool> mora,
  Value<double> moraMonto,
  Value<DateTime> createdAt,
});

class $$CuotasTableFilterComposer
    extends Composer<_$AppDatabase, $CuotasTable> {
  $$CuotasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idCuota => $composableBuilder(
    column: $table.idCuota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPlan => $composableBuilder(
    column: $table.idPlan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numeroCuota => $composableBuilder(
    column: $table.numeroCuota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montoCuota => $composableBuilder(
    column: $table.montoCuota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montoTotal => $composableBuilder(
    column: $table.montoTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get capital => $composableBuilder(
    column: $table.capital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montoCapital => $composableBuilder(
    column: $table.montoCapital,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interes => $composableBuilder(
    column: $table.interes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montoInteres => $composableBuilder(
    column: $table.montoInteres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saldoPendiente => $composableBuilder(
    column: $table.saldoPendiente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get saldoRestante => $composableBuilder(
    column: $table.saldoRestante,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaPago => $composableBuilder(
    column: $table.fechaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mora => $composableBuilder(
    column: $table.mora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get moraMonto => $composableBuilder(
    column: $table.moraMonto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CuotasTableOrderingComposer
    extends Composer<_$AppDatabase, $CuotasTable> {
  $$CuotasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idCuota => $composableBuilder(
    column: $table.idCuota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPlan => $composableBuilder(
    column: $table.idPlan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numeroCuota => $composableBuilder(
    column: $table.numeroCuota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montoCuota => $composableBuilder(
    column: $table.montoCuota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montoTotal => $composableBuilder(
    column: $table.montoTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get capital => $composableBuilder(
    column: $table.capital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montoCapital => $composableBuilder(
    column: $table.montoCapital,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interes => $composableBuilder(
    column: $table.interes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montoInteres => $composableBuilder(
    column: $table.montoInteres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saldoPendiente => $composableBuilder(
    column: $table.saldoPendiente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get saldoRestante => $composableBuilder(
    column: $table.saldoRestante,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaPago => $composableBuilder(
    column: $table.fechaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mora => $composableBuilder(
    column: $table.mora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get moraMonto => $composableBuilder(
    column: $table.moraMonto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CuotasTableAnnotationComposer
    extends Composer<_$AppDatabase, $CuotasTable> {
  $$CuotasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idCuota =>
      $composableBuilder(column: $table.idCuota, builder: (column) => column);

  GeneratedColumn<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idPlan =>
      $composableBuilder(column: $table.idPlan, builder: (column) => column);

  GeneratedColumn<int> get numeroCuota => $composableBuilder(
    column: $table.numeroCuota,
    builder: (column) => column,
  );

  GeneratedColumn<double> get montoCuota => $composableBuilder(
    column: $table.montoCuota,
    builder: (column) => column,
  );

  GeneratedColumn<double> get montoTotal => $composableBuilder(
    column: $table.montoTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get capital =>
      $composableBuilder(column: $table.capital, builder: (column) => column);

  GeneratedColumn<double> get montoCapital => $composableBuilder(
    column: $table.montoCapital,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interes =>
      $composableBuilder(column: $table.interes, builder: (column) => column);

  GeneratedColumn<double> get montoInteres => $composableBuilder(
    column: $table.montoInteres,
    builder: (column) => column,
  );

  GeneratedColumn<double> get saldoPendiente => $composableBuilder(
    column: $table.saldoPendiente,
    builder: (column) => column,
  );

  GeneratedColumn<double> get saldoRestante => $composableBuilder(
    column: $table.saldoRestante,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaPago =>
      $composableBuilder(column: $table.fechaPago, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get mora =>
      $composableBuilder(column: $table.mora, builder: (column) => column);

  GeneratedColumn<double> get moraMonto =>
      $composableBuilder(column: $table.moraMonto, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CuotasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CuotasTable,
          Cuota,
          $$CuotasTableFilterComposer,
          $$CuotasTableOrderingComposer,
          $$CuotasTableAnnotationComposer,
          $$CuotasTableCreateCompanionBuilder,
          $$CuotasTableUpdateCompanionBuilder,
          (Cuota, BaseReferences<_$AppDatabase, $CuotasTable, Cuota>),
          Cuota,
          PrefetchHooks Function()
        > {
  $$CuotasTableTableManager(_$AppDatabase db, $CuotasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CuotasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CuotasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CuotasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idCuota = const Value.absent(),
                Value<int?> idPrestamo = const Value.absent(),
                Value<int?> idPlan = const Value.absent(),
                Value<int?> numeroCuota = const Value.absent(),
                Value<double?> montoCuota = const Value.absent(),
                Value<double?> montoTotal = const Value.absent(),
                Value<double?> capital = const Value.absent(),
                Value<double?> montoCapital = const Value.absent(),
                Value<double?> interes = const Value.absent(),
                Value<double?> montoInteres = const Value.absent(),
                Value<double?> saldoPendiente = const Value.absent(),
                Value<double?> saldoRestante = const Value.absent(),
                Value<DateTime?> fechaVencimiento = const Value.absent(),
                Value<DateTime?> fechaPago = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String> observaciones = const Value.absent(),
                Value<bool> mora = const Value.absent(),
                Value<double> moraMonto = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CuotasCompanion(
                idCuota: idCuota,
                idPrestamo: idPrestamo,
                idPlan: idPlan,
                numeroCuota: numeroCuota,
                montoCuota: montoCuota,
                montoTotal: montoTotal,
                capital: capital,
                montoCapital: montoCapital,
                interes: interes,
                montoInteres: montoInteres,
                saldoPendiente: saldoPendiente,
                saldoRestante: saldoRestante,
                fechaVencimiento: fechaVencimiento,
                fechaPago: fechaPago,
                estado: estado,
                observaciones: observaciones,
                mora: mora,
                moraMonto: moraMonto,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idCuota = const Value.absent(),
                Value<int?> idPrestamo = const Value.absent(),
                Value<int?> idPlan = const Value.absent(),
                Value<int?> numeroCuota = const Value.absent(),
                Value<double?> montoCuota = const Value.absent(),
                Value<double?> montoTotal = const Value.absent(),
                Value<double?> capital = const Value.absent(),
                Value<double?> montoCapital = const Value.absent(),
                Value<double?> interes = const Value.absent(),
                Value<double?> montoInteres = const Value.absent(),
                Value<double?> saldoPendiente = const Value.absent(),
                Value<double?> saldoRestante = const Value.absent(),
                Value<DateTime?> fechaVencimiento = const Value.absent(),
                Value<DateTime?> fechaPago = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String> observaciones = const Value.absent(),
                Value<bool> mora = const Value.absent(),
                Value<double> moraMonto = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CuotasCompanion.insert(
                idCuota: idCuota,
                idPrestamo: idPrestamo,
                idPlan: idPlan,
                numeroCuota: numeroCuota,
                montoCuota: montoCuota,
                montoTotal: montoTotal,
                capital: capital,
                montoCapital: montoCapital,
                interes: interes,
                montoInteres: montoInteres,
                saldoPendiente: saldoPendiente,
                saldoRestante: saldoRestante,
                fechaVencimiento: fechaVencimiento,
                fechaPago: fechaPago,
                estado: estado,
                observaciones: observaciones,
                mora: mora,
                moraMonto: moraMonto,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CuotasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CuotasTable,
      Cuota,
      $$CuotasTableFilterComposer,
      $$CuotasTableOrderingComposer,
      $$CuotasTableAnnotationComposer,
      $$CuotasTableCreateCompanionBuilder,
      $$CuotasTableUpdateCompanionBuilder,
      (Cuota, BaseReferences<_$AppDatabase, $CuotasTable, Cuota>),
      Cuota,
      PrefetchHooks Function()
    >;
typedef $$PagosTableCreateCompanionBuilder = PagosCompanion Function({
  Value<int> idPago,
  Value<int?> idCuota,
  Value<int?> idPrestamo,
  Value<double?> monto,
  Value<DateTime> fechaPago,
  Value<String> metodoPago,
  Value<String> observacion,
  Value<bool> pagoCompleto,
  Value<String> tipoPago,
  Value<String> estadoPago,
  Value<String?> cuotasIds,
  Value<double> mora,
  Value<double> descuento,
  Value<DateTime> createdAt,
});
typedef $$PagosTableUpdateCompanionBuilder = PagosCompanion Function({
  Value<int> idPago,
  Value<int?> idCuota,
  Value<int?> idPrestamo,
  Value<double?> monto,
  Value<DateTime> fechaPago,
  Value<String> metodoPago,
  Value<String> observacion,
  Value<bool> pagoCompleto,
  Value<String> tipoPago,
  Value<String> estadoPago,
  Value<String?> cuotasIds,
  Value<double> mora,
  Value<double> descuento,
  Value<DateTime> createdAt,
});

class $$PagosTableFilterComposer extends Composer<_$AppDatabase, $PagosTable> {
  $$PagosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idPago => $composableBuilder(
    column: $table.idPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idCuota => $composableBuilder(
    column: $table.idCuota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaPago => $composableBuilder(
    column: $table.fechaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pagoCompleto => $composableBuilder(
    column: $table.pagoCompleto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoPago => $composableBuilder(
    column: $table.tipoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estadoPago => $composableBuilder(
    column: $table.estadoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cuotasIds => $composableBuilder(
    column: $table.cuotasIds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mora => $composableBuilder(
    column: $table.mora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get descuento => $composableBuilder(
    column: $table.descuento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PagosTableOrderingComposer
    extends Composer<_$AppDatabase, $PagosTable> {
  $$PagosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idPago => $composableBuilder(
    column: $table.idPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idCuota => $composableBuilder(
    column: $table.idCuota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaPago => $composableBuilder(
    column: $table.fechaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pagoCompleto => $composableBuilder(
    column: $table.pagoCompleto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoPago => $composableBuilder(
    column: $table.tipoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadoPago => $composableBuilder(
    column: $table.estadoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cuotasIds => $composableBuilder(
    column: $table.cuotasIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mora => $composableBuilder(
    column: $table.mora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get descuento => $composableBuilder(
    column: $table.descuento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PagosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PagosTable> {
  $$PagosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idPago =>
      $composableBuilder(column: $table.idPago, builder: (column) => column);

  GeneratedColumn<int> get idCuota =>
      $composableBuilder(column: $table.idCuota, builder: (column) => column);

  GeneratedColumn<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaPago =>
      $composableBuilder(column: $table.fechaPago, builder: (column) => column);

  GeneratedColumn<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observacion => $composableBuilder(
    column: $table.observacion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pagoCompleto => $composableBuilder(
    column: $table.pagoCompleto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoPago =>
      $composableBuilder(column: $table.tipoPago, builder: (column) => column);

  GeneratedColumn<String> get estadoPago => $composableBuilder(
    column: $table.estadoPago,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cuotasIds =>
      $composableBuilder(column: $table.cuotasIds, builder: (column) => column);

  GeneratedColumn<double> get mora =>
      $composableBuilder(column: $table.mora, builder: (column) => column);

  GeneratedColumn<double> get descuento =>
      $composableBuilder(column: $table.descuento, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PagosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PagosTable,
          Pago,
          $$PagosTableFilterComposer,
          $$PagosTableOrderingComposer,
          $$PagosTableAnnotationComposer,
          $$PagosTableCreateCompanionBuilder,
          $$PagosTableUpdateCompanionBuilder,
          (Pago, BaseReferences<_$AppDatabase, $PagosTable, Pago>),
          Pago,
          PrefetchHooks Function()
        > {
  $$PagosTableTableManager(_$AppDatabase db, $PagosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PagosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PagosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PagosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idPago = const Value.absent(),
                Value<int?> idCuota = const Value.absent(),
                Value<int?> idPrestamo = const Value.absent(),
                Value<double?> monto = const Value.absent(),
                Value<DateTime> fechaPago = const Value.absent(),
                Value<String> metodoPago = const Value.absent(),
                Value<String> observacion = const Value.absent(),
                Value<bool> pagoCompleto = const Value.absent(),
                Value<String> tipoPago = const Value.absent(),
                Value<String> estadoPago = const Value.absent(),
                Value<String?> cuotasIds = const Value.absent(),
                Value<double> mora = const Value.absent(),
                Value<double> descuento = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PagosCompanion(
                idPago: idPago,
                idCuota: idCuota,
                idPrestamo: idPrestamo,
                monto: monto,
                fechaPago: fechaPago,
                metodoPago: metodoPago,
                observacion: observacion,
                pagoCompleto: pagoCompleto,
                tipoPago: tipoPago,
                estadoPago: estadoPago,
                cuotasIds: cuotasIds,
                mora: mora,
                descuento: descuento,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idPago = const Value.absent(),
                Value<int?> idCuota = const Value.absent(),
                Value<int?> idPrestamo = const Value.absent(),
                Value<double?> monto = const Value.absent(),
                Value<DateTime> fechaPago = const Value.absent(),
                Value<String> metodoPago = const Value.absent(),
                Value<String> observacion = const Value.absent(),
                Value<bool> pagoCompleto = const Value.absent(),
                Value<String> tipoPago = const Value.absent(),
                Value<String> estadoPago = const Value.absent(),
                Value<String?> cuotasIds = const Value.absent(),
                Value<double> mora = const Value.absent(),
                Value<double> descuento = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PagosCompanion.insert(
                idPago: idPago,
                idCuota: idCuota,
                idPrestamo: idPrestamo,
                monto: monto,
                fechaPago: fechaPago,
                metodoPago: metodoPago,
                observacion: observacion,
                pagoCompleto: pagoCompleto,
                tipoPago: tipoPago,
                estadoPago: estadoPago,
                cuotasIds: cuotasIds,
                mora: mora,
                descuento: descuento,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PagosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PagosTable,
      Pago,
      $$PagosTableFilterComposer,
      $$PagosTableOrderingComposer,
      $$PagosTableAnnotationComposer,
      $$PagosTableCreateCompanionBuilder,
      $$PagosTableUpdateCompanionBuilder,
      (Pago, BaseReferences<_$AppDatabase, $PagosTable, Pago>),
      Pago,
      PrefetchHooks Function()
    >;
typedef $$MetodoPagosTableCreateCompanionBuilder =
    MetodoPagosCompanion Function({
      Value<int> idMetodo,
      required String nombre,
      Value<String> descripcion,
      Value<bool> estado,
    });
typedef $$MetodoPagosTableUpdateCompanionBuilder =
    MetodoPagosCompanion Function({
      Value<int> idMetodo,
      Value<String> nombre,
      Value<String> descripcion,
      Value<bool> estado,
    });

class $$MetodoPagosTableFilterComposer
    extends Composer<_$AppDatabase, $MetodoPagosTable> {
  $$MetodoPagosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idMetodo => $composableBuilder(
    column: $table.idMetodo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetodoPagosTableOrderingComposer
    extends Composer<_$AppDatabase, $MetodoPagosTable> {
  $$MetodoPagosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idMetodo => $composableBuilder(
    column: $table.idMetodo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetodoPagosTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetodoPagosTable> {
  $$MetodoPagosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idMetodo =>
      $composableBuilder(column: $table.idMetodo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$MetodoPagosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetodoPagosTable,
          MetodoPago,
          $$MetodoPagosTableFilterComposer,
          $$MetodoPagosTableOrderingComposer,
          $$MetodoPagosTableAnnotationComposer,
          $$MetodoPagosTableCreateCompanionBuilder,
          $$MetodoPagosTableUpdateCompanionBuilder,
          (
            MetodoPago,
            BaseReferences<_$AppDatabase, $MetodoPagosTable, MetodoPago>,
          ),
          MetodoPago,
          PrefetchHooks Function()
        > {
  $$MetodoPagosTableTableManager(_$AppDatabase db, $MetodoPagosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetodoPagosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetodoPagosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetodoPagosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idMetodo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => MetodoPagosCompanion(
                idMetodo: idMetodo,
                nombre: nombre,
                descripcion: descripcion,
                estado: estado,
              ),
          createCompanionCallback:
              ({
                Value<int> idMetodo = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<bool> estado = const Value.absent(),
              }) => MetodoPagosCompanion.insert(
                idMetodo: idMetodo,
                nombre: nombre,
                descripcion: descripcion,
                estado: estado,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetodoPagosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetodoPagosTable,
      MetodoPago,
      $$MetodoPagosTableFilterComposer,
      $$MetodoPagosTableOrderingComposer,
      $$MetodoPagosTableAnnotationComposer,
      $$MetodoPagosTableCreateCompanionBuilder,
      $$MetodoPagosTableUpdateCompanionBuilder,
      (
        MetodoPago,
        BaseReferences<_$AppDatabase, $MetodoPagosTable, MetodoPago>,
      ),
      MetodoPago,
      PrefetchHooks Function()
    >;
typedef $$CategoriaEgresosTableCreateCompanionBuilder =
    CategoriaEgresosCompanion Function({
      Value<int> idCategoria,
      required String nombre,
      Value<String> descripcion,
      Value<bool> activo,
      Value<DateTime> createdAt,
    });
typedef $$CategoriaEgresosTableUpdateCompanionBuilder =
    CategoriaEgresosCompanion Function({
      Value<int> idCategoria,
      Value<String> nombre,
      Value<String> descripcion,
      Value<bool> activo,
      Value<DateTime> createdAt,
    });

class $$CategoriaEgresosTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriaEgresosTable> {
  $$CategoriaEgresosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idCategoria => $composableBuilder(
    column: $table.idCategoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriaEgresosTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriaEgresosTable> {
  $$CategoriaEgresosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idCategoria => $composableBuilder(
    column: $table.idCategoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriaEgresosTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriaEgresosTable> {
  $$CategoriaEgresosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idCategoria => $composableBuilder(
    column: $table.idCategoria,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CategoriaEgresosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriaEgresosTable,
          CategoriaEgreso,
          $$CategoriaEgresosTableFilterComposer,
          $$CategoriaEgresosTableOrderingComposer,
          $$CategoriaEgresosTableAnnotationComposer,
          $$CategoriaEgresosTableCreateCompanionBuilder,
          $$CategoriaEgresosTableUpdateCompanionBuilder,
          (
            CategoriaEgreso,
            BaseReferences<
              _$AppDatabase,
              $CategoriaEgresosTable,
              CategoriaEgreso
            >,
          ),
          CategoriaEgreso,
          PrefetchHooks Function()
        > {
  $$CategoriaEgresosTableTableManager(
    _$AppDatabase db,
    $CategoriaEgresosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriaEgresosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriaEgresosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriaEgresosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idCategoria = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CategoriaEgresosCompanion(
                idCategoria: idCategoria,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idCategoria = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CategoriaEgresosCompanion.insert(
                idCategoria: idCategoria,
                nombre: nombre,
                descripcion: descripcion,
                activo: activo,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriaEgresosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriaEgresosTable,
      CategoriaEgreso,
      $$CategoriaEgresosTableFilterComposer,
      $$CategoriaEgresosTableOrderingComposer,
      $$CategoriaEgresosTableAnnotationComposer,
      $$CategoriaEgresosTableCreateCompanionBuilder,
      $$CategoriaEgresosTableUpdateCompanionBuilder,
      (
        CategoriaEgreso,
        BaseReferences<_$AppDatabase, $CategoriaEgresosTable, CategoriaEgreso>,
      ),
      CategoriaEgreso,
      PrefetchHooks Function()
    >;
typedef $$EgresosTableCreateCompanionBuilder = EgresosCompanion Function({
  Value<int> idEgreso,
  Value<int?> idCategoria,
  Value<String?> idUsuario,
  Value<String?> descripcion,
  Value<String?> concepto,
  Value<double?> monto,
  Value<DateTime?> fecha,
  Value<String> observaciones,
  Value<bool> estado,
  Value<DateTime> createdAt,
});
typedef $$EgresosTableUpdateCompanionBuilder = EgresosCompanion Function({
  Value<int> idEgreso,
  Value<int?> idCategoria,
  Value<String?> idUsuario,
  Value<String?> descripcion,
  Value<String?> concepto,
  Value<double?> monto,
  Value<DateTime?> fecha,
  Value<String> observaciones,
  Value<bool> estado,
  Value<DateTime> createdAt,
});

class $$EgresosTableFilterComposer
    extends Composer<_$AppDatabase, $EgresosTable> {
  $$EgresosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idEgreso => $composableBuilder(
    column: $table.idEgreso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idCategoria => $composableBuilder(
    column: $table.idCategoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idUsuario => $composableBuilder(
    column: $table.idUsuario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EgresosTableOrderingComposer
    extends Composer<_$AppDatabase, $EgresosTable> {
  $$EgresosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idEgreso => $composableBuilder(
    column: $table.idEgreso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idCategoria => $composableBuilder(
    column: $table.idCategoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idUsuario => $composableBuilder(
    column: $table.idUsuario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concepto => $composableBuilder(
    column: $table.concepto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EgresosTableAnnotationComposer
    extends Composer<_$AppDatabase, $EgresosTable> {
  $$EgresosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idEgreso =>
      $composableBuilder(column: $table.idEgreso, builder: (column) => column);

  GeneratedColumn<int> get idCategoria => $composableBuilder(
    column: $table.idCategoria,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idUsuario =>
      $composableBuilder(column: $table.idUsuario, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get concepto =>
      $composableBuilder(column: $table.concepto, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$EgresosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EgresosTable,
          Egreso,
          $$EgresosTableFilterComposer,
          $$EgresosTableOrderingComposer,
          $$EgresosTableAnnotationComposer,
          $$EgresosTableCreateCompanionBuilder,
          $$EgresosTableUpdateCompanionBuilder,
          (Egreso, BaseReferences<_$AppDatabase, $EgresosTable, Egreso>),
          Egreso,
          PrefetchHooks Function()
        > {
  $$EgresosTableTableManager(_$AppDatabase db, $EgresosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EgresosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EgresosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EgresosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idEgreso = const Value.absent(),
                Value<int?> idCategoria = const Value.absent(),
                Value<String?> idUsuario = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String?> concepto = const Value.absent(),
                Value<double?> monto = const Value.absent(),
                Value<DateTime?> fecha = const Value.absent(),
                Value<String> observaciones = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EgresosCompanion(
                idEgreso: idEgreso,
                idCategoria: idCategoria,
                idUsuario: idUsuario,
                descripcion: descripcion,
                concepto: concepto,
                monto: monto,
                fecha: fecha,
                observaciones: observaciones,
                estado: estado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idEgreso = const Value.absent(),
                Value<int?> idCategoria = const Value.absent(),
                Value<String?> idUsuario = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<String?> concepto = const Value.absent(),
                Value<double?> monto = const Value.absent(),
                Value<DateTime?> fecha = const Value.absent(),
                Value<String> observaciones = const Value.absent(),
                Value<bool> estado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => EgresosCompanion.insert(
                idEgreso: idEgreso,
                idCategoria: idCategoria,
                idUsuario: idUsuario,
                descripcion: descripcion,
                concepto: concepto,
                monto: monto,
                fecha: fecha,
                observaciones: observaciones,
                estado: estado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EgresosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EgresosTable,
      Egreso,
      $$EgresosTableFilterComposer,
      $$EgresosTableOrderingComposer,
      $$EgresosTableAnnotationComposer,
      $$EgresosTableCreateCompanionBuilder,
      $$EgresosTableUpdateCompanionBuilder,
      (Egreso, BaseReferences<_$AppDatabase, $EgresosTable, Egreso>),
      Egreso,
      PrefetchHooks Function()
    >;
typedef $$SimulacionPrestamosTableCreateCompanionBuilder =
    SimulacionPrestamosCompanion Function({
      Value<int> idSimulacion,
      Value<String?> idUsuario,
      required double monto,
      required double interes,
      required int numeroCuotas,
      required String frecuenciaPago,
      required String tipoPrestamo,
      required DateTime fechaInicio,
      required double totalCobrar,
      required double interesTotal,
      required double valorCuota,
      Value<String?> planPagos,
      Value<DateTime> createdAt,
    });
typedef $$SimulacionPrestamosTableUpdateCompanionBuilder =
    SimulacionPrestamosCompanion Function({
      Value<int> idSimulacion,
      Value<String?> idUsuario,
      Value<double> monto,
      Value<double> interes,
      Value<int> numeroCuotas,
      Value<String> frecuenciaPago,
      Value<String> tipoPrestamo,
      Value<DateTime> fechaInicio,
      Value<double> totalCobrar,
      Value<double> interesTotal,
      Value<double> valorCuota,
      Value<String?> planPagos,
      Value<DateTime> createdAt,
    });

class $$SimulacionPrestamosTableFilterComposer
    extends Composer<_$AppDatabase, $SimulacionPrestamosTable> {
  $$SimulacionPrestamosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idSimulacion => $composableBuilder(
    column: $table.idSimulacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idUsuario => $composableBuilder(
    column: $table.idUsuario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interes => $composableBuilder(
    column: $table.interes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numeroCuotas => $composableBuilder(
    column: $table.numeroCuotas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frecuenciaPago => $composableBuilder(
    column: $table.frecuenciaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipoPrestamo => $composableBuilder(
    column: $table.tipoPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCobrar => $composableBuilder(
    column: $table.totalCobrar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interesTotal => $composableBuilder(
    column: $table.interesTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get valorCuota => $composableBuilder(
    column: $table.valorCuota,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planPagos => $composableBuilder(
    column: $table.planPagos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SimulacionPrestamosTableOrderingComposer
    extends Composer<_$AppDatabase, $SimulacionPrestamosTable> {
  $$SimulacionPrestamosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idSimulacion => $composableBuilder(
    column: $table.idSimulacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idUsuario => $composableBuilder(
    column: $table.idUsuario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monto => $composableBuilder(
    column: $table.monto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interes => $composableBuilder(
    column: $table.interes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numeroCuotas => $composableBuilder(
    column: $table.numeroCuotas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frecuenciaPago => $composableBuilder(
    column: $table.frecuenciaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoPrestamo => $composableBuilder(
    column: $table.tipoPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCobrar => $composableBuilder(
    column: $table.totalCobrar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interesTotal => $composableBuilder(
    column: $table.interesTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get valorCuota => $composableBuilder(
    column: $table.valorCuota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planPagos => $composableBuilder(
    column: $table.planPagos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SimulacionPrestamosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SimulacionPrestamosTable> {
  $$SimulacionPrestamosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idSimulacion => $composableBuilder(
    column: $table.idSimulacion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idUsuario =>
      $composableBuilder(column: $table.idUsuario, builder: (column) => column);

  GeneratedColumn<double> get monto =>
      $composableBuilder(column: $table.monto, builder: (column) => column);

  GeneratedColumn<double> get interes =>
      $composableBuilder(column: $table.interes, builder: (column) => column);

  GeneratedColumn<int> get numeroCuotas => $composableBuilder(
    column: $table.numeroCuotas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frecuenciaPago => $composableBuilder(
    column: $table.frecuenciaPago,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tipoPrestamo => $composableBuilder(
    column: $table.tipoPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaInicio => $composableBuilder(
    column: $table.fechaInicio,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCobrar => $composableBuilder(
    column: $table.totalCobrar,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interesTotal => $composableBuilder(
    column: $table.interesTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get valorCuota => $composableBuilder(
    column: $table.valorCuota,
    builder: (column) => column,
  );

  GeneratedColumn<String> get planPagos =>
      $composableBuilder(column: $table.planPagos, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SimulacionPrestamosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SimulacionPrestamosTable,
          SimulacionPrestamo,
          $$SimulacionPrestamosTableFilterComposer,
          $$SimulacionPrestamosTableOrderingComposer,
          $$SimulacionPrestamosTableAnnotationComposer,
          $$SimulacionPrestamosTableCreateCompanionBuilder,
          $$SimulacionPrestamosTableUpdateCompanionBuilder,
          (
            SimulacionPrestamo,
            BaseReferences<
              _$AppDatabase,
              $SimulacionPrestamosTable,
              SimulacionPrestamo
            >,
          ),
          SimulacionPrestamo,
          PrefetchHooks Function()
        > {
  $$SimulacionPrestamosTableTableManager(
    _$AppDatabase db,
    $SimulacionPrestamosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SimulacionPrestamosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SimulacionPrestamosTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SimulacionPrestamosTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> idSimulacion = const Value.absent(),
                Value<String?> idUsuario = const Value.absent(),
                Value<double> monto = const Value.absent(),
                Value<double> interes = const Value.absent(),
                Value<int> numeroCuotas = const Value.absent(),
                Value<String> frecuenciaPago = const Value.absent(),
                Value<String> tipoPrestamo = const Value.absent(),
                Value<DateTime> fechaInicio = const Value.absent(),
                Value<double> totalCobrar = const Value.absent(),
                Value<double> interesTotal = const Value.absent(),
                Value<double> valorCuota = const Value.absent(),
                Value<String?> planPagos = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SimulacionPrestamosCompanion(
                idSimulacion: idSimulacion,
                idUsuario: idUsuario,
                monto: monto,
                interes: interes,
                numeroCuotas: numeroCuotas,
                frecuenciaPago: frecuenciaPago,
                tipoPrestamo: tipoPrestamo,
                fechaInicio: fechaInicio,
                totalCobrar: totalCobrar,
                interesTotal: interesTotal,
                valorCuota: valorCuota,
                planPagos: planPagos,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idSimulacion = const Value.absent(),
                Value<String?> idUsuario = const Value.absent(),
                required double monto,
                required double interes,
                required int numeroCuotas,
                required String frecuenciaPago,
                required String tipoPrestamo,
                required DateTime fechaInicio,
                required double totalCobrar,
                required double interesTotal,
                required double valorCuota,
                Value<String?> planPagos = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SimulacionPrestamosCompanion.insert(
                idSimulacion: idSimulacion,
                idUsuario: idUsuario,
                monto: monto,
                interes: interes,
                numeroCuotas: numeroCuotas,
                frecuenciaPago: frecuenciaPago,
                tipoPrestamo: tipoPrestamo,
                fechaInicio: fechaInicio,
                totalCobrar: totalCobrar,
                interesTotal: interesTotal,
                valorCuota: valorCuota,
                planPagos: planPagos,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SimulacionPrestamosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SimulacionPrestamosTable,
      SimulacionPrestamo,
      $$SimulacionPrestamosTableFilterComposer,
      $$SimulacionPrestamosTableOrderingComposer,
      $$SimulacionPrestamosTableAnnotationComposer,
      $$SimulacionPrestamosTableCreateCompanionBuilder,
      $$SimulacionPrestamosTableUpdateCompanionBuilder,
      (
        SimulacionPrestamo,
        BaseReferences<
          _$AppDatabase,
          $SimulacionPrestamosTable,
          SimulacionPrestamo
        >,
      ),
      SimulacionPrestamo,
      PrefetchHooks Function()
    >;
typedef $$PlanPagosTableCreateCompanionBuilder = PlanPagosCompanion Function({
  Value<int> idPlan,
  Value<int?> idPrestamo,
  Value<int?> numeroCuotas,
  Value<String?> frecuenciaPago,
  Value<DateTime> createdAt,
});
typedef $$PlanPagosTableUpdateCompanionBuilder = PlanPagosCompanion Function({
  Value<int> idPlan,
  Value<int?> idPrestamo,
  Value<int?> numeroCuotas,
  Value<String?> frecuenciaPago,
  Value<DateTime> createdAt,
});

class $$PlanPagosTableFilterComposer
    extends Composer<_$AppDatabase, $PlanPagosTable> {
  $$PlanPagosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get idPlan => $composableBuilder(
    column: $table.idPlan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numeroCuotas => $composableBuilder(
    column: $table.numeroCuotas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frecuenciaPago => $composableBuilder(
    column: $table.frecuenciaPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PlanPagosTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanPagosTable> {
  $$PlanPagosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get idPlan => $composableBuilder(
    column: $table.idPlan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numeroCuotas => $composableBuilder(
    column: $table.numeroCuotas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frecuenciaPago => $composableBuilder(
    column: $table.frecuenciaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlanPagosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanPagosTable> {
  $$PlanPagosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get idPlan =>
      $composableBuilder(column: $table.idPlan, builder: (column) => column);

  GeneratedColumn<int> get idPrestamo => $composableBuilder(
    column: $table.idPrestamo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numeroCuotas => $composableBuilder(
    column: $table.numeroCuotas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frecuenciaPago => $composableBuilder(
    column: $table.frecuenciaPago,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PlanPagosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanPagosTable,
          PlanPago,
          $$PlanPagosTableFilterComposer,
          $$PlanPagosTableOrderingComposer,
          $$PlanPagosTableAnnotationComposer,
          $$PlanPagosTableCreateCompanionBuilder,
          $$PlanPagosTableUpdateCompanionBuilder,
          (PlanPago, BaseReferences<_$AppDatabase, $PlanPagosTable, PlanPago>),
          PlanPago,
          PrefetchHooks Function()
        > {
  $$PlanPagosTableTableManager(_$AppDatabase db, $PlanPagosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanPagosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanPagosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanPagosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> idPlan = const Value.absent(),
                Value<int?> idPrestamo = const Value.absent(),
                Value<int?> numeroCuotas = const Value.absent(),
                Value<String?> frecuenciaPago = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlanPagosCompanion(
                idPlan: idPlan,
                idPrestamo: idPrestamo,
                numeroCuotas: numeroCuotas,
                frecuenciaPago: frecuenciaPago,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> idPlan = const Value.absent(),
                Value<int?> idPrestamo = const Value.absent(),
                Value<int?> numeroCuotas = const Value.absent(),
                Value<String?> frecuenciaPago = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlanPagosCompanion.insert(
                idPlan: idPlan,
                idPrestamo: idPrestamo,
                numeroCuotas: numeroCuotas,
                frecuenciaPago: frecuenciaPago,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PlanPagosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanPagosTable,
      PlanPago,
      $$PlanPagosTableFilterComposer,
      $$PlanPagosTableOrderingComposer,
      $$PlanPagosTableAnnotationComposer,
      $$PlanPagosTableCreateCompanionBuilder,
      $$PlanPagosTableUpdateCompanionBuilder,
      (PlanPago, BaseReferences<_$AppDatabase, $PlanPagosTable, PlanPago>),
      PlanPago,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonasTableTableManager get personas =>
      $$PersonasTableTableManager(_db, _db.personas);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$RolUsuariosTableTableManager get rolUsuarios =>
      $$RolUsuariosTableTableManager(_db, _db.rolUsuarios);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$MonedasTableTableManager get monedas =>
      $$MonedasTableTableManager(_db, _db.monedas);
  $$ConfiguracionesTableTableManager get configuraciones =>
      $$ConfiguracionesTableTableManager(_db, _db.configuraciones);
  $$CobradoresTableTableManager get cobradores =>
      $$CobradoresTableTableManager(_db, _db.cobradores);
  $$GarantesTableTableManager get garantes =>
      $$GarantesTableTableManager(_db, _db.garantes);
  $$GarantiasTableTableManager get garantias =>
      $$GarantiasTableTableManager(_db, _db.garantias);
  $$TipoPrestamosTableTableManager get tipoPrestamos =>
      $$TipoPrestamosTableTableManager(_db, _db.tipoPrestamos);
  $$EstadoPrestamosTableTableManager get estadoPrestamos =>
      $$EstadoPrestamosTableTableManager(_db, _db.estadoPrestamos);
  $$PrestamosTableTableManager get prestamos =>
      $$PrestamosTableTableManager(_db, _db.prestamos);
  $$PrestamoGarantesTableTableManager get prestamoGarantes =>
      $$PrestamoGarantesTableTableManager(_db, _db.prestamoGarantes);
  $$PrestamoGarantiasTableTableManager get prestamoGarantias =>
      $$PrestamoGarantiasTableTableManager(_db, _db.prestamoGarantias);
  $$CuotasTableTableManager get cuotas =>
      $$CuotasTableTableManager(_db, _db.cuotas);
  $$PagosTableTableManager get pagos =>
      $$PagosTableTableManager(_db, _db.pagos);
  $$MetodoPagosTableTableManager get metodoPagos =>
      $$MetodoPagosTableTableManager(_db, _db.metodoPagos);
  $$CategoriaEgresosTableTableManager get categoriaEgresos =>
      $$CategoriaEgresosTableTableManager(_db, _db.categoriaEgresos);
  $$EgresosTableTableManager get egresos =>
      $$EgresosTableTableManager(_db, _db.egresos);
  $$SimulacionPrestamosTableTableManager get simulacionPrestamos =>
      $$SimulacionPrestamosTableTableManager(_db, _db.simulacionPrestamos);
  $$PlanPagosTableTableManager get planPagos =>
      $$PlanPagosTableTableManager(_db, _db.planPagos);
}
