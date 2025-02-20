import 'package:example/order_online/bindings/app_binding.dart';
import 'package:example/order_online/constants/app_routes.dart';
import 'package:example/order_online/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      // key: MenuBuilderGlobalVariable.navState,
      title: 'Flutter Demo',
      theme: appTheme(context),
      debugShowCheckedModeBanner: false,
      // builder: (context, child) => MediaQuery(
      //   data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      //   child: child!,
      // ),
      getPages: appRoutes,

      initialBinding: AppBinding(),
      initialRoute: RouteNames.kLogin,
      // home: FlutterFoodpageMenuBuilder(
      //   config: MenuBuilderConfig(
      //     authenticationKey: "949221b4ca632538eff4a088de002fc1",
      //     mode: DevelopmentMode.development,
      //     geminiAPIKey: "<gemini-api-key>",
      //     applicationName: "EPOS",
      //   ),
      // ),
    );
  }
}
