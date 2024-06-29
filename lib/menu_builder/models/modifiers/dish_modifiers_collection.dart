// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DishModifiersCollection {
  final List<DishModifierData> masterModifiers;
  DishModifiersCollection({
    required this.masterModifiers,
  });

  DishModifiersCollection copyWith({
    List<DishModifierData>? masterModifiers,
  }) {
    return DishModifiersCollection(
      masterModifiers: masterModifiers ?? this.masterModifiers,
    );
  }

  @override
  String toString() =>
      'DishModifiersCollection(masterModifiers: $masterModifiers)';

  @override
  bool operator ==(covariant DishModifiersCollection other) {
    if (identical(this, other)) return true;

    return listEquals(other.masterModifiers, masterModifiers);
  }

  @override
  int get hashCode => masterModifiers.hashCode;
}

class DishModifierData {
  final String id;
  final String name;
  final String minimumRequired;
  final String maximumRequired;
  final String status;
  final List<GroupItem> groupItems;
  DishModifierData({
    required this.id,
    required this.name,
    required this.minimumRequired,
    required this.maximumRequired,
    required this.status,
    required this.groupItems,
  });

  DishModifierData copyWith({
    String? id,
    String? name,
    String? minimumRequired,
    String? maximumRequired,
    String? status,
    List<GroupItem>? groupItems,
  }) {
    return DishModifierData(
      id: id ?? this.id,
      name: name ?? this.name,
      minimumRequired: minimumRequired ?? this.minimumRequired,
      maximumRequired: maximumRequired ?? this.maximumRequired,
      status: status ?? this.status,
      groupItems: groupItems ?? this.groupItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'minimumRequired': minimumRequired,
      'maximumRequired': maximumRequired,
      'status': status,
      'groupItems': groupItems.map((x) => x.toMap()).toList(),
    };
  }

  factory DishModifierData.fromMap(Map<String, dynamic> map) {
    return DishModifierData(
      id: map['id'] as String,
      name: map['name'] as String,
      minimumRequired: map['minimumRequired'] as String,
      maximumRequired: map['maximumRequired'] as String,
      status: map['status'] as String,
      groupItems: List<GroupItem>.from(
        (map['groupItems'] ?? []).map<GroupItem>(
          (x) => GroupItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DishModifierData.fromJson(String source) =>
      DishModifierData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DishModifierData(id: $id, name: $name, minimumRequired: $minimumRequired, maximumRequired: $maximumRequired, status: $status, groupItems: $groupItems)';
  }

  @override
  bool operator ==(covariant DishModifierData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.minimumRequired == minimumRequired &&
        other.maximumRequired == maximumRequired &&
        other.status == status &&
        listEquals(other.groupItems, groupItems);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        minimumRequired.hashCode ^
        maximumRequired.hashCode ^
        status.hashCode ^
        groupItems.hashCode;
  }
}

class GroupItem {
  final String id;
  final String groupID;
  final String name;
  final String price;
  final String status;
  final String sort;
  GroupItem({
    required this.id,
    required this.groupID,
    required this.name,
    required this.price,
    required this.status,
    required this.sort,
  });

  GroupItem copyWith({
    String? id,
    String? groupID,
    String? name,
    String? price,
    String? status,
    String? sort,
  }) {
    return GroupItem(
      id: id ?? this.id,
      groupID: groupID ?? this.groupID,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      sort: sort ?? this.sort,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'groupID': groupID,
      'name': name,
      'price': price,
      'status': status,
      'sort': sort,
    };
  }

  factory GroupItem.fromMap(Map<String, dynamic> map) {
    return GroupItem(
      id: map['id'] as String,
      groupID: map['groupID'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
      status: map['status'] as String,
      sort: map['sort'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupItem.fromJson(String source) =>
      GroupItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GroupItem(id: $id, groupID: $groupID, name: $name, price: $price, status: $status, sort: $sort)';
  }

  @override
  bool operator ==(covariant GroupItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.groupID == groupID &&
        other.name == name &&
        other.price == price &&
        other.status == status &&
        other.sort == sort;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        groupID.hashCode ^
        name.hashCode ^
        price.hashCode ^
        status.hashCode ^
        sort.hashCode;
  }
}
