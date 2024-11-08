import 'package:flutter/material.dart';
import 'package:task_management/core/res/app_colors.dart';

class Themes {
  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );

  static final light = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white));

  static final dark = ThemeData(
      // colorScheme: defaultDarkColorScheme,
      // scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.darkGray,
      brightness: Brightness.dark,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.white));
}
