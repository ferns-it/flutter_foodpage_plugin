// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DishCollectionModel {
  final List<DishDetails> dishes;
  DishCollectionModel({
    required this.dishes,
  });

  bool get isDishesEmpty => dishes.isEmpty;
  int get totalDishes => dishes.length;

  DishCollectionModel copyWith({
    List<DishDetails>? dishes,
  }) {
    return DishCollectionModel(
      dishes: dishes ?? this.dishes,
    );
  }
}

class DishDetails {
  final String pID;
  final String shopID;
  final String shopSpecificID;
  final String identifierName;
  final String name;
  final String description;
  final String photo;
  final String productType;
  final String type;
  final String online;
  final String dining;
  final String activeStatus;
  final String price;
  final String priceValue;
  final List<Category> categories;
  DishDetails({
    required this.pID,
    required this.shopID,
    required this.shopSpecificID,
    required this.identifierName,
    required this.name,
    required this.description,
    required this.photo,
    required this.productType,
    required this.type,
    required this.online,
    required this.dining,
    required this.activeStatus,
    required this.price,
    required this.priceValue,
    required this.categories,
  });

  DishDetails copyWith({
    String? pID,
    String? shopID,
    String? shopSpecificID,
    String? identifierName,
    String? name,
    String? description,
    String? photo,
    String? productType,
    String? type,
    String? online,
    String? dining,
    String? activeStatus,
    String? price,
    String? priceValue,
    List<Category>? categories,
  }) {
    return DishDetails(
      pID: pID ?? this.pID,
      shopID: shopID ?? this.shopID,
      shopSpecificID: shopSpecificID ?? this.shopSpecificID,
      identifierName: identifierName ?? this.identifierName,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      productType: productType ?? this.productType,
      type: type ?? this.type,
      online: online ?? this.online,
      dining: dining ?? this.dining,
      activeStatus: activeStatus ?? this.activeStatus,
      price: price ?? this.price,
      priceValue: priceValue ?? this.priceValue,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pID': pID,
      'shopID': shopID,
      'shopSpecificID': shopSpecificID,
      'identifierName': identifierName,
      'name': name,
      'description': description,
      'photo': photo,
      'productType': productType,
      'type': type,
      'online': online,
      'dining': dining,
      'activeStatus': activeStatus,
      'price': price,
      'priceValue': priceValue,
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory DishDetails.fromMap(Map<String, dynamic> map) {
    return DishDetails(
      pID: map['pID'] as String,
      shopID: map['shopID'] as String,
      shopSpecificID: map['shopSpecificID'] as String,
      identifierName: map['identifierName'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      photo: map['photo'] as String,
      productType: map['productType'] as String,
      type: map['type'] as String,
      online: map['online'] as String,
      dining: map['dining'] as String,
      activeStatus: map['activeStatus'] as String,
      price: map['price'] as String,
      priceValue: map['priceValue'] as String,
      categories: List<Category>.from(
        (map['categories'] ?? []).map<Category>(
          (x) => Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  bool get onlineEnabled => online == "Yes";
  bool get diningEnabled => dining == "Yes";
  bool get active => activeStatus == "Yes";

  String toJson() => json.encode(toMap());

  factory DishDetails.fromJson(String source) =>
      DishDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DishDetails(pID: $pID, shopID: $shopID, shopSpecificID: $shopSpecificID, identifierName: $identifierName, name: $name, description: $description, photo: $photo, productType: $productType, type: $type, online: $online, dining: $dining, activeStatus: $activeStatus, price: $price, priceValue: $priceValue, categories: $categories)';
  }

  @override
  bool operator ==(covariant DishDetails other) {
    if (identical(this, other)) return true;

    return other.pID == pID &&
        other.shopID == shopID &&
        other.shopSpecificID == shopSpecificID &&
        other.identifierName == identifierName &&
        other.name == name &&
        other.description == description &&
        other.photo == photo &&
        other.productType == productType &&
        other.type == type &&
        other.online == online &&
        other.dining == dining &&
        other.activeStatus == activeStatus &&
        other.price == price &&
        other.priceValue == priceValue &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode {
    return pID.hashCode ^
        shopID.hashCode ^
        shopSpecificID.hashCode ^
        identifierName.hashCode ^
        name.hashCode ^
        description.hashCode ^
        photo.hashCode ^
        productType.hashCode ^
        type.hashCode ^
        online.hashCode ^
        dining.hashCode ^
        activeStatus.hashCode ^
        price.hashCode ^
        priceValue.hashCode ^
        categories.hashCode;
  }
}

class Category {
  final String cID;
  final String name;
  Category({
    required this.cID,
    required this.name,
  });

  Category copyWith({
    String? cID,
    String? name,
  }) {
    return Category(
      cID: cID ?? this.cID,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cID': cID,
      'name': name,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      cID: map['cID'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Categorie(cID: $cID, name: $name)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.cID == cID && other.name == name;
  }

  @override
  int get hashCode => cID.hashCode ^ name.hashCode;
}
