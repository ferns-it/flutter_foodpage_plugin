import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/menu_builder_app_colors.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_collection_model.dart';

import '../../core/utils/ui_utils.dart';

class FoodDetailsTile extends StatelessWidget {
  const FoodDetailsTile({super.key, required this.dish});

  final DishDetails dish;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const placeHolder =
        'https://theme-assets.getbento.com/sensei/e439fc7.sensei/assets/images/catering-item-placeholder-704x520.png';

    return Card(
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
      color: !dish.active ? Colors.grey.shade100 : null,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                dish.photo,
                height: 60,
                errorBuilder: (BuildContext context, _, __) {
                  return Image.network(
                    placeHolder,
                    height: 60,
                  );
                },
              ),
            ),
            horizontalSpaceRegular,
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(dish.name, style: textTheme.titleMedium),
                        verticalSpaceTiny,
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                removeHtmlTags(dish.description),
                                style: textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  horizontalSpaceRegular,
                  Text(
                    dish.price,
                    style: textTheme.titleMedium!.copyWith(
                      color: MenuBuilderColors.kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
