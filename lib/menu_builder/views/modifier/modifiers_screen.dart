import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/constants/menu_builder_app_colors.dart';
import '../../core/utils/ui_utils.dart';

class ModifiersScreen extends StatelessWidget {
  const ModifiersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(
        bottom: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Manage Modifiers", style: textTheme.titleLarge),
          verticalSpaceTiny,
          Text(
            "Add and remove new modifiers",
            style: textTheme.bodyMedium!.copyWith(
              color: MenuBuilderColors.kGrey2,
            ),
          ),
          verticalSpaceMedium,
          const Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flexible(flex: 2, child: _CategoryTreeViewWidget()),
                // Spacer(),
                // Flexible(
                //   flex: 3,
                //   child: _BuildAddUpdateCategorySection(),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


