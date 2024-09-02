import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/add_food_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../widgets/food_details_tile.dart';
import '../widgets/search_bar_widget.dart';

class FoodMenuScreen extends StatelessWidget {
  const FoodMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DishesController>();
    return Builder(builder: (context) {
      final textTheme = Theme.of(context).textTheme;
      return Padding(
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
                      "Manage Your Restaurant Menu",
                      style: textTheme.bodyMedium!.copyWith(
                        color: MenuBuilderColors.kGrey2,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // OutlinedButton.icon(
                //   onPressed: () {},
                //   icon: const Icon(FluentIcons.settings_16_filled),
                //   label: const Text("Manage Menu"),
                //   style: OutlinedButton.styleFrom(
                //     textStyle: textTheme.titleMedium,
                //     foregroundColor: MenuBuilderColors.kPurple,
                //     backgroundColor: MenuBuilderColors.kPurple.withOpacity(0.1),
                //     elevation: 0,
                //     side: BorderSide(
                //       width: 0.8,
                //       color: MenuBuilderColors.kPurple.withOpacity(0.3),
                //     ),
                //   ),
                // ),
                // horizontalSpaceRegular,
                OutlinedButton.icon(
                  onPressed: () {
                    controller.resetEditDishID();
                    controller.initalizeAllFormControllers();
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
                    backgroundColor: MenuBuilderColors.kOrange.withOpacity(0.1),
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
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SearchBarWidget(
                  onSearchChanged: (String? query) {},
                  searchTextController: TextEditingController(),
                  borderRadius: 8.0,
                  fillColor: MenuBuilderColors.kWhite,
                ),
              ),
            ),
            verticalSpaceRegular,
            controller.dishCollection.when(initial: () {
              return const SizedBox();
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, completed: (_) {
              final categories = controller.categoriesCollection;
              return Expanded(
                child: DefaultTabController(
                  length: categories.length,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        tabs: categories.map((category) {
                          return Tab(text: category.name.toUpperCase());
                        }).toList(),
                        tabAlignment: categories.length <= 10
                            ? TabAlignment.fill
                            : TabAlignment.center,
                        indicatorPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: categories.length > 10,
                        padding: EdgeInsets.zero,
                        dividerColor: Colors.transparent,
                      ),
                      verticalSpaceRegular,
                      Expanded(
                        child: TabBarView(
                            children: categories.map((category) {
                          final dishes =
                              controller.filterDishesByCategory(category);
                          return AlignedGridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            itemCount: dishes.length,
                            itemBuilder: (context, index) {
                              final dish = dishes[index];
                              return InkWell(
                                onTap: () {
                                  controller.onSelectDish(index);
                                  Scaffold.of(context).openEndDrawer();
                                },
                                child: FoodDetailsTile(dish: dish),
                              );
                            },
                          );
                        }).toList()),
                      ),
                    ],
                  ),
                ),
              );
            }, error: (message, error) {
              return Center(child: Text(message ?? "Something went wrong!"));
            }),
          ],
        ),
      );
    });
  }
}
