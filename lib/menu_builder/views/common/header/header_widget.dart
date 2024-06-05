import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mq = MediaQuery.of(context);
    return Container(
      height: mq.size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MenuBuilderColors.kWhite,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              FluentIcons.building_shop_24_regular,
              color: Colors.grey.shade600,
            ),
            horizontalSpaceSmall,
            Text(
              "Le Arabia Restaurant",
              style: textTheme.titleMedium!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            horizontalSpaceSmall,
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade400,
              size: 28,
            ),
            horizontalSpaceRegular,
          ],
        ),
      ),
    );
  }
}
