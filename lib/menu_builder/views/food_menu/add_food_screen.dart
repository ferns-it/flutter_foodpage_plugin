import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_theme.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';

import '../../core/constants/menu_builder_app_colors.dart';
import '../../widgets/custom_rounded_textfield.dart';

class AddFoodScreen extends StatelessWidget {
  const AddFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    final bottom = mq.viewInsets.bottom;
    return Theme(
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
        return Scaffold(
          appBar: AppBar(title: const Text("Add Food Item")),
          endDrawer: Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: size.height - bottom,
              child: Drawer(
                width: size.width * 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 24.0,
                  ),
                  child: ListView(
                    children: const <Widget>[
                      FoodVariationItem(),
                      verticalSpaceSmall,
                      FoodVariationItem(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          child: Padding(
                            padding: defaultCardPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Basic Information",
                                  style: textTheme.titleMedium,
                                ),
                                verticalSpaceMedium,
                                CustomRoundedTextField.topText(
                                  hintText: "Enter dish name",
                                  topText: "Dish name",
                                  borderRadius: BorderRadius.circular(8.0),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                                verticalSpaceRegular,
                                CustomRoundedTextField.topText(
                                  hintText: "Short note about dish..",
                                  topText: "Description",
                                  borderRadius: BorderRadius.circular(8.0),
                                  maxLines: 2,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                ),
                                verticalSpaceMedium,
                                const CustomRadioCheckboxGroup(
                                  title1: "Veg/Non Veg",
                                  title2: "Available On",
                                  options1: ["Veg", "Non Veg"],
                                  options2: ["Online", "Dine In"],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Card(child: Column(children: <Widget>[])),
                      ),
                    ],
                  ),
                ),
                verticalSpaceTiny,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: defaultCardPadding,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Food Variations",
                                      style: textTheme.titleMedium,
                                    ),
                                    Builder(builder: (context) {
                                      return OutlinedButton.icon(
                                        onPressed: () {
                                          Scaffold.of(context).openEndDrawer();
                                        },
                                        icon: const Icon(
                                          FluentIcons.add_24_filled,
                                        ),
                                        label: const Text("Add Variation"),
                                        style: OutlinedButton.styleFrom(
                                          textStyle: textTheme.titleMedium,
                                          foregroundColor:
                                              MenuBuilderColors.kBlue,
                                          backgroundColor: MenuBuilderColors
                                              .kBlue
                                              .withOpacity(0.1),
                                          elevation: 0,
                                          side: BorderSide(
                                            width: 0.8,
                                            color: MenuBuilderColors.kBlue
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                                verticalSpaceRegular,
                                const FoodVariationItem(),
                                verticalSpaceRegular,
                                const FoodVariationItem()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: defaultCardPadding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Category",
                                        style: textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          verticalSpaceRegular,
                          SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Padding(
                                padding: defaultCardPadding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Category",
                                        style: textTheme.titleMedium),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomRadioCheckboxGroup extends StatelessWidget {
  final String title1;
  final String title2;
  final List<String> options1;
  final List<String> options2;

  const CustomRadioCheckboxGroup({
    required this.title1,
    required this.title2,
    required this.options1,
    required this.options2,
    Key? key,
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
          ),
        ),
        Expanded(
          child: CustomOptionGroup(
            title: title2,
            options: options2,
            isRadio: false,
          ),
        ),
      ],
    );
  }
}

class CustomOptionGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final bool isRadio;

  const CustomOptionGroup({
    required this.title,
    required this.options,
    required this.isRadio,
    Key? key,
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
                              groupValue: options.first,
                              onChanged: (_) {},
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                option,
                                style: textTheme.bodyMedium,
                              ),
                            )
                          : CheckboxListTile(
                              value: true,
                              onChanged: (_) {},
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                option,
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

class FoodVariationItem extends StatelessWidget {
  const FoodVariationItem({super.key});

  @override
  Widget build(BuildContext context) {
    const defaultCardPadding = EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 18.0,
    );
    final textTheme = Theme.of(context).textTheme;

    return Padding(
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
    );
  }
}
