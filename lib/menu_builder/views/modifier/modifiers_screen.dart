import 'package:collection/collection.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:provider/provider.dart';

import '../../core/constants/menu_builder_app_colors.dart';
import '../../core/utils/helper_utils.dart';
import '../../core/utils/ui_utils.dart';
import '../../models/modifiers/dish_modifiers_collection.dart';

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Manage Modifiers", style: textTheme.titleLarge),
                  verticalSpaceTiny,
                  Text(
                    "Add and update master modifiers",
                    style: textTheme.bodyMedium!.copyWith(
                      color: MenuBuilderColors.kGrey2,
                    ),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {
                  context.read<DishModifiersController>().clearFormEntries();
                  Scaffold.of(context).openEndDrawer();
                },
                icon: const Icon(FluentIcons.add_16_filled),
                label: const Text("Add Modifier"),
                style: OutlinedButton.styleFrom(
                  textStyle: textTheme.titleMedium,
                ),
              ),
            ],
          ),
          verticalSpaceMedium,
          const Expanded(child: _ModifiersListSection()),
        ],
      ),
    );
  }
}

class _ModifiersListSection extends StatelessWidget {
  const _ModifiersListSection();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DishModifiersController>();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          _buildHeaderTable(),
          controller.modifiersCollection.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(child: CircularProgressIndicator()),
            completed: (data) => _buildCompletedTable(data),
            error: (message, error) => Text(message ?? ""),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(1),
        4: FlexColumnWidth(1),
        5: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: MenuBuilderColors.kWhite,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          children: [
            _buildTableHeaderCell("SN", firstElem: true),
            _buildTableHeaderCell("Name"),
            _buildTableHeaderCell("Items"),
            _buildTableHeaderCell("Min"),
            _buildTableHeaderCell("Max"),
            _buildTableHeaderCell("Actions", lastElem: true),
          ],
        ),
      ],
    );
  }

  Widget _buildCompletedTable(DishModifiersCollection data) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: MenuBuilderColors.kWhite,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1),
              },
              border: TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey.shade300),
              ),
              children: data.masterModifiers.mapIndexed((index, modifier) {
                return TableRow(
                  children: <Widget>[
                    _buildTableCell("${index + 1}", firstElem: true),
                    _buildTableCell(capitalizeFirstLetter(modifier.name)),
                    _buildItemTableCell(modifier.groupItems),
                    _buildTableCell(modifier.minimumRequired),
                    _buildTableCell(modifier.maximumRequired),
                    _buildActionsButtons(index),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String label,
      {bool firstElem = false, bool lastElem = false}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Builder(builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0).copyWith(
              left: firstElem ? 20.0 : 8.0,
              right: lastElem ? 20.0 : 8.0,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildItemTableCell(List<GroupItem> items) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Wrap(
            spacing: 8.0,
            children: items.map((item) {
              return Chip(
                backgroundColor: Colors.grey.shade200,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                label: Text(
                  capitalizeFirstLetter(item.name),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: const Color.fromARGB(255, 20, 20, 20),
                      ),
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }

  Widget _buildTableCell(String label,
      {bool firstElem = false, bool lastElem = false}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Builder(builder: (context) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0).copyWith(
              left: firstElem ? 20.0 : 8.0,
              right: lastElem ? 20.0 : 8.0,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildActionsButtons(int index) {
    return Builder(builder: (context) {
      final controller = context.watch<DishModifiersController>();
      return TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: InkWell(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
            controller.onPressEditButton(index);
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MenuBuilderColors.kBlue.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.edit,
                color: MenuBuilderColors.kBlue,
              ),
            ),
          ),
        ),
      );
    });
  }
}
