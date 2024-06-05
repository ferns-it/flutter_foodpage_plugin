import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/add_food_screen.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/food_details_side_sheet_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../common/root/base_root_widget.dart';
import '../widgets/food_details_tile.dart';
import '../widgets/search_bar_widget.dart';

class FoodMenuScreen extends StatelessWidget {
  const FoodMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseRootWidget(
      endDrawer: const FoodDetailsSideSheetWidget(),
      child: Builder(builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Food Menu", style: textTheme.titleLarge),
                        verticalSpaceTiny,
                        Text(
                          "Manage Your Restaurant Menu From Here",
                          style: textTheme.bodyMedium!.copyWith(
                            color: MenuBuilderColors.kGrey2,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(FluentIcons.settings_16_filled),
                      label: const Text("Manage Menu"),
                      style: OutlinedButton.styleFrom(
                        textStyle: textTheme.titleMedium,
                        foregroundColor: MenuBuilderColors.kPurple,
                        backgroundColor:
                            MenuBuilderColors.kPurple.withOpacity(0.1),
                        elevation: 0,
                        side: BorderSide(
                          width: 0.8,
                          color: MenuBuilderColors.kPurple.withOpacity(0.3),
                        ),
                      ),
                    ),
                    horizontalSpaceRegular,
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const AddFoodScreen(),
                          ),
                        );
                      },
                      icon: const Icon(FluentIcons.add_16_filled),
                      label: const Text("Add Product"),
                      style: OutlinedButton.styleFrom(
                        textStyle: textTheme.titleMedium,
                        foregroundColor: MenuBuilderColors.kOrange,
                        backgroundColor:
                            MenuBuilderColors.kOrange.withOpacity(0.1),
                        elevation: 0,
                        side: BorderSide(
                          width: 0.8,
                          color: MenuBuilderColors.kOrange.withOpacity(0.3),
                        ),
                      ),
                    )
                  ],
                ),
                verticalSpaceMedium,
                Container(
                  height: 60,
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
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Expanded(
                  child: AlignedGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: const FoodDetailsTile(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
