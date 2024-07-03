import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dishController = context.watch<DishesController>();
    final dishCategoryController = context.watch<DishCategoryController>();
    final dishModifiersController = context.watch<DishModifiersController>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: const Icon(FluentIcons.food_20_regular),
                    title: const Text("Total Products"),
                    subtitle: Text("${dishController.totalDishes}"),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: const Icon(FluentIcons.apps_list_20_regular),
                    title: const Text("Total Categories"),
                    subtitle: Text("${dishCategoryController.totalCategories}"),
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpaceSmall,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: const Icon(FluentIcons.food_20_regular),
                    title: const Text("Total Menus"),
                    subtitle: Text("${dishController.listOfMenus.length}"),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              Expanded(
                child: Card(
                  child: ListTile(
                    leading: const Icon(FluentIcons.apps_add_in_20_regular),
                    title: const Text("Total Modifiers"),
                    subtitle: Text("${dishModifiersController.modifiersCount}"),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
