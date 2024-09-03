import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/shop/shop_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:provider/provider.dart';

import '../../../controllers/auth/auth_controller.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mq = MediaQuery.of(context);
    final builderConfig = context.watch<AuthController>().builderConfig;
    final shopController = context.watch<ShopController>();

    return Container(
      height: mq.size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MenuBuilderColors.kWhite,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: <Widget>[
          horizontalSpaceMedium,
          if (builderConfig != null) ...[
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(FluentIcons.arrow_left_20_filled),
              label: Text("Back To ${builderConfig.applicationName}"),
              style: OutlinedButton.styleFrom(
                textStyle: textTheme.titleMedium,
                foregroundColor: MenuBuilderColors.kPurple,
                backgroundColor: MenuBuilderColors.kPurple.withOpacity(0.1),
                elevation: 0,
                side: BorderSide(
                  width: 0.8,
                  color: MenuBuilderColors.kPurple.withOpacity(0.3),
                ),
              ),
            ),
          ],
          const Spacer(),
          Visibility(
            visible: shopController.shopDetails?.shopName != null,
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
                  shopController.shopDetails?.shopName ?? "",
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          horizontalSpaceMedium,
        ],
      ),
    );
  }
}
