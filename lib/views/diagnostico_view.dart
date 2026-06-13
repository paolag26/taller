import 'package:flutter/material.dart';

import 'package:sist_prestamo/provider/diagnostico_provider.dart';
import 'package:sist_prestamo/controllers/diagnostico_controller.dart';

class DiagnosticoView extends StatefulWidget {
  const DiagnosticoView({super.key});

  @override
  State<DiagnosticoView> createState() => _DiagnosticoViewState();
}

class _DiagnosticoViewState extends State<DiagnosticoView> {
  final controller = DiagnosticoProvider().controller;

  @override
  void initState() {
    super.initState();
    controller.cargar();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(child: Text(controller.error!));
        }

        return RefreshIndicator(
          onRefresh: controller.cargar,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _ResumenGeneral(controller: controller),
              const SizedBox(height: 16),
              _RolesSection(controller: controller),
              const SizedBox(height: 16),
              _UsuariosSection(controller: controller),
              const SizedBox(height: 16),
              _PrestamosSection(controller: controller),
              const SizedBox(height: 16),
              _CuotasPendientesSection(controller: controller),
              const SizedBox(height: 16),
              _CoordenadasSection(controller: controller),
              const SizedBox(height: 16),
              _ConceptoGastoSection(controller: controller),
            ],
          ),
        );
      },
    );
  }
}

class _ResumenGeneral extends StatelessWidget {
  final DiagnosticoController controller;

  const _ResumenGeneral({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Resumen datos Base local',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          _Metric(label: 'Roles', value: controller.roles.length),
          _Metric(label: 'Usuarios', value: controller.usuarios.length),
          _Metric(label: 'Personas', value: controller.personas.length),
          _Metric(label: 'Prestamos', value: controller.prestamos.length),
          _Metric(label: 'Planes', value: controller.planes.length),
          _Metric(label: 'Cuotas', value: controller.cuotas.length),
          _Metric(label: 'Pagos', value: controller.pagos.length),
          _Metric(label: 'Conceptos', value: controller.conceptosGasto.length),
          _Metric(label: 'Egresos', value: controller.egresos.length),
        ],
      ),
    );
  }
}

class _RolesSection extends StatelessWidget {
  final DiagnosticoController controller;

  const _RolesSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Roles',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SimpleTable(
            columns: const ['id_rol', 'nombre', 'descripcion'],
            rows: controller.roles,
          ),
          if (controller.rolesFaltantes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Faltan roles: ${controller.rolesFaltantes.join(', ')}',
              style: const TextStyle(
                color: Color(0xffb91c1c),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            const _SqlBlock(sql: _rolesSql),
          ],
        ],
      ),
    );
  }
}

class _UsuariosSection extends StatelessWidget {
  final DiagnosticoController controller;

  const _UsuariosSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Usuarios creados',
      child: _SimpleTable(
        columns: const ['persona', 'rol', 'username', 'estado', 'id_usuario'],
        rows: controller.usuariosDiagnostico,
      ),
    );
  }
}

class _PrestamosSection extends StatelessWidget {
  final DiagnosticoController controller;

  const _PrestamosSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    final sinCuotas = controller.prestamosDiagnostico.where((prestamo) {
      return prestamo['cuotas'] == 0;
    }).length;

    return _Panel(
      title: 'Prestamos / plan_pagos / cuota',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sinCuotas > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                '$sinCuotas prestamos no tienen cuotas relacionadas.',
                style: const TextStyle(
                  color: Color(0xffb91c1c),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          _SimpleTable(
            columns: const [
              'id_prestamo',
              'planes',
              'cuotas',
              'pendientes',
              'pagadas',
              'mora',
              'saldo',
            ],
            rows: controller.prestamosDiagnostico,
          ),
        ],
      ),
    );
  }
}

class _CuotasPendientesSection extends StatelessWidget {
  final DiagnosticoController controller;

  const _CuotasPendientesSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Cuotas disponibles para pagos',
      child: _SimpleTable(
        columns: const ['id_prestamo', 'id_cuota', 'estado', 'saldo_pendiente'],
        rows: controller.cuotasPendientesDiagnostico,
      ),
    );
  }
}

class _CoordenadasSection extends StatelessWidget {
  final DiagnosticoController controller;

  const _CoordenadasSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'Ubicaciones persona.latitud / persona.longitud',
      child: _SimpleTable(
        columns: const ['persona', 'latitud', 'longitud'],
        rows: controller.coordenadasDiagnostico,
      ),
    );
  }
}

class _ConceptoGastoSection extends StatelessWidget {
  final DiagnosticoController controller;

  const _ConceptoGastoSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _Panel(
      title: 'concepto_gasto / RLS',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Registros leidos: ${controller.conceptosGasto.length}'),
          if (controller.conceptoGastoError != null) ...[
            const SizedBox(height: 8),
            Text(
              controller.conceptoGastoError!,
              style: const TextStyle(color: Color(0xffb91c1c)),
            ),
          ],
          const SizedBox(height: 12),
          const Text(
            'SQL para revisar y corregir policies en Base local si RLS bloquea INSERT/UPDATE/SELECT:',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const _SqlBlock(sql: _conceptoGastoRlsSql),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget child;

  const _Panel({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffe5e7eb)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final int value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        border: Border.all(color: const Color(0xffe5e7eb)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          Text(label),
        ],
      ),
    );
  }
}

class _SimpleTable extends StatelessWidget {
  final List<String> columns;
  final List<Map<String, dynamic>> rows;

  const _SimpleTable({required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const Text('Sin registros.');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final visibles = rows.take(80).toList();
        if (constraints.maxWidth < 700) {
          return Column(
            children: visibles.map((row) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xfff8fafc),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xffe5e7eb)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columns.map((column) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('$column: ${_value(row[column])}'),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: columns.map((column) {
              return DataColumn(label: Text(column));
            }).toList(),
            rows: visibles.map((row) {
              return DataRow(
                cells: columns.map((column) {
                  return DataCell(
                    SizedBox(
                      width: 160,
                      child: Text(
                        _value(row[column]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  String _value(dynamic value) {
    if (value == null) return '';
    if (value is double) return value.toStringAsFixed(2);
    return value.toString();
  }
}

class _SqlBlock extends StatelessWidget {
  final String sql;

  const _SqlBlock({required this.sql});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff111827),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        sql,
        style: const TextStyle(
          color: Color(0xffe5e7eb),
          fontFamily: 'monospace',
          fontSize: 12,
        ),
      ),
    );
  }
}

const _rolesSql = '''
insert into public.rol (nombre, descripcion)
select 'ADMIN', 'Administrador del sistema'
where not exists (
  select 1 from public.rol where upper(nombre) = 'ADMIN'
);

insert into public.rol (nombre, descripcion)
select 'CLIENTE', 'Cliente del sistema'
where not exists (
  select 1 from public.rol where upper(nombre) = 'CLIENTE'
);

insert into public.rol (nombre, descripcion)
select 'COBRADOR', 'Cobrador del sistema'
where not exists (
  select 1 from public.rol where upper(nombre) = 'COBRADOR'
);
''';

const _conceptoGastoRlsSql = '''
select schemaname, tablename, rowsecurity
from pg_tables
where schemaname = 'public'
  and tablename = 'concepto_gasto';

select policyname, cmd, roles, qual, with_check
from pg_policies
where schemaname = 'public'
  and tablename = 'concepto_gasto';

alter table public.concepto_gasto enable row level security;

do \$\$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'concepto_gasto'
      and policyname = 'concepto_gasto_select_authenticated'
  ) then
    create policy concepto_gasto_select_authenticated
    on public.concepto_gasto
    for select
    to authenticated
    using (true);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'concepto_gasto'
      and policyname = 'concepto_gasto_insert_authenticated'
  ) then
    create policy concepto_gasto_insert_authenticated
    on public.concepto_gasto
    for insert
    to authenticated
    with check (true);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'concepto_gasto'
      and policyname = 'concepto_gasto_update_authenticated'
  ) then
    create policy concepto_gasto_update_authenticated
    on public.concepto_gasto
    for update
    to authenticated
    using (true)
    with check (true);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public'
      and tablename = 'concepto_gasto'
      and policyname = 'concepto_gasto_delete_authenticated'
  ) then
    create policy concepto_gasto_delete_authenticated
    on public.concepto_gasto
    for delete
    to authenticated
    using (true);
  end if;
end
\$\$;
''';
