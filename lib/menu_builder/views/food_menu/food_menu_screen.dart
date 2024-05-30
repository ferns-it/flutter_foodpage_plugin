import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';

import '../common/root/base_root_widget.dart';
import '../widgets/search_bar_widget.dart';

class FoodMenuScreen extends StatelessWidget {
  const FoodMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BaseRootWidget(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Food Menu", style: textTheme.titleMedium),
              verticalSpaceTiny,
              Text(
                "Manage Your Restaurant Menu From Here",
                style: textTheme.bodyMedium!.copyWith(
                  color: MenuBuilderColors.kGrey2,
                ),
              ),
              verticalSpaceRegular,
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MenuBuilderColors.kWhite,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SearchBarWidget(
                        onSearchChanged: (String? query) {},
                        searchTextController: TextEditingController(),
                        borderRadius: 8.0,
                      ),
                    ),
                    const Spacer(),
                    FilledButton.tonalIcon(
                      onPressed: () {},
                      icon: const Icon(FluentIcons.add_16_regular),
                      label: const Text("Add Product"),
                      style: FilledButton.styleFrom(
                        textStyle: textTheme.bodyMedium,
                        foregroundColor: MenuBuilderColors.kPrimaryColor,
                        backgroundColor:
                            MenuBuilderColors.kPrimaryColor.withOpacity(0.1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
