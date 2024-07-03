import 'package:flutter/widgets.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/auth/auth_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../dishes/dish_category_controller.dart';

class MenuBuilderDependencyRegistrar {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthController()),
    ChangeNotifierProvider(create: (_) => PageNavigationController()),
    ChangeNotifierProvider(create: (_) => DishesController()),
    ChangeNotifierProvider(create: (_) => DishCategoryController()),
    ChangeNotifierProvider(create: (_) => DishModifiersController()),
  ];

  static Future<void> initializeAllProviders(BuildContext context) async {
    await Future.wait([]).then((value) {
      context.read<DishModifiersController>().init();
      context.read<DishesController>().init();
      context.read<DishCategoryController>().init();
    });
  }
}
