import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dishes/dishes_controller.dart';
import '../../../core/utils/helper_utils.dart';
import '../../../services/app_exception/app_exception.dart';
import '../add_food_screen.dart';

class FoodDetailsSideSheetWidget extends StatefulWidget {
  const FoodDetailsSideSheetWidget({super.key});

  @override
  State<FoodDetailsSideSheetWidget> createState() =>
      _FoodDetailsSideSheetWidgetState();
}

class _FoodDetailsSideSheetWidgetState
    extends State<FoodDetailsSideSheetWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DishesController>().getDishDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    final controller = context.watch<DishesController>();

    if (controller.selectedDish == null) {
      return const SizedBox();
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: SafeArea(
        child: Drawer(
          width: size.width * 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      FluentIcons.chevron_left_28_filled,
                      color: MenuBuilderColors.kGrey,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        controller.initalizeAllFormControllers();
                        controller.onPressEditButton();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const AddFoodScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MenuBuilderColors.kBlue.withOpacity(0.25),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: MenuBuilderColors.kBlue,
                        ),
                      ),
                    ),
                    horizontalSpaceRegular,
                    InkWell(
                      onTap: () {
                        controller.deleteDish();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              MenuBuilderColors.kPrimaryColor.withOpacity(0.25),
                        ),
                        child: const Icon(
                          Icons.delete_forever,
                          color: MenuBuilderColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              controller.viewDishDetails.when(initial: () {
                return const SizedBox();
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }, completed: (data) {
                const weekDays = [
                  'Sunday',
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday'
                ];

                inspect(data);
                return Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 28.0,
                      horizontal: 20.0,
                    ),
                    child: ListView(
                      children: <Widget>[
                        verticalSpaceSmall,
                        Center(
                          child: Container(
                            height: size.height * 0.2,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.selectedDish!.photo,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceSmall,
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(controller.selectedDish!.name,
                                  style: textTheme.titleMedium),
                              horizontalSpaceSmall,
                              const Icon(
                                FontAwesomeIcons.drumstickBite,
                                color: Color(0xFFA16868),
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                        verticalSpaceVerySmall,
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            child: SegmentedButton<String>(
                              segments: [
                                ButtonSegment(
                                  value: "Online",
                                  icon: !controller.selectedDish!.onlineEnabled
                                      ? const Icon(
                                          Icons.close,
                                          color: MenuBuilderColors.kMaterialRed,
                                        )
                                      : const Icon(
                                          Icons.check,
                                          color:
                                              MenuBuilderColors.kSuccessGreen2,
                                        ),
                                  label: Text(
                                    "Online",
                                    style: textTheme.labelLarge!.copyWith(
                                      color: !controller
                                              .selectedDish!.onlineEnabled
                                          ? MenuBuilderColors.kMaterialRed
                                          : MenuBuilderColors.kSuccessGreen2,
                                    ),
                                  ),
                                  tooltip: "Online Status",
                                ),
                                ButtonSegment(
                                  value: "DineIn",
                                  icon: !controller.selectedDish!.diningEnabled
                                      ? const Icon(
                                          Icons.close,
                                          color: MenuBuilderColors.kMaterialRed,
                                        )
                                      : const Icon(
                                          Icons.check,
                                          color:
                                              MenuBuilderColors.kSuccessGreen2,
                                        ),
                                  label: Text(
                                    "Dine In",
                                    style: textTheme.labelLarge!.copyWith(
                                      color: !controller
                                              .selectedDish!.diningEnabled
                                          ? MenuBuilderColors.kMaterialRed
                                          : MenuBuilderColors.kSuccessGreen2,
                                    ),
                                  ),
                                  tooltip: "DineIn Status",
                                ),
                                ButtonSegment(
                                  value: "Active",
                                  icon: !controller.selectedDish!.active
                                      ? const Icon(
                                          Icons.close,
                                          color: MenuBuilderColors.kMaterialRed,
                                        )
                                      : const Icon(
                                          Icons.check,
                                          color:
                                              MenuBuilderColors.kSuccessGreen2,
                                        ),
                                  label: Text(
                                    "Active",
                                    style: textTheme.labelLarge!.copyWith(
                                      color: !controller.selectedDish!.active
                                          ? MenuBuilderColors.kMaterialRed
                                          : MenuBuilderColors.kSuccessGreen2,
                                    ),
                                  ),
                                  tooltip: "Active Status",
                                ),
                              ],
                              selected: const {},
                              emptySelectionAllowed: true,
                              showSelectedIcon: false,
                              onSelectionChanged: (value) {},
                              style: SegmentedButton.styleFrom(
                                backgroundColor: MenuBuilderColors.kWhite2,
                                foregroundColor: MenuBuilderColors.kBlack,
                                side: const BorderSide(
                                  color: MenuBuilderColors.kLightGrey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceSmall,
                        _buildExpansionTileContainer(
                          context,
                          icon: Icons.notes,
                          title: "Description",
                          children: [
                            const Divider(),
                            verticalSpaceSmall,
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                removeHtmlTags(
                                  controller.selectedDish!.description,
                                ),
                                style: textTheme.bodySmall,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        verticalSpaceRegular,
                        _buildExpansionTileContainer(
                          context,
                          icon: FluentIcons.info_20_regular,
                          title: "Basic Info",
                          children: [
                            _buildInfoRow(
                              context,
                              FluentIcons.food_20_regular,
                              controller.selectedDish!.name,
                            ),
                            if (data.variationData.length != 1)
                              verticalSpaceRegular,
                            ...data.variationData
                                .mapIndexed((index, variation) {
                              return _buildVariationDetailsTile(
                                index + 1,
                                variation,
                                data.variationData.length != 1,
                              );
                            }).toList(),
                          ],
                        ),
                        verticalSpaceRegular,
                        _buildExpansionTileContainer(
                          context,
                          icon: FluentIcons.app_folder_20_regular,
                          title: "Categories",
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runSpacing: 2.0,
                                spacing: 8.0,
                                children:
                                    data.formattedCategories.map((category) {
                                  return Chip(
                                    label: Text(
                                      category,
                                      style: textTheme.labelMedium,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    backgroundColor: MenuBuilderColors.kWhite,
                                    side: const BorderSide(
                                      color: MenuBuilderColors.kLightGrey,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                        verticalSpaceRegular,
                        _buildExpansionTileContainer(
                          context,
                          icon: FluentIcons.apps_add_in_20_regular,
                          title: "Addons/Modifiers",
                          children: const <Widget>[],
                        ),
                        verticalSpaceRegular,
                        _buildExpansionTileContainer(
                          context,
                          icon: FluentIcons.app_folder_20_regular,
                          title: "Menu Group",
                          children: data.selectedMenuList.isEmpty
                              ? <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: FilterChip(
                                      label: Text("Default",
                                          style: textTheme.labelMedium),
                                      onSelected: (_) {},
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      showCheckmark: false,
                                      backgroundColor: MenuBuilderColors.kWhite,
                                      side: const BorderSide(
                                        color: MenuBuilderColors.kLightGrey,
                                      ),
                                    ),
                                  )
                                ]
                              : [],
                        ),
                        verticalSpaceRegular,
                        _buildExpansionTileContainer(
                          context,
                          icon: FluentIcons.clock_20_regular,
                          title: "Timing Info",
                          children: [
                            verticalSpaceTiny,
                            Table(
                                border: TableBorder.all(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                children: weekDays
                                    .where((day) => data.availability.days
                                        .contains(day.toLowerCase()))
                                    .map((day) {
                                  return _buildMultiDataTableRow(
                                    context,
                                    day,
                                    data.formattedTiming,
                                  );
                                }).toList()),
                            verticalSpaceSmall,
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, error: (String? message, AppExceptions? exceptions) {
                return Center(child: Text(message ?? "Unknown error"));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTileContainer(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        dense: true,
        leading: Icon(icon, size: 20),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        title: Text(
          title,
          style: textTheme.titleMedium,
        ),
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String text, {
    bool smallText = false,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.grey.shade700,
        ),
        horizontalSpaceSmall,
        Flexible(
          child: Text(
            text,
            style: smallText
                ? textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade700,
                  )
                : textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade700,
                  ),
          ),
        ),
      ],
    );
  }

  TableRow _buildMultiDataTableRow(
    BuildContext context,
    String day,
    List<String> timings,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return TableRow(
      children: <Widget>[
        Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: timings.length > 1 ? 14.0 : 8.0),
            child: Text(
              day,
              style:
                  textTheme.bodyMedium!.copyWith(color: Colors.grey.shade500),
            ),
          ),
        ),
        Column(
          children: [
            verticalSpaceTiny,
            ...timings.map((timing) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  timing,
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.left,
                ),
              );
            }).toList(),
            verticalSpaceTiny,
          ],
        )
      ],
    );
  }

  Widget _buildVariationDetailsTile(int number, VariationData data,
      [bool showCard = true]) {
    return showCard
        ? Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: _buildVariationDetailsTileWidget(number, data)))
        : _buildVariationDetailsTileWidget(number, data, showCard);
  }

  Widget _buildVariationDetailsTileWidget(int number, VariationData data,
      [bool showCard = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (showCard) ...[
          Text("Variation $number"),
          const Divider(height: 20.0),
        ],
        if (data.name.isNotEmpty)
          _buildInfoRow(
            context,
            FluentIcons.star_20_regular,
            data.name,
            smallText: true,
          ),
        verticalSpaceSmall,
        _buildInfoRow(
          context,
          FluentIcons.money_20_regular,
          "£${data.price}",
          smallText: true,
        ),
        if (data.ingredients.isNotEmpty) ...[
          verticalSpaceSmall,
          _buildInfoRow(
            context,
            FluentIcons.book_star_20_regular,
            data.ingredients.trimRight()..trimLeft(),
            smallText: true,
          ),
        ],
        if (data.allergens.isNotEmpty) ...[
          verticalSpaceSmall,
          _buildInfoRow(
            context,
            FluentIcons.warning_20_regular,
            data.formattedAllergens,
            smallText: true,
          ),
        ],
        verticalSpaceSmall,
        _buildInfoRow(
          context,
          FluentIcons.stack_20_regular,
          "${data.stock} Stocks Available",
          smallText: true,
        ),
      ],
    );
  }
}
