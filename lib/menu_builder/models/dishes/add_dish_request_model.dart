// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'add_dish_data.dart';

class AddDishRequestModel with AddDishData {
  final String? productType;
  final String? type;
  final String? online;
  final String? dining;
  final String? name;
  final String? description;
  final String? photo;
  final List<dynamic> category;
  final int? activeStatus;
  final List<String> productMenuGroup;
  final double? price;
  final int? isUnlimitedStock;
  final int? quantity;
  final List<String> allergns;
  final String? ingredients;
  final String? allDayAvailable;
  final List<String> availability;
  final List<Map<String, dynamic>> timing;
  final List<String> addonsMasterGroup;
  AddDishRequestModel({
    this.productType,
    this.type,
    this.online,
    this.dining,
    this.name,
    this.description,
    this.photo,
    this.category = const [],
    this.activeStatus,
    this.productMenuGroup = const [],
    this.price,
    this.isUnlimitedStock,
    this.quantity,
    this.allergns = const [],
    this.ingredients,
    this.allDayAvailable,
    this.availability = const [],
    this.timing = const [],
    this.addonsMasterGroup = const [],
  });

  AddDishRequestModel copyWith({
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
    double? price,
    int? isUnlimitedStock,
    int? quantity,
    List<String>? allergns,
    String? ingredients,
    String? allDayAvailable,
    List<String>? availability,
    List<Map<String, dynamic>>? timing,
    List<String>? addonsMasterGroup,
  }) {
    return AddDishRequestModel(
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
      price: price ?? this.price,
      isUnlimitedStock: isUnlimitedStock ?? this.isUnlimitedStock,
      quantity: quantity ?? this.quantity,
      allergns: allergns ?? this.allergns,
      ingredients: ingredients ?? this.ingredients,
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
      'price': price,
      'isUnlimitedStock': isUnlimitedStock,
      'quantity': quantity,
      'allergns': allergns,
      'ingredients': ingredients,
      'allDayAvailable': allDayAvailable,
      'availability': availability,
      'timing': timing,
      'addonsMasterGroup': addonsMasterGroup,
    };
  }

  factory AddDishRequestModel.fromMap(Map<String, dynamic> map) {
    return AddDishRequestModel(
      productType:
          map['productType'] != null ? map['productType'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      online: map['online'] != null ? map['online'] as String : null,
      dining: map['dining'] != null ? map['dining'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      category: List<dynamic>.from((map['category'] as List<dynamic>)),
      activeStatus:
          map['activeStatus'] != null ? map['activeStatus'] as int : null,
      productMenuGroup:
          List<String>.from((map['productMenuGroup'] as List<String>)),
      price: map['price'] != null ? map['price'] as double : null,
      isUnlimitedStock: map['isUnlimitedStock'] != null
          ? map['isUnlimitedStock'] as int
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      allergns: List<String>.from((map['allergns'] as List<String>)),
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
      allDayAvailable: map['allDayAvailable'] != null
          ? map['allDayAvailable'] as String
          : null,
      availability: List<String>.from((map['availability'] as List<String>)),
      timing: List<Map<String, dynamic>>.from(
        (map['timing'] ?? []).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
      addonsMasterGroup:
          List<String>.from((map['addonsMasterGroup'] as List<String>)),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AddDishRequestModel.fromJson(String source) =>
      AddDishRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddSingleDishRequest(productType: $productType, type: $type, online: $online, dining: $dining, name: $name, description: $description, photo: $photo, category: $category, activeStatus: $activeStatus, productMenuGroup: $productMenuGroup, price: $price, isUnlimitedStock: $isUnlimitedStock, quantity: $quantity, allergns: $allergns, ingredients: $ingredients, allDayAvailable: $allDayAvailable, availability: $availability, timing: $timing, addonsMasterGroup: $addonsMasterGroup)';
  }

  @override
  bool operator ==(covariant AddDishRequestModel other) {
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
        other.price == price &&
        other.isUnlimitedStock == isUnlimitedStock &&
        other.quantity == quantity &&
        listEquals(other.allergns, allergns) &&
        other.ingredients == ingredients &&
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
        price.hashCode ^
        isUnlimitedStock.hashCode ^
        quantity.hashCode ^
        allergns.hashCode ^
        ingredients.hashCode ^
        allDayAvailable.hashCode ^
        availability.hashCode ^
        timing.hashCode ^
        addonsMasterGroup.hashCode;
  }
}
