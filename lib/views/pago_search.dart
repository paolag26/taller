import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';

class PagoSearch extends StatelessWidget {
  const PagoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: AppValidators.safeText,

      decoration: InputDecoration(
        hintText: 'Buscar pago',

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
