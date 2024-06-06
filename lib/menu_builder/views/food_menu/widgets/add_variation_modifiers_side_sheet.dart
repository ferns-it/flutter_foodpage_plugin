import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/menu_builder_app_colors.dart';
import '../../../core/utils/ui_utils.dart';
import '../../../widgets/custom_rounded_textfield.dart';

class AddVariationModifiersSideSheet extends StatelessWidget {
  const AddVariationModifiersSideSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 24.0,
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
              tabs: [
                Tab(text: "Variations".toUpperCase()),
                Tab(text: "Modifiers/Addons".toUpperCase()),
              ],
            ),
            Expanded(
              child: TabBarView(children: [
                Column(
                  children: <Widget>[
                    verticalSpaceRegular,
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        FluentIcons.add_24_filled,
                      ),
                      label: const Text("Add Variation"),
                      style: OutlinedButton.styleFrom(
                        textStyle: textTheme.titleMedium,
                        foregroundColor: MenuBuilderColors.kBlue,
                        backgroundColor:
                            MenuBuilderColors.kBlue.withOpacity(0.1),
                        elevation: 0,
                        side: BorderSide(
                          width: 0.8,
                          color: MenuBuilderColors.kBlue.withOpacity(0.3),
                        ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: const <Widget>[
                          FoodVariationItem(),
                          verticalSpaceSmall,
                          FoodVariationItem(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Column(
                  children: <Widget>[
                    verticalSpaceMedium,
                    AddModifiersFormWidget(),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class FoodVariationItem extends StatelessWidget {
  const FoodVariationItem({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultCardPadding = EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 18.0,
    );
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: defaultCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Variation", style: textTheme.titleMedium),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MenuBuilderColors.kPrimaryColor.withOpacity(0.25),
                  ),
                  child: const Icon(
                    Icons.delete_forever,
                    color: MenuBuilderColors.kPrimaryColor,
                    size: 22,
                  ),
                ),
              ],
            ),
            const Divider(),
            verticalSpaceSmall,
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomRoundedTextField.topText(
                    topText: "Dish name",
                    hintText: "Enter dish name",
                    borderRadius: BorderRadius.circular(8.0),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                horizontalSpaceRegular,
                Expanded(
                  child: CustomRoundedTextField.topText(
                    topText: "Dish price",
                    hintText: "Enter dish price",
                    borderRadius: BorderRadius.circular(8.0),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
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
            ),
            verticalSpaceRegular,
            CustomRoundedTextField.topText(
              topText: "Dish Allergens",
              hintText: "Enter Dish Allergens",
              borderRadius: BorderRadius.circular(8.0),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
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
