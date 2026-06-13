import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_formatters.dart';

class AppSnackbarSuccess {
  const AppSnackbarSuccess._();

  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xff166534),
      ),
    );
  }
}

class AppSnackbarError {
  const AppSnackbarError._();

  static void show(BuildContext context, Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppFormatters.friendlyError(error)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffb91c1c),
      ),
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  final bool loading;
  final Widget child;
  final String message;

  const AppLoadingOverlay({
    super.key,
    required this.loading,
    required this.child,
    this.message = 'Procesando...',
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Positioned.fill(
            child: AbsorbPointer(
              child: Container(
                color: Colors.black.withValues(alpha: 0.08),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          message,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
