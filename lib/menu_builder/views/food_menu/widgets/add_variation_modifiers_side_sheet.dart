import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/google_ai/gemini_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/validators/menu_builder_validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/menu_builder_app_colors.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../widgets/custom_rounded_textfield.dart';
import 'build_allergens_widget.dart';

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
              side: const BorderSide(width: 1, color: MenuBuilderColors.kBlue),
            ),
          ),
          verticalSpaceSmall,
          Expanded(
            child: Form(
              key: controller.variationFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
    final geminiController = context.watch<GeminiController>();

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
                      color: MenuBuilderColors.kBlue.withOpacity(0.1),
                    ),
                    child: const Icon(
                      FluentIcons.copy_24_regular,
                      color: MenuBuilderColors.kBlue,
                      size: 22,
                    ),
                  ),
                ),
                if (controller.variationsFormEntries.length > 1) ...[
                  horizontalSpaceRegular,
                  InkWell(
                    onTap: () {
                      controller.removeVariationFormEntry(index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            MenuBuilderColors.kPrimaryColor.withOpacity(0.1),
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
                Expanded(
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
              suffixIcon: geminiController.dishIngredientsGenerating
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
                  : IconButton(
                      onPressed: () async {
                        final name = entry["name"].text;
                        if (name.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Dish Name cannot be empty!");
                          return;
                        }
                        final generatedContent = await geminiController
                            .generateDishIngredients(name);
                        if (generatedContent != null) {
                          entry["ingredients"].text = generatedContent;
                        }
                      },
                      icon: const Icon(FluentIcons.sparkle_24_regular),
                    ),
            ),
            verticalSpaceRegular,
            BuildAllergensWidget(index: index),
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
