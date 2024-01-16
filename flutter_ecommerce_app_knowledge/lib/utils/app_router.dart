import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app_knowledge/models/product_item_model.dart';
import 'package:flutter_ecommerce_app_knowledge/utils/app_routes.dart';
import 'package:flutter_ecommerce_app_knowledge/view_models/payment_cubit/payment_cubit.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/add_payment_card.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/custom_bottom_navbar.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/login_page.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/my_orders_page.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/payment_page.dart';
import 'package:flutter_ecommerce_app_knowledge/views/pages/product_details_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.productDetails:
        final ProductItemModel productDetailsArguments =
            settings.arguments as ProductItemModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(
            productItem: productDetailsArguments,
          ),
          settings: settings,
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );
      case AppRoutes.myOrders:
        return MaterialPageRoute(
          builder: (_) => const MyOrdersPage(),
          settings: settings,
        );
      case AppRoutes.addPaymentCard:
        return MaterialPageRoute(
          builder: (_) => const AddPaymentCard(),
          settings: settings,
        );
      case AppRoutes.payment:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = PaymentCubit();
              cubit.getPaymentViewData();
              return cubit;
            },
            child: const PaymentPage(),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Error Page!'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
