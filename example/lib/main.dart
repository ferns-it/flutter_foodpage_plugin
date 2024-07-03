import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/menu_builder_config.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/flutter_foodpage_menu_builder.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/core/dependency_register_widget.dart';
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
        title: 'Flutter Demo',
        theme: appTheme(context),
        debugShowCheckedModeBanner: false,
        home: FlutterFoodpageMenuBuilder(
          config: MenuBuilderConfig(
            authenticationKey: "5521bacd985f98bbcb30c9e0f1a242ae",
            mode: DevelopmentMode.development,
          ),
        ),
      ),
    );
  }
}
