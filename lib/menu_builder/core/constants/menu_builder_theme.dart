import 'package:flutter/material.dart';

import '../utils/material_color_generator.dart';
import 'menu_builder_app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData menuBuilderTheme(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: getMaterialColor(MenuBuilderColors.kPrimaryColor),
      backgroundColor: MenuBuilderColors.kBackgroundColor,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(textTheme),
  );
}
