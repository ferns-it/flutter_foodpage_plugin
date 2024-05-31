import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/utils/ui_utils.dart';

class FoodDetailsTile extends StatelessWidget {
  const FoodDetailsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://ferns.uk/foodpage/uploads/1631879331/1631879331.png",
                height: 60,
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Noodles", style: textTheme.titleMedium),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "Maggi is an international brand of seasonings, instant soups",
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
