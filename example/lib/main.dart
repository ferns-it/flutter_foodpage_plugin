import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/food_menu_screen.dart';
import 'package:get/get.dart';

import 'order_online/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: appTheme(context),
      debugShowCheckedModeBanner: false,
      home: const FoodMenuScreen(),
    );
  }
}
