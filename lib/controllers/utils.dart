import 'package:flutter/material.dart';

class Utils {
  // SNACKBAR

  static void snackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // LOADING

  static Future<void> loading(BuildContext context) async {
    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // CLOSE DIALOG

  static void close(BuildContext context) {
    Navigator.pop(context);
  }

  // RESPONSIVE

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}
