import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/app_feedback.dart';
import 'package:sist_prestamo/controllers/pago_controller.dart';

class PagoFormDialog extends StatefulWidget {
  final PagoController controller;
  final int? cuotaInicialId;

  const PagoFormDialog({
    super.key,
    required this.controller,
    this.cuotaInicialId,
  });

  @override
  State<PagoFormDialog> createState() => _PagoFormDialogState();
}

class _PagoFormDialogState extends State<PagoFormDialog> {
  final formKey = GlobalKey<FormState>();
  final montoController = TextEditingController();
  final fechaController = TextEditingController();
  final observacionController = TextEditingController();

  List<Map<String, dynamic>> clientes = [];
  Map<String, dynamic>? clienteSeleccionado;
  Map<String, dynamic>? prestamoSeleccionado;
  final selectedCuotaIds = <int>{};

  String tipoPago = 'CUOTAS';
  String metodoPago = 'EFECTIVO';
  bool loading = true;
  bool saving = false;
  String? loadError;
  bool get puedeGuardar {
    if (clienteSeleccionado == null || prestamoSeleccionado == null) {
      return false;
    }
    if (AppValidators.decimal(montoController.text) != null) return false;
    if (AppValidators.safeTextValidator(observacionController.text) != null) {
      return false;
    }
    if (tipoPago != 'AMORTIZACION' && _cuotasSeleccionadas().isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    fechaController.text = _formatDate(DateTime.now());
    cargarDatos();
  }

  @override
  void dispose() {
    montoController.dispose();
    fechaController.dispose();
    observacionController.dispose();
    super.dispose();
  }

  Future<void> cargarDatos() async {
    try {
      final response = await widget.controller.listarClientesConCuotas();

      if (!mounted) return;

      Map<String, dynamic>? clienteInicial;

      if (widget.cuotaInicialId != null) {
        for (final cliente in response) {
          final cuotas = _cuotasCliente(cliente);
          final existe = cuotas.any(
            (cuota) => cuota['id_cuota'] == widget.cuotaInicialId,
          );
          if (existe) {
            clienteInicial = cliente;
            selectedCuotaIds.add(widget.cuotaInicialId!);
            break;
          }
        }
      }

      setState(() {
        clientes = response;
        clienteSeleccionado = clienteInicial;
        prestamoSeleccionado = _prestamosCliente(clienteInicial).isEmpty
            ? null
            : _prestamosCliente(clienteInicial).first;
        loadError = null;
        _actualizarMontoSeleccionado();
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        loadError = 'No se pudieron cargar clientes para pagos: $e';
        loading = false;
      });
    }
  }

  Future<void> guardarPago() async {
    if (!formKey.currentState!.validate()) return;

    if (clienteSeleccionado == null) {
      _snack('Seleccione un cliente');
      return;
    }

    final monto = _toDouble(montoController.text);
    if (monto <= 0) {
      _snack('Ingrese un monto valido');
      return;
    }

    final cuotas = _cuotasSeleccionadas();
    if (tipoPago != 'AMORTIZACION' && cuotas.isEmpty) {
      _snack('Seleccione al menos una cuota');
      return;
    }

    setState(() {
      saving = true;
    });

    try {
      if (tipoPago == 'AMORTIZACION') {
        final idPrestamo = _primerPrestamoId();
        if (idPrestamo == null) {
          throw Exception('El cliente no tiene prestamos pendientes');
        }

        await widget.controller.registrarAmortizacion(
          idPrestamo: idPrestamo,
          monto: monto,
          fecha: fechaController.text,
          metodoPago: metodoPago,
          observacion: AppValidators.sanitizeText(observacionController.text),
        );
      } else {
        await widget.controller.registrarPagosCuotas(
          cuotas: cuotas,
          montoTotal: monto,
          fecha: fechaController.text,
          metodoPago: metodoPago,
          observacion: AppValidators.sanitizeText(observacionController.text),
          tipoPago: _tipoPagoParaCuotas(cuotas),
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

  void _seleccionarTipoPago(String value) {
    setState(() {
      tipoPago = value;
      selectedCuotaIds.clear();
      if (value == 'ADELANTADA') {
        final cuotas = _cuotasPrestamoSeleccionado();
        for (final cuota in cuotas.take(2)) {
          selectedCuotaIds.add(cuota['id_cuota']);
        }
      }
      _actualizarMontoSeleccionado();
    });
  }

  void _actualizarMontoSeleccionado() {
    if (tipoPago == 'AMORTIZACION') {
      return;
    }

    final total = widget.controller.totalCuotas(_cuotasSeleccionadas());

    montoController.text = total > 0 ? total.toStringAsFixed(2) : '';
  }

  List<Map<String, dynamic>> _cuotasCliente(Map<String, dynamic>? cliente) {
    return widget.controller.cuotasCliente(cliente);
  }

  List<Map<String, dynamic>> _prestamosCliente(Map<String, dynamic>? cliente) {
    return widget.controller.prestamosCliente(cliente);
  }

  List<Map<String, dynamic>> _cuotasPrestamoSeleccionado() {
    return widget.controller.cuotasPrestamo(
      clienteSeleccionado,
      prestamoSeleccionado,
    );
  }

  List<Map<String, dynamic>> _todasCuotasPrestamoSeleccionado() {
    return widget.controller.cuotasPrestamoTodas(
      clienteSeleccionado,
      prestamoSeleccionado,
    );
  }

  List<Map<String, dynamic>> _cuotasSeleccionadas() {
    return widget.controller.cuotasSeleccionadas(
      cliente: clienteSeleccionado,
      prestamo: prestamoSeleccionado,
      selectedCuotaIds: selectedCuotaIds,
    );
  }

  int? _primerPrestamoId() {
    return prestamoSeleccionado?['id_prestamo'];
  }

  String _tipoPagoParaCuotas(List<Map<String, dynamic>> cuotas) {
    return widget.controller.tipoPagoParaCuotas(cuotas, tipoPago);
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final ci = cliente['ci_persona'] ?? '';
    final nombreCompleto = '$nombres $paterno'.trim();

    return nombreCompleto.isEmpty ? ci : '$nombreCompleto - $ci';
  }

  String _nombrePrestamo(Map<String, dynamic> prestamo) {
    final id = prestamo['id_prestamo'] ?? '';
    final tipo = prestamo['tipo_prestamo']?['nombre'] ?? 'Sin tipo';
    final estado = prestamo['estado_prestamo']?['nombre'] ?? 'ACTIVO';
    final saldo = _toDouble(prestamo['saldo_pendiente_calculado']);
    return '#$id - $tipo - $estado - Bs ${saldo.toStringAsFixed(2)}';
  }

  String _labelCuota(Map<String, dynamic> cuota) {
    final numero = cuota['numero_cuota'];
    final fecha = cuota['fecha_vencimiento'] ?? '';

    return 'Cuota $numero - $fecha';
  }

  double _toDouble(dynamic value) {
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  double _saldoCuota(Map<String, dynamic> cuota) {
    return widget.controller.saldoCuota(cuota);
  }

  bool _tieneCuotasRegistradas() {
    return _todasCuotasPrestamoSeleccionado().isNotEmpty;
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  void _snack(String message) {
    AppSnackbarError.show(context, message);
  }

  @override
  Widget build(BuildContext context) {
    final prestamos = _prestamosCliente(clienteSeleccionado);
    final cuotas = _cuotasPrestamoSeleccionado();
    final todasCuotas = _todasCuotasPrestamoSeleccionado();

    return AlertDialog(
      title: const Text('Registro de Pago'),
      content: SizedBox(
        width: 640,
        child: AppLoadingOverlay(
          loading: saving,
          message: 'Registrando pago...',
          child: loading
              ? const Padding(
                  padding: EdgeInsets.all(30),
                  child: Center(child: CircularProgressIndicator()),
                )
              : Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: () => setState(() {}),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (loadError != null) ...[
                          _InfoPago(text: loadError!),
                          const SizedBox(height: 12),
                        ],
                        if (clientes.isEmpty) ...[
                          const _InfoPago(
                            text:
                                'No hay clientes activos cargados. Registre o active un cliente antes de registrar pagos.',
                          ),
                          const SizedBox(height: 12),
                        ],
                        DropdownButtonFormField<int>(
                          initialValue: clienteSeleccionado?['id_cliente'],
                          isExpanded: true,
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
                              clienteSeleccionado = clientes.firstWhere(
                                (cliente) => cliente['id_cliente'] == value,
                              );
                              final prestamos = _prestamosCliente(
                                clienteSeleccionado,
                              );
                              prestamoSeleccionado = prestamos.isEmpty
                                  ? null
                                  : prestamos.first;
                              selectedCuotaIds.clear();
                              montoController.clear();
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        DropdownButtonFormField<int>(
                          initialValue: prestamoSeleccionado?['id_prestamo'],
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Prestamo activo',
                          ),
                          items: prestamos.map((prestamo) {
                            return DropdownMenuItem<int>(
                              value: prestamo['id_prestamo'],
                              child: Text(_nombrePrestamo(prestamo)),
                            );
                          }).toList(),
                          validator: (value) =>
                              value == null ? 'Seleccione un prestamo' : null,
                          onChanged: (value) {
                            setState(() {
                              prestamoSeleccionado = prestamos.firstWhere(
                                (prestamo) => prestamo['id_prestamo'] == value,
                              );
                              selectedCuotaIds.clear();
                              montoController.clear();
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        if (prestamoSeleccionado != null)
                          _PrestamoResumen(
                            prestamo: prestamoSeleccionado!,
                            cuotas: todasCuotas,
                            saldoBuilder: _saldoCuota,
                          ),
                        const SizedBox(height: 18),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'CUOTAS',
                              label: Text('Cuotas'),
                            ),
                            ButtonSegment(
                              value: 'ADELANTADA',
                              label: Text('Cuota adelantada'),
                            ),
                            ButtonSegment(
                              value: 'AMORTIZACION',
                              label: Text('Amortizacion'),
                            ),
                          ],
                          selected: {tipoPago},
                          onSelectionChanged: (value) {
                            _seleccionarTipoPago(value.first);
                          },
                        ),
                        const SizedBox(height: 18),
                        if (tipoPago != 'AMORTIZACION')
                          _CuotasSelector(
                            cuotas: cuotas,
                            tieneCuotasRegistradas: _tieneCuotasRegistradas(),
                            selectedCuotaIds: selectedCuotaIds,
                            singleSelection: false,
                            labelBuilder: _labelCuota,
                            saldoBuilder: (cuota) => _saldoCuota(cuota),
                            onChanged: () {
                              setState(_actualizarMontoSeleccionado);
                            },
                          ),
                        if (tipoPago == 'AMORTIZACION')
                          const _InfoPago(
                            text:
                                'La amortizacion aplica el monto ingresado a las cuotas pendientes del prestamo, empezando por las mas proximas.',
                          ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: montoController,
                          readOnly: tipoPago != 'AMORTIZACION',
                          validator: (value) {
                            return AppValidators.decimal(value);
                          },
                          inputFormatters: AppValidators.decimalOnly,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(labelText: 'Monto'),
                        ),
                        const SizedBox(height: 18),
                        DropdownButtonFormField<String>(
                          initialValue: metodoPago,
                          decoration: const InputDecoration(
                            labelText: 'Modalidad de pago',
                          ),
                          items: const [
                            DropdownMenuItem(value: 'QR', child: Text('QR')),
                            DropdownMenuItem(
                              value: 'TRANSFERENCIA',
                              child: Text('Transferencia'),
                            ),
                            DropdownMenuItem(
                              value: 'EFECTIVO',
                              child: Text('Efectivo'),
                            ),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              metodoPago = value;
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: fechaController,
                          readOnly: true,
                          decoration: const InputDecoration(labelText: 'Fecha'),
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: observacionController,
                          inputFormatters: AppValidators.safeText,
                          validator: AppValidators.safeTextValidator,
                          minLines: 2,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Observacion',
                          ),
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
          onPressed: saving || loading || !puedeGuardar ? null : guardarPago,
          child: Text(saving ? 'Guardando...' : 'Guardar'),
        ),
      ],
    );
  }
}

class _CuotasSelector extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;
  final bool tieneCuotasRegistradas;
  final Set<int> selectedCuotaIds;
  final bool singleSelection;
  final String Function(Map<String, dynamic> cuota) labelBuilder;
  final double Function(Map<String, dynamic> cuota) saldoBuilder;
  final VoidCallback onChanged;

  const _CuotasSelector({
    required this.cuotas,
    required this.tieneCuotasRegistradas,
    required this.selectedCuotaIds,
    required this.singleSelection,
    required this.labelBuilder,
    required this.saldoBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (cuotas.isEmpty) {
      return _InfoPago(
        text: tieneCuotasRegistradas
            ? 'El prestamo no tiene cuotas pendientes de pago.'
            : 'El prestamo seleccionado no tiene cuotas registradas.',
      );
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 210),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffd1d5db)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: cuotas.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final cuota = cuotas[index];
          final idCuota = cuota['id_cuota'];
          final selected = selectedCuotaIds.contains(idCuota);
          final puedeSeleccionar = _puedeSeleccionar(index);

          return CheckboxListTile(
            value: selected,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(labelBuilder(cuota)),
            subtitle: Text(
              puedeSeleccionar
                  ? 'Bs ${saldoBuilder(cuota).toStringAsFixed(2)}'
                  : 'Debe pagar primero las cuotas mas antiguas',
            ),
            onChanged: puedeSeleccionar
                ? (value) {
                    if (singleSelection) {
                      selectedCuotaIds
                        ..clear()
                        ..add(idCuota);
                    } else if (value == true) {
                      selectedCuotaIds.add(idCuota);
                    } else {
                      selectedCuotaIds.remove(idCuota);
                    }
                    onChanged();
                  }
                : null,
          );
        },
      ),
    );
  }

  bool _puedeSeleccionar(int index) {
    if (index == 0) return true;
    for (var i = 0; i < index; i++) {
      if (!selectedCuotaIds.contains(cuotas[i]['id_cuota'])) {
        return false;
      }
    }
    return true;
  }
}

class _PrestamoResumen extends StatelessWidget {
  final Map<String, dynamic> prestamo;
  final List<Map<String, dynamic>> cuotas;
  final double Function(Map<String, dynamic> cuota) saldoBuilder;

  const _PrestamoResumen({
    required this.prestamo,
    required this.cuotas,
    required this.saldoBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final cuotasPagadas = cuotas.where(_pagada).length;
    final cuotasMora = cuotas.where(_mora).length;
    final cuotasPendientes = cuotas.length - cuotasPagadas - cuotasMora;
    final saldo = cuotas
        .where((cuota) => !_pagada(cuota))
        .fold<double>(0, (total, cuota) => total + saldoBuilder(cuota));
    final tipo = prestamo['tipo_prestamo']?['nombre'] ?? 'Sin tipo';
    final estado = prestamo['estado_prestamo']?['nombre'] ?? 'ACTIVO';
    final monto = double.tryParse(prestamo['monto']?.toString() ?? '') ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe5e7eb)),
      ),
      child: Wrap(
        spacing: 18,
        runSpacing: 8,
        children: [
          Text('Tipo: $tipo'),
          Text('Estado: $estado'),
          Text('Monto: Bs ${monto.toStringAsFixed(2)}'),
          Text('Saldo: Bs ${saldo.toStringAsFixed(2)}'),
          Text('Pendientes: $cuotasPendientes'),
          Text('Pagadas: $cuotasPagadas'),
          Text('Mora: $cuotasMora'),
        ],
      ),
    );
  }

  bool _pagada(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    return estado == 'PAGADA' || estado == 'PAGADO' || saldoBuilder(cuota) <= 0;
  }

  bool _mora(Map<String, dynamic> cuota) {
    final estado = cuota['estado']?.toString().toUpperCase() ?? '';
    if (estado == 'MORA') return true;
    if (_pagada(cuota)) return false;
    final fecha = DateTime.tryParse(
      cuota['fecha_vencimiento']?.toString() ?? '',
    );
    if (fecha == null) return false;
    final hoy = DateTime.now();
    return DateTime(
      fecha.year,
      fecha.month,
      fecha.day,
    ).isBefore(DateTime(hoy.year, hoy.month, hoy.day));
  }
}

class _InfoPago extends StatelessWidget {
  final String text;

  const _InfoPago({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xfff8fafc),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffe5e7eb)),
      ),
      child: Text(text),
    );
  }
}
