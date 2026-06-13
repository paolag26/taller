import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';

class PrestamoSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const PrestamoSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: AppValidators.safeText,
      onChanged: onChanged,

      decoration: InputDecoration(
        hintText: 'Buscar préstamo',

        prefixIcon: const Icon(Icons.search),

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
