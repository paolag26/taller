import 'package:flutter/material.dart';

import 'package:sist_prestamo/controllers/app_validators.dart';
import 'package:sist_prestamo/views/main_layout.dart';

import 'package:sist_prestamo/provider/auth_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final controller = AuthProvider().controller;

  Future<void> login() async {
    final success = await controller.login(
      email: AppValidators.sanitizeText(emailController.text),

      password: passwordController.text.trim(),
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (_) => const MainLayout()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,

      builder: (context, child) {
        return Container(
          width: 400,

          padding: const EdgeInsets.all(30),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),

                blurRadius: 10,
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const Icon(
                Icons.account_balance_wallet,

                size: 80,

                color: Color(0xff14532d),
              ),

              const SizedBox(height: 20),

              const Text(
                'Cuentas Claras',

                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                inputFormatters: AppValidators.safeText,
                keyboardType: TextInputType.emailAddress,

                decoration: const InputDecoration(labelText: 'Correo'),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,

                obscureText: true,

                decoration: const InputDecoration(labelText: 'Contraseña'),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: controller.loading ? null : login,

                child: controller.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Iniciar sesión'),
              ),
            ],
          ),
        );
      },
    );
  }
}
