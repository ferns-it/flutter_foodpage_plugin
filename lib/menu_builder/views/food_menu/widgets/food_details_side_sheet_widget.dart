import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/ui_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodDetailsSideSheetWidget extends StatelessWidget {
  const FoodDetailsSideSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Drawer(
          width: mq.width * 0.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                verticalSpaceSmall,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    "https://ferns.uk/foodpage/uploads/1631879331/1631879331.png",
                    height: 120,
                  ),
                ),
                verticalSpaceSmall,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Chicken Noodles", style: textTheme.titleMedium),
                    horizontalSpaceSmall,
                    // const Icon(
                    //   FontAwesomeIcons.leaf,
                    //   color: Color.fromARGB(255, 5, 160, 0),
                    //   size: 20,
                    // ),
                    const Icon(
                      FontAwesomeIcons.drumstickBite,
                      color: Color(0xFFA16868),
                      size: 20,
                    ),
                  ],
                ),
                verticalSpaceVerySmall,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ExpansionTile(
                    dense: true,
                    leading: const Icon(Icons.notes, size: 20),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      "Description",
                      style: textTheme.titleMedium,
                    ),
                    children: [
                      const Divider(),
                      Text(
                        "Noodles are a type of food made from unleavened dough which is either rolled flat and cut, stretched, or extruded, into long strips or strings. Noodles are a staple food in many cultures and made into a variety of shapes. The most common noodles are either those derived from Chinese cuisine or Italian cuisine.",
                        style: textTheme.bodySmall,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ExpansionTile(
                    dense: true,
                    leading: const Icon(FluentIcons.info_20_regular, size: 20),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      "Basic Info",
                      style: textTheme.titleMedium,
                    ),
                    children: <Widget>[
                      verticalSpaceTiny,
                      Row(
                        children: <Widget>[
                          Icon(
                            FluentIcons.food_20_regular,
                            color: Colors.grey.shade700,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "Vegitable Noodles",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: <Widget>[
                          Icon(
                            FluentIcons.book_information_20_regular,
                            color: Colors.grey.shade700,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "Cucumber, Carrots, Kohlrabi",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: <Widget>[
                          Icon(
                            FluentIcons.money_20_regular,
                            color: Colors.grey.shade700,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "£30.00",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceSmall,
                      Row(
                        children: <Widget>[
                          Icon(
                            FluentIcons.stack_20_regular,
                            color: Colors.grey.shade700,
                          ),
                          horizontalSpaceSmall,
                          Text(
                            "Unlimited",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ExpansionTile(
                    dense: true,
                    leading: const Icon(
                      FluentIcons.app_folder_20_regular,
                      size: 20,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      "Categories",
                      style: textTheme.titleMedium,
                    ),
                    children: const <Widget>[
                      verticalSpaceTiny,
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ExpansionTile(
                    dense: true,
                    leading: const Icon(
                      FluentIcons.apps_add_in_20_regular,
                      size: 20,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      "Addons/Modifiers",
                      style: textTheme.titleMedium,
                    ),
                    children: const <Widget>[
                      verticalSpaceTiny,
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ExpansionTile(
                    dense: true,
                    leading: const Icon(
                      FluentIcons.app_folder_20_regular,
                      size: 20,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      "Menu Group",
                      style: textTheme.titleMedium,
                    ),
                    children: const <Widget>[
                      verticalSpaceTiny,
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ExpansionTile(
                    dense: true,
                    leading: const Icon(
                      FluentIcons.clock_20_regular,
                      size: 20,
                    ),
                    childrenPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      "Timing Info",
                      style: textTheme.titleMedium,
                    ),
                    children: <Widget>[
                      verticalSpaceTiny,
                      Table(
                        border: TableBorder.all(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text('Sunday',
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey.shade500)),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text('10:00 AM to 5:30 PM',
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey.shade500)),
                              ),
                            ),
                          ]),
                          TableRow(children: [
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text('Monday',
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey.shade500)),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text('10:00 AM to 5:30 PM',
                                    style: textTheme.bodyMedium!
                                        .copyWith(color: Colors.grey.shade500)),
                              ),
                            ),
                          ])
                        ],
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
