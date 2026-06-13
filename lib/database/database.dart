import 'package:drift/drift.dart';

import 'database_stub.dart'
    if (dart.library.io) 'database_io.dart'
    if (dart.library.js_interop) 'database_web.dart';

part 'database.g.dart';

class Personas extends Table {
  @override
  String get tableName => 'persona';

  TextColumn get ciPersona => text().named('ci_persona')();
  TextColumn get nombres => text()();
  TextColumn get apellidoPaterno =>
      text().named('apellido_paterno').withDefault(const Constant(''))();
  TextColumn get apellidoMaterno =>
      text().named('apellido_materno').withDefault(const Constant(''))();
  TextColumn get telefono => text().withDefault(const Constant(''))();
  TextColumn get correo => text().withDefault(const Constant(''))();
  TextColumn get direccionDomicilio =>
      text().named('direccion_domicilio').withDefault(const Constant(''))();
  TextColumn get direccionTrabajo =>
      text().named('direccion_trabajo').withDefault(const Constant(''))();
  RealColumn get latitud => real().nullable()();
  RealColumn get longitud => real().nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {ciPersona};
}

class Clientes extends Table {
  @override
  String get tableName => 'cliente';

  IntColumn get idCliente => integer().named('id_cliente').autoIncrement()();
  TextColumn get ciPersona =>
      text().named('ci_persona').nullable().references(Personas, #ciPersona)();
  TextColumn get estadoCredito =>
      text().named('estado_credito').withDefault(const Constant('BUENO'))();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class RolUsuarios extends Table {
  @override
  String get tableName => 'rol_usuario';

  IntColumn get idRol => integer().named('id_rol').autoIncrement()();
  TextColumn get nombre => text().unique()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

class Usuarios extends Table {
  @override
  String get tableName => 'usuario';

  TextColumn get idUsuario => text().named('id_usuario')();
  TextColumn get ciPersona =>
      text().named('ci_persona').nullable().references(Personas, #ciPersona)();
  IntColumn get idRol =>
      integer().named('id_rol').nullable().references(RolUsuarios, #idRol)();
  TextColumn get username => text().unique()();
  TextColumn get password => text().withDefault(const Constant(''))();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {idUsuario};
}

class Monedas extends Table {
  @override
  String get tableName => 'moneda';

  IntColumn get idMoneda => integer().named('id_moneda').autoIncrement()();
  TextColumn get nombre => text().unique()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

class Configuraciones extends Table {
  @override
  String get tableName => 'configuracion';

  TextColumn get clave => text()();
  TextColumn get valor => text().nullable()();
  DateTimeColumn get updatedAt =>
      dateTime().named('updated_at').withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {clave};
}

class Cobradores extends Table {
  @override
  String get tableName => 'cobrador';

  IntColumn get idCobrador => integer().named('id_cobrador').autoIncrement()();
  TextColumn get ciPersona =>
      text().named('ci_persona').nullable().references(Personas, #ciPersona)();
  TextColumn get zona => text().nullable()();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Garantes extends Table {
  @override
  String get tableName => 'garante';

  IntColumn get idGarante => integer().named('id_garante').autoIncrement()();
  TextColumn get ciPersona =>
      text().named('ci_persona').nullable().references(Personas, #ciPersona)();
  RealColumn get ingresoMensual => real().named('ingreso_mensual').nullable()();
  TextColumn get ocupacion => text().withDefault(const Constant(''))();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Garantias extends Table {
  @override
  String get tableName => 'garantia';

  IntColumn get idGarantia => integer().named('id_garantia').autoIncrement()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get fotografia => text().nullable()();
  TextColumn get urlReferencia => text().named('url_referencia').nullable()();
  RealColumn get valorEstimado => real().named('valor_estimado').nullable()();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class TipoPrestamos extends Table {
  @override
  String get tableName => 'tipo_prestamo';

  IntColumn get idTipo => integer().named('id_tipo').autoIncrement()();
  TextColumn get nombre => text().unique()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  BoolColumn get visibleCliente =>
      boolean().named('visible_cliente').withDefault(const Constant(true))();
}

class EstadoPrestamos extends Table {
  @override
  String get tableName => 'estado_prestamo';

  IntColumn get idEstado => integer().named('id_estado').autoIncrement()();
  TextColumn get nombre => text().unique()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  BoolColumn get visibleCliente =>
      boolean().named('visible_cliente').withDefault(const Constant(true))();
}

class Prestamos extends Table {
  @override
  String get tableName => 'prestamo';

  IntColumn get idPrestamo => integer().named('id_prestamo').autoIncrement()();
  IntColumn get idCliente => integer()
      .named('id_cliente')
      .nullable()
      .references(Clientes, #idCliente)();
  IntColumn get idCobrador => integer()
      .named('id_cobrador')
      .nullable()
      .references(Cobradores, #idCobrador)();
  IntColumn get idTipo => integer()
      .named('id_tipo')
      .nullable()
      .references(TipoPrestamos, #idTipo)();
  IntColumn get idEstado => integer()
      .named('id_estado')
      .nullable()
      .references(EstadoPrestamos, #idEstado)();
  IntColumn get idGarantia => integer()
      .named('id_garantia')
      .nullable()
      .references(Garantias, #idGarantia)();
  IntColumn get prestamoOrigen => integer()
      .named('prestamo_origen')
      .nullable()
      .references(Prestamos, #idPrestamo)();
  BoolColumn get esRefinanciamiento => boolean()
      .named('es_refinanciamiento')
      .withDefault(const Constant(false))();
  RealColumn get monto => real()();
  RealColumn get interes => real()();
  DateTimeColumn get fechaInicio => dateTime().named('fecha_inicio')();
  DateTimeColumn get fechaFin => dateTime().named('fecha_fin').nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class PrestamoGarantes extends Table {
  @override
  String get tableName => 'prestamo_garante';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get idPrestamo =>
      integer().named('id_prestamo').references(Prestamos, #idPrestamo)();
  IntColumn get idGarante => integer()
      .named('id_garante')
      .nullable()
      .references(Garantes, #idGarante)();
  IntColumn get idCliente => integer()
      .named('id_cliente')
      .nullable()
      .references(Clientes, #idCliente)();
}

class PrestamoGarantias extends Table {
  @override
  String get tableName => 'prestamo_garantia';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get idPrestamo =>
      integer().named('id_prestamo').references(Prestamos, #idPrestamo)();
  IntColumn get idGarantia =>
      integer().named('id_garantia').references(Garantias, #idGarantia)();
}

class Cuotas extends Table {
  @override
  String get tableName => 'cuota';

  IntColumn get idCuota => integer().named('id_cuota').autoIncrement()();
  IntColumn get idPrestamo => integer()
      .named('id_prestamo')
      .nullable()
      .references(Prestamos, #idPrestamo)();
  IntColumn get idPlan =>
      integer().named('id_plan').nullable().references(PlanPagos, #idPlan)();
  IntColumn get numeroCuota => integer().named('numero_cuota').nullable()();
  RealColumn get montoCuota => real().named('monto_cuota').nullable()();
  RealColumn get montoTotal => real().named('monto_total').nullable()();
  RealColumn get capital => real().nullable()();
  RealColumn get montoCapital => real().named('monto_capital').nullable()();
  RealColumn get interes => real().nullable()();
  RealColumn get montoInteres => real().named('monto_interes').nullable()();
  RealColumn get saldoPendiente => real().named('saldo_pendiente').nullable()();
  RealColumn get saldoRestante => real().named('saldo_restante').nullable()();
  DateTimeColumn get fechaVencimiento =>
      dateTime().named('fecha_vencimiento').nullable()();
  DateTimeColumn get fechaPago => dateTime().named('fecha_pago').nullable()();
  TextColumn get estado => text().withDefault(const Constant('PENDIENTE'))();
  TextColumn get observaciones => text().withDefault(const Constant(''))();
  BoolColumn get mora => boolean().withDefault(const Constant(false))();
  RealColumn get moraMonto =>
      real().named('mora_monto').withDefault(const Constant(0))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Pagos extends Table {
  @override
  String get tableName => 'pago';

  IntColumn get idPago => integer().named('id_pago').autoIncrement()();
  IntColumn get idCuota =>
      integer().named('id_cuota').nullable().references(Cuotas, #idCuota)();
  IntColumn get idPrestamo => integer()
      .named('id_prestamo')
      .nullable()
      .references(Prestamos, #idPrestamo)();
  RealColumn get monto => real().nullable()();
  DateTimeColumn get fechaPago =>
      dateTime().named('fecha_pago').withDefault(currentDateAndTime)();
  TextColumn get metodoPago =>
      text().named('metodo_pago').withDefault(const Constant('EFECTIVO'))();
  TextColumn get observacion => text().withDefault(const Constant(''))();
  BoolColumn get pagoCompleto =>
      boolean().named('pago_completo').withDefault(const Constant(true))();
  TextColumn get tipoPago =>
      text().named('tipo_pago').withDefault(const Constant('NORMAL'))();
  TextColumn get estadoPago =>
      text().named('estado_pago').withDefault(const Constant('COMPLETO'))();
  TextColumn get cuotasIds => text().named('cuotas_ids').nullable()();
  RealColumn get mora => real().withDefault(const Constant(0))();
  RealColumn get descuento => real().withDefault(const Constant(0))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class MetodoPagos extends Table {
  @override
  String get tableName => 'metodo_pago';

  IntColumn get idMetodo => integer().named('id_metodo').autoIncrement()();
  TextColumn get nombre => text().unique()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
}

class CategoriaEgresos extends Table {
  @override
  String get tableName => 'categoria_egreso';

  IntColumn get idCategoria =>
      integer().named('id_categoria').autoIncrement()();
  TextColumn get nombre => text().unique()();
  TextColumn get descripcion => text().withDefault(const Constant(''))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Egresos extends Table {
  @override
  String get tableName => 'egreso';

  IntColumn get idEgreso => integer().named('id_egreso').autoIncrement()();
  IntColumn get idCategoria => integer()
      .named('id_categoria')
      .nullable()
      .references(CategoriaEgresos, #idCategoria)();
  TextColumn get idUsuario =>
      text().named('id_usuario').nullable().references(Usuarios, #idUsuario)();
  TextColumn get descripcion => text().nullable()();
  TextColumn get concepto => text().nullable()();
  RealColumn get monto => real().nullable()();
  DateTimeColumn get fecha => dateTime().nullable()();
  TextColumn get observaciones => text().withDefault(const Constant(''))();
  BoolColumn get estado => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class SimulacionPrestamos extends Table {
  @override
  String get tableName => 'simulacion_prestamo';

  IntColumn get idSimulacion =>
      integer().named('id_simulacion').autoIncrement()();
  TextColumn get idUsuario =>
      text().named('id_usuario').nullable().references(Usuarios, #idUsuario)();
  RealColumn get monto => real()();
  RealColumn get interes => real()();
  IntColumn get numeroCuotas => integer().named('numero_cuotas')();
  TextColumn get frecuenciaPago => text().named('frecuencia_pago')();
  TextColumn get tipoPrestamo => text().named('tipo_prestamo')();
  DateTimeColumn get fechaInicio => dateTime().named('fecha_inicio')();
  RealColumn get totalCobrar => real().named('total_cobrar')();
  RealColumn get interesTotal => real().named('interes_total')();
  RealColumn get valorCuota => real().named('valor_cuota')();
  TextColumn get planPagos => text().named('plan_pagos').nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class PlanPagos extends Table {
  @override
  String get tableName => 'plan_pagos';

  IntColumn get idPlan => integer().named('id_plan').autoIncrement()();
  IntColumn get idPrestamo => integer()
      .named('id_prestamo')
      .nullable()
      .references(Prestamos, #idPrestamo)();
  IntColumn get numeroCuotas => integer().named('numero_cuotas').nullable()();
  TextColumn get frecuenciaPago => text().named('frecuencia_pago').nullable()();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Personas,
    Clientes,
    RolUsuarios,
    Usuarios,
    Monedas,
    Configuraciones,
    Cobradores,
    Garantes,
    Garantias,
    TipoPrestamos,
    EstadoPrestamos,
    Prestamos,
    PrestamoGarantes,
    PrestamoGarantias,
    Cuotas,
    Pagos,
    MetodoPagos,
    CategoriaEgresos,
    Egresos,
    SimulacionPrestamos,
    PlanPagos,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await _addColumnIfMissing(m, cuotas, 'cuota', 'id_plan', cuotas.idPlan);
        await _addColumnIfMissing(
          m,
          cuotas,
          'cuota',
          'monto_total',
          cuotas.montoTotal,
        );
        await _addColumnIfMissing(
          m,
          cuotas,
          'cuota',
          'monto_capital',
          cuotas.montoCapital,
        );
        await _addColumnIfMissing(
          m,
          cuotas,
          'cuota',
          'monto_interes',
          cuotas.montoInteres,
        );
        await _addColumnIfMissing(
          m,
          cuotas,
          'cuota',
          'saldo_restante',
          cuotas.saldoRestante,
        );
        await _addColumnIfMissing(
          m,
          garantias,
          'garantia',
          'url_referencia',
          garantias.urlReferencia,
        );
      }
    },
  );

  Future<void> _addColumnIfMissing(
    Migrator m,
    TableInfo tableInfo,
    String table,
    String column,
    GeneratedColumn columnDef,
  ) async {
    final exists = await customSelect('pragma table_info("$table")').get();
    final hasColumn = exists.any((row) => row.data['name'] == column);
    if (!hasColumn) {
      await m.addColumn(tableInfo, columnDef);
    }
  }

  Future<void> seedCatalogosBase() async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(rolUsuarios, [
        RolUsuariosCompanion.insert(
          idRol: const Value(1),
          nombre: 'ADMIN',
          descripcion: const Value('Administrador del sistema'),
        ),
        RolUsuariosCompanion.insert(
          idRol: const Value(2),
          nombre: 'CLIENTE',
          descripcion: const Value('Cliente con acceso a su cuenta'),
        ),
        RolUsuariosCompanion.insert(
          idRol: const Value(3),
          nombre: 'COBRADOR',
          descripcion: const Value('Gestiona cobranza en ruta'),
        ),
      ]);
      batch.insertAllOnConflictUpdate(tipoPrestamos, [
        TipoPrestamosCompanion.insert(
          idTipo: const Value(1),
          nombre: 'Gota a gota',
          descripcion: const Value('Cobro diario'),
        ),
        TipoPrestamosCompanion.insert(
          idTipo: const Value(2),
          nombre: 'Mensual',
          descripcion: const Value('Interes mensual con capital al final'),
        ),
        TipoPrestamosCompanion.insert(
          idTipo: const Value(3),
          nombre: 'Frances',
          descripcion: const Value('Amortizacion progresiva'),
        ),
        TipoPrestamosCompanion.insert(
          idTipo: const Value(4),
          nombre: 'Amortizacion Universal',
          descripcion: const Value('Capital fijo con interes sobre saldo'),
        ),
      ]);
      batch.insertAllOnConflictUpdate(estadoPrestamos, [
        EstadoPrestamosCompanion.insert(
          idEstado: const Value(1),
          nombre: 'ACTIVO',
        ),
        EstadoPrestamosCompanion.insert(
          idEstado: const Value(2),
          nombre: 'PAGADO',
        ),
        EstadoPrestamosCompanion.insert(
          idEstado: const Value(3),
          nombre: 'MORA',
        ),
        EstadoPrestamosCompanion.insert(
          idEstado: const Value(4),
          nombre: 'CANCELADO',
        ),
        EstadoPrestamosCompanion.insert(
          idEstado: const Value(5),
          nombre: 'REFINANCIADO',
        ),
      ]);
      batch.insertAllOnConflictUpdate(metodoPagos, [
        MetodoPagosCompanion.insert(
          idMetodo: const Value(1),
          nombre: 'EFECTIVO',
        ),
        MetodoPagosCompanion.insert(idMetodo: const Value(2), nombre: 'QR'),
        MetodoPagosCompanion.insert(
          idMetodo: const Value(3),
          nombre: 'TRANSFERENCIA',
        ),
      ]);
      batch.insertAllOnConflictUpdate(categoriaEgresos, [
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(1),
          nombre: 'Combustible',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(2),
          nombre: 'Transporte',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(3),
          nombre: 'Viaticos',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(4),
          nombre: 'Alimentacion',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(5),
          nombre: 'Mantenimiento',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(6),
          nombre: 'Papeleria',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(7),
          nombre: 'Servicios',
        ),
        CategoriaEgresosCompanion.insert(
          idCategoria: const Value(8),
          nombre: 'Otros',
        ),
      ]);
      batch.insertAllOnConflictUpdate(monedas, [
        MonedasCompanion.insert(idMoneda: const Value(1), nombre: 'BOB'),
        MonedasCompanion.insert(idMoneda: const Value(2), nombre: 'USD'),
      ]);
    });
  }
}
