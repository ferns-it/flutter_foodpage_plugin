import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.network(
                "https://foodpage.co.uk/theme/img/logo.png",
              ),
            ),
            const Divider(),
            verticalSpaceMedium,
            Container(
              color: MenuBuilderColors.kPrimaryColor.withOpacity(0.1),
              child: Center(
                child: ListTile(
                  onTap: () {},
                  selected: true,
                  leading: const Icon(FluentIcons.home_20_regular),
                  title: const Text("Dashboard"),
                  titleTextStyle: textTheme.labelLarge,
                ),
              ),
            ),
            verticalSpaceSmall,
            ListTile(
              onTap: () {},
              leading: const Icon(FluentIcons.food_20_regular),
              title: const Text("Food Menu"),
              titleTextStyle: textTheme.labelLarge,
            ),
            verticalSpaceSmall,
            ListTile(
              onTap: () {},
              leading: const Icon(FluentIcons.apps_list_20_regular),
              title: const Text("Categories"),
              titleTextStyle: textTheme.labelLarge,
            ),
            verticalSpaceSmall,
            ListTile(
              onTap: () {},
              leading: const Icon(FluentIcons.apps_add_in_20_regular),
              title: const Text("Modifiers"),
              titleTextStyle: textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
