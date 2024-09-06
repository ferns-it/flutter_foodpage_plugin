import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/widgets/custom_rounded_textfield.dart';
import 'package:provider/provider.dart';

import '../../../controllers/dishes/dishes_controller.dart';
import '../../../core/constants/menu_builder_app_colors.dart';

class AddAvailabilitySideSheet extends StatelessWidget {
  const AddAvailabilitySideSheet({super.key});

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
          Text("Availability", style: textTheme.titleLarge),
          const Divider(height: 40.0),
          verticalSpaceSmall,
          ListTileTheme(
            contentPadding: EdgeInsets.zero,
            child: CheckboxListTile(
              value: controller.allDaysEnabled,
              onChanged: controller.onChangeAllDaysEnable,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text("All Days"),
            ),
          ),
          if (!controller.allDaysEnabled) ...[
            Wrap(
              runSpacing: 4.0,
              spacing: 10.0,
              children: controller.listOfAvailabilityDays.map((option) {
                return FilterChip(
                  onSelected: (_) => controller.onChangeAvailableDays(option),
                  backgroundColor: Colors.grey.shade300,
                  side: BorderSide.none,
                  padding: const EdgeInsets.all(10.0),
                  label: Text(capitalizeFirstLetter(option)),
                  labelStyle: textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade800,
                  ),
                  selected: controller.checkDaysIsSelected(option),
                  checkmarkColor: Colors.grey.shade800,
                  selectedColor: Colors.grey.shade300,
                );
              }).toList(),
            ),
          ],
          verticalSpaceSmall,
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  "Note: If the entries are empty, the dish availability will match the shop's operating hours by default.",
                  style: textTheme.bodyMedium,
                ),
              ),
              horizontalSpaceMedium,
              IconButton.filledTonal(
                style: IconButton.styleFrom(
                  backgroundColor: MenuBuilderColors.kBlue.withOpacity(
                    0.1,
                  ),
                  foregroundColor: MenuBuilderColors.kBlue,
                ),
                onPressed: () => controller.addAvailabilityEntries(),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemCount: controller.dishAvailabilityEntries.length,
              itemBuilder: (context, index) {
                final entry = controller.dishAvailabilityEntries[index];
                final startTimeController = TextEditingController();
                final startTime = entry.$1;
                if (startTime != null) {
                  startTimeController.text = formatTimeOfDay(startTime);
                }
                final endTime = entry.$2;
                final endTimeController = TextEditingController();
                if (endTime != null) {
                  endTimeController.text = formatTimeOfDay(endTime);
                }

                return Row(
                  children: <Widget>[
                    Flexible(
                      child: CustomRoundedTextField.topText(
                        topText: "Start Time",
                        hintText: "Pick time",
                        textEditingController: startTimeController,
                        borderRadius: BorderRadius.circular(4.0),
                        readOnly: true,
                        suffixIcon: InkWell(
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime == null) return;
                            controller.onStartTimeChange(index, pickedTime);
                          },
                          child: const Icon(
                            Icons.schedule,
                            color: MenuBuilderColors.kOrange,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpaceRegular,
                    Flexible(
                      child: CustomRoundedTextField.topText(
                        topText: "End Time",
                        hintText: "Pick time",
                        textEditingController: endTimeController,
                        borderRadius: BorderRadius.circular(4.0),
                        readOnly: true,
                        suffixIcon: InkWell(
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime == null) return;
                            controller.onEndTimeChange(index, pickedTime);
                          },
                          child: const Icon(
                            Icons.schedule,
                            color: MenuBuilderColors.kOrange,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: IconButton(
                          onPressed: index == 0
                              ? null
                              : () {
                                  controller.removeAvailabilityEntries(index);
                                },
                          disabledColor: Colors.grey,
                          color: MenuBuilderColors.kPrimaryColor,
                          icon: const Icon(
                            Icons.close,
                          ),
                        ))
                  ],
                );
              },
              separatorBuilder: (_, __) {
                return verticalSpaceRegular;
              },
            ),
          )
        ],
      ),
    );
  }
}
