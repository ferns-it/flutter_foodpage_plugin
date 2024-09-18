import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/add_food_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../widgets/food_details_tile.dart';
import '../widgets/search_bar_widget.dart';

class FoodMenuScreen extends StatefulWidget {
  const FoodMenuScreen({super.key});

  @override
  State<FoodMenuScreen> createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  @override
  void initState() {
    context.read<DishesController>().initializeSearchController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   context.read<DishesController>().disposeSearchController();
  //   super.dispose();
  // }

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
                    controller.initializeAllFormControllers();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => const AddFoodScreen(),
                      ),
                    );
                  },
                  icon: const Icon(FluentIcons.add_24_filled),
                  label: const Text("Add Product"),
                ),
              ],
            ),
            verticalSpaceMedium,
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 3,
                  shadowColor: Colors.grey.withOpacity(0.3),
                  child: SearchBarWidget(
                    onSearchChanged: (String? query) {
                      controller.searchDishes(query);
                    },
                    searchTextController: context
                        .read<DishesController>()
                        .searchTextEditingController,
                    borderRadius: 8.0,
                    fillColor: MenuBuilderColors.kWhite,
                  ),
                ),
              ),
            ),
            verticalSpaceRegular,
            controller.dishCollection.when(initial: () {
              return const SizedBox();
            }, loading: () {
              return const Center(child: CircularProgressIndicator());
            }, completed: (_) {
              final categories = controller.listOfCategories;
              final categoryController =
                  context.watch<DishCategoryController>();

              return Expanded(
                child: DefaultTabController(
                  length: categories.length,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        tabs: categories.map((category) {
                          return Tab(
                            text: (category.name ?? "Unknown").toUpperCase(),
                          );
                        }).toList(),
                        tabAlignment: categories.length <= 8
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              !categoryController.categoryStatusLoading
                                  ? TextButton.icon(
                                      label: const Text("Active"),
                                      style: TextButton.styleFrom(
                                        textStyle: textTheme.titleMedium,
                                      ),
                                      onPressed: () {
                                        categoryController
                                            .disableEnableCategory(
                                                category: category,
                                                onRequestRefresh: () async {
                                                  await controller
                                                      .initializeAddDishRequiredData();
                                                });
                                      },
                                      icon: category.categoryStatus != "Active"
                                          ? const Icon(
                                              Icons.close,
                                              color: MenuBuilderColors
                                                  .kMaterialRed,
                                            )
                                          : const Icon(
                                              Icons.check,
                                              color: MenuBuilderColors
                                                  .kSuccessGreen2,
                                            ),
                                    )
                                  : const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 3),
                                    ),
                              verticalSpaceSmall,
                              Expanded(
                                child: AlignedGridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisSpacing: 2,
                                  itemCount: dishes.length,
                                  itemBuilder: (context, index) {
                                    final dish = dishes[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.onSelectDish(dish.pID);
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      child: FoodDetailsTile(dish: dish),
                                    );
                                  },
                                ),
                              ),
                            ],
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
