import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/controllers/calculadora_controller.dart';
import 'package:sist_prestamo/models/calculadora_model.dart';

class CalculadoraFormCard extends StatelessWidget {
  final CalculadoraController controller;
  final VoidCallback onGuardar;
  final VoidCallback onConfirmar;

  const CalculadoraFormCard({
    super.key,
    required this.controller,
    required this.onGuardar,
    required this.onConfirmar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xffe2e8f0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Simulacion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<int>(
              // ignore: deprecated_member_use
              value: controller.idCliente,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Cliente',
                prefixIcon: Icon(Icons.person),
              ),
              items: controller.clientes.map((cliente) {
                return DropdownMenuItem<int>(
                  value: cliente['id_cliente'],
                  child: Text(_nombreCliente(cliente)),
                );
              }).toList(),
              onChanged: controller.actualizarCliente,
            ),
            const SizedBox(height: 14),
            TextFormField(
              initialValue: controller.monto.toStringAsFixed(0),
              inputFormatters: AppValidators.decimalOnly,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Monto',
                prefixIcon: Icon(Icons.attach_money),
              ),
              onChanged: controller.actualizarMonto,
            ),
            const SizedBox(height: 14),
            TextFormField(
              initialValue: controller.interes.toStringAsFixed(0),
              inputFormatters: AppValidators.decimalOnly,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Interes (%)',
                prefixIcon: Icon(Icons.percent),
              ),
              onChanged: controller.actualizarInteres,
            ),
            const SizedBox(height: 14),
            TextFormField(
              initialValue: controller.numeroCuotas.toString(),
              inputFormatters: AppValidators.integerOnly,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Numero de cuotas',
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              onChanged: controller.actualizarCuotas,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<TipoPrestamoCalculadora>(
              // ignore: deprecated_member_use
              value: controller.tipo,
              decoration: const InputDecoration(
                labelText: 'Tipo de prestamo',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              items: TipoPrestamoCalculadora.values.map((tipo) {
                return DropdownMenuItem(
                  value: tipo,
                  child: Text(CalculadoraController.labelTipo(tipo)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.actualizarTipo(value);
              },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<FrecuenciaPago>(
              // ignore: deprecated_member_use
              value: controller.frecuencia,
              decoration: const InputDecoration(
                labelText: 'Frecuencia de pago',
                prefixIcon: Icon(Icons.event_repeat),
              ),
              items: FrecuenciaPago.values.map((frecuencia) {
                return DropdownMenuItem(
                  value: frecuencia,
                  child: Text(
                    CalculadoraController.labelFrecuencia(frecuencia),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) controller.actualizarFrecuencia(value);
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              readOnly: true,
              initialValue: _date(controller.fechaInicio),
              decoration: const InputDecoration(
                labelText: 'Fecha inicio',
                prefixIcon: Icon(Icons.lock_clock),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onGuardar,
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar simulacion'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onConfirmar,
                    icon: const Icon(Icons.add_business),
                    label: const Text('Confirmar prestamo'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _date(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String _nombreCliente(Map<String, dynamic> cliente) {
    final persona = cliente['persona'];
    final nombres = persona?['nombres'] ?? '';
    final paterno = persona?['apellido_paterno'] ?? '';
    final ci = cliente['ci_persona'] ?? '';
    final completo = '$nombres $paterno'.trim();
    return completo.isEmpty ? ci : '$completo - $ci';
  }
}
