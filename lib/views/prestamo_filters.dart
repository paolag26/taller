import 'package:flutter/material.dart';

class PrestamoFilters extends StatefulWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const PrestamoFilters({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<PrestamoFilters> createState() => _PrestamoFiltersState();
}

class _PrestamoFiltersState extends State<PrestamoFilters> {
  String estado = 'TODOS';

  @override
  void initState() {
    super.initState();
    estado = widget.value;
  }

  @override
  void didUpdateWidget(covariant PrestamoFilters oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      estado = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,

      child: DropdownButtonFormField<String>(
        // ignore: deprecated_member_use
        value: estado,

        decoration: InputDecoration(
          labelText: 'Estado',

          filled: true,

          fillColor: Colors.white,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),

        items: const [
          DropdownMenuItem(value: 'TODOS', child: Text('Todos')),

          DropdownMenuItem(value: 'ACTIVO', child: Text('Activos')),

          DropdownMenuItem(value: 'PAGADO', child: Text('Pagados')),

          DropdownMenuItem(value: 'MORA', child: Text('En mora')),

          DropdownMenuItem(value: 'CANCELADO', child: Text('Cancelados')),
        ],

        onChanged: (value) {
          setState(() {
            estado = value!;
          });
          widget.onChanged(value!);
        },
      ),
    );
  }
}
