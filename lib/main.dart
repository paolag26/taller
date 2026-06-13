// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/app_constants.dart';
import 'package:sist_prestamo/controllers/database_config.dart';
import 'package:sist_prestamo/views/app_theme.dart';
import 'package:sist_prestamo/provider/app_providers.dart';
import 'package:sist_prestamo/views/login_view.dart';
import 'package:sist_prestamo/views/app_error_view.dart';

import 'package:sist_prestamo/controllers/app_routes.dart';

void main() {
  print('INICIANDO MAIN');
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        print('FLUTTER ERROR: ${details.exception}');
        print(details.stack);
      };
      ErrorWidget.builder = (details) {
        print('ERROR WIDGET: ${details.exceptionAsString()}');
        print('ERROR WIDGET STACKTRACE: ${details.stack}');
        return AppErrorView(details: details);
      };
      runApp(const MyApp());
      print('RUNAPP OK');
    },
    (error, stack) {
      print('ERROR GLOBAL: $error');
      print(stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      routes: AppRoutes.routes,
      home: const AppBootstrap(),
    );
  }
}

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  late Future<void> _startup;

  @override
  void initState() {
    super.initState();
    _startup = _initialize();
  }

  Future<void> _initialize() async {
    print('APP INICIADA CORRECTAMENTE');
    await DatabaseConfig.initialize().timeout(const Duration(seconds: 15));
    print('DATABASE OK');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _startup,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: Text('APP INICIADA CORRECTAMENTE')),
          );
        }

        if (snapshot.hasError) {
          print('DATABASE ERROR: ${snapshot.error}');
          print(snapshot.stackTrace);
          return _StartupErrorView(
            error: snapshot.error,
            stackTrace: snapshot.stackTrace,
            onRetry: () {
              setState(() {
                _startup = _initialize();
              });
            },
          );
        }

        print('PROVIDERS OK');
        return const AppProviders(child: LoginView());
      },
    );
  }
}

class _StartupErrorView extends StatelessWidget {
  const _StartupErrorView({
    required this.error,
    required this.stackTrace,
    required this.onRetry,
  });

  final Object? error;
  final StackTrace? stackTrace;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'No se pudo iniciar la base de datos local',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SelectableText(error?.toString() ?? 'Error desconocido'),
                if (stackTrace != null) ...[
                  const SizedBox(height: 12),
                  SelectableText(stackTrace.toString(), maxLines: 12),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
