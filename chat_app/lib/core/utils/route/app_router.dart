import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/views/pages/login_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold(
          body: Center(
            child: Text('No route defined here!'),
          ),
        ));
    }
  }
}