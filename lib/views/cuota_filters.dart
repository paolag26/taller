import 'package:flutter/material.dart';

class CuotaFilters extends StatefulWidget {
  const CuotaFilters({super.key});

  @override
  State<CuotaFilters> createState() => _CuotaFiltersState();
}

class _CuotaFiltersState extends State<CuotaFilters> {
  String estado = 'TODOS';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: estado,

      decoration: InputDecoration(
        labelText: 'Estado',

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),

      items: const [
        DropdownMenuItem(value: 'TODOS', child: Text('Todos')),

        DropdownMenuItem(value: 'PENDIENTE', child: Text('Pendientes')),

        DropdownMenuItem(value: 'PAGADO', child: Text('Pagadas')),

        DropdownMenuItem(value: 'MORA', child: Text('En mora')),
      ],

      onChanged: (value) {
        setState(() {
          estado = value!;
        });
      },
    );
  }
}
