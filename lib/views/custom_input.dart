import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';

class CustomInput extends StatelessWidget {
  final String hint;

  final TextEditingController? controller;

  final bool obscureText;

  const CustomInput({
    super.key,

    required this.hint,

    this.controller,

    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      obscureText: obscureText,
      inputFormatters: AppValidators.safeText,

      decoration: InputDecoration(
        hintText: hint,

        filled: true,

        fillColor: Colors.white,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
