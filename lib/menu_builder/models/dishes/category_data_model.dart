// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DishCategoryCollectionModel {
  final List<CategoryDataModel> categories;
  DishCategoryCollectionModel({
    required this.categories,
  });

  bool get isCategoriesEmpty => categories.isEmpty;
  int get totalCategories => categories.length;

  DishCategoryCollectionModel copyWith({
    List<CategoryDataModel>? categories,
  }) {
    return DishCategoryCollectionModel(
      categories: categories ?? this.categories,
    );
  }
}

class CategoryDataModel {
  final String? cID;
  final String? name;
  final String? description;
  final String? shopID;
  final String? shopSpecificID;
  final String? status;
  final String? parentID;
  final String? defaultFlag;
  final String? sortOrder;
  CategoryDataModel({
    this.cID,
    this.name,
    this.description,
    this.shopID,
    this.shopSpecificID,
    this.status,
    this.parentID,
    this.defaultFlag,
    this.sortOrder,
  });

  CategoryDataModel copyWith({
    String? cID,
    String? name,
    String? description,
    String? shopID,
    String? shopSpecificID,
    String? status,
    String? parentID,
    String? defaultFlag,
    String? sortOrder,
  }) {
    return CategoryDataModel(
      cID: cID ?? this.cID,
      name: name ?? this.name,
      description: description ?? this.description,
      shopID: shopID ?? this.shopID,
      shopSpecificID: shopSpecificID ?? this.shopSpecificID,
      status: status ?? this.status,
      parentID: parentID ?? this.parentID,
      defaultFlag: defaultFlag ?? this.defaultFlag,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cID': cID,
      'name': name,
      'description': description,
      'shopID': shopID,
      'shopSpecificID': shopSpecificID,
      'status': status,
      'parentID': parentID,
      'defaultFlag': defaultFlag,
      'sortOrder': sortOrder,
    };
  }

  factory CategoryDataModel.fromMap(Map<String, dynamic> map) {
    return CategoryDataModel(
      cID: map['cID'] != null ? map['cID'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      shopSpecificID: map['shopSpecificID'] != null
          ? map['shopSpecificID'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      parentID: map['parentID'] != null ? map['parentID'] as String : null,
      defaultFlag:
          map['defaultFlag'] != null ? map['defaultFlag'] as String : null,
      sortOrder: map['sortOrder'] != null ? map['sortOrder'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryDataModel.fromJson(String source) =>
      CategoryDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryDataModel(cID: $cID, name: $name, description: $description, shopID: $shopID, shopSpecificID: $shopSpecificID, status: $status, parentID: $parentID, defaultFlag: $defaultFlag, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(covariant CategoryDataModel other) {
    if (identical(this, other)) return true;

    return other.cID == cID &&
        other.name == name &&
        other.description == description &&
        other.shopID == shopID &&
        other.shopSpecificID == shopSpecificID &&
        other.status == status &&
        other.parentID == parentID &&
        other.defaultFlag == defaultFlag &&
        other.sortOrder == sortOrder;
  }

  @override
  int get hashCode {
    return cID.hashCode ^
        name.hashCode ^
        description.hashCode ^
        shopID.hashCode ^
        shopSpecificID.hashCode ^
        status.hashCode ^
        parentID.hashCode ^
        defaultFlag.hashCode ^
        sortOrder.hashCode;
  }
}
