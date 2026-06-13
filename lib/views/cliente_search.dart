import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';

class ClienteSearch extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const ClienteSearch({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,

      child: TextField(
        inputFormatters: AppValidators.safeText,
        onChanged: onChanged,

        decoration: InputDecoration(
          hintText: 'Buscar cliente',

          prefixIcon: const Icon(Icons.search),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
