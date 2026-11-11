class ChoiceItem {
  ChoiceItem({required this.name, required this.price});
  String name;
  String price;

  Map<String, dynamic> toJson() => {"name": name, "price": price};
}

class ChoiceGroup {
  ChoiceGroup({required this.name, List<ChoiceItem>? items})
      : items = items ?? [];
  String name;
  final List<ChoiceItem> items;

  Map<String, dynamic> toJson() => {
        "name": name,
        "items": items.map((e) => e.toJson()).toList(),
      };
}
