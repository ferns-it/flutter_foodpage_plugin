import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/views/widgets/drag_and_drop.dart';

import '../../core/constants/menu_builder_app_colors.dart';
import '../../core/utils/ui_utils.dart';

class CategoryTreeNode {
  const CategoryTreeNode({
    required this.title,
    this.children = const <CategoryTreeNode>[],
  });

  final String title;
  final List<CategoryTreeNode> children;
}

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

final List<CategoryTreeNode> roots = categoriesDemoData.map((categoryData) {
  return CategoryTreeNode(
    title: categoryData['category'] as String,
    children:
        (categoryData['sub-categories'] as List<String>).map((subCategory) {
      return CategoryTreeNode(title: subCategory);
    }).toList(),
  );
}).toList();

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Manage Category", style: textTheme.titleLarge),
          verticalSpaceTiny,
          Text(
            "Add and remove new categories",
            style: textTheme.bodyMedium!.copyWith(
              color: MenuBuilderColors.kGrey2,
            ),
          ),
          verticalSpaceMedium,
          const Expanded(child: DragAndDropTreeView())
          // Expanded(
          //   child: AnimatedTreeView<CategoryTreeNode>(
          //     treeController: treeController,
          //     nodeBuilder: (
          //       BuildContext context,
          //       TreeEntry<CategoryTreeNode> entry,
          //     ) {
          //       return InkWell(
          //         onTap: () => treeController.toggleExpansion(entry.node),
          //         child: TreeIndentation(
          //           entry: entry,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(
          //               entry.node.title,
          //               style: textTheme.titleMedium,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // Expanded(
          //   child: AnimatedTreeView<CategoryTreeNode>(
          //     treeController: treeController,
          //     nodeBuilder:
          //         (BuildContext context, TreeEntry<CategoryTreeNode> entry) {
          //       return TreeDragTarget<CategoryTreeNode>(
          //         node: entry.node,
          //         onNodeAccepted:
          //             (TreeDragAndDropDetails<CategoryTreeNode> details) {
          //           // Optionally make sure the target node is expanded so the dragging
          //           // node is visible in its new vicinity when the tree gets rebuilt.
          //           treeController.setExpansionState(details.targetNode, true);

          //           // Make sure to rebuild your tree view to show the reordered nodes
          //           // in their new vicinity.
          //           treeController.rebuild();
          //         },
          //         builder:
          //             (BuildContext context, TreeDragAndDropDetails? details) {
          //           Widget myTreeNodeTile = Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Text(entry.node.title),
          //           );

          //           // If details is not null, a dragging tree node is hovering this
          //           // drag target. Add some decoration to give feedback to the user.
          //           if (details != null) {
          //             myTreeNodeTile = ColoredBox(
          //               color: Theme.of(context)
          //                   .colorScheme
          //                   .primary
          //                   .withOpacity(0.3),
          //               child: myTreeNodeTile,
          //             );
          //           }

          //           return TreeDraggable<CategoryTreeNode>(
          //             node: entry.node,

          //             // Show some feedback to the user under the dragging pointer,
          //             // this can be any widget.
          //             feedback: IntrinsicWidth(
          //               child: Material(
          //                 elevation: 4,
          //                 child: myTreeNodeTile,
          //               ),
          //             ),

          //             child: InkWell(
          //               onTap: () => treeController.toggleExpansion(entry.node),
          //               child: TreeIndentation(
          //                 entry: entry,
          //                 child: myTreeNodeTile,
          //               ),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
