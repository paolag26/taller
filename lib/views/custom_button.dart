import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  final IconData? icon;

  const CustomButton({
    super.key,

    required this.text,

    required this.onPressed,

    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,

      child: ElevatedButton.icon(
        onPressed: onPressed,

        icon: icon != null ? Icon(icon) : const SizedBox(),

        label: Text(text),
      ),
    );
  }
}
