import 'package:flutter/material.dart';

class ClienteFilters extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const ClienteFilters({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,

      decoration: const InputDecoration(
        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(),
      ),

      items: const [
        DropdownMenuItem(value: 'TODOS', child: Text('Todos')),

        DropdownMenuItem(value: 'ACTIVOS', child: Text('Activos')),

        DropdownMenuItem(value: 'INACTIVOS', child: Text('Inactivos')),
      ],

      onChanged: (value) {
        if (value == null) return;
        onChanged(value);
      },
    );
  }
}
