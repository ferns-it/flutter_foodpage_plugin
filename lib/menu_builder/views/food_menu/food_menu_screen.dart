import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/responsive_utils.dart';
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
  late DishesController dishesController;

  @override
  void initState() {
    super.initState();
    dishesController = context.read<DishesController>();
    dishesController.initializeSearchController();
  }

  @override
  void dispose() {
    dishesController.disposeSearchController();
    super.dispose();
  }

  void _openAddProduct(DishesController controller) {
    controller.resetEditDishID();
    controller.initializeAllFormControllers();
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const AddFoodScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DishesController>();
    final isMobile = ResponsiveUtils.isMobile(context);
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildHeader(context, controller, isMobile, textTheme),
          isMobile ? verticalSpaceRegular : verticalSpaceMedium,
          _buildSearch(context, isMobile),
          verticalSpaceRegular,
          controller.dishCollection.when(initial: () {
            return const SizedBox();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, completed: (_) {
            final categories = controller.menuCategories;
            final categoryController = context.watch<DishCategoryController>();

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
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      dividerColor: Colors.transparent,
                      labelStyle: isMobile ? textTheme.labelLarge : null,
                    ),
                    isMobile ? verticalSpaceSmall : verticalSpaceRegular,
                    Expanded(
                      child: TabBarView(
                        children: categories.map((category) {
                          final dishes =
                              controller.filterDishesByCategory(category);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (category != controller.allCategory)
                                _buildCategoryStatusButton(
                                  context,
                                  controller: controller,
                                  categoryController: categoryController,
                                  category: category,
                                  isMobile: isMobile,
                                  textTheme: textTheme,
                                ),
                              verticalSpaceSmall,
                              Expanded(
                                child: AlignedGridView.count(
                                  padding: EdgeInsets.only(
                                    bottom: isMobile ? 16 : 0,
                                  ),
                                  crossAxisCount: isMobile ? 1 : 2,
                                  mainAxisSpacing: isMobile ? 8 : 2,
                                  crossAxisSpacing: isMobile ? 0 : 2,
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
                        }).toList(),
                      ),
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
  }

  Widget _buildHeader(
    BuildContext context,
    DishesController controller,
    bool isMobile,
    TextTheme textTheme,
  ) {
    final titleBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        verticalSpaceSmall,
        Text("Food Menu", style: textTheme.titleLarge),
        verticalSpaceTiny,
        Text(
          "Manage Your Restaurant Menu",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodyMedium!.copyWith(
            color: MenuBuilderColors.kGrey2,
          ),
        ),
      ],
    );

    if (isMobile) {
      return Row(
        children: <Widget>[
          Expanded(child: titleBlock),
          horizontalSpaceSmall,
          OutlinedButton.icon(
            onPressed: () => _openAddProduct(controller),
            icon: const Icon(FluentIcons.add_24_filled, size: 18),
            label: const Text("Add"),
            style: OutlinedButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
          ),
        ],
      );
    }

    return Row(
      children: <Widget>[
        titleBlock,
        const Spacer(),
        OutlinedButton.icon(
          onPressed: () => _openAddProduct(controller),
          icon: const Icon(FluentIcons.add_24_filled),
          label: const Text("Add Product"),
        ),
      ],
    );
  }

  Widget _buildSearch(BuildContext context, bool isMobile) {
    final search = Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: SearchBarWidget(
        onSearchChanged: (String? query) {},
        searchTextController:
            context.read<DishesController>().searchTextEditingController,
        borderRadius: 8.0,
        fillColor: MenuBuilderColors.kWhite,
      ),
    );

    if (isMobile) {
      return SizedBox(width: double.infinity, child: search);
    }

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: search,
      ),
    );
  }

  Widget _buildCategoryStatusButton(
    BuildContext context, {
    required DishesController controller,
    required DishCategoryController categoryController,
    required dynamic category,
    required bool isMobile,
    required TextTheme textTheme,
  }) {
    if (categoryController.categoryStatusLoading) {
      return const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 10.0, top: 10.0),
          child: SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
        ),
      );
    }

    final isActive = category.categoryStatus == "Active";

    return Align(
      alignment: Alignment.centerRight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          textStyle: isMobile ? textTheme.titleSmall : textTheme.titleMedium,
          visualDensity: isMobile ? VisualDensity.compact : null,
          backgroundColor: Colors.white,
          foregroundColor: isActive
              ? MenuBuilderColors.kMaterialRed
              : MenuBuilderColors.kSuccessGreen2,
          side: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
        onPressed: () {
          categoryController.disableEnableCategory(
            category: category,
            onRequestRefresh: () async {
              await controller.initializeAddDishRequiredData();
            },
          );
        },
        child: Text(isActive ? "Disable Category" : "Enable Category"),
      ),
    );
  }
}
