import 'package:flutter/material.dart';

class ErrorDialog {
  static void show(BuildContext context, {required String message}) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),

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
