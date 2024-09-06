import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dishes/dishes_controller.dart';
import '../../../core/constants/menu_builder_app_colors.dart';
import '../../../core/utils/ui_utils.dart';

class BuildAllergensWidget extends StatelessWidget {
  const BuildAllergensWidget({Key? key, this.index = 0}) : super(key: key);

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
                  final allergens = controller.dishVariationType ==
                          DishVariationType.single
                      ? controller.singleSelectedAllergens
                      : controller.variationsFormEntries[index]["allergens"];
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
                      color: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return backgroundColor;
                        }
                        return null;
                      }),
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
