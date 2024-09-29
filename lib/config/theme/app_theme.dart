import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteOrange,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,

    appBarTheme: const AppBarTheme(
      color: AppColors.whiteOrange,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
    ),

  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.whiteOrange,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
    ),

  );
}