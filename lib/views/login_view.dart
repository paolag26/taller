import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
