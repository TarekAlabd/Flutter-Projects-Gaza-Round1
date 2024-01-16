import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/firebase_options.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_colors.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_router.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_routes.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/auth_cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.getUser();
        return cubit;
      },
      child: Builder(builder: (context) {
        return BlocBuilder<AuthCubit, AuthState>(
          bloc: BlocProvider.of<AuthCubit>(context),
          buildWhen: (previous, current) => current is AuthSuccess,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter E-commerce App',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                inputDecorationTheme: InputDecorationTheme(
                  fillColor: AppColors.grey1,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.grey2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.grey2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.grey2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: AppColors.grey2,
                    ),
                  ),
                ),
                useMaterial3: true,
              ),
              initialRoute:
                  state is AuthSuccess ? AppRoutes.home : AppRoutes.login,
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        );
      }),
    );
  }
}
