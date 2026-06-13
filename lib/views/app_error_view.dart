import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  final FlutterErrorDetails? details;
  final VoidCallback? onRetry;

  const AppErrorView({super.key, this.details, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xfff6f8fa),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffe2e8f0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xfffff1f2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    color: Color(0xffbe123c),
                    size: 34,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ocurrio un problema',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff0f172a),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'La pantalla no pudo cargarse correctamente. El detalle tecnico fue registrado para revision.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xff64748b)),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  onPressed: onRetry ?? () {},
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
