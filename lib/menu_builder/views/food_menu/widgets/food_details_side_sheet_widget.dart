import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodDetailsSideSheetWidget extends StatelessWidget {
  const FoodDetailsSideSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Drawer(
          width: size.width * 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      FluentIcons.chevron_left_28_filled,
                      color: MenuBuilderColors.kGrey,
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: MenuBuilderColors.kBlue.withOpacity(0.25),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: MenuBuilderColors.kBlue,
                      ),
                    ),
                    horizontalSpaceRegular,
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            MenuBuilderColors.kPrimaryColor.withOpacity(0.25),
                      ),
                      child: const Icon(
                        Icons.delete_forever,
                        color: MenuBuilderColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 28.0,
                    horizontal: 20.0,
                  ),
                  child: ListView(
                    children: <Widget>[
                      verticalSpaceSmall,
                      Center(
                        child: Container(
                          height: size.height * 0.2,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  "https://ferns.uk/foodpage/uploads/1631879331/1631879331.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Chicken Noodles",
                                style: textTheme.titleMedium),
                            horizontalSpaceSmall,
                            const Icon(
                              FontAwesomeIcons.drumstickBite,
                              color: Color(0xFFA16868),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      verticalSpaceVerySmall,
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: SegmentedButton<String>(
                            segments: [
                              ButtonSegment(
                                value: "Online",
                                icon: const Icon(
                                  Icons.close,
                                  color: MenuBuilderColors.kMaterialRed,
                                ),
                                label: Text(
                                  "Online",
                                  style: textTheme.labelLarge!.copyWith(
                                    color: MenuBuilderColors.kMaterialRed,
                                  ),
                                ),
                                tooltip: "Online Status",
                              ),
                              ButtonSegment(
                                value: "DineIn",
                                icon: const Icon(
                                  Icons.check,
                                  color: MenuBuilderColors.kSuccessGreen2,
                                ),
                                label: Text(
                                  "Dine In",
                                  style: textTheme.labelLarge!.copyWith(
                                    color: MenuBuilderColors.kSuccessGreen2,
                                  ),
                                ),
                                tooltip: "DineIn Status",
                              ),
                              ButtonSegment(
                                value: "Active",
                                icon: const Icon(
                                  Icons.check,
                                  color: MenuBuilderColors.kSuccessGreen2,
                                ),
                                label: Text(
                                  "Active",
                                  style: textTheme.labelLarge!.copyWith(
                                    color: MenuBuilderColors.kSuccessGreen2,
                                  ),
                                ),
                                tooltip: "Active Status",
                              ),
                            ],
                            selected: const {},
                            emptySelectionAllowed: true,
                            showSelectedIcon: false,
                            onSelectionChanged: (value) {},
                            style: SegmentedButton.styleFrom(
                              backgroundColor: MenuBuilderColors.kWhite2,
                              foregroundColor: MenuBuilderColors.kBlack,
                              side: const BorderSide(
                                color: MenuBuilderColors.kLightGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      _buildExpansionTileContainer(
                        context,
                        icon: Icons.notes,
                        title: "Description",
                        children: [
                          const Divider(),
                          Text(
                            "Noodles are a type of food made from unleavened dough which is either rolled flat and cut, stretched, or extruded, into long strips or strings. Noodles are a staple food in many cultures and made into a variety of shapes. The most common noodles are either those derived from Chinese cuisine or Italian cuisine.",
                            style: textTheme.bodySmall,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      verticalSpaceRegular,
                      _buildExpansionTileContainer(
                        context,
                        icon: FluentIcons.info_20_regular,
                        title: "Basic Info",
                        children: [
                          _buildInfoRow(context, FluentIcons.food_20_regular,
                              "Vegetable Noodles"),
                          verticalSpaceSmall,
                          _buildInfoRow(
                            context,
                            FluentIcons.book_information_20_regular,
                            "Cucumber, Carrots, Kohlrabi",
                          ),
                          verticalSpaceSmall,
                          _buildInfoRow(
                              context, FluentIcons.money_20_regular, "£30.00"),
                          verticalSpaceSmall,
                          _buildInfoRow(context, FluentIcons.stack_20_regular,
                              "Unlimited Stock"),
                        ],
                      ),
                      verticalSpaceRegular,
                      _buildExpansionTileContainer(
                        context,
                        icon: FluentIcons.app_folder_20_regular,
                        title: "Categories",
                        children: const <Widget>[],
                      ),
                      verticalSpaceRegular,
                      _buildExpansionTileContainer(
                        context,
                        icon: FluentIcons.apps_add_in_20_regular,
                        title: "Addons/Modifiers",
                        children: const <Widget>[],
                      ),
                      verticalSpaceRegular,
                      _buildExpansionTileContainer(
                        context,
                        icon: FluentIcons.app_folder_20_regular,
                        title: "Menu Group",
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FilterChip(
                              label:
                                  Text("Default", style: textTheme.labelMedium),
                              onSelected: (_) {},
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              showCheckmark: false,
                              backgroundColor: MenuBuilderColors.kWhite,
                              side: const BorderSide(
                                color: MenuBuilderColors.kLightGrey,
                              ),
                            ),
                          )
                        ],
                      ),
                      verticalSpaceRegular,
                      _buildExpansionTileContainer(
                        context,
                        icon: FluentIcons.clock_20_regular,
                        title: "Timing Info",
                        children: [
                          verticalSpaceTiny,
                          Table(
                            border: TableBorder.all(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            children: <TableRow>[
                              _buildTableRow(
                                context,
                                'Sunday',
                                '10:00 AM to 5:30 PM',
                              ),
                              _buildTableRow(
                                context,
                                'Monday',
                                '10:00 AM to 5:30 PM',
                              ),
                            ],
                          ),
                          verticalSpaceSmall,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTileContainer(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ExpansionTile(
        dense: true,
        leading: Icon(icon, size: 20),
        childrenPadding: const EdgeInsets.symmetric(
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

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String text,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.grey.shade700,
        ),
        horizontalSpaceSmall,
        Text(
          text,
          style: textTheme.bodyMedium!.copyWith(
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, String day, String timing) {
    final textTheme = Theme.of(context).textTheme;
    return TableRow(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              day,
              style:
                  textTheme.bodyMedium!.copyWith(color: Colors.grey.shade500),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              timing,
              style:
                  textTheme.bodyMedium!.copyWith(color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }
}
