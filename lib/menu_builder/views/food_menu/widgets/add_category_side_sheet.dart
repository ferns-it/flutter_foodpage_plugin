import 'package:flutter/material.dart';

class AddCategoriesSideSheet extends StatelessWidget {
  const AddCategoriesSideSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesDemoData = [
      {
        "category": "Soft Drinks",
        "sub-categories": ["Pepsi", "Coca-cola", "Sprite", "Fanta"]
      },
      {
        "category": "Juices",
        "sub-categories": [
          "Orange Juice",
          "Apple Juice",
          "Grape Juice",
          "Pineapple Juice"
        ]
      },
      {
        "category": "Snacks",
        "sub-categories": ["Chips", "Nuts", "Popcorn", "Pretzels"]
      },
      {
        "category": "Dairy Products",
        "sub-categories": ["Milk", "Cheese", "Yogurt", "Butter"]
      },
      {
        "category": "Bakery",
        "sub-categories": ["Bread", "Croissant", "Muffins", "Bagels"]
      },
      {
        "category": "Fruits",
        "sub-categories": ["Apple", "Banana", "Grapes", "Orange"]
      },
      {
        "category": "Vegetables",
        "sub-categories": ["Carrot", "Broccoli", "Spinach", "Potato"]
      },
      {
        "category": "Frozen Foods",
        "sub-categories": [
          "Ice Cream",
          "Frozen Pizza",
          "Frozen Vegetables",
          "Frozen Meals"
        ]
      },
      {
        "category": "Canned Goods",
        "sub-categories": [
          "Canned Beans",
          "Canned Corn",
          "Canned Tomatoes",
          "Canned Soup"
        ]
      },
      {
        "category": "Condiments",
        "sub-categories": ["Ketchup", "Mustard", "Mayonnaise", "BBQ Sauce"]
      },
    ];

    final textTheme = Theme.of(context).textTheme;

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
            children: categoriesDemoData.map((data) {
              final subCategories = data["sub-categories"] as List<String>;
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
                    data["category"] as String,
                    style: textTheme.titleSmall,
                  ),
                  leading: Checkbox(
                    value: false,
                    onChanged: (_) {},
                  ),
                  dense: true,
                  children: <Widget>[
                    ListView.builder(
                      itemCount: subCategories.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      itemBuilder: (context, index) {
                        final category = subCategories[index];
                        return CheckboxListTile(
                          value: false,
                          onChanged: (_) {},
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            category,
                            style: textTheme.bodyMedium,
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
