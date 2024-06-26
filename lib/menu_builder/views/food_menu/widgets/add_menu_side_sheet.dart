import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dishes/dishes_controller.dart';

class AddMenuSideSheet extends StatelessWidget {
  const AddMenuSideSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<DishesController>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 24.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Menus", style: textTheme.titleLarge),
          const Divider(height: 40.0),
          Expanded(
              child: ListView(
            children: controller.listOfMenus.entries.map((entry) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    entry.value,
                    style: textTheme.titleSmall,
                  ),
                  value: controller.checkMenuIsSelected(entry.key),
                  onChanged: (_) {
                    controller.onChangeChooseMenus(entry.key);
                  },
                  dense: true,
                  enabled: controller.defaultEntryKey != null &&
                      entry.key != controller.defaultEntryKey,
                ),
              );
            }).toList(),
          ))
        ],
      ),
    );
  }
}
