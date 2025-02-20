import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: false,
    colorSchemeSeed: Colors.black,
    appBarTheme: const AppBarTheme(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: Colors.black)),
    cardTheme: CardTheme(
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  );
}
