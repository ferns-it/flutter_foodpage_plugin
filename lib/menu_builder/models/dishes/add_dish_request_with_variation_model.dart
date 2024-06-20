import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'add_dish_data.dart';

class AddDishRequestWithVariationModel with AddDishData {
  final String? productType;
  final String? type;
  final String? online;
  final String? dining;
  final String? name;
  final String? description;
  final String? photo;
  final List<dynamic>? category;
  final int? activeStatus;
  final List<String>? productMenuGroup;
  final List<VariationDishData>? variations;
  final String? allDayAvailable;
  final List<String>? availability;
  final List<Map<String, dynamic>>? timing;
  final List<String>? addonsMasterGroup;
  AddDishRequestWithVariationModel({
    this.productType,
    this.type,
    this.online,
    this.dining,
    this.name,
    this.description,
    this.photo,
    this.category,
    this.activeStatus,
    this.productMenuGroup,
    this.variations,
    this.allDayAvailable,
    this.availability,
    this.timing,
    this.addonsMasterGroup,
  });

  AddDishRequestWithVariationModel copyWith({
    String? productType,
    String? type,
    String? online,
    String? dining,
    String? name,
    String? description,
    String? photo,
    List<dynamic>? category,
    int? activeStatus,
    List<String>? productMenuGroup,
    List<VariationDishData>? variations,
    String? allDayAvailable,
    List<String>? availability,
    List<Map<String, dynamic>>? timing,
    List<String>? addonsMasterGroup,
  }) {
    return AddDishRequestWithVariationModel(
      productType: productType ?? this.productType,
      type: type ?? this.type,
      online: online ?? this.online,
      dining: dining ?? this.dining,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      category: category ?? this.category,
      activeStatus: activeStatus ?? this.activeStatus,
      productMenuGroup: productMenuGroup ?? this.productMenuGroup,
      variations: variations ?? this.variations,
      allDayAvailable: allDayAvailable ?? this.allDayAvailable,
      availability: availability ?? this.availability,
      timing: timing ?? this.timing,
      addonsMasterGroup: addonsMasterGroup ?? this.addonsMasterGroup,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productType': productType,
      'type': type,
      'online': online,
      'dining': dining,
      'name': name,
      'description': description,
      'photo': photo,
      'category': category,
      'activeStatus': activeStatus,
      'productMenuGroup': productMenuGroup,
      'variations': variations?.map((x) => x.toMap()).toList(),
      'allDayAvailable': allDayAvailable,
      'availability': availability,
      'timing': timing,
      'addonsMasterGroup': addonsMasterGroup,
    };
  }

  factory AddDishRequestWithVariationModel.fromMap(Map<String, dynamic> map) {
    return AddDishRequestWithVariationModel(
      productType:
          map['productType'] != null ? map['productType'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      online: map['online'] != null ? map['online'] as String : null,
      dining: map['dining'] != null ? map['dining'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      category: map['category'] != null
          ? List<dynamic>.from((map['category'] as List<dynamic>))
          : null,
      activeStatus:
          map['activeStatus'] != null ? map['activeStatus'] as int : null,
      productMenuGroup: map['productMenuGroup'] != null
          ? List<String>.from((map['productMenuGroup'] as List<String>))
          : null,
      variations: map['variations'] != null
          ? List<VariationDishData>.from(
              (map['variations'] as List<int>).map<VariationDishData?>(
                (x) => VariationDishData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      allDayAvailable: map['allDayAvailable'] != null
          ? map['allDayAvailable'] as String
          : null,
      availability: map['availability'] != null
          ? List<String>.from((map['availability'] as List<String>))
          : null,
      timing: map['timing'] != null
          ? List<Map<String, dynamic>>.from(
              (map['timing'] as List<dynamic>).map<Map<String, dynamic>?>(
                (x) => x,
              ),
            )
          : null,
      addonsMasterGroup: map['addonsMasterGroup'] != null
          ? List<String>.from((map['addonsMasterGroup'] as List<String>))
          : null,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AddDishRequestWithVariationModel.fromJson(String source) =>
      AddDishRequestWithVariationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddVariationDishRequest(productType: $productType, type: $type, online: $online, dining: $dining, name: $name, description: $description, photo: $photo, category: $category, activeStatus: $activeStatus, productMenuGroup: $productMenuGroup, variations: $variations, allDayAvailable: $allDayAvailable, availability: $availability, timing: $timing, addonsMasterGroup: $addonsMasterGroup)';
  }

  @override
  bool operator ==(covariant AddDishRequestWithVariationModel other) {
    if (identical(this, other)) return true;

    return other.productType == productType &&
        other.type == type &&
        other.online == online &&
        other.dining == dining &&
        other.name == name &&
        other.description == description &&
        other.photo == photo &&
        listEquals(other.category, category) &&
        other.activeStatus == activeStatus &&
        listEquals(other.productMenuGroup, productMenuGroup) &&
        listEquals(other.variations, variations) &&
        other.allDayAvailable == allDayAvailable &&
        listEquals(other.availability, availability) &&
        listEquals(other.timing, timing) &&
        listEquals(other.addonsMasterGroup, addonsMasterGroup);
  }

  @override
  int get hashCode {
    return productType.hashCode ^
        type.hashCode ^
        online.hashCode ^
        dining.hashCode ^
        name.hashCode ^
        description.hashCode ^
        photo.hashCode ^
        category.hashCode ^
        activeStatus.hashCode ^
        productMenuGroup.hashCode ^
        variations.hashCode ^
        allDayAvailable.hashCode ^
        availability.hashCode ^
        timing.hashCode ^
        addonsMasterGroup.hashCode;
  }
}

class VariationDishData {
  final String? pvID;
  final String? name;
  final double? price;
  final int? isUnlimitedStock;
  final int? quantity;
  final List<dynamic>? allergensMaster;
  final String? ingredients;
  VariationDishData({
    this.pvID,
    this.name,
    this.price,
    this.isUnlimitedStock,
    this.quantity,
    this.allergensMaster,
    this.ingredients,
  });

  VariationDishData copyWith({
    String? pvID,
    String? name,
    double? price,
    int? isUnlimitedStock,
    int? quantity,
    List<dynamic>? allergensMaster,
    String? ingredients,
  }) {
    return VariationDishData(
      pvID: pvID ?? this.pvID,
      name: name ?? this.name,
      price: price ?? this.price,
      isUnlimitedStock: isUnlimitedStock ?? this.isUnlimitedStock,
      quantity: quantity ?? this.quantity,
      allergensMaster: allergensMaster ?? this.allergensMaster,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pvID': pvID,
      'name': name,
      'price': price,
      'isUnlimitedStock': isUnlimitedStock,
      'quantity': quantity,
      'allergensMaster': allergensMaster,
      'ingredients': ingredients,
    };
  }

  factory VariationDishData.fromMap(Map<String, dynamic> map) {
    return VariationDishData(
      pvID: map['pvID'] != null ? map['name'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      isUnlimitedStock: map['isUnlimitedStock'] != null
          ? map['isUnlimitedStock'] as int
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      allergensMaster: map['allergensMaster'] != null
          ? List<String>.from((map['allergensMaster'] as List<String>))
          : null,
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariationDishData.fromJson(String source) =>
      VariationDishData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariationDishData(pvID: $pvID,name: $name, price: $price, isUnlimitedStock: $isUnlimitedStock, quantity: $quantity, allergensMaster: $allergensMaster, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant VariationDishData other) {
    if (identical(this, other)) return true;

    return other.pvID == pvID &&
        other.name == name &&
        other.price == price &&
        other.isUnlimitedStock == isUnlimitedStock &&
        other.quantity == quantity &&
        listEquals(other.allergensMaster, allergensMaster) &&
        other.ingredients == ingredients;
  }

  @override
  int get hashCode {
    return pvID.hashCode ^
        name.hashCode ^
        price.hashCode ^
        isUnlimitedStock.hashCode ^
        quantity.hashCode ^
        allergensMaster.hashCode ^
        ingredients.hashCode;
  }
}
