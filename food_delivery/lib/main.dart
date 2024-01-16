import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/food_item.dart';
import 'package:food_delivery/pages/custom_bottom_navbar.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:food_delivery/pages/product_details_page.dart';
import 'package:food_delivery/utils/app_colors.dart';
import 'package:food_delivery/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: AppTheme.appTheme(theme),
      routes: {
        '/': (context) => const CustomBottomNavbar(),
        '/product-Details': (context) => ProductDetailsPage(foodItem: food[0]),
      },
    );
  }
}
