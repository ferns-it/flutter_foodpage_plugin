import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/category/categories_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/common/root/base_root_widget.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/dashboard/dashboard_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/food_menu_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/food_details_side_sheet_widget.dart';
import 'package:provider/provider.dart';

import 'modifier/modifiers_screen.dart';

class FlutterFoodpageMenuBuilder extends StatelessWidget {
  const FlutterFoodpageMenuBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const DashboardScreen(),
      const FoodMenuScreen(),
      const CategoriesScreen(),
      const ModifiersScreen(),
    ];

    return Builder(builder: (context) {
      final pageNavigationController =
          context.watch<PageNavigationController>();
      final currentPageIndex = pageNavigationController.currentPageIndex;
      return BaseRootWidget(
        endDrawer:
            currentPageIndex == 1 ? const FoodDetailsSideSheetWidget() : null,
        child: Expanded(
          child: screens[
              pageNavigationController.currentPageIndex % screens.length],
        ),
      );
    });
  }
}
