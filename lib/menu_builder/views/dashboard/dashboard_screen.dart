import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';

import '../common/root/base_root_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseRootWidget(
      child: Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(FluentIcons.food_20_regular),
                        title: Text("Total Products"),
                        subtitle: Text("300"),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          FluentIcons.apps_list_20_regular,
                        ),
                        title: Text("Total Categories"),
                        subtitle: Text("10"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpaceSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(FluentIcons.food_20_regular),
                        title: Text("Total Menus"),
                        subtitle: Text("4"),
                      ),
                    ),
                  ),
                  horizontalSpaceSmall,
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          FluentIcons.apps_add_in_20_regular,
                        ),
                        title: Text("Total Modifiers"),
                        subtitle: Text("8"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
