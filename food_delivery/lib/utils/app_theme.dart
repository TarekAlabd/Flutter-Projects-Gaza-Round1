import 'package:flutter/material.dart';
import 'package:food_delivery/utils/app_colors.dart';

class AppTheme {
  static ThemeData? appTheme(ThemeData theme) {
    return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
    useMaterial3: true,
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.seedColor,
    ),
    textTheme: theme.textTheme.copyWith(
      labelMedium: theme.textTheme.labelMedium!.copyWith(color: Colors.grey),
    ),
  );
  }
}
