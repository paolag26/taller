import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/erp_card.dart';
import 'package:sist_prestamo/views/loading_widget.dart';
import 'package:sist_prestamo/provider/egreso_provider.dart';
import 'package:sist_prestamo/controllers/egreso_controller.dart';
import 'package:sist_prestamo/models/egreso_model.dart';

class EgresosView extends StatefulWidget {
  const EgresosView({super.key});

  @override
  State<EgresosView> createState() => _EgresosViewState();
}

class _EgresosViewState extends State<EgresosView>
    with SingleTickerProviderStateMixin {
  final controller = EgresoProvider().controller;
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    controller.cargarEgresos();
  }

  @override
  void dispose() {
    tabController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.loading) {
          return const LoadingWidget();
        }

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: 'Egresos y gastos',
                subtitle:
                    'Control de gastos operativos por conceptos de gasto.',
                trailing: ElevatedButton.icon(
                  onPressed: () => _abrirFormulario(),
                  icon: const Icon(Icons.add),
                  label: const Text('Registrar gasto'),
                ),
              ),
              if (controller.error != null) ...[
                const SizedBox(height: 12),
                _ErrorBox(message: controller.error!),
              ],
              const SizedBox(height: 16),
              _SummaryCards(controller: controller),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xffe2e8f0)),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  labelColor: const Color(0xff14532d),
                  unselectedLabelColor: const Color(0xff64748b),
                  indicatorColor: const Color(0xff14532d),
                  tabs: const [
                    Tab(icon: Icon(Icons.receipt_long), text: 'Lista'),
                    Tab(icon: Icon(Icons.add_card), text: 'Registrar'),
                    Tab(icon: Icon(Icons.category), text: 'Conceptos de Gasto'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    _ListaTab(
                      controller: controller,
                      onEdit: _abrirFormulario,
                      onDelete: _confirmarEliminar,
                      onDetail: _verDetalle,
                    ),
                    _RegistroTab(
                      controller: controller,
                      onSave: (egreso) async {
                        await _guardar(egreso);
                        tabController.animateTo(0);
                      },
                    ),
                    _ConceptosTab(
                      controller: controller,
                      onSave: _guardarConcepto,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _abrirFormulario([EgresoModel? egreso]) async {
    final result = await showDialog<EgresoModel>(
      context: context,
      builder: (context) {
        return _EgresoFormDialog(
          egreso: egreso,
          conceptos: controller.conceptos,
        );
      },
    );

    if (result == null) return;
    await _guardar(result);
  }

  Future<void> _guardar(EgresoModel egreso) async {
    try {
      await controller.guardarEgreso(egreso);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gasto guardado')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar el gasto')),
      );
    }
  }

  Future<void> _guardarConcepto(ConceptoGastoModel concepto) async {
    try {
      await controller.guardarConcepto(concepto);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Concepto de gasto guardado')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar el concepto de gasto'),
        ),
      );
    }
  }

  Future<void> _confirmarEliminar(EgresoModel egreso) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Inhabilitar gasto'),
          content: Text(
            'El gasto "${egreso.concepto}" quedara inactivo y no se sumara en reportes.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Inhabilitar'),
            ),
          ],
        );
      },
    );

    if (confirmar != true || egreso.idEgreso == null) return;

    try {
      await controller.eliminarEgreso(egreso.idEgreso!);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gasto inhabilitado')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo inhabilitar el gasto')),
      );
    }
  }

  Future<void> _verDetalle(EgresoModel egreso) async {
    await showDialog(
      context: context,
      builder: (context) => _DetalleDialog(egreso: egreso),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  final EgresoController controller;

  const _SummaryCards({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        _MetricBox(
          title: 'Gastos del dia',
          value: _money(controller.totalDia),
          icon: Icons.today,
          color: const Color(0xff2563eb),
        ),
        _MetricBox(
          title: 'Gastos del mes',
          value: _money(controller.totalMesActual),
          icon: Icons.calendar_month,
          color: const Color(0xffdc2626),
        ),
        _MetricBox(
          title: 'Gastos del anio',
          value: _money(controller.totalAnioActual),
          icon: Icons.event,
          color: const Color(0xff7c3aed),
        ),
        _MetricBox(
          title: 'Concepto mayor',
          value: controller.conceptoMayorGasto,
          icon: Icons.category,
          color: const Color(0xffd97706),
        ),
      ],
    );
  }

  String _money(double value) => 'Bs ${value.toStringAsFixed(2)}';
}

class _MetricBox extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricBox({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffe2e8f0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xff64748b))),
                const SizedBox(height: 6),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListaTab extends StatelessWidget {
  final EgresoController controller;
  final ValueChanged<EgresoModel> onEdit;
  final ValueChanged<EgresoModel> onDelete;
  final ValueChanged<EgresoModel> onDetail;

  const _ListaTab({
    required this.controller,
    required this.onEdit,
    required this.onDelete,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FiltersPanel(controller: controller),
        const SizedBox(height: 14),
        Expanded(
          child: ErpCard(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Expanded(
                  child: controller.egresosPaginados.isEmpty
                      ? _EmptyEgresos(onNew: () => onEdit(nullEgreso))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              const Color(0xfff8fafc),
                            ),
                            columns: const [
                              DataColumn(label: Text('Codigo')),
                              DataColumn(label: Text('Fecha')),
                              DataColumn(label: Text('Concepto')),
                              DataColumn(label: Text('Concepto de Gasto')),
                              DataColumn(label: Text('Usuario')),
                              DataColumn(label: Text('Monto')),
                              DataColumn(label: Text('Estado')),
                              DataColumn(label: Text('Acciones')),
                            ],
                            rows: controller.egresosPaginados.map((egreso) {
                              return DataRow(
                                cells: [
                                  DataCell(Text('#${egreso.idEgreso ?? '-'}')),
                                  DataCell(Text(egreso.fecha)),
                                  DataCell(
                                    SizedBox(
                                      width: 190,
                                      child: Text(
                                        egreso.concepto,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(egreso.conceptoNombre)),
                                  DataCell(Text(egreso.usuarioNombre)),
                                  DataCell(Text(_money(egreso.monto))),
                                  DataCell(
                                    StatusChip.fromText(
                                      egreso.estado ? 'ACTIVO' : 'INACTIVO',
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          tooltip: 'Detalle',
                                          onPressed: () => onDetail(egreso),
                                          icon: const Icon(
                                            Icons.visibility_outlined,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Editar',
                                          onPressed: () => onEdit(egreso),
                                          icon: const Icon(Icons.edit_outlined),
                                        ),
                                        IconButton(
                                          tooltip: 'Inhabilitar',
                                          onPressed: egreso.estado
                                              ? () => onDelete(egreso)
                                              : null,
                                          icon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                ),
                const SizedBox(height: 10),
                _Pagination(controller: controller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  EgresoModel get nullEgreso => EgresoModel(
    fecha: _date(DateTime.now()),
    concepto: '',
    descripcion: '',
    monto: 0,
  );

  String _money(double value) => 'Bs ${value.toStringAsFixed(2)}';
}

class _FiltersPanel extends StatelessWidget {
  final EgresoController controller;

  const _FiltersPanel({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      padding: const EdgeInsets.all(14),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 270,
            child: TextField(
              inputFormatters: AppValidators.safeText,
              onChanged: controller.cambiarBusqueda,
              decoration: const InputDecoration(
                labelText: 'Buscar por concepto',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: DropdownButtonFormField<int?>(
              initialValue: controller.filters.idConcepto,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Concepto de Gasto'),
              items: [
                const DropdownMenuItem<int?>(value: null, child: Text('Todas')),
                ...controller.conceptos.map((concepto) {
                  return DropdownMenuItem<int?>(
                    value: concepto.id,
                    child: Text(concepto.nombre),
                  );
                }),
              ],
              onChanged: controller.cambiarConcepto,
            ),
          ),
          SizedBox(
            width: 220,
            child: DropdownButtonFormField<String?>(
              initialValue: controller.filters.idUsuario,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Usuario'),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('Todos'),
                ),
                ...controller.usuarios.map((usuario) {
                  return DropdownMenuItem<String?>(
                    value: usuario.idUsuario,
                    child: Text(usuario.nombre),
                  );
                }),
              ],
              onChanged: controller.cambiarUsuario,
            ),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                initialDateRange:
                    controller.filters.desde == null ||
                        controller.filters.hasta == null
                    ? null
                    : DateTimeRange(
                        start: controller.filters.desde!,
                        end: controller.filters.hasta!,
                      ),
              );

              if (range != null) {
                controller.cambiarRango(range.start, range.end);
              }
            },
            icon: const Icon(Icons.date_range),
            label: Text(
              controller.filters.desde == null
                  ? 'Rango de fechas'
                  : '${_date(controller.filters.desde!)} / ${_date(controller.filters.hasta!)}',
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => controller.cambiarRango(null, null),
            icon: const Icon(Icons.clear),
            label: const Text('Limpiar fechas'),
          ),
          FilterChip(
            label: const Text('Ver inactivos'),
            selected: controller.filters.incluirInactivos,
            onSelected: controller.cambiarIncluirInactivos,
          ),
        ],
      ),
    );
  }
}

class _Pagination extends StatelessWidget {
  final EgresoController controller;

  const _Pagination({required this.controller});

  @override
  Widget build(BuildContext context) {
    final page = controller.filters.page;
    final total = controller.totalPaginas;

    return Row(
      children: [
        Text(
          'Mostrando ${controller.egresosPaginados.length} de ${controller.egresosFiltrados.length} gastos',
          style: const TextStyle(color: Color(0xff64748b)),
        ),
        const Spacer(),
        IconButton(
          onPressed: page == 0 ? null : () => controller.irPagina(page - 1),
          icon: const Icon(Icons.chevron_left),
        ),
        Text('${page + 1} / $total'),
        IconButton(
          onPressed: page + 1 >= total
              ? null
              : () => controller.irPagina(page + 1),
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}

class _RegistroTab extends StatelessWidget {
  final EgresoController controller;
  final ValueChanged<EgresoModel> onSave;

  const _RegistroTab({required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ErpCard(
        child: _EgresoInlineForm(
          conceptos: controller.conceptos,
          onSave: onSave,
        ),
      ),
    );
  }
}

class _ConceptosTab extends StatelessWidget {
  final EgresoController controller;
  final ValueChanged<ConceptoGastoModel> onSave;

  const _ConceptosTab({required this.controller, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ErpCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Conceptos de Gasto',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _openConceptoDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Nuevo concepto'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.separated(
              itemCount: controller.conceptos.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final concepto = controller.conceptos[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: concepto.activo
                        ? const Color(0xffdcfce7)
                        : const Color(0xffe2e8f0),
                    child: Icon(
                      Icons.category,
                      color: concepto.activo
                          ? const Color(0xff14532d)
                          : const Color(0xff64748b),
                    ),
                  ),
                  title: Text(concepto.nombre),
                  subtitle: Text(concepto.descripcion),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      Switch(
                        value: concepto.activo,
                        onChanged: (value) {
                          controller.cambiarEstadoConcepto(concepto, value);
                        },
                      ),
                      IconButton(
                        tooltip: 'Editar',
                        onPressed: () =>
                            _openConceptoDialog(context, concepto: concepto),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openConceptoDialog(
    BuildContext context, {
    ConceptoGastoModel? concepto,
  }) async {
    final result = await showDialog<ConceptoGastoModel>(
      context: context,
      builder: (context) => _ConceptoDialog(concepto: concepto),
    );

    if (result != null) {
      onSave(result);
    }
  }
}

class _EgresoFormDialog extends StatelessWidget {
  final EgresoModel? egreso;
  final List<ConceptoGastoModel> conceptos;

  const _EgresoFormDialog({this.egreso, required this.conceptos});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(egreso == null ? 'Registrar gasto' : 'Editar gasto'),
      content: SizedBox(
        width: 620,
        child: SingleChildScrollView(
          child: _EgresoInlineForm(
            egreso: egreso,
            conceptos: conceptos,
            onSave: (value) => Navigator.pop(context, value),
          ),
        ),
      ),
    );
  }
}

class _EgresoInlineForm extends StatefulWidget {
  final EgresoModel? egreso;
  final List<ConceptoGastoModel> conceptos;
  final ValueChanged<EgresoModel> onSave;

  const _EgresoInlineForm({
    this.egreso,
    required this.conceptos,
    required this.onSave,
  });

  @override
  State<_EgresoInlineForm> createState() => _EgresoInlineFormState();
}

class _EgresoInlineFormState extends State<_EgresoInlineForm> {
  final formKey = GlobalKey<FormState>();
  final fechaController = TextEditingController();
  final conceptoController = TextEditingController();
  final descripcionController = TextEditingController();
  final montoController = TextEditingController();
  final observacionesController = TextEditingController();
  int? idConcepto;
  bool estado = true;
  bool get puedeGuardar {
    return _required(fechaController.text) == null &&
        conceptoController.text.trim().isNotEmpty &&
        widget.conceptos.any(
          (concepto) =>
              concepto.activo &&
              concepto.nombre.trim().toLowerCase() ==
                  conceptoController.text.trim().toLowerCase(),
        ) &&
        _moneyValidator(montoController.text) == null &&
        idConcepto != null &&
        AppValidators.safeTextValidator(descripcionController.text) == null &&
        AppValidators.safeTextValidator(observacionesController.text) == null;
  }

  @override
  void initState() {
    super.initState();
    final egreso = widget.egreso;
    fechaController.text = egreso?.fecha ?? _date(DateTime.now());
    conceptoController.text = egreso?.concepto ?? '';
    descripcionController.text = egreso?.descripcion ?? '';
    montoController.text = egreso == null ? '' : egreso.monto.toString();
    observacionesController.text = egreso?.observaciones ?? '';
    idConcepto = egreso?.idConcepto ?? _idConceptoPorNombre(egreso?.concepto);
    estado = egreso?.estado ?? true;
  }

  @override
  void dispose() {
    fechaController.dispose();
    conceptoController.dispose();
    descripcionController.dispose();
    montoController.dispose();
    observacionesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: () => setState(() {}),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Datos del gasto',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 180,
                child: TextFormField(
                  controller: fechaController,
                  readOnly: true,
                  validator: _required,
                  decoration: InputDecoration(
                    labelText: 'Fecha',
                    suffixIcon: IconButton(
                      onPressed: _selectFecha,
                      icon: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 260,
                child: DropdownButtonFormField<int>(
                  initialValue: idConcepto,
                  validator: (value) =>
                      value == null ? 'Seleccione un concepto' : null,
                  decoration: const InputDecoration(
                    labelText: 'Concepto de Gasto',
                  ),
                  items: widget.conceptos
                      .where((concepto) => concepto.activo)
                      .map((concepto) {
                        return DropdownMenuItem<int>(
                          value: concepto.id,
                          child: Text(concepto.nombre),
                        );
                      })
                      .toList(),
                  onChanged: (value) {
                    final concepto = widget.conceptos.firstWhere(
                      (item) => item.id == value,
                    );
                    setState(() {
                      idConcepto = value;
                      conceptoController.text = concepto.nombre;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 180,
                child: TextFormField(
                  controller: montoController,
                  validator: _moneyValidator,
                  inputFormatters: AppValidators.decimalOnly,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Monto'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: descripcionController,
            inputFormatters: AppValidators.safeText,
            validator: AppValidators.safeTextValidator,
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Descripcion'),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: observacionesController,
            inputFormatters: AppValidators.safeText,
            validator: AppValidators.safeTextValidator,
            minLines: 2,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Observaciones'),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Gasto activo'),
            value: estado,
            onChanged: (value) {
              setState(() {
                estado = value;
              });
            },
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: puedeGuardar ? _save : null,
                icon: const Icon(Icons.save),
                label: const Text('Guardar gasto'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectFecha() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(fechaController.text) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      fechaController.text = _date(selected);
    }
  }

  void _save() {
    if (!formKey.currentState!.validate()) return;

    widget.onSave(
      EgresoModel(
        idEgreso: widget.egreso?.idEgreso,
        fecha: fechaController.text.trim(),
        concepto: AppValidators.sanitizeText(conceptoController.text),
        descripcion: AppValidators.sanitizeText(descripcionController.text),
        monto: double.parse(
          AppValidators.sanitizeNumeric(montoController.text),
        ),
        idConcepto: idConcepto,
        observaciones: AppValidators.sanitizeText(observacionesController.text),
        estado: estado,
      ),
    );
  }

  int? _idConceptoPorNombre(String? nombre) {
    final text = nombre?.trim().toLowerCase() ?? '';
    if (text.isEmpty) return null;
    for (final concepto in widget.conceptos) {
      if (concepto.nombre.trim().toLowerCase() == text) {
        return concepto.id;
      }
    }
    return null;
  }
}

class _ConceptoDialog extends StatefulWidget {
  final ConceptoGastoModel? concepto;

  const _ConceptoDialog({this.concepto});

  @override
  State<_ConceptoDialog> createState() => _ConceptoDialogState();
}

class _ConceptoDialogState extends State<_ConceptoDialog> {
  final formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  bool activo = true;
  bool get puedeGuardar {
    return AppValidators.letters(nombreController.text) == null &&
        AppValidators.safeTextValidator(descripcionController.text) == null;
  }

  @override
  void initState() {
    super.initState();
    final concepto = widget.concepto;
    nombreController.text = concepto?.nombre ?? '';
    descripcionController.text = concepto?.descripcion ?? '';
    activo = concepto?.activo ?? true;
  }

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.concepto == null
            ? 'Nuevo concepto de gasto'
            : 'Concepto de gasto',
      ),
      content: SizedBox(
        width: 420,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () => setState(() {}),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nombreController,
                inputFormatters: AppValidators.lettersOnly,
                validator: AppValidators.letters,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descripcionController,
                inputFormatters: AppValidators.safeText,
                validator: AppValidators.safeTextValidator,
                minLines: 2,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Descripcion'),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Activo'),
                value: activo,
                onChanged: (value) {
                  setState(() {
                    activo = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: puedeGuardar
              ? () {
                  if (!formKey.currentState!.validate()) return;

                  Navigator.pop(
                    context,
                    ConceptoGastoModel(
                      id: widget.concepto?.id,
                      nombre: AppValidators.sanitizeText(nombreController.text),
                      descripcion: AppValidators.sanitizeText(
                        descripcionController.text,
                      ),
                      activo: activo,
                    ),
                  );
                }
              : null,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}

class _DetalleDialog extends StatelessWidget {
  final EgresoModel egreso;

  const _DetalleDialog({required this.egreso});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Detalle gasto #${egreso.idEgreso ?? '-'}'),
      content: SizedBox(
        width: 460,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Fecha', egreso.fecha),
            _DetailRow('Concepto de Gasto', egreso.conceptoNombre),
            _DetailRow('Descripcion', egreso.descripcion),
            _DetailRow('Usuario', egreso.usuarioNombre),
            _DetailRow('Monto', _money(egreso.monto)),
            _DetailRow('Observaciones', egreso.observaciones),
            _DetailRow('Estado', egreso.estado ? 'Activo' : 'Inactivo'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xff64748b),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}

class _EmptyEgresos extends StatelessWidget {
  final VoidCallback onNew;

  const _EmptyEgresos({required this.onNew});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.receipt_long, size: 58, color: Color(0xff94a3b8)),
          const SizedBox(height: 12),
          const Text(
            'No hay gastos para mostrar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: onNew,
            icon: const Icon(Icons.add),
            label: const Text('Registrar gasto'),
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  final String message;

  const _ErrorBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfffff1f2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xfffecdd3)),
      ),
      child: Text(message, style: const TextStyle(color: Color(0xffbe123c))),
    );
  }
}

String? _required(String? value) {
  return AppValidators.required(value);
}

String? _moneyValidator(String? value) {
  return AppValidators.decimal(value);
}

String _date(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}

String _money(double value) => 'Bs ${value.toStringAsFixed(2)}';
