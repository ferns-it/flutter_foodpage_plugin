// ignore_for_file: unused_field

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_category_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/validators/menu_builder_validators.dart';
import 'package:flutter_foodpage_plugin/menu_builder/widgets/custom_rounded_textfield.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeTableViewController();
    });
  }

  void initializeTableViewController() {
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
    final categoryController = context.watch<DishCategoryController>();
    final controller = context.watch<DishesController>();
    final listOfCategories = controller.listOfCategories;

    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("All Categories", style: textTheme.titleMedium),
                  horizontalSpaceSmall,
                  TextButton(
                    onPressed: () async {
                      final controller = context.read<DishCategoryController>();
                      controller.resetSelectedCategory();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: MenuBuilderColors.kPrimaryColor,
                    ),
                    child: const Text("DESELECT"),
                  )
                ],
              ),
              const Divider(),
              Flexible(
                child: ReorderableListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final category = listOfCategories.elementAt(index);
                      final selectedCId =
                          categoryController.selectedCategory?.cID;
                      return ListTile(
                        key: ValueKey(category.cID),
                        title: Text(category.name ?? "Unknown"),
                        onTap: () =>
                            categoryController.onPressCategory(category),
                        selectedTileColor: MenuBuilderColors.kAccentOrange,
                        selected:
                            selectedCId != null && selectedCId == category.cID,
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      );
                    },
                    itemCount: listOfCategories.length,
                    onReorder: (int oldIndex, int newIndex) {
                      return context
                          .read<DishCategoryController>()
                          .reOrderCategory(context, oldIndex, newIndex);
                    }),
              )
              // Flexible(
              //   child: TreeView(
              //     shrinkWrap: true,
              //     controller: treeViewController,
              //     allowParentSelect: true,
              //     supportParentDoubleTap: false,
              //     onExpansionChanged: (key, expanded) =>
              //         _expandNode(key, expanded),
              //     onNodeTap: (key) {
              //       final controller = context.read<DishCategoryController>();
              //       final dishController = context.read<DishesController>();
              //       var category =
              //           dishController.listOfCategories.firstWhereOrNull((x) {
              //         return x.cID == key;
              //       });
              //
              //       category ??=
              //           dishController.childCategories.firstWhereOrNull((x) {
              //         return x.cID == key;
              //       });
              //
              //       if (category == null) {
              //         log("Category not found in the list",
              //             name: "Category Selection");
              //         return;
              //       }
              //
              //       controller.onPressCategory(category);
              //       controller.updateTreeViewController(
              //         treeViewController.copyWith(selectedKey: key),
              //       );
              //     },
              //     theme: TreeViewTheme(
              //       expanderTheme: const ExpanderThemeData(
              //         animated: true,
              //         modifier: ExpanderModifier.none,
              //         type: ExpanderType.chevron,
              //         size: 20,
              //       ),
              //       parentLabelStyle: textTheme.titleMedium!,
              //       labelStyle: textTheme.titleMedium!,
              //       colorScheme: Theme.of(context).colorScheme.copyWith(
              //           primary: MenuBuilderColors.kAccentOrange,
              //           onPrimary: MenuBuilderColors.kOrange),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }

  void _expandNode(String key, bool expanded) {
    final categoryController = context.read<DishCategoryController>();
    final treeViewController = categoryController.treeViewController;
    if (treeViewController == null) return;
    Node<dynamic>? node = treeViewController.getNode(key);
    if (node != null) {
      List<Node> updated = treeViewController.updateNode(
        key,
        node.copyWith(expanded: expanded),
      );
      categoryController.updateTreeViewController(
        treeViewController.copyWith(children: updated),
      );
    }
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
  void initializeTableViewController() {
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      !controller.editMode ? "Add Category" : "Update Category",
                      style: textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Visibility(
                      visible: controller.editMode,
                      child: InkWell(
                        onTap: () {
                          controller.disableEnableCategory(
                              onRequestRefresh: () async {
                            await dishController
                                .initializeAddDishRequiredData();
                            initializeTableViewController();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MenuBuilderColors.kPrimaryColor
                                .withOpacity(0.25),
                          ),
                          child: const Icon(
                            Icons.close,
                            color: MenuBuilderColors.kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                ),
                verticalSpaceRegular,
                OutlinedButton(
                  onPressed: () {
                    if (controller.editMode) {
                      controller.updateCategory(onRequestRefresh: () async {
                        await dishController.initializeAddDishRequiredData();
                        initializeTableViewController();
                      });
                      return;
                    }
                    controller.addNewCategory(onRequestRefresh: () async {
                      await dishController.initializeAddDishRequiredData();
                      initializeTableViewController();
                    });
                  },
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
                  child: Text(
                    !controller.editMode ? "Add Category" : "Update Category",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
