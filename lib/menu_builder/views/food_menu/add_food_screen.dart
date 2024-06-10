import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_theme.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/food_menu/widgets/add_variation_modifiers_side_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                width: size.width * 0.5, // size.width * 0.5
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: const AddVariationModifiersSideSheet(),
              ),
            ),
          ),
          body: Padding(
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
                              verticalSpaceMedium,
                              _BuildAllergensWidget()
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: defaultCardPadding,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    }),
                                  ],
                                ),
                                const Divider(),
                                verticalSpaceRegular,
                                SizedBox(
                                  height: mq.size.height * 0.3,
                                  child: AlignedGridView.count(
                                    crossAxisCount: 2,
                                    itemCount: 3,
                                    mainAxisSpacing: 14.0,
                                    crossAxisSpacing: 14.0,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        title: const Text(
                                          "Chicken Biriyani 1/2",
                                        ),
                                        subtitle: Text(
                                          "£100.00",
                                          style: textTheme.bodyLarge!.copyWith(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
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
                                      "Choices & Addons",
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
                                        label: const Text("Add Modifier"),
                                        style: OutlinedButton.styleFrom(
                                          textStyle: textTheme.titleMedium,
                                          foregroundColor:
                                              MenuBuilderColors.kOrange2,
                                          backgroundColor: MenuBuilderColors
                                              .kOrange2
                                              .withOpacity(0.1),
                                          elevation: 0,
                                          side: BorderSide(
                                            width: 0.8,
                                            color: MenuBuilderColors.kOrange2
                                                .withOpacity(0.3),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                                const Divider(),
                                verticalSpaceRegular,
                                AlignedGridView.count(
                                  crossAxisCount: 3,
                                  itemCount: 4,
                                  mainAxisSpacing: 14.0,
                                  crossAxisSpacing: 14.0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return const FoodModifiersDetailsWidget();
                                  },
                                ),
                                verticalSpaceRegular,
                                const Divider(),
                                const _BuildMasterModifiersWidget()
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Availability",
                                        style: textTheme.titleMedium,
                                      ),
                                      Icon(
                                        FluentIcons.edit_20_regular,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceMedium,
                                  _buildExpansionTileContainer(
                                    context,
                                    icon: FluentIcons.calendar_24_regular,
                                    title: "Sunday",
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "10:00 AM to 07:30 PM",
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      verticalSpaceVerySmall,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "10:00 AM to 07:30 PM",
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  _buildExpansionTileContainer(
                                    context,
                                    icon: FluentIcons.calendar_24_regular,
                                    title: "Monday",
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "10:00 AM to 07:30 PM",
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      verticalSpaceVerySmall,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "10:00 AM to 07:30 PM",
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  _buildExpansionTileContainer(
                                    context,
                                    icon: FluentIcons.calendar_24_regular,
                                    title: "Tuesday",
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "10:00 AM to 07:30 PM",
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      verticalSpaceVerySmall,
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "10:00 AM to 07:30 PM",
                                          style: textTheme.bodyMedium!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ),
                                      verticalSpaceTiny,
                                    ],
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Categories",
                                        style: textTheme.titleMedium,
                                      ),
                                      Icon(
                                        FluentIcons.add_20_filled,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Chip(
                                    onDeleted: () {},
                                    backgroundColor: MenuBuilderColors.kPurple
                                        .withOpacity(0.1),
                                    side: BorderSide.none,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    label: const Text("Drinks"),
                                    labelStyle: textTheme.bodyLarge!.copyWith(
                                      color: MenuBuilderColors.kPurple,
                                    ),
                                    deleteIcon:
                                        const Icon(Icons.close, size: 20),
                                    deleteIconColor: MenuBuilderColors.kPurple,
                                    // selected: true,
                                    // selectedColor: AppColors.backgroundColor,
                                  ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Menus",
                                        style: textTheme.titleMedium,
                                      ),
                                      Icon(
                                        FluentIcons.add_20_filled,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  Chip(
                                    backgroundColor: MenuBuilderColors.kOrange
                                        .withOpacity(0.1),
                                    side: BorderSide.none,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                    ),
                                    label: const Text("Default"),
                                    labelStyle: textTheme.bodyLarge!.copyWith(
                                      color: MenuBuilderColors.kOrange,
                                    ),
                                  ),
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
        );
      }),
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

class _BuildAllergensWidget extends StatelessWidget {
  _BuildAllergensWidget({Key? key}) : super(key: key);

  final List<String> foodAllergens = [
    "Milk",
    "Eggs",
    "Fish",
    "Crustacean shellfish",
    "Tree nuts",
    "Peanuts",
    "Wheat",
    "Soybeans",
    "Sesame",
    "Mustard",
    "Celery",
    "Sulphur dioxide and sulphites",
    "Lupin",
    "Molluscs"
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
            child: Wrap(
              spacing: 8.0,
              runSpacing: 0.0,
              children: foodAllergens.map((item) {
                final backgroundColor =
                    MenuBuilderColors.kPrimaryColor.withOpacity(
                  0.1,
                );
                return FilterChip(
                  label: Text(item),
                  selected: false,
                  selectedColor: backgroundColor,
                  backgroundColor: backgroundColor,
                  labelStyle: textTheme.titleSmall!.copyWith(
                    color: MenuBuilderColors.kPrimaryColor,
                  ),
                  checkmarkColor: MenuBuilderColors.kPrimaryColor,
                  onSelected: (_) {},
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
              "£10.00",
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
              "£10.00",
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
              children: List.generate(20, (_) {
                return FilterChip(
                  label: const Text("Test"),
                  selected: false,
                  selectedColor: MenuBuilderColors.kBlue.withOpacity(0.15),
                  backgroundColor: MenuBuilderColors.kBlue.withOpacity(0.15),
                  labelStyle: textTheme.titleSmall!.copyWith(
                    color: MenuBuilderColors.kBlue,
                  ),
                  checkmarkColor: MenuBuilderColors.kBlue,
                  onSelected: (_) {},
                );
              }),
            ),
          ),
          verticalSpaceRegular,
        ],
      ),
    );
  }
}
