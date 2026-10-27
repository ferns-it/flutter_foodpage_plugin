// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/input_formatters.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/validators/menu_builder_validators.dart';
import 'package:flutter_foodpage_plugin/menu_builder/widgets/custom_rounded_textfield.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_initialise_data_model.dart';
import '../../core/constants/menu_builder_app_colors.dart';
import '../../core/utils/ui_utils.dart';
import '../widgets/build_dropdown_base.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  void resetTableViewController() {
    final controller = context.read<DishesController>();
    final categoryController = context.read<DishCategoryController>();
    final listOfCategories = controller.listOfCategories
        .where((category) => category.cID != null)
        .map((category) {
      final children = category.childrens
          .where((child) => child.cID != null)
          .map((child) => Node(
                key: child.cID!,
                label: capitalizeFirstLetter(child.name ?? ""),
              ))
          .toList();

      return Node(
        key: category.cID!,
        label: capitalizeFirstLetter(category.name ?? ""),
        children: children,
      );
    }).toList();

    categoryController.updateTreeViewController(TreeViewController(
      children: listOfCategories,
      selectedKey: null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        resetTableViewController();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
          bottom: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Manage Category", style: textTheme.titleLarge),
            verticalSpaceTiny,
            Text(
              "Add and remove new categories",
              style: textTheme.bodyMedium!.copyWith(
                color: MenuBuilderColors.kGrey2,
              ),
            ),
            verticalSpaceMedium,
            const Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(flex: 2, child: _CategoryTreeViewWidget()),
                  Spacer(),
                  Flexible(
                    flex: 3,
                    child: _BuildAddUpdateCategorySection(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTreeViewWidget extends StatefulWidget {
  const _CategoryTreeViewWidget();

  @override
  State<_CategoryTreeViewWidget> createState() =>
      _CategoryTreeViewWidgetState();
}

class _CategoryTreeViewWidgetState extends State<_CategoryTreeViewWidget> {
 final Set<String> _expandedCategoryIds = {};
 


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final categoryController = context.watch<DishCategoryController>();
    final controller = context.watch<DishesController>();
    final categories = controller.listOfCategories
        .where((category) => category.cID != null)
        .toList();

    final selectedCId = categoryController.selectedCategory?.cID;

     return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Categories",
                  style: textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: categoryController.selectedCategory != null
                      ? () {
                          categoryController.resetSelectedCategory();
                        }
                      : null,
                  style: TextButton.styleFrom(
                    foregroundColor: MenuBuilderColors.kPrimaryColor,
                    disabledForegroundColor: Colors.grey.shade500,
                  ),
                  child: const Text("DESELECT"),
                ),
              ],
            ),
            Text(
              "Tap a category to expand its subcategories.",
              style: textTheme.bodySmall,
            ),
            const Divider(),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: categories.map((category) {
                  return _buildCategoryTile(
                    category: category,
                    level: 0,
                    selectedCId: selectedCId,
                    categoryController: categoryController,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );}
     Widget _buildCategoryTile({
    required CategoryData category,
    required int level,
    required String? selectedCId,
    required DishCategoryController categoryController,
  }) {
    final categoryId = category.cID;

    if (categoryId == null) {
      return const SizedBox.shrink();
    }

    final children =
        category.childrens.where((child) => child.cID != null).toList();

    final hasChildren = children.isNotEmpty;
    final isExpanded = _expandedCategoryIds.contains(categoryId);
    final isSelected = selectedCId == categoryId;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          key: ValueKey('category_$categoryId'),
          contentPadding: EdgeInsets.only(
            left: level * 20.0,
            right: 4,
          ),
          tileColor:
              category.categoryStatus != "Active" ? Colors.grey.shade100 : null,
          selected: isSelected,
          selectedTileColor: MenuBuilderColors.kAccentOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          visualDensity: const VisualDensity(
            horizontal: 0,
            vertical: -2,
          ),

          // Expand/collapse icon
          leading: hasChildren
              ? IconButton(
                  tooltip: isExpanded
                      ? 'Collapse subcategories'
                      : 'Expand subcategories',
                  icon: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isExpanded) {
                        _expandedCategoryIds.remove(categoryId);
                      } else {
                        _expandedCategoryIds.add(categoryId);
                      }
                    });
                  },
                )
              : const SizedBox(width: 48),

          // Select the category when tapping its name
          title: Text(category.name ?? "Unknown"),
          onTap: () {
            categoryController.onPressCategory(category);

            if (hasChildren) {
              setState(() {
                if (isExpanded) {
                  _expandedCategoryIds.remove(categoryId);
                } else {
                  _expandedCategoryIds.add(categoryId);
                }
              });
            }
          },
        ),

        // Recursively display children only when expanded
        if (hasChildren && isExpanded)
          ...children.map(
            (child) => _buildCategoryTile(
              category: child,
              level: level + 1,
              selectedCId: selectedCId,
              categoryController: categoryController,
            ),
          ),
      ],
    );
  }
}
              
class _BuildAddUpdateCategorySection extends StatefulWidget {
  const _BuildAddUpdateCategorySection({Key? key}) : super(key: key);

  @override
  State<_BuildAddUpdateCategorySection> createState() =>
      _BuildAddUpdateCategorySectionState();
}

class _BuildAddUpdateCategorySectionState
    extends State<_BuildAddUpdateCategorySection> {
  
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final controller = context.watch<DishCategoryController>();
    final dishController = context.watch<DishesController>();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (controller.editMode) ...[
                      InkWell(
                        onTap: () {
                          controller.resetSelectedCategory();
                          controller.clearCategoryForm();
                        },
                        child: const BackButtonIcon(),
                      ),
                      horizontalSpaceSmall,
                    ],
                    Text(
                      !controller.editMode ? "Add Category" : "Update Category",
                      style: textTheme.titleMedium,
                    ),
                    if (controller.selectedCategory != null) ...[
                      const Spacer(),
                      !controller.categoryStatusLoading
                          ? OutlinedButton.icon(
                              label: const Text("Active"),
                              style: OutlinedButton.styleFrom(
                                textStyle: textTheme.titleMedium,
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              onPressed: () {
                                controller.disableEnableCategory(
                                    onRequestRefresh: () async {
                                  final dishCategoryController =
                                      context.read<DishCategoryController>();
                                  await dishController
                                      .initializeAddDishRequiredData();

                                  final category = dishController
                                      .listOfCategories
                                      .firstWhere(
                                    (category) =>
                                        category.cID ==
                                        dishCategoryController
                                            .selectedCategory?.cID,
                                  );

                                  dishCategoryController
                                      .onPressCategory(category);
                                });
                              },
                              icon: controller
                                          .selectedCategory!.categoryStatus !=
                                      "Active"
                                  ? const Icon(
                                      Icons.close,
                                      color: MenuBuilderColors.kMaterialRed,
                                    )
                                  : const Icon(
                                      Icons.check,
                                      color: MenuBuilderColors.kSuccessGreen2,
                                    ),
                            )
                          : const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                    ]
                  ],
                ),
                if (controller.isLoading) ...[
                  verticalSpaceRegular,
                  const LinearProgressIndicator(minHeight: 3.0),
                  verticalSpaceSmall,
                ] else
                  const Divider(height: 40.0),
                if (!controller.editMode) ...[
                  Text(
                    "Choose Type",
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RadioListTile(
                          value: CategoryType.parent,
                          groupValue: controller.addCategoryType,
                          onChanged: controller.onChangeCategoryType,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Parent"),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: CategoryType.child,
                          groupValue: controller.addCategoryType,
                          onChanged: controller.onChangeCategoryType,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text("Child"),
                        ),
                      ),
                    ],
                  ),
                  if (controller.addCategoryType == CategoryType.child) ...[
                    verticalSpaceRegular,
                    BuildDropdownBase(
                      height: 50,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String?>(
                          items: dishController.listOfCategories
                              .map<DropdownMenuItem<String?>>((category) {
                            return DropdownMenuItem<String?>(
                              value: category.cID,
                              child: Text(
                                category.name ?? "",
                                maxLines: 1,
                                softWrap: false,
                              ),
                            );
                          }).toList(),
                          onChanged: controller.onChangeSelectedCategoryId,
                          value: controller.selectedCategoryId,
                          isExpanded: true,
                          isDense: true,
                          hint: Text(
                            "Select Category",
                            style: textTheme.titleMedium!.copyWith(
                              color: MenuBuilderColors.kGrey2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  verticalSpaceRegular,
                ],
                CustomRoundedTextField.topText(
                  hintText: "Enter Category",
                  topText: "Category Name",
                  borderRadius: BorderRadius.circular(8.0),
                  textInputAction: TextInputAction.done,
                  validator: MenuBuilderValidators.validateCategoryName,
                  textEditingController: controller.nameController,
                  autovalidateMode: AutovalidateMode.disabled,
                  inputFormatters: const <TextInputFormatter>[
                    NoEmojiTextInputFormatter(),
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
                  textEditingController: controller.descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: const <TextInputFormatter>[
                    NoEmojiTextInputFormatter(),
                  ],
                ),
                verticalSpaceRegular,
                OutlinedButton(
                  onPressed: !controller.isLoading
                      ? () {
                          if (controller.editMode) {
                            controller.updateCategory(
                                onRequestRefresh: () async {
                              await dishController
                                  .initializeAddDishRequiredData();
                            });
                            return;
                          }
                          controller.addNewCategory(onRequestRefresh: () async {
                            await dishController
                                .initializeAddDishRequiredData();
                          });
                        }
                      : null,
                  style: OutlinedButton.styleFrom(
                    textStyle: textTheme.titleMedium,
                    foregroundColor: MenuBuilderColors.kBlue,
                    backgroundColor: MenuBuilderColors.kBlue.withOpacity(0.1),
                    elevation: 0,
                    side: BorderSide(
                      width: 0.8,
                      color: MenuBuilderColors.kBlue.withOpacity(0.3),
                    ),
                  ),
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
