import 'package:flutter/material.dart';

import 'package:sist_prestamo/views/login_view.dart';

import 'package:sist_prestamo/views/main_layout.dart';

class AppRoutes {
  static const String login = '/login';

  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginView(),

    dashboard: (context) => const MainLayout(),
  };
}
