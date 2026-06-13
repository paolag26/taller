import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sist_prestamo/models/calculadora_model.dart';
import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/app_feedback.dart';
import 'package:sist_prestamo/views/prestamo_plan_preview.dart';
import 'package:sist_prestamo/controllers/prestamo_controller.dart';
import 'package:sist_prestamo/models/prestamo_model.dart';

class PrestamoFormDialog extends StatefulWidget {
  final PrestamoController controller;
  final Map<String, dynamic>? prestamo;
  final SimulacionPrestamo? simulacionInicial;

  const PrestamoFormDialog({
    super.key,
    required this.controller,
    this.prestamo,
    this.simulacionInicial,
  });

  @override
  State<PrestamoFormDialog> createState() => _PrestamoFormDialogState();
}

class _PrestamoFormDialogState extends State<PrestamoFormDialog> {
  final formKey = GlobalKey<FormState>();
  final montoController = TextEditingController();
  final interesController = TextEditingController();
  final cuotasController = TextEditingController(text: '24');
  final fechaInicioController = TextEditingController();
  final fechaFinController = TextEditingController();

  List<Map<String, dynamic>> clientes = [];
  List<Map<String, dynamic>> tipos = [];
  List<Map<String, dynamic>> estados = [];

  int? clienteSeleccionado;
  int? tipoSeleccionado;
  int? estadoSeleccionado;
  bool esRefinanciamiento = false;
  bool loading = true;
  bool saving = false;
  String? catalogosError;
  String garantiaModo = 'NINGUNA';
  int? garanteClienteSeleccionado;
  SimulacionPrestamo? simulacion;
  final List<Map<String, dynamic>> garantes = [];
  final List<Map<String, dynamic>> articulos = [];

  bool get isEditing => widget.prestamo != null;
  bool get puedeGuardar {
    return clienteSeleccionado != null &&
        tipoSeleccionado != null &&
        numeroRequerido(montoController.text) == null &&
        validarInteres(interesController.text) == null &&
        AppValidators.integer(cuotasController.text) == null;
  }

  @override
  void initState() {
    super.initState();
    _actualizarFechasAutomaticas();
    _cargarSimulacionInicial();
    montoController.addListener(_actualizarVistaPrevia);
    interesController.addListener(_actualizarVistaPrevia);
    cuotasController.addListener(_actualizarVistaPrevia);
    cargarDatos();
  }

  @override
  void dispose() {
    montoController.dispose();
    interesController.dispose();
    cuotasController.dispose();
    fechaInicioController.dispose();
    fechaFinController.dispose();
    super.dispose();
  }

  Future<void> cargarDatos() async {
    final data = await widget.controller.cargarDatosFormulario();

    if (!mounted) return;

    setState(() {
      clientes = data.clientes;
      tipos = data.tipos;
      estados = data.estados;
      catalogosError = data.catalogosError;
      _cargarPrestamoExistente();
      tipoSeleccionado ??= tipos.isNotEmpty ? tipos.first['id_tipo'] : null;
      estadoSeleccionado ??= _idEstadoPorNombre('ACTIVO');
      loading = false;
    });

    _actualizarVistaPrevia();
  }

  void _cargarPrestamoExistente() {
    final prestamo = widget.prestamo;
    if (prestamo == null) return;

    clienteSeleccionado = prestamo['id_cliente'];
    tipoSeleccionado = prestamo['id_tipo'];
    estadoSeleccionado = prestamo['id_estado'];
    esRefinanciamiento = prestamo['es_refinanciamiento'] == true;
    montoController.text = prestamo['monto']?.toString() ?? '';
    interesController.text = prestamo['interes']?.toString() ?? '';
    cuotasController.text = '24';
    fechaInicioController.text = prestamo['fecha_inicio']?.toString() ?? '';
    fechaFinController.text = prestamo['fecha_fin']?.toString() ?? '';
  }

  void _cargarSimulacionInicial() {
    final simulacion = widget.simulacionInicial;
    if (simulacion == null || widget.prestamo != null) return;

    montoController.text = simulacion.monto.toStringAsFixed(2);
    interesController.text = simulacion.interesPercent.toStringAsFixed(2);
    cuotasController.text = simulacion.numeroCuotas.toString();
    tipoSeleccionado = switch (simulacion.tipo) {
      TipoPrestamoCalculadora.gotaAGota => 1,
      TipoPrestamoCalculadora.interesMensual => 2,
      TipoPrestamoCalculadora.frances => 3,
      TipoPrestamoCalculadora.universal => 4,
    };
    _actualizarFechasAutomaticas();
  }

  void _actualizarVistaPrevia() {
    if (loading) return;
    _actualizarFechasAutomaticas();

    final monto = double.tryParse(montoController.text.trim());
    final interes = double.tryParse(interesController.text.trim());
    final plazo = int.tryParse(cuotasController.text.trim());

    if (monto == null ||
        interes == null ||
        plazo == null ||
        monto <= 0 ||
        interes < 0 ||
        interes > 20 ||
        plazo <= 0 ||
        tipoSeleccionado == null) {
      if (simulacion != null && mounted) {
        setState(() {
          simulacion = null;
        });
      }
      return;
    }

    final nuevaSimulacion = widget.controller.simularPrestamo(
      monto: monto,
      interesPercent: interes,
      plazo: plazo,
      idTipoPrestamo: tipoSeleccionado!,
    );

    if (!mounted) {
      simulacion = nuevaSimulacion;
      return;
    }

    setState(() {
      simulacion = nuevaSimulacion;
    });
  }

  Future<void> guardarPrestamo() async {
    if (!formKey.currentState!.validate()) {
      AppSnackbarError.show(context, 'Revise los datos del prestamo.');
      return;
    }
    estadoSeleccionado ??= _idEstadoPorNombre('ACTIVO');
    if (estadoSeleccionado == null) {
      AppSnackbarError.show(context, 'No existe el estado ACTIVO.');
      return;
    }

    setState(() {
      saving = true;
    });

    final garantiaError = _validarGarantiaAntesDeGuardar();
    if (garantiaError != null) {
      setState(() {
        saving = false;
      });
      AppSnackbarError.show(context, garantiaError);
      return;
    }

    final prestamo = PrestamoModel(
      idPrestamo: widget.prestamo?['id_prestamo'],
      idCliente: clienteSeleccionado!,
      idTipo: tipoSeleccionado!,
      idEstado: estadoSeleccionado!,
      esRefinanciamiento: esRefinanciamiento,
      monto: double.parse(AppValidators.sanitizeNumeric(montoController.text)),
      interes: double.parse(
        AppValidators.sanitizeNumeric(interesController.text),
      ),
      fechaInicio: widget.prestamo?['fecha_inicio']?.toString() ?? '',
      fechaFin: widget.prestamo?['fecha_fin']?.toString(),
    );

    try {
      if (isEditing) {
        await widget.controller.actualizarPrestamo(prestamo);
      } else {
        await widget.controller.insertarPrestamo(
          prestamo,
          garantes: garantes,
          articulos: articulos,
          plazo: int.parse(cuotasController.text.trim()),
        );
      }

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      AppSnackbarError.show(context, e);
    } finally {
      if (mounted) {
        setState(() {
          saving = false;
        });
      }
    }
  }

  String? requerido(String? value) {
    return AppValidators.required(value);
  }

  String? numeroRequerido(String? value) {
    return AppValidators.decimal(value);
  }

  // ======================================
  // REGLA DE NEGOCIO
  // El interés permitido debe estar
  // entre 0% y 20%.
  // ======================================
  String? validarInteres(String? value) {
    final decimalError = AppValidators.decimal(value);
    if (decimalError != null) return decimalError;

    final interes = double.tryParse(AppValidators.sanitizeNumeric(value ?? ''));
    if (interes == null) return 'Ingrese un interes valido.';
    if (interes < 0) return 'El interés no puede ser negativo.';
    if (interes > 20) return 'El interés máximo permitido es 20%.';
    return null;
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final ci = cliente['ci_persona'] ?? '';
    final nombreCompleto = '$nombres $paterno'.trim();

    return nombreCompleto.isEmpty ? ci : '$nombreCompleto - $ci';
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  void _actualizarFechasAutomaticas() {
    final inicio = widget.controller.fechaInicioAutomatica();
    fechaInicioController.text = _formatDate(inicio);

    final plazo = int.tryParse(cuotasController.text.trim());
    if (tipoSeleccionado == null || plazo == null || plazo <= 0) {
      fechaFinController.text = '';
      return;
    }

    final fin = widget.controller.calcularFechaFinAutomatica(
      idTipoPrestamo: tipoSeleccionado!,
      plazo: plazo,
      fechaInicio: inicio,
    );
    fechaFinController.text = _formatDate(fin);
  }

  int? _validSelectedId(
    List<Map<String, dynamic>> items,
    String key,
    int? selected,
  ) {
    if (selected == null) return null;

    final exists = items.any((item) => item[key] == selected);
    return exists ? selected : null;
  }

  int? _idEstadoPorNombre(String nombre) {
    final buscado = nombre.trim().toUpperCase();
    for (final estado in estados) {
      if (estado['nombre']?.toString().trim().toUpperCase() == buscado) {
        return estado['id_estado'];
      }
    }
    return null;
  }

  String _nombreEstadoActual() {
    final id = estadoSeleccionado ?? _idEstadoPorNombre('ACTIVO');
    final estado = estados.cast<Map<String, dynamic>?>().firstWhere(
      (item) => item?['id_estado'] == id,
      orElse: () => null,
    );
    return estado?['nombre']?.toString().toUpperCase() ?? 'ACTIVO';
  }

  Future<void> agregarGarante() async {
    final idGarante = garanteClienteSeleccionado;
    if (idGarante == null) return;

    try {
      final result = widget.controller.validarYGarantiaDesdeCliente(
        clientes: clientes,
        idClientePrestamo: clienteSeleccionado,
        idGarante: idGarante,
        garantesActuales: garantes,
      );

      setState(() {
        garantiaModo = 'GARANTES';
        garantes.add(result);
        garanteClienteSeleccionado = null;
        articulos.clear();
      });
    } catch (e) {
      AppSnackbarError.show(context, e);
    }
  }

  Future<void> agregarArticulo() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return const _ArticuloDialog();
      },
    );

    if (result == null) return;

    setState(() {
      garantiaModo = 'ARTICULOS';
      articulos.add(result);
      garantes.clear();
    });
  }

  String? _validarGarantiaAntesDeGuardar() {
    if (garantiaModo == 'GARANTES') {
      if (garantes.isEmpty) return 'Agregue al menos un garante.';
      if (garantes.length > 2) return 'Solo se permiten maximo 2 garantes.';
    }
    if (garantiaModo == 'ARTICULOS') {
      if (articulos.isEmpty) return 'Agregue al menos un articulo en garantia.';
      for (final articulo in articulos) {
        final descripcion = articulo['descripcion']?.toString().trim() ?? '';
        final valor =
            double.tryParse(articulo['valor_estimado']?.toString() ?? '') ?? 0;
        if (descripcion.isEmpty || valor <= 0) {
          return 'Cada articulo debe tener descripcion y valor estimado mayor a cero.';
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEditing ? 'Editar Prestamo' : 'Nuevo Prestamo'),
      content: SizedBox(
        width: 760,
        child: AppLoadingOverlay(
          loading: saving,
          message: 'Guardando prestamo...',
          child: loading
              ? const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: () => setState(() {}),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (catalogosError != null) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xfffff7ed),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xfffed7aa),
                              ),
                            ),
                            child: Text(
                              catalogosError!,
                              style: const TextStyle(color: Color(0xff9a3412)),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                        DropdownButtonFormField<int>(
                          // ignore: deprecated_member_use
                          value: _validSelectedId(
                            clientes,
                            'id_cliente',
                            clienteSeleccionado,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Cliente',
                          ),
                          items: clientes.map((cliente) {
                            return DropdownMenuItem<int>(
                              value: cliente['id_cliente'],
                              child: Text(_nombreCliente(cliente)),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'Seleccione un cliente' : null,
                          onChanged: (value) {
                            setState(() {
                              clienteSeleccionado = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<int>(
                          // ignore: deprecated_member_use
                          value: _validSelectedId(
                            tipos,
                            'id_tipo',
                            tipoSeleccionado,
                          ),
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Tipo de prestamo',
                          ),
                          items: tipos.map((tipo) {
                            return DropdownMenuItem<int>(
                              value: tipo['id_tipo'],
                              child: Text(tipo['nombre'] ?? ''),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'Seleccione un tipo' : null,
                          onChanged: (value) {
                            setState(() {
                              tipoSeleccionado = value;
                            });
                            _actualizarVistaPrevia();
                          },
                        ),
                        const SizedBox(height: 20),
                        _EstadoPrestamoBadge(estado: _nombreEstadoActual()),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: montoController,
                          validator: numeroRequerido,
                          inputFormatters: AppValidators.decimalOnly,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(labelText: 'Monto'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: interesController,
                          validator: validarInteres,
                          inputFormatters: AppValidators.decimalOnly,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Interes',
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: cuotasController,
                          validator: AppValidators.integer,
                          inputFormatters: AppValidators.integerOnly,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Plazo'),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: fechaInicioController,
                          validator: requerido,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Fecha inicio',
                            suffixIcon: Icon(Icons.lock_clock),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: fechaFinController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Fecha fin',
                            suffixIcon: Icon(Icons.event_available),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          value: esRefinanciamiento,
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Refinanciamiento'),
                          onChanged: (value) {
                            setState(() {
                              esRefinanciamiento = value;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        PrestamoPlanPreview(simulacion: simulacion),
                        const SizedBox(height: 12),
                        _GarantiaSection(
                          modo: garantiaModo,
                          clientes: clientes,
                          idClientePrestamo: clienteSeleccionado,
                          garanteClienteSeleccionado:
                              garanteClienteSeleccionado,
                          garantes: garantes,
                          articulos: articulos,
                          onModoChanged: isEditing
                              ? null
                              : (value) {
                                  if (value == null) return;
                                  setState(() {
                                    garantiaModo = value;
                                    if (value == 'GARANTES') {
                                      articulos.clear();
                                    } else if (value == 'ARTICULOS') {
                                      garantes.clear();
                                    }
                                  });
                                },
                          onAddGarante: isEditing ? null : agregarGarante,
                          onGaranteChanged: isEditing
                              ? null
                              : (value) {
                                  setState(() {
                                    garanteClienteSeleccionado = value;
                                  });
                                },
                          onAddArticulo: isEditing ? null : agregarArticulo,
                          onRemoveGarante: (index) {
                            setState(() {
                              garantes.removeAt(index);
                            });
                          },
                          onRemoveArticulo: (index) {
                            setState(() {
                              articulos.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: saving
              ? null
              : () {
                  Navigator.pop(context);
                },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: saving || loading || !puedeGuardar
              ? null
              : guardarPrestamo,
          child: Text(saving ? 'Guardando...' : 'Guardar'),
        ),
      ],
    );
  }
}

class _EstadoPrestamoBadge extends StatelessWidget {
  final String estado;

  const _EstadoPrestamoBadge({required this.estado});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffe8f5ec),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xffbbf7d0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_outlined, color: Color(0xff14532d)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Estado actual: $estado',
              style: const TextStyle(
                color: Color(0xff14532d),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Text('Automatico', style: TextStyle(color: Color(0xff64748b))),
        ],
      ),
    );
  }
}

class _GarantiaSection extends StatelessWidget {
  final String modo;
  final List<Map<String, dynamic>> clientes;
  final int? idClientePrestamo;
  final int? garanteClienteSeleccionado;
  final List<Map<String, dynamic>> garantes;
  final List<Map<String, dynamic>> articulos;
  final ValueChanged<String?>? onModoChanged;
  final VoidCallback? onAddGarante;
  final ValueChanged<int?>? onGaranteChanged;
  final VoidCallback? onAddArticulo;
  final ValueChanged<int> onRemoveGarante;
  final ValueChanged<int> onRemoveArticulo;

  const _GarantiaSection({
    required this.modo,
    required this.clientes,
    required this.idClientePrestamo,
    required this.garanteClienteSeleccionado,
    required this.garantes,
    required this.articulos,
    required this.onModoChanged,
    required this.onAddGarante,
    required this.onGaranteChanged,
    required this.onAddArticulo,
    required this.onRemoveGarante,
    required this.onRemoveArticulo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe5e7eb)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Garantia', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            // ignore: deprecated_member_use
            value: modo,
            decoration: const InputDecoration(labelText: 'Tipo de garantia'),
            items: const [
              DropdownMenuItem(value: 'NINGUNA', child: Text('Sin garantia')),
              DropdownMenuItem(value: 'GARANTES', child: Text('Garantes')),
              DropdownMenuItem(value: 'ARTICULOS', child: Text('Articulos')),
            ],
            onChanged: onModoChanged,
          ),
          if (modo == 'GARANTES') ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              initialValue: garanteClienteSeleccionado,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Seleccionar cliente garante',
              ),
              items: clientes
                  .where(
                    (cliente) => cliente['id_cliente'] != idClientePrestamo,
                  )
                  .map((cliente) {
                    final persona = cliente['persona'];
                    final nombres = persona?['nombres'] ?? '';
                    final paterno = persona?['apellido_paterno'] ?? '';
                    final ci = cliente['ci_persona'] ?? '';
                    final nombre = '$nombres $paterno'.trim();
                    return DropdownMenuItem<int>(
                      value: cliente['id_cliente'],
                      child: Text(nombre.isEmpty ? 'CI $ci' : '$nombre - $ci'),
                    );
                  })
                  .toList(),
              onChanged: onGaranteChanged,
            ),
            const SizedBox(height: 8),
            ...garantes.asMap().entries.map((entry) {
              final garante = entry.value;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(garante['nombre_completo'] ?? 'Cliente garante'),
                subtitle: Text(
                  'CI ${garante['ci_persona'] ?? ''} - Tel. ${garante['telefono'] ?? ''}',
                ),
                trailing: IconButton(
                  onPressed: () {
                    onRemoveGarante(entry.key);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onAddGarante,
                icon: const Icon(Icons.person_add),
                label: const Text('Agregar garante'),
              ),
            ),
          ],
          if (modo == 'ARTICULOS') ...[
            const SizedBox(height: 12),
            ...articulos.asMap().entries.map((entry) {
              final articulo = entry.value;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(articulo['descripcion'] ?? ''),
                subtitle: Text('Bs ${articulo['valor_estimado']}'),
                trailing: IconButton(
                  onPressed: () {
                    onRemoveArticulo(entry.key);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            }),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onAddArticulo,
                icon: const Icon(Icons.add_box),
                label: const Text('Nuevo articulo'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ArticuloDialog extends StatefulWidget {
  const _ArticuloDialog();

  @override
  State<_ArticuloDialog> createState() => _ArticuloDialogState();
}

class _ArticuloDialogState extends State<_ArticuloDialog> {
  final formKey = GlobalKey<FormState>();
  final valorController = TextEditingController();
  final descripcionController = TextEditingController();
  final fotoController = TextEditingController();
  final urlController = TextEditingController();
  final picker = ImagePicker();
  bool get puedeAgregar {
    return AppValidators.decimal(valorController.text) == null &&
        AppValidators.safeTextValidator(
              descripcionController.text,
              required: true,
            ) ==
            null &&
        AppValidators.safeTextValidator(fotoController.text) == null &&
        AppValidators.safeTextValidator(urlController.text) == null;
  }

  @override
  void dispose() {
    valorController.dispose();
    descripcionController.dispose();
    fotoController.dispose();
    urlController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarImagen(ImageSource source) async {
    final file = await picker.pickImage(source: source, imageQuality: 80);
    if (file == null) return;
    setState(() {
      fotoController.text = file.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registro articulo'),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: () => setState(() {}),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: descripcionController,
                  inputFormatters: AppValidators.safeText,
                  validator: (value) =>
                      AppValidators.safeTextValidator(value, required: true),
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(labelText: 'Descripcion'),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: valorController,
                  inputFormatters: AppValidators.decimalOnly,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    return AppValidators.decimal(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Valor estimado',
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: fotoController,
                  readOnly: true,
                  validator: AppValidators.safeTextValidator,
                  decoration: const InputDecoration(
                    labelText: 'Ruta de imagen',
                    suffixIcon: Icon(Icons.image_outlined),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _seleccionarImagen(ImageSource.camera),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: const Text('Camara'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _seleccionarImagen(ImageSource.gallery),
                      icon: const Icon(Icons.upload_file_outlined),
                      label: const Text('Subir imagen'),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: urlController,
                  inputFormatters: AppValidators.safeText,
                  validator: AppValidators.safeTextValidator,
                  decoration: const InputDecoration(
                    labelText: 'URL de referencia opcional',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: puedeAgregar
              ? () {
                  if (!formKey.currentState!.validate()) return;
                  Navigator.pop(context, {
                    'valor_estimado':
                        double.tryParse(
                          AppValidators.sanitizeNumeric(valorController.text),
                        ) ??
                        0,
                    'descripcion': AppValidators.sanitizeText(
                      descripcionController.text,
                    ),
                    'fotografia': AppValidators.sanitizeText(
                      fotoController.text,
                    ),
                    'url_referencia': AppValidators.sanitizeText(
                      urlController.text,
                    ),
                  });
                }
              : null,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
