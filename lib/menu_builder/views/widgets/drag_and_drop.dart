import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

class Node {
  Node({
    required this.name,
    Iterable<Node>? children,
  }) : _children = <Node>[] {
    if (children == null) return;

    for (final Node child in children) {
      child._parent = this;
      _children.add(child);
    }
  }

  final String name;
  final List<Node> _children;

  Iterable<Node> get children => _children;
  bool get isLeaf => _children.isEmpty;

  Node? get parent => _parent;
  Node? _parent;

  int get index => _parent?._children.indexOf(this) ?? -1;

  void insertChild(int index, Node node) {
    // Adjust the index if necessary when dropping a node at the same parent
    if (node._parent == this && node.index < index) {
      index--;
    }

    // Ensure the node is removed from its previous parent and update it
    node
      .._parent?._children.remove(node)
      .._parent = this;

    _children.insert(index, node);
  }
}

extension on TreeDragAndDropDetails<Node> {
  /// Splits the target node's height in three and checks the vertical offset
  /// of the dragging node, applying the appropriate callback.
  T mapDropPosition<T>({
    required T Function() whenAbove,
    required T Function() whenInside,
    required T Function() whenBelow,
  }) {
    final double oneThirdOfTotalHeight = targetBounds.height * 0.3;
    final double pointerVerticalOffset = dropPosition.dy;

    if (pointerVerticalOffset < oneThirdOfTotalHeight) {
      return whenAbove();
    } else if (pointerVerticalOffset < oneThirdOfTotalHeight * 2) {
      return whenInside();
    } else {
      return whenBelow();
    }
  }
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

final List<Node> roots = categoriesDemoData.map((categoryData) {
  return Node(
    name: categoryData['category'] as String,
    children:
        (categoryData['sub-categories'] as List<String>).map((subCategory) {
      return Node(name: subCategory);
    }).toList(),
  );
}).toList();

class DragAndDropTreeView extends StatefulWidget {
  const DragAndDropTreeView({super.key});

  @override
  State<DragAndDropTreeView> createState() => _DragAndDropTreeViewState();
}

class _DragAndDropTreeViewState extends State<DragAndDropTreeView> {
  late final Node root;
  late final TreeController<Node> treeController;

  @override
  void initState() {
    super.initState();

    treeController = TreeController<Node>(
      roots: roots,
      childrenProvider: (Node node) => node.children,

      // The parentProvider is extremely important when automatically expanding
      // and collapsing tree nodes on hover, as the [TreeDragTarget] needs to
      // ensure that it doesn't collapse an ancestor of the dragging node as it
      // would be removed from the view stopping the drag updates and callbacks.
      //
      // When not provided, the [TreeController] would need to first locate the
      // target node in the tree and then check its ancestors, which could be
      // very expensive for deep trees.
      parentProvider: (Node node) => node.parent,
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  void onNodeAccepted(TreeDragAndDropDetails<Node> details) {
    Node? newParent;
    int newIndex = 0;

    details.mapDropPosition(
      whenAbove: () {
        // Insert the dragged node as the previous sibling of the target node.
        newParent = details.targetNode.parent;
        newIndex = details.targetNode.index;
      },
      whenInside: () {
        // Insert the dragged node as the last child of the target node.
        newParent = details.targetNode;
        newIndex = details.targetNode.children.length;

        // Ensure that the dragged node is visible after reordering.
        treeController.setExpansionState(details.targetNode, true);
      },
      whenBelow: () {
        // Insert the dragged node as the next sibling of the target node.
        newParent = details.targetNode.parent;
        newIndex = details.targetNode.index + 1;
      },
    );

    (newParent ?? root).insertChild(newIndex, details.draggedNode);

    // Rebuild the tree to show the reordered node in its new vicinity.
    treeController.rebuild();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final IndentGuide indentGuide = DefaultIndentGuide.of(context);
    final BorderSide borderSide = BorderSide(
      color: Theme.of(context).colorScheme.outline,
      width: indentGuide is AbstractLineGuide ? indentGuide.thickness : 2.0,
    );

    return AnimatedTreeView<Node>(
      treeController: treeController,
      nodeBuilder: (BuildContext context, TreeEntry<Node> entry) {
        return DragAndDropTreeTile(
          entry: entry,
          borderSide: borderSide,
          onNodeAccepted: onNodeAccepted,
          onFolderPressed: () => treeController.toggleExpansion(entry.node),
        );
      },
    );
  }
}

class DragAndDropTreeTile extends StatelessWidget {
  const DragAndDropTreeTile({
    super.key,
    required this.entry,
    required this.onNodeAccepted,
    this.borderSide = BorderSide.none,
    this.longPressDelay,
    this.onFolderPressed,
  });

  final TreeEntry<Node> entry;
  final TreeDragTargetNodeAccepted<Node> onNodeAccepted;
  final BorderSide borderSide;
  final Duration? longPressDelay;
  final VoidCallback? onFolderPressed;

  @override
  Widget build(BuildContext context) {
    return TreeDragTarget<Node>(
      node: entry.node,
      onNodeAccepted: onNodeAccepted,
      builder: (BuildContext context, TreeDragAndDropDetails<Node>? details) {
        Decoration? decoration;

        if (details != null) {
          // Add a border to indicate in which portion of the target's height
          // the dragging node will be inserted.
          decoration = BoxDecoration(
            border: details.mapDropPosition(
              whenAbove: () => Border(top: borderSide),
              whenInside: () => Border.fromBorderSide(borderSide),
              whenBelow: () => Border(bottom: borderSide),
            ),
          );
        }

        return TreeDraggable<Node>(
          node: entry.node,
          longPressDelay: longPressDelay,
          childWhenDragging: Opacity(
            opacity: .5,
            child: IgnorePointer(
              child: TreeTile(entry: entry),
            ),
          ),
          feedback: IntrinsicWidth(
            child: Material(
              elevation: 4,
              child: TreeTile(
                entry: entry,
                showIndentation: false,
                onFolderPressed: () {},
              ),
            ),
          ),
          child: TreeTile(
            entry: entry,
            onFolderPressed: entry.node.isLeaf ? null : onFolderPressed,
            decoration: decoration,
          ),
        );
      },
    );
  }
}

class TreeTile extends StatelessWidget {
  const TreeTile({
    super.key,
    required this.entry,
    this.onFolderPressed,
    this.decoration,
    this.showIndentation = true,
  });

  final TreeEntry<Node> entry;
  final VoidCallback? onFolderPressed;
  final Decoration? decoration;
  final bool showIndentation;

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Row(
        children: [
          if (entry.hasChildren)
            ExpandIcon(
              key: GlobalObjectKey(entry.node),
              isExpanded: entry.isExpanded,
              onPressed: (_) => onFolderPressed!(),
            )
          else
            const SizedBox(height: 40, width: 8),
          Expanded(
            child: InkWell(
              onTap: () => onFolderPressed!(),
              child: Text(
                entry.node.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );

    if (decoration != null) {
      content = DecoratedBox(
        decoration: decoration!,
        child: content,
      );
    }

    if (showIndentation) {
      return TreeIndentation(
        entry: entry,
        guide: IndentGuide.connectingLines(
          color: Colors.grey.shade400,
          thickness: 1.5,
        ),
        child: content,
      );
    }

    return content;
  }
}
