import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_collection_model.dart';

import '../../core/utils/ui_utils.dart';

class FoodDetailsTile extends StatelessWidget {
  const FoodDetailsTile({super.key, required this.dish});

  final DishDetails dish;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                dish.photo,
                height: 60,
                errorBuilder: (BuildContext context, _, __) {
                  return Image.network(
                    'https://theme-assets.getbento.com/sensei/e439fc7.sensei/assets/images/catering-item-placeholder-704x520.png',
                    height: 60,
                  );
                },
              ),
            ),
            horizontalSpaceSmall,
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
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
