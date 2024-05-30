import 'package:flutter/material.dart';

import '../utils/material_color_generator.dart';
import 'menu_builder_app_colors.dart';

ThemeData menuBuilderTheme(BuildContext context) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: getMaterialColor(MenuBuilderColors.kPrimaryColor),
      backgroundColor: MenuBuilderColors.kBackgroundColor,
    ),
  );
}
