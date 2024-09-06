import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/dishes/dishes_controller.dart';
import 'package:provider/provider.dart';

class AddCategoriesSideSheet extends StatelessWidget {
  const AddCategoriesSideSheet({super.key});

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
          Text("Categories", style: textTheme.titleLarge),
          Expanded(
              child: ListView(
            children: controller.listOfCategories
                .mapIndexed((parentIndex, parentCategory) {
              final subCategories = parentCategory.childrens;
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.0,
                  ),
                ),
                child: ExpansionTile(
                  title: Text(
                    parentCategory.name ?? "Unknown",
                    style: textTheme.titleSmall,
                  ),
                  enabled: parentCategory.childrens.isNotEmpty,
                  leading: Checkbox(
                    value: controller.checkParentIsSelected(parentCategory),
                    onChanged: (_) {
                      controller.whenSelectParentCategory(parentCategory);
                    },
                  ),
                  dense: true,
                  children: <Widget>[
                    ListView.builder(
                      itemCount: subCategories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemBuilder: (context, index) {
                        final category = subCategories[index];
                        return CheckboxListTile(
                          value: controller.checkChildIsSelected(
                              parentCategory.cID, category),
                          onChanged: (_) {
                            controller.whenSelectSubCategory(
                              parentCategory.cID,
                              category,
                            );
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            category.name ?? "Unknown",
                            style: textTheme.bodyMedium!
                                .copyWith(color: Colors.grey.shade800),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }).toList(),
          ))
        ],
      ),
    );
  }
}
