import 'package:flutter/material.dart';

class SuccessDialog {
  static void show(BuildContext context, {required String message}) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Éxito'),

          content: Text(message),

          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
