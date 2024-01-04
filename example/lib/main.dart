import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_online/bindings/app_binding.dart';
import 'order_online/constants/app_routes.dart';
import 'order_online/constants/route_names.dart';
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
      initialBinding: AppBinding(),
      initialRoute: RouteNames.kDashBoard,
      getPages: appRoutes,
    );
  }
}
