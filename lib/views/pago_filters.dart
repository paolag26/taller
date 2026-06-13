import 'package:flutter/material.dart';

class PagoFilters extends StatefulWidget {
  const PagoFilters({super.key});

  @override
  State<PagoFilters> createState() => _PagoFiltersState();
}

class _PagoFiltersState extends State<PagoFilters> {
  String estado = 'TODOS';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: estado,

      decoration: InputDecoration(
        labelText: 'Estado pago',

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      items: const [
        DropdownMenuItem(value: 'TODOS', child: Text('Todos')),

        DropdownMenuItem(value: 'COMPLETO', child: Text('Completos')),

        DropdownMenuItem(value: 'PARCIAL', child: Text('Parciales')),
      ],

      onChanged: (value) {
        setState(() {
          estado = value!;
        });
      },
    );
  }
}
