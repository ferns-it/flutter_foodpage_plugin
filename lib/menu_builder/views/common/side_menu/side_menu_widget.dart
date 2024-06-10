import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/page_navigation_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final readPageNavigationController =
        context.read<PageNavigationController>();
    final pageNavigationController = context.watch<PageNavigationController>();

    return Container(
      width: size.width * 0.2,
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      decoration: BoxDecoration(
        color: MenuBuilderColors.kWhite,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTileTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        selectedTileColor: MenuBuilderColors.kPrimaryColor,
        child: Column(
          children: <Widget>[
            Center(
              child: Image.asset(
                "packages/flutter_foodpage_plugin/assets/images/food-page-logo.png",
                height: 30,
              ),
            ),
            verticalSpaceSmall,
            const Divider(),
            verticalSpaceMedium,
            _buildMenuItem(
              context,
              icon: pageNavigationController.currentPageIndex == 0
                  ? FluentIcons.home_20_filled
                  : FluentIcons.home_20_regular,
              title: "Dashboard",
              selected: pageNavigationController.currentPageIndex == 0,
              onTap: () {
                readPageNavigationController.onChangePageIndex(0);
              },
            ),
            verticalSpaceSmall,
            _buildMenuItem(
              context,
              icon: pageNavigationController.currentPageIndex == 1
                  ? FluentIcons.food_20_filled
                  : FluentIcons.food_20_regular,
              title: "Food Menu",
              selected: pageNavigationController.currentPageIndex == 1,
              onTap: () {
                readPageNavigationController.onChangePageIndex(1);
              },
            ),
            verticalSpaceSmall,
            _buildMenuItem(
              context,
              icon: pageNavigationController.currentPageIndex == 2
                  ? FluentIcons.apps_list_20_filled
                  : FluentIcons.apps_list_20_regular,
              title: "Categories",
              selected: pageNavigationController.currentPageIndex == 2,
              onTap: () {
                readPageNavigationController.onChangePageIndex(2);
              },
            ),
            verticalSpaceSmall,
            _buildMenuItem(
              context,
              icon: pageNavigationController.currentPageIndex == 3
                  ? FluentIcons.apps_add_in_20_filled
                  : FluentIcons.apps_add_in_20_regular,
              title: "Modifiers",
              selected: pageNavigationController.currentPageIndex == 3,
              onTap: () {
                readPageNavigationController.onChangePageIndex(3);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool selected = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: selected ? MenuBuilderColors.kPrimaryColor.withOpacity(0.1) : null,
      child: Center(
        child: ListTile(
          onTap: onTap,
          selected: selected,
          leading: Icon(icon),
          title: Text(title),
          titleTextStyle: textTheme.labelLarge,
        ),
      ),
    );
  }
}
