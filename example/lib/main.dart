import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/global/global_variable.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/menu_builder_config.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/core/dependency_register_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/flutter_foodpage_menu_builder.dart';
import 'package:get/get.dart';

import 'order_online/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DependencyRegisterWidget(
      child: GetMaterialApp(
        key: MenuBuilderGlobalVariable.navState,
        title: 'Flutter Demo',
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        ),
        home: FlutterFoodpageMenuBuilder(
          config: MenuBuilderConfig(
            authenticationKey: "949221b4ca632538eff4a088de002fc1",
            mode: DevelopmentMode.development,
            geminiAPIKey: "<gemini-api-key>",
            applicationName: "EPOS",
          ),
        ),
      ),
    );
  }
}
