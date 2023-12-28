// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DishData {
  final String? pID;
  final String? shopID;
  final String? shopSpecificID;
  final String? identifierName;
  final String? name;
  final String? description;
  final String? photo;
  final String? productType;
  final String? type;
  final String? online;
  final String? dining;
  final String? activeStatus;
  final String? price;
  final String? priceValue;
  final List<DishCategory> categories;
  DishData({
    this.pID,
    this.shopID,
    this.shopSpecificID,
    this.identifierName,
    this.name,
    this.description,
    this.photo,
    this.productType,
    this.type,
    this.online,
    this.dining,
    this.activeStatus,
    this.price,
    this.priceValue,
     this.categories = const[],
  });

  DishData copyWith({
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
    List<DishCategory>? categories,
  }) {
    return DishData(
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

  factory DishData.fromMap(Map<String, dynamic> map) {
    return DishData(
      pID: map['pID'] != null ? map['pID'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      shopSpecificID: map['shopSpecificID'] != null ? map['shopSpecificID'] as String : null,
      identifierName: map['identifierName'] != null ? map['identifierName'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      productType: map['productType'] != null ? map['productType'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      online: map['online'] != null ? map['online'] as String : null,
      dining: map['dining'] != null ? map['dining'] as String : null,
      activeStatus: map['activeStatus'] != null ? map['activeStatus'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      priceValue: map['priceValue'] != null ? map['priceValue'] as String : null,
      categories:map['categories'] != null ? List<DishCategory>.from((map['categories'] as List<dynamic>).map<DishCategory>((x) => DishCategory.fromMap(x as Map<String,dynamic>),),) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory DishData.fromJson(String source) => DishData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DishData(pID: $pID, shopID: $shopID, shopSpecificID: $shopSpecificID, identifierName: $identifierName, name: $name, description: $description, photo: $photo, productType: $productType, type: $type, online: $online, dining: $dining, activeStatus: $activeStatus, price: $price, priceValue: $priceValue, categories: $categories)';
  }

  @override
  bool operator ==(covariant DishData other) {
    if (identical(this, other)) return true;
  
    return 
      other.pID == pID &&
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

class DishCategory {
  final String? cID;
  final String? name;
  DishCategory({
    this.cID,
    this.name,
  });

  DishCategory copyWith({
    String? cID,
    String? name,
  }) {
    return DishCategory(
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

  factory DishCategory.fromMap(Map<String, dynamic> map) {
    return DishCategory(
      cID: map['cID'] != null ? map['cID'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DishCategory.fromJson(String source) =>
      DishCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DishCategory(cID: $cID, name: $name)';

  @override
  bool operator ==(covariant DishCategory other) {
    if (identical(this, other)) return true;

    return other.cID == cID && other.name == name;
  }

  @override
  int get hashCode => cID.hashCode ^ name.hashCode;
}
