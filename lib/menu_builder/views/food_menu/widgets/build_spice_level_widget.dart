import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dishes/dishes_controller.dart';
import '../../../core/constants/menu_builder_app_colors.dart';
import '../../../core/utils/ui_utils.dart';

class BuildSpiceLevelWidget extends StatelessWidget {
  const BuildSpiceLevelWidget({super.key, this.index = 0});

  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<DishesController>();
    final levels = controller.listOfSpiceLevels;

    if (levels.isEmpty) return const SizedBox.shrink();

    final selected = controller.spiceLevelFor(index);

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
            color: MenuBuilderColors.kWhite2,
            child: Center(
              child: Text('Spice Level', style: textTheme.titleMedium),
            ),
          ),
          verticalSpaceSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: levels.where((l) => l.name != null).map((level) {
                final isSelected = level.name == selected;
                final backgroundColor =
                    MenuBuilderColors.kGrey.withOpacity(0.1);

                return ChoiceChip(
                  checkmarkColor: Colors.grey.shade600,
                  selected: isSelected,
                  selectedColor: backgroundColor,
                  backgroundColor: backgroundColor,
                  label: Text(level.name!),
                  labelStyle: textTheme.titleSmall!.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  // label: Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     if (level.icon != null) ...[
                  //       Text(level.icon!, style: const TextStyle(fontSize: 14)),
                  //       const SizedBox(width: 6),
                  //     ],
                  //     Text(
                  //       level.name!,
                  //       style: textTheme.titleSmall!.copyWith(
                  //         color: Colors.grey.shade600,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  onSelected: (_) =>
                      controller.onChangeSpiceLevel(index, level.name),
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