import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/validators/menu_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/menu_builder_app_colors.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../widgets/custom_rounded_textfield.dart';

class AddVariationModifiersSideSheet extends StatefulWidget {
  const AddVariationModifiersSideSheet({super.key, this.index = 0});

  final int index;

  @override
  State<AddVariationModifiersSideSheet> createState() =>
      _AddVariationModifiersSideSheetState();
}

class _AddVariationModifiersSideSheetState
    extends State<AddVariationModifiersSideSheet>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.animateTo(widget.index);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<DishesController>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 24.0,
      ),
      child: Column(
        children: <Widget>[
          OutlinedButton.icon(
            onPressed: () => controller.addNewVariationFormEntry(),
            icon: const Icon(
              FluentIcons.add_24_filled,
            ),
            label: const Text("Add Variation"),
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
          ),
          verticalSpaceSmall,
          Expanded(
            child: Form(
              key: controller.variationFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MenuBuilderColors.kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(8.0)),
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(FluentIcons.info_24_regular),
                        horizontalSpaceSmall,
                        Flexible(
                          child: Text(
                            "For a single variation dish, it is not required to enter the dish name. For multiple variations, it is required to enter the dish name. For example, Full and Half for biryani.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade700),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: controller.variationsFormEntries.length,
                      itemBuilder: (context, index) {
                        final entry = controller.variationsFormEntries[index];
                        return FoodVariationItem(index: index, entry: entry);
                      },
                      separatorBuilder: (_, __) {
                        return verticalSpaceSmall;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FoodVariationItem extends StatelessWidget {
  const FoodVariationItem(
      {super.key, required this.entry, required this.index});

  final int index;
  final Map<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    const defaultCardPadding = EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 18.0,
    );
    final textTheme = Theme.of(context).textTheme;

    final controller = context.watch<DishesController>();

    return Card(
      child: Padding(
        padding: defaultCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Variation ${index + 1}", style: textTheme.titleMedium),
                const Spacer(),
                InkWell(
                  onTap: () => controller.duplicateVariationFormEntry(index),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: MenuBuilderColors.kBlue.withOpacity(0.25),
                    ),
                    child: const Icon(
                      FluentIcons.copy_24_regular,
                      color: MenuBuilderColors.kBlue,
                      size: 22,
                    ),
                  ),
                ),
                if (index != 0) ...[
                  horizontalSpaceRegular,
                  InkWell(
                    onTap: () {
                      if (index == 0) return;
                      controller.removeVariationFormEntry(index);
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
                        size: 22,
                      ),
                    ),
                  ),
                ]
              ],
            ),
            const Divider(),
            verticalSpaceSmall,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                controller.variationsFormEntries.length != 1
                    ? Expanded(
                        child: CustomRoundedTextField.topText(
                          topText: "Dish name",
                          hintText: "Enter dish name",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validator: MenuBuilderValidators.validateDishName,
                          textEditingController:
                              entry["name"] as TextEditingController,
                        ),
                      )
                    : Expanded(
                        child: CustomRoundedTextField.topText(
                          topText: "Dish name",
                          hintText: "Enter dish name",
                          textEditingController: TextEditingController()
                            ..text = "Single Variation",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          readOnly: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                horizontalSpaceRegular,
                Expanded(
                  child: CustomRoundedTextField.topText(
                    topText: "Dish price",
                    hintText: "Enter dish price",
                    borderRadius: BorderRadius.circular(8.0),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: MenuBuilderValidators.validatePrice,
                    textEditingController:
                        entry["price"] as TextEditingController,
                  ),
                ),
              ],
            ),
            verticalSpaceRegular,
            CustomRoundedTextField.topText(
              topText: "Ingredients",
              hintText: "Short note about dish ingredients..",
              borderRadius: BorderRadius.circular(8.0),
              maxLines: 2,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              textEditingController:
                  entry["ingredients"] as TextEditingController,
            ),
            verticalSpaceRegular,
            _BuildAllergensWidget(index: index),
            verticalSpaceRegular,
          ],
        ),
      ),
    );
  }
}

class AddModifiersFormWidget extends StatelessWidget {
  const AddModifiersFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Modifier 1",
                style: textTheme.titleMedium,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_forever,
                  color: MenuBuilderColors.kPrimaryColor,
                  size: 22,
                ),
              )
            ],
          ),
          dense: true,
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.all(20.0),
          children: <Widget>[
            CustomRoundedTextField.topText(
              topText: "Group name",
              hintText: "Eg Drinks, Salads..",
              borderRadius: BorderRadius.circular(8.0),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            verticalSpaceTiny,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ).copyWith(bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Modifier Options",
                        style: textTheme.titleMedium,
                      ),
                      IconButton(
                        onPressed: () {},
                        color: Theme.of(context).primaryColor,
                        icon: const Icon(Icons.add, size: 28),
                      )
                    ],
                  ),
                  verticalSpaceSmall,
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: CustomRoundedTextField.topText(
                          topText: "Option name",
                          hintText: "Eg Pepsi, Coca-Cola",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          fillColor: MenuBuilderColors.kWhite,
                        ),
                      ),
                      horizontalSpaceRegular,
                      Expanded(
                        flex: 2,
                        child: CustomRoundedTextField.topText(
                          topText: "Price",
                          hintText: "£0.00",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          fillColor: MenuBuilderColors.kWhite,
                        ),
                      ),
                      horizontalSpaceRegular,
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(top: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              MenuBuilderColors.kPrimaryColor.withOpacity(0.25),
                        ),
                        child: const Icon(
                          Icons.delete_forever,
                          color: MenuBuilderColors.kPrimaryColor,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: CustomRoundedTextField.topText(
                          topText: "Option name",
                          hintText: "Eg Pepsi, Coca-Cola",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          fillColor: MenuBuilderColors.kWhite,
                        ),
                      ),
                      horizontalSpaceRegular,
                      Expanded(
                        flex: 2,
                        child: CustomRoundedTextField.topText(
                          topText: "Price",
                          hintText: "£0.00",
                          borderRadius: BorderRadius.circular(8.0),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          fillColor: MenuBuilderColors.kWhite,
                        ),
                      ),
                      horizontalSpaceRegular,
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(top: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              MenuBuilderColors.kPrimaryColor.withOpacity(0.25),
                        ),
                        child: const Icon(
                          Icons.delete_forever,
                          color: MenuBuilderColors.kPrimaryColor,
                          size: 22,
                        ),
                      )
                    ],
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

class _BuildAllergensWidget extends StatelessWidget {
  const _BuildAllergensWidget({Key? key, required this.index})
      : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final controller = context.watch<DishesController>();

    final addDishInitializeData = controller.addDishInitializeData;

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
                "Allergens",
                style: textTheme.titleMedium,
              ),
            ),
          ),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: addDishInitializeData!.allergens.data
                    .where((allergen) => allergen.name != null)
                    .map((allergen) {
                  final backgroundColor =
                      MenuBuilderColors.kGrey.withOpacity(0.1);
                  final entry = controller.variationsFormEntries[index];
                  final allergens = entry["allergens"] as List;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: FilterChip(
                      label: Text(allergen.name!),
                      selected: allergen.id != null &&
                          allergens.contains(allergen.id),
                      selectedColor: backgroundColor,
                      backgroundColor: backgroundColor,
                      labelStyle: textTheme.titleSmall!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                      checkmarkColor: Colors.grey.shade600,
                      onSelected: (_) => controller.onChangeAllergensSelection(
                          index, allergen.id),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          verticalSpaceRegular,
        ],
      ),
    );
  }
}
