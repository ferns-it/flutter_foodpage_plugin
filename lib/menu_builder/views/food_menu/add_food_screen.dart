import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/google_ai/gemini_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/shop/shop_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_theme.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/validators/menu_builder_validators.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/add_availability_side_sheet.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/add_category_side_sheet.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/add_menu_side_sheet.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/add_variation_modifiers_side_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../core/constants/menu_builder_app_colors.dart';
import '../../widgets/custom_rounded_textfield.dart';
import 'widgets/build_allergens_widget.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen>
    with SingleTickerProviderStateMixin {
  // @override
  // void dispose() {
  //   context.read<DishesController>().disposeAllFormControllers();
  //   super.dispose();
  // }

  Widget getSideSheetWidget(BuildContext context) {
    final controller = context.read<DishesController>();
    final activeSideSheetType = controller.activeSideSheetType;

    switch (activeSideSheetType) {
      case AddDishSideSheetType.variation:
        return const AddVariationModifiersSideSheet();
      case AddDishSideSheetType.availability:
        return const AddAvailabilitySideSheet();
      case AddDishSideSheetType.category:
        return const AddCategoriesSideSheet();
      case AddDishSideSheetType.menu:
        return const AddMenuSideSheet();
    }
  }

  Offset? _tapDownPosition;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final bottom = mq.viewInsets.bottom;

    return PopScope(
      onPopInvoked: (_) {
        context.read<DishesController>().resetFormEntries();
      },
      child: Theme(
        data: menuBuilderTheme(context).copyWith(
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        child: Builder(builder: (context) {
          final textTheme = Theme.of(context).textTheme;
          const defaultCardPadding = EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 18.0,
          );

          final controller = context.watch<DishesController>();
          final geminiController = context.read<GeminiController>();
          final shopController = context.watch<ShopController>();
          final addDishInitializeData = controller.addDishInitializeData;

          return Scaffold(
            appBar: AppBar(
              title: controller.editDishId != null
                  ? const Text("Edit Dish")
                  : const Text("Add Dish"),
              actions: <Widget>[
                OutlinedButton.icon(
                  onPressed: () => controller.addOrUpdateDish().then((result) {
                    if (result == ResponseResult.success) {
                      Navigator.pop(context);
                      controller.resetFormEntries();
                    }
                  }),
                  icon: const Icon(FluentIcons.save_24_filled),
                  label: controller.editDishId != null
                      ? const Text("Update Dish")
                      : const Text("Save Dish"),
                  style: OutlinedButton.styleFrom(
                    textStyle: textTheme.titleMedium,
                  ),
                ),
                horizontalSpaceRegular,
              ],
            ),
            endDrawer: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: size.height - bottom,
                child: Drawer(
                  width: size.width * 0.5, // size.width * 0.5
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: getSideSheetWidget(context),
                ),
              ),
            ),
            endDrawerEnableOpenDragGesture: false,
            body: Form(
              key: controller.addNewDishFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: ListView(
                        children: <Widget>[
                          Card(
                            child: Padding(
                              padding: defaultCardPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Basic Information",
                                    style: textTheme.titleMedium,
                                  ),
                                  verticalSpaceSmall,
                                  const Divider(),
                                  verticalSpaceRegular,
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: CustomRoundedTextField.topText(
                                          hintText: "Enter dish name",
                                          topText: "Dish name",
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          keyboardType: TextInputType.name,
                                          textInputAction: TextInputAction.next,
                                          textEditingController:
                                              controller.nameController,
                                          validator: MenuBuilderValidators
                                              .validateDishName,
                                        ),
                                      ),
                                      horizontalSpaceRegular,
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Variation Type",
                                              style: textTheme.titleSmall!
                                                  .copyWith(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                            verticalSpaceTiny,
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 6.0,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              child: Row(
                                                children: DishVariationType
                                                    .values
                                                    .map(
                                                      (value) => Flexible(
                                                        child: RadioListTile(
                                                          title: Text(
                                                            capitalizeFirstLetter(
                                                              value.name,
                                                            ),
                                                          ),
                                                          value: value,
                                                          groupValue: controller
                                                              .dishVariationType,
                                                          onChanged: controller
                                                              .onChangeDishVariationType,
                                                          visualDensity:
                                                              const VisualDensity(
                                                            horizontal:
                                                                VisualDensity
                                                                    .minimumDensity,
                                                            vertical: VisualDensity
                                                                .minimumDensity,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(growable: false),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  verticalSpaceRegular,
                                  CustomRoundedTextField.topText(
                                    hintText: "Short note about dish..",
                                    topText: "Description",
                                    borderRadius: BorderRadius.circular(8.0),
                                    maxLines: 2,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    textEditingController:
                                        controller.descriptionController,
                                    suffixIcon: context
                                            .watch<GeminiController>()
                                            .dishDescriptionGenerating
                                        ? const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: SizedBox(
                                              height: 26.0,
                                              width: 26.0,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2.5,
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            customBorder: const CircleBorder(),
                                            onTapDown:
                                                (TapDownDetails details) {
                                              _tapDownPosition =
                                                  details.globalPosition;
                                            },
                                            onLongPress: () async {
                                              if (_tapDownPosition == null) {
                                                return;
                                              }

                                              final RenderBox overlay =
                                                  Overlay.of(context)
                                                          .context
                                                          .findRenderObject()
                                                      as RenderBox;

                                              await showMenu(
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                items: [
                                                  PopupMenuItem(
                                                    value: 0,
                                                    child: const Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons
                                                              .spellcheck_outlined,
                                                          size: 22,
                                                        ),
                                                        SizedBox(width: 14.0),
                                                        Text(
                                                            "Spelling & Grammar"),
                                                      ],
                                                    ),
                                                    onTap: () async {
                                                      final desc = controller
                                                          .descriptionController
                                                          .text;
                                                      if (desc.isEmpty) {
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              "Description cannot be empty!",
                                                        );
                                                        return;
                                                      }
                                                      final generatedContent =
                                                          await geminiController
                                                              .spellAndGrammarDishDescription(
                                                        desc,
                                                      );

                                                      if (generatedContent !=
                                                          null) {
                                                        controller
                                                                .descriptionController
                                                                .text =
                                                            generatedContent;
                                                      }
                                                    },
                                                  ),
                                                ],
                                                position: RelativeRect.fromLTRB(
                                                  _tapDownPosition!.dx,
                                                  _tapDownPosition!.dy,
                                                  overlay.size.width -
                                                      _tapDownPosition!.dx,
                                                  overlay.size.height -
                                                      _tapDownPosition!.dy,
                                                ),
                                              );
                                            },
                                            onTap: () async {
                                              final name = controller
                                                  .nameController.text;
                                              if (name.isEmpty) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Dish Name cannot be empty!");
                                                return;
                                              }
                                              final generatedContent =
                                                  await geminiController
                                                      .generateDishDescription(
                                                          name);
                                              if (generatedContent != null) {
                                                controller.descriptionController
                                                    .text = generatedContent;
                                              }
                                            },
                                            child: const Icon(
                                              FluentIcons.sparkle_24_regular,
                                            ),
                                          ),
                                  ),
                                  verticalSpaceMedium,
                                  CustomRadioCheckboxGroup(
                                    title1: "Veg/Non Veg",
                                    title2: "Available On",
                                    options1:
                                        addDishInitializeData!.dishtype.data,
                                    groupValue: controller.dishType,
                                    options2: const ["Online", "Dine In"],
                                    checkboxValues: [
                                      controller.onlineStatus,
                                      controller.dineInStatus
                                    ],
                                    onChangedCheckbox: (index, value) {
                                      if (value == null) return;
                                      if (index == 0) {
                                        controller.onChangeOnlineStatus(value);
                                      } else {
                                        controller.onChangeDineInStatus(value);
                                      }
                                    },
                                    onChangedRadio: (dishType) {
                                      if (dishType == null) return;
                                      controller.onChangeDishType(dishType);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          controller.dishVariationType ==
                                  DishVariationType.single
                              ? LayoutBuilder(builder: (context, constraints) {
                                  return Card(
                                    child: Padding(
                                      padding: defaultCardPadding,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(
                                            width: constraints.maxWidth / 2,
                                            child:
                                                CustomRoundedTextField.topText(
                                              topText: "Dish price",
                                              hintText: "Enter dish price",
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              validator: MenuBuilderValidators
                                                  .validatePrice,
                                              textEditingController: controller
                                                  .singleVariationPriceController,
                                            ),
                                          ),
                                          verticalSpaceRegular,
                                          CustomRoundedTextField.topText(
                                            topText: "Ingredients",
                                            hintText:
                                                "Short note about dish ingredients..",
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            maxLines: 2,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            textEditingController: controller
                                                .singleVariationIngredientsController,
                                            suffixIcon: geminiController
                                                    .dishIngredientsGenerating
                                                ? const Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: SizedBox(
                                                      height: 26.0,
                                                      width: 26.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2.5,
                                                      ),
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () async {
                                                      final name = controller
                                                          .nameController.text;
                                                      if (name.isEmpty) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                "Dish Name cannot be empty!");
                                                        return;
                                                      }
                                                      final generatedContent =
                                                          await geminiController
                                                              .generateDishIngredients(
                                                                  name);
                                                      if (generatedContent !=
                                                          null) {
                                                        controller
                                                                .singleVariationIngredientsController
                                                                .text =
                                                            generatedContent;
                                                      }
                                                    },
                                                    icon: const Icon(FluentIcons
                                                        .sparkle_24_regular),
                                                  ),
                                          ),
                                          verticalSpaceRegular,
                                          const BuildAllergensWidget()
                                        ],
                                      ),
                                    ),
                                  );
                                })
                              : Card(
                                  child: Padding(
                                    padding: defaultCardPadding,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                "Variations",
                                                style: textTheme.titleMedium,
                                              ),
                                              const Spacer(),
                                              Builder(builder: (context) {
                                                return OutlinedButton.icon(
                                                  onPressed: () {
                                                    controller
                                                        .onChangeSideSheetType(
                                                      AddDishSideSheetType
                                                          .variation,
                                                    );

                                                    Scaffold.of(context)
                                                        .openEndDrawer();
                                                  },
                                                  icon: const Icon(
                                                    FluentIcons.add_24_filled,
                                                  ),
                                                  label: const Text(
                                                      "Add Variation"),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    textStyle:
                                                        textTheme.titleMedium,
                                                    foregroundColor:
                                                        MenuBuilderColors.kBlue,
                                                    side: const BorderSide(
                                                      width: 1,
                                                      color: MenuBuilderColors
                                                          .kBlue,
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ],
                                          ),
                                          const Divider(),
                                          verticalSpaceRegular,
                                          if (controller
                                              .variationsFormEntriesEmpty)
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                ),
                                                child: Text(
                                                  "You have no variations yet. To add a variation, press the Add Variation (+) button.",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors
                                                            .grey.shade600,
                                                      ),
                                                ),
                                              ),
                                            )
                                          else
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxHeight: mq.size.height * 0.3,
                                              ),
                                              child: AlignedGridView.count(
                                                crossAxisCount: 2,
                                                itemCount: controller
                                                    .variationsFormEntries
                                                    .length,
                                                mainAxisSpacing: 14.0,
                                                crossAxisSpacing: 14.0,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  final entry = controller
                                                          .variationsFormEntries[
                                                      index];
                                                  final hasValues = controller
                                                      .checkVariationEntryIsEmpty(
                                                          index);

                                                  if (hasValues) {
                                                    return const SizedBox
                                                        .shrink();
                                                  }

                                                  final name = (entry["name"]
                                                          as TextEditingController)
                                                      .text;
                                                  final price = (entry["price"]
                                                          as TextEditingController)
                                                      .text;

                                                  if (name.isEmpty ||
                                                      price.isEmpty) {
                                                    return const SizedBox
                                                        .shrink();
                                                  }

                                                  return ListTile(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.0),
                                                    ),
                                                    title: Text(name),
                                                    subtitle: Text(
                                                      "₹$price",
                                                      style: textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          const Card(
                            child: Padding(
                              padding: defaultCardPadding,
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text(
                                    //       "Choices & Addons",
                                    //       style: textTheme.titleMedium,
                                    //     ),
                                    //     Builder(builder: (context) {
                                    //       return OutlinedButton.icon(
                                    //         onPressed: () {
                                    //           Scaffold.of(context)
                                    //               .openEndDrawer();
                                    //         },
                                    //         icon: const Icon(
                                    //           FluentIcons.add_24_filled,
                                    //         ),
                                    //         label: const Text("Add Modifier"),
                                    //         style: OutlinedButton.styleFrom(
                                    //           textStyle: textTheme.titleMedium,
                                    //           foregroundColor:
                                    //               MenuBuilderColors.kOrange2,
                                    //           backgroundColor: MenuBuilderColors
                                    //               .kOrange2
                                    //               .withOpacity(0.1),
                                    //           elevation: 0,
                                    //           side: BorderSide(
                                    //             width: 0.8,
                                    //             color: MenuBuilderColors.kOrange2
                                    //                 .withOpacity(0.3),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     })
                                    //   ],
                                    // ),
                                    // const Divider(),
                                    // verticalSpaceRegular,
                                    // AlignedGridView.count(
                                    //   crossAxisCount: 3,
                                    //   itemCount: 4,
                                    //   mainAxisSpacing: 14.0,
                                    //   crossAxisSpacing: 14.0,
                                    //   shrinkWrap: true,
                                    //   physics:
                                    //       const NeverScrollableScrollPhysics(),
                                    //   itemBuilder: (context, index) {
                                    //     return const FoodModifiersDetailsWidget();
                                    //   },
                                    // ),
                                    // verticalSpaceRegular,
                                    // const Divider(),
                                    _BuildMasterModifiersWidget()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerTheme: const DividerThemeData(
                            color: Colors.transparent,
                          ),
                          dividerColor: Colors.transparent,
                        ),
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: defaultCardPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Categories",
                                            style: textTheme.titleMedium,
                                          ),
                                          Builder(builder: (context) {
                                            return InkWell(
                                              onTap: () {
                                                controller
                                                    .onChangeSideSheetType(
                                                  AddDishSideSheetType.category,
                                                );
                                                Scaffold.of(context)
                                                    .openEndDrawer();
                                              },
                                              child: Icon(
                                                FluentIcons.add_20_filled,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.grey.shade300,
                                        height: 40.0,
                                      ),
                                      Text(
                                        "Parent Categories",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Colors.grey.shade600),
                                      ),
                                      verticalSpaceSmall,
                                      Divider(color: Colors.grey.shade300),
                                      SizedBox(
                                        height: 40.0,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .choosedParentCategory.length,
                                          itemBuilder: (context, index) {
                                            final element = controller
                                                .choosedParentCategory[index];
                                            return Chip(
                                              onDeleted: () {
                                                controller.removeParentCategory(
                                                  element.$1,
                                                );
                                              },
                                              backgroundColor: MenuBuilderColors
                                                  .kPurple
                                                  .withOpacity(0.1),
                                              side: BorderSide.none,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6.0,
                                              ),
                                              label: Text(capitalizeFirstLetter(
                                                  element.$2 ?? "")),
                                              labelStyle:
                                                  textTheme.bodyLarge!.copyWith(
                                                color:
                                                    MenuBuilderColors.kPurple,
                                              ),
                                              deleteIcon: const Icon(
                                                  Icons.close,
                                                  size: 20),
                                              deleteIconColor:
                                                  MenuBuilderColors.kPurple,
                                              // selected: true,
                                              // selectedColor: AppColors.backgroundColor,
                                            );
                                          },
                                          separatorBuilder: (_, __) {
                                            return horizontalSpaceSmall;
                                          },
                                        ),
                                      ),
                                      verticalSpaceSmall,
                                      if (controller
                                          .choosedSubCategories.isNotEmpty) ...[
                                        Divider(color: Colors.grey.shade300),
                                        verticalSpaceSmall,
                                        Text(
                                          "Children",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.grey.shade600),
                                        ),
                                        verticalSpaceSmall,
                                        Divider(color: Colors.grey.shade300),
                                        SizedBox(
                                          height: 40.0,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .choosedSubCategories.length,
                                            itemBuilder: (context, index) {
                                              final element = controller
                                                  .choosedSubCategories[index];
                                              return Chip(
                                                onDeleted: () {
                                                  controller
                                                      .removeChildCategory(
                                                    element.$1,
                                                    element.$3,
                                                  );
                                                },
                                                backgroundColor:
                                                    MenuBuilderColors.kOrange
                                                        .withOpacity(0.1),
                                                side: BorderSide.none,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 6.0,
                                                ),
                                                label: Text(
                                                    "${capitalizeFirstLetter(element.$4 ?? "")} ( ${capitalizeFirstLetter(element.$2 ?? "")} )"),
                                                labelStyle: textTheme.bodyLarge!
                                                    .copyWith(
                                                  color:
                                                      MenuBuilderColors.kOrange,
                                                ),
                                                deleteIcon: const Icon(
                                                    Icons.close,
                                                    size: 20),
                                                deleteIconColor:
                                                    MenuBuilderColors.kOrange,
                                                // selected: true,
                                                // selectedColor: AppColors.backgroundColor,
                                              );
                                            },
                                            separatorBuilder: (_, __) {
                                              return horizontalSpaceSmall;
                                            },
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: defaultCardPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Menus",
                                            style: textTheme.titleMedium,
                                          ),
                                          Builder(builder: (context) {
                                            return InkWell(
                                              onTap: () {
                                                controller
                                                    .onChangeSideSheetType(
                                                  AddDishSideSheetType.menu,
                                                );
                                                Scaffold.of(context)
                                                    .openEndDrawer();
                                              },
                                              child: Icon(
                                                FluentIcons.add_20_filled,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      verticalSpaceSmall,
                                      Wrap(
                                        runSpacing: 2.0,
                                        spacing: 8.0,
                                        children:
                                            controller.choosedMenus.map((key) {
                                          return Chip(
                                            backgroundColor: MenuBuilderColors
                                                .kOrange
                                                .withOpacity(0.1),
                                            side: BorderSide.none,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0,
                                            ),
                                            label: Text(
                                                controller.listOfMenus[key]),
                                            labelStyle:
                                                textTheme.bodyLarge!.copyWith(
                                              color: MenuBuilderColors.kOrange,
                                            ),
                                          );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: defaultCardPadding,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Availability",
                                            style: textTheme.titleMedium,
                                          ),
                                          Builder(builder: (context) {
                                            return InkWell(
                                              onTap: () {
                                                controller
                                                    .onChangeSideSheetType(
                                                  AddDishSideSheetType
                                                      .availability,
                                                );
                                                Scaffold.of(context)
                                                    .openEndDrawer();
                                              },
                                              child: Icon(
                                                FluentIcons.edit_20_regular,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      verticalSpaceRegular,
                                      if (controller.allDaysEnabled)
                                        Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                shopController
                                                    .shopAvailableDaysStartEnd,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                            verticalSpaceSmall,
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Dish availability matches the shop's operating hours.",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MenuBuilderColors
                                                          .kPrimaryColor,
                                                    ),
                                              ),
                                            ),
                                            verticalSpaceSmall,
                                            Builder(builder: (context) {
                                              final dishAvailabilityEntries =
                                                  controller
                                                      .dishAvailabilityEntries
                                                      .where((entry) =>
                                                          entry.$1 != null &&
                                                          entry.$2 != null);
                                              return Visibility(
                                                visible: dishAvailabilityEntries
                                                    .isNotEmpty,
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 10.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: MenuBuilderColors
                                                          .kLightGrey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children:
                                                        dishAvailabilityEntries
                                                            .map((entry) {
                                                      return Text(
                                                        "${formatTimeOfDay(entry.$1!)} to ${formatTimeOfDay(entry.$2!)}",
                                                        style: textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color: Colors
                                                              .grey.shade500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              );
                                            })
                                          ],
                                        )
                                      else
                                        ...controller.availableDays.map((day) {
                                          return Column(
                                            children: <Widget>[
                                              _buildExpansionTileContainer(
                                                context,
                                                icon: FluentIcons
                                                    .calendar_24_regular,
                                                title:
                                                    capitalizeFirstLetter(day),
                                                children: controller
                                                    .dishAvailabilityEntries
                                                    .where((entry) =>
                                                        entry.$1 != null &&
                                                        entry.$2 != null)
                                                    .map((entry) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 4.0,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${formatTimeOfDay(entry.$1!)} to ${formatTimeOfDay(entry.$2!)}",
                                                        style: textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              verticalSpaceSmall,
                                            ],
                                          );
                                        }).toList(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void showCustomDialog({
    required BuildContext context,
    required String barrierLabel,
    required Offset position,
    required Widget child,
  }) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      barrierLabel: barrierLabel,
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            Positioned(
              top: position.dy,
              right: position.dx + 20,
              child: child,
            ),
          ],
        );
      },
    );
  }

  Widget _buildExpansionTileContainer(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
    EdgeInsets? childrenPadding,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        dense: true,
        initiallyExpanded: false,
        leading: Icon(icon, size: 20),
        childrenPadding: childrenPadding ??
            const EdgeInsets.symmetric(
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
}

class CustomRadioCheckboxGroup extends StatelessWidget {
  final String title1;
  final String title2;
  final List<String> options1;
  final List<String> options2;
  final String groupValue;
  final List<bool> checkboxValues;
  final void Function(String?) onChangedRadio;
  final void Function(int, bool?) onChangedCheckbox;

  const CustomRadioCheckboxGroup({
    required this.title1,
    required this.title2,
    required this.options1,
    required this.options2,
    Key? key,
    required this.onChangedRadio,
    required this.groupValue,
    required this.checkboxValues,
    required this.onChangedCheckbox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomOptionGroup(
            title: title1,
            options: options1,
            isRadio: true,
            groupValue: groupValue,
            onChangedRadio: onChangedRadio,
          ),
        ),
        Expanded(
          child: CustomOptionGroup(
            title: title2,
            options: options2,
            isRadio: false,
            values: checkboxValues,
            onChangedCheckbox: onChangedCheckbox,
          ),
        ),
      ],
    );
  }
}

class CustomOptionGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? groupValue;
  final List<bool> values;
  final bool isRadio;
  final void Function(String?)? onChangedRadio;
  final void Function(int, bool?)? onChangedCheckbox;

  const CustomOptionGroup({
    required this.title,
    required this.options,
    required this.isRadio,
    Key? key,
    this.groupValue,
    this.values = const [false, false],
    this.onChangedRadio,
    this.onChangedCheckbox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Text(
            title,
            style: textTheme.titleSmall!.copyWith(color: Colors.grey.shade700),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: options
              .map((option) => Expanded(
                    child: ListTileTheme(
                      child: isRadio
                          ? RadioListTile(
                              value: option,
                              groupValue: groupValue,
                              onChanged: onChangedRadio,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                capitalizeFirstLetter(option),
                                style: textTheme.bodyMedium,
                              ),
                            )
                          : CheckboxListTile(
                              value: values[options.indexOf(option)],
                              onChanged: onChangedCheckbox != null
                                  ? (value) => onChangedCheckbox!(
                                      options.indexOf(option), value)
                                  : null,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                capitalizeFirstLetter(option),
                                style: textTheme.bodyMedium,
                              ),
                            ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class FoodModifiersDetailsWidget extends StatelessWidget {
  const FoodModifiersDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            width: double.infinity,
            color: MenuBuilderColors.kWhite2,
            child: Center(
              child: Text(
                "Drinks",
                style: textTheme.titleMedium,
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Text(
              "Pepsi Full",
              style: textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            trailing: Text(
              "₹10.00",
              style: textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            title: Text(
              "Pepsi Full",
              style: textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            trailing: Text(
              "₹10.00",
              style: textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BuildMasterModifiersWidget extends StatelessWidget {
  const _BuildMasterModifiersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<DishesController>();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            color: MenuBuilderColors.kWhite2,
            child: Center(
              child: Text(
                "Master Addons",
                style: textTheme.titleMedium,
              ),
            ),
          ),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 0.0,
              children: controller.listOfMasterAddons.map((addon) {
                final backgroundColor = MenuBuilderColors.kGrey.withOpacity(
                  0.1,
                );
                if (addon.title == null || addon.id == null) {
                  return const SizedBox.shrink();
                }
                return FilterChip(
                  label: Text(addon.title ?? ""),
                  selected: controller.choosedMasterAddons.contains(addon),
                  selectedColor: backgroundColor,
                  backgroundColor: backgroundColor,
                  labelStyle: textTheme.titleSmall!.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  color: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return backgroundColor;
                    }
                    return null;
                  }),
                  checkmarkColor: Colors.grey.shade600,
                  onSelected: (_) => controller.onChooseMasterAddons(addon),
                );
              }).toList(),
            ),
          ),
          verticalSpaceRegular,
        ],
      ),
    );
  }
}
