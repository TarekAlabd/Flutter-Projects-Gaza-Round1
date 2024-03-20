import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/views/pages/login_page.dart';
import 'package:chat_app/features/chat/manager/cubit/chat_cubit.dart';
import 'package:chat_app/features/chat/views/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case AppRoutes.chat:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChatCubit();
              cubit.getMessages();
              return cubit;
            },
            child: const ChatPage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No route defined here!'),
                  ),
                ));
    }
  }
}
