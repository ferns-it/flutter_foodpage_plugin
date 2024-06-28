import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dish_modifiers_controller.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
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
          const _ModifiersListSection(),
        ],
      ),
    );
  }
}

class _ModifiersListSection extends StatelessWidget {
  const _ModifiersListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.read<DishModifiersController>();
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Table(
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: MenuBuilderColors.kWhite,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                children: <Widget>[
                  _buildTableHeaderCell("SN", firstElem: true),
                  _buildTableHeaderCell("Name"),
                  _buildTableHeaderCell("Items"),
                  _buildTableHeaderCell("Min"),
                  _buildTableHeaderCell("Max"),
                  _buildTableHeaderCell("Actions", lastElem: true),
                ],
              ),
            ],
          ),
          verticalSpaceSmall,
          controller.modifiersCollection.when(initial: () {
            return const SizedBox.shrink();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, completed: (data) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: MenuBuilderColors.kWhite,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Table(
                children: data.masterModifiers.mapIndexed((index, modifier) {
                  return TableRow(
                    children: <Widget>[
                      _buildTableCell(index.toString(), firstElem: true),
                      _buildTableCell(modifier.name),
                      _buildTableCell("Items"),
                      _buildTableCell(modifier.minimumRequired),
                      _buildTableCell(modifier.maximumRequired),
                      _buildTableCell("Actions", lastElem: true),
                    ],
                  );
                }).toList(),
              ),
            );
          }, error: (message, error) {
            return Text(message ?? "");
          }),
        ],
      ),
      // child: Card(
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(8.0),
      //       side: BorderSide(color: Colors.grey.shade300)),
      //   child: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text("SL", style: textTheme.titleMedium),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildTableHeaderCell(
    String label, {
    bool firstElem = false,
    bool lastElem = false,
  }) {
    return Builder(builder: (context) {
      return Padding(
        padding: firstElem
            ? const EdgeInsets.symmetric(vertical: 8.0).copyWith(left: 20.0)
            : lastElem
                ? const EdgeInsets.symmetric(vertical: 8.0)
                    .copyWith(right: 20.0)
                : const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    });
  }

  Widget _buildTableCell(
    String label, {
    bool firstElem = false,
    bool lastElem = false,
  }) {
    return Builder(builder: (context) {
      return Padding(
        padding: firstElem
            ? const EdgeInsets.symmetric(vertical: 8.0).copyWith(left: 20.0)
            : lastElem
                ? const EdgeInsets.symmetric(vertical: 8.0)
                    .copyWith(right: 20.0)
                : const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    });
  }
}
