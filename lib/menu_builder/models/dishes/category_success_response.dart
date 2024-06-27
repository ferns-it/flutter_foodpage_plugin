// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategorySuccessResponse {
  final String? message;
  final int? categoryID;
  final NewCategorySubData? categoryData;
  CategorySuccessResponse({
    this.message,
    this.categoryID,
    this.categoryData,
  });

  CategorySuccessResponse copyWith({
    String? message,
    int? categoryID,
    NewCategorySubData? categoryData,
  }) {
    return CategorySuccessResponse(
      message: message ?? this.message,
      categoryID: categoryID ?? this.categoryID,
      categoryData: categoryData ?? this.categoryData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'categoryID': categoryID,
      'categoryData': categoryData?.toMap(),
    };
  }

  factory CategorySuccessResponse.fromMap(Map<String, dynamic> map) {
    return CategorySuccessResponse(
      message: map['message'] != null ? map['message'] as String : null,
      categoryID: map['categoryID'] != null ? map['categoryID'] as int : null,
      categoryData: map['categoryData'] != null
          ? NewCategorySubData.fromMap(
              map['categoryData'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySuccessResponse.fromJson(String source) =>
      CategorySuccessResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategorySuccessResponse(message: $message, categoryID: $categoryID, categoryData: $categoryData)';

  @override
  bool operator ==(covariant CategorySuccessResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.categoryID == categoryID &&
        other.categoryData == categoryData;
  }

  @override
  int get hashCode =>
      message.hashCode ^ categoryID.hashCode ^ categoryData.hashCode;
}

class NewCategorySubData {
  final String? name;
  final String? description;
  final String? shopID;
  final String? shopSpecificID;
  final int? status;
  final String? parentID;
  final int? defaultFlag;
  final int? sortOrder;
  NewCategorySubData({
    this.name,
    this.description,
    this.shopID,
    this.shopSpecificID,
    this.status,
    this.parentID,
    this.defaultFlag,
    this.sortOrder,
  });

  NewCategorySubData copyWith({
    String? name,
    String? description,
    String? shopID,
    String? shopSpecificID,
    int? status,
    String? parentID,
    int? defaultFlag,
    int? sortOrder,
  }) {
    return NewCategorySubData(
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

  factory NewCategorySubData.fromMap(Map<String, dynamic> map) {
    return NewCategorySubData(
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      shopSpecificID: map['shopSpecificID'] != null
          ? map['shopSpecificID'] as String
          : null,
      status: map['status'] != null ? map['status'] as int : null,
      parentID: map['parentID'] != null ? map['parentID'] as String : null,
      defaultFlag:
          map['defaultFlag'] != null ? map['defaultFlag'] as int : null,
      sortOrder: map['sortOrder'] != null ? map['sortOrder'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewCategorySubData.fromJson(String source) =>
      NewCategorySubData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryData(name: $name, description: $description, shopID: $shopID, shopSpecificID: $shopSpecificID, status: $status, parentID: $parentID, defaultFlag: $defaultFlag, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(covariant NewCategorySubData other) {
    if (identical(this, other)) return true;

    return other.name == name &&
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
    return name.hashCode ^
        description.hashCode ^
        shopID.hashCode ^
        shopSpecificID.hashCode ^
        status.hashCode ^
        parentID.hashCode ^
        defaultFlag.hashCode ^
        sortOrder.hashCode;
  }
}
