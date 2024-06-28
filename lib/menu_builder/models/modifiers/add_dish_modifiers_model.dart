import 'dart:convert';

class AddDishModifiersModel {
  final String name;
  final String minimumRequired;
  final String maximumRequired;
  final GroupItems groupItems;
  AddDishModifiersModel({
    required this.name,
    this.minimumRequired = "0",
    this.maximumRequired = "0",
    required this.groupItems,
  });

  AddDishModifiersModel copyWith({
    String? name,
    String? minimumRequired,
    String? maximumRequired,
    GroupItems? groupItems,
  }) {
    return AddDishModifiersModel(
      name: name ?? this.name,
      minimumRequired: minimumRequired ?? this.minimumRequired,
      maximumRequired: maximumRequired ?? this.maximumRequired,
      groupItems: groupItems ?? this.groupItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'minimumRequired': minimumRequired,
      'maximumRequired': maximumRequired,
      'groupItems': groupItems.toMap(),
    };
  }

  factory AddDishModifiersModel.fromMap(Map<String, dynamic> map) {
    return AddDishModifiersModel(
      name: map['name'] as String,
      minimumRequired: map['minimumRequired'] as String,
      maximumRequired: map['maximumRequired'] as String,
      groupItems: GroupItems.fromMap(map['groupItems'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddDishModifiersModel.fromJson(String source) =>
      AddDishModifiersModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddDishModifiersModel(name: $name, minimumRequired: $minimumRequired, maximumRequired: $maximumRequired, groupItems: $groupItems)';
  }

  @override
  bool operator ==(covariant AddDishModifiersModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.minimumRequired == minimumRequired &&
        other.maximumRequired == maximumRequired &&
        other.groupItems == groupItems;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        minimumRequired.hashCode ^
        maximumRequired.hashCode ^
        groupItems.hashCode;
  }
}

class GroupItems {
  final String name;
  final String price;
  final String status;
  final String sort;
  GroupItems({
    required this.name,
    required this.price,
    required this.status,
    required this.sort,
  });

  GroupItems copyWith({
    String? name,
    String? price,
    String? status,
    String? sort,
  }) {
    return GroupItems(
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'status': status,
      'sort': sort,
    };
  }

  factory GroupItems.fromMap(Map<String, dynamic> map) {
    return GroupItems(
      name: map['name'] as String,
      price: map['price'] as String,
      status: map['status'] as String,
      sort: map['sort'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupItems.fromJson(String source) =>
      GroupItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupItems(name: $name, price: $price, status: $status, sort: $sort)';
  }

  @override
  bool operator ==(covariant GroupItems other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.price == price &&
        other.status == status &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    return name.hashCode ^ price.hashCode ^ status.hashCode ^ sort.hashCode;
  }
}
