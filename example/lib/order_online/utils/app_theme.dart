import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: false,
    colorSchemeSeed: AppColors.primaryColor,
    cardTheme: CardThemeData(
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
    ),
  );
}
