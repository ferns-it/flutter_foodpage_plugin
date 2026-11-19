import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:provider/provider.dart';

class MenuNavigation {
  static void _resetSelectedCategory(BuildContext context) {
    final controller = context.read<DishCategoryController>();
    if (!controller.editMode) return;
    controller.resetSelectedCategory();
    controller.clearCategoryForm();
  }

  static void goTo(BuildContext context, int index) {
    final nav = context.read<PageNavigationController>();
    final dishes = context.read<DishesController>();
    final current = nav.currentPageIndex;

    switch (index) {
      case 0: // Dashboard
        _resetSelectedCategory(context);
        if (current == 1) dishes.clearDishSearch();
        break;
      case 1: // Food Menu
        _resetSelectedCategory(context);
        break;
      case 2: // Categories
        if (current == 1) dishes.clearDishSearch();
        break;
      case 3: // Modifiers
        _resetSelectedCategory(context);
        if (current == 1) dishes.clearDishSearch();
        break;
    }
    nav.onChangePageIndex(index);
  }
}