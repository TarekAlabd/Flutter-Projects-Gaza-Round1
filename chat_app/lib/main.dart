import 'package:chat_app/core/utils/route/app_router.dart';
import 'package:chat_app/core/utils/route/app_routes.dart';
import 'package:chat_app/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  debugPrint('Test Token');
  debugPrint(await messaging.getToken());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message');
  print('Message data: ${message.data}');
  if (message.notification != null) {
    print(
        'Message also contained a notification: ${message.notification!.title}');
    print(
        'Message also contained a notification: ${message.notification!.body}');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.getUser();
        return cubit;
      },
      child: Builder(builder: (context) {
        final authCubit = BlocProvider.of<AuthCubit>(context);

        return BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          buildWhen: (previous, current) => current is AuthSuccess,
          builder: (context, state) {
            return MaterialApp(
              title: 'Chat App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              onGenerateRoute: AppRouter.onGenerateRoute,
              initialRoute:
                  state is AuthSuccess ? AppRoutes.chat : AppRoutes.login,
            );
          },
        );
      }),
    );
  }
}
