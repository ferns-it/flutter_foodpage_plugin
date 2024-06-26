// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../../core/utils/helper_utils.dart';

class DishViewDetailsModel {
  final BasicData basicData;
  final List<VariationData> variationData;
  final List<SelectedCategorie> selectedCategories;
  final List<dynamic> selectedAddonGroups;
  final List<dynamic> selectedMenuList;
  final Availability availability;
  DishViewDetailsModel({
    required this.basicData,
    required this.variationData,
    required this.selectedCategories,
    required this.selectedAddonGroups,
    required this.selectedMenuList,
    required this.availability,
  });

  DishViewDetailsModel copyWith({
    BasicData? basicData,
    List<VariationData>? variationData,
    List<SelectedCategorie>? selectedCategories,
    List<String>? selectedAddonGroups,
    List<String>? selectedMenuList,
    Availability? availability,
  }) {
    return DishViewDetailsModel(
      basicData: basicData ?? this.basicData,
      variationData: variationData ?? this.variationData,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedAddonGroups: selectedAddonGroups ?? this.selectedAddonGroups,
      selectedMenuList: selectedMenuList ?? this.selectedMenuList,
      availability: availability ?? this.availability,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'basicData': basicData.toMap(),
      'variationData': variationData.map((x) => x.toMap()).toList(),
      'selectedCategories': selectedCategories.map((x) => x.toMap()).toList(),
      'selectedAddonGroups': selectedAddonGroups,
      'selectedMenuList': selectedMenuList,
      'availability': availability.toMap(),
    };
  }

  factory DishViewDetailsModel.fromMap(Map<String, dynamic> map) {
    List<VariationData> variationDataList = [];
    if (map['variationData'] is Map<String, dynamic>) {
      variationDataList = [
        VariationData.fromMap(map['variationData'] as Map<String, dynamic>)
      ];
    } else {
      variationDataList = List<VariationData>.from(
        (map['variationData'] ?? []).map<VariationData>(
          (x) => VariationData.fromMap(x as Map<String, dynamic>),
        ),
      );
    }

    return DishViewDetailsModel(
      basicData: BasicData.fromMap(map['basicData'] as Map<String, dynamic>),
      variationData: variationDataList,
      selectedCategories: List<SelectedCategorie>.from(
        (map['selectedCategories'] ?? []).map<SelectedCategorie>(
          (x) => SelectedCategorie.fromMap(x as Map<String, dynamic>),
        ),
      ),
      selectedAddonGroups:
          List<dynamic>.from((map['selectedAddonGroups'] ?? [])),
      selectedMenuList:
          List<dynamic>.from((map['selectedMenuList'] as List<dynamic>)),
      availability:
          Availability.fromMap(map['availability'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DishViewDetailsModel.fromJson(String source) =>
      DishViewDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DishViewDetailsModel(basicData: $basicData, variationData: $variationData, selectedCategories: $selectedCategories, selectedAddonGroups: $selectedAddonGroups, selectedMenuList: $selectedMenuList, availability: $availability)';
  }

  List<String> get formattedTiming =>
      availability.timing.map((e) => e.formatTime).toList();

  List<String> get formattedCategories =>
      selectedCategories.map((e) => e.cName).toList();

  @override
  bool operator ==(covariant DishViewDetailsModel other) {
    if (identical(this, other)) return true;

    return other.basicData == basicData &&
        listEquals(other.variationData, variationData) &&
        listEquals(other.selectedCategories, selectedCategories) &&
        listEquals(other.selectedAddonGroups, selectedAddonGroups) &&
        listEquals(other.selectedMenuList, selectedMenuList) &&
        other.availability == availability;
  }

  @override
  int get hashCode {
    return basicData.hashCode ^
        variationData.hashCode ^
        selectedCategories.hashCode ^
        selectedAddonGroups.hashCode ^
        selectedMenuList.hashCode ^
        availability.hashCode;
  }
}

class BasicData {
  final String pID;
  final String productType;
  final String shopID;
  final String shopSpecificID;
  final String identifierName;
  final String name;
  final String description;
  final String photo;
  final String type;
  final String online;
  final String dining;
  final String activeStatus;
  BasicData({
    required this.pID,
    required this.productType,
    required this.shopID,
    required this.shopSpecificID,
    required this.identifierName,
    required this.name,
    required this.description,
    required this.photo,
    required this.type,
    required this.online,
    required this.dining,
    required this.activeStatus,
  });

  BasicData copyWith({
    String? pID,
    String? productType,
    String? shopID,
    String? shopSpecificID,
    String? identifierName,
    String? name,
    String? description,
    String? photo,
    String? type,
    String? online,
    String? dining,
    String? activeStatus,
  }) {
    return BasicData(
      pID: pID ?? this.pID,
      productType: productType ?? this.productType,
      shopID: shopID ?? this.shopID,
      shopSpecificID: shopSpecificID ?? this.shopSpecificID,
      identifierName: identifierName ?? this.identifierName,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      type: type ?? this.type,
      online: online ?? this.online,
      dining: dining ?? this.dining,
      activeStatus: activeStatus ?? this.activeStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pID': pID,
      'productType': productType,
      'shopID': shopID,
      'shopSpecificID': shopSpecificID,
      'identifierName': identifierName,
      'name': name,
      'description': description,
      'photo': photo,
      'type': type,
      'online': online,
      'dining': dining,
      'activeStatus': activeStatus,
    };
  }

  factory BasicData.fromMap(Map<String, dynamic> map) {
    return BasicData(
      pID: map['pID'] as String,
      productType: map['productType'] as String,
      shopID: map['shopID'] as String,
      shopSpecificID: map['shopSpecificID'] as String,
      identifierName: map['identifierName'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      photo: map['photo'] as String,
      type: map['type'] as String,
      online: map['online'] as String,
      dining: map['dining'] as String,
      activeStatus: map['activeStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicData.fromJson(String source) =>
      BasicData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BasicData(pID: $pID, productType: $productType, shopID: $shopID, shopSpecificID: $shopSpecificID, identifierName: $identifierName, name: $name, description: $description, photo: $photo, type: $type, online: $online, dining: $dining, activeStatus: $activeStatus)';
  }

  @override
  bool operator ==(covariant BasicData other) {
    if (identical(this, other)) return true;

    return other.pID == pID &&
        other.productType == productType &&
        other.shopID == shopID &&
        other.shopSpecificID == shopSpecificID &&
        other.identifierName == identifierName &&
        other.name == name &&
        other.description == description &&
        other.photo == photo &&
        other.type == type &&
        other.online == online &&
        other.dining == dining &&
        other.activeStatus == activeStatus;
  }

  @override
  int get hashCode {
    return pID.hashCode ^
        productType.hashCode ^
        shopID.hashCode ^
        shopSpecificID.hashCode ^
        identifierName.hashCode ^
        name.hashCode ^
        description.hashCode ^
        photo.hashCode ^
        type.hashCode ^
        online.hashCode ^
        dining.hashCode ^
        activeStatus.hashCode;
  }
}

class VariationData {
  final String pvID;
  final String name;
  final String price;
  final String displayPrice;
  final String ingredients;
  final String isUnlimitedStock;
  final String stock;
  final List<Allergen> allergens;
  final List<dynamic> selectedallergens;
  final List<dynamic> allergensMaster;
  VariationData({
    required this.pvID,
    required this.name,
    required this.price,
    required this.displayPrice,
    required this.ingredients,
    required this.isUnlimitedStock,
    required this.stock,
    required this.allergens,
    required this.selectedallergens,
    required this.allergensMaster,
  });

  VariationData copyWith({
    String? pvID,
    String? name,
    String? price,
    String? displayPrice,
    String? ingredients,
    String? isUnlimitedStock,
    String? stock,
    List<Allergen>? allergens,
    List<String>? selectedallergens,
    List<String>? allergensMaster,
  }) {
    return VariationData(
      pvID: pvID ?? this.pvID,
      name: name ?? this.name,
      price: price ?? this.price,
      displayPrice: displayPrice ?? this.displayPrice,
      ingredients: ingredients ?? this.ingredients,
      isUnlimitedStock: isUnlimitedStock ?? this.isUnlimitedStock,
      stock: stock ?? this.stock,
      allergens: allergens ?? this.allergens,
      selectedallergens: selectedallergens ?? this.selectedallergens,
      allergensMaster: allergensMaster ?? this.allergensMaster,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pvID': pvID,
      'name': name,
      'price': price,
      'displayPrice': displayPrice,
      'ingredients': ingredients,
      'isUnlimitedStock': isUnlimitedStock,
      'stock': stock,
      'allergens': allergens.map((x) => x.toMap()).toList(),
      'selectedallergens': selectedallergens,
      'allergensMaster': allergensMaster,
    };
  }

  factory VariationData.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return VariationData(
      pvID: map['pvID'] as String,
      name: map['name'] ?? "",
      price: map['price'] as String,
      displayPrice: map['displayPrice'] ?? "",
      ingredients: map['ingredients'] as String,
      isUnlimitedStock: map['isUnlimitedStock'] as String,
      stock: map['stock'] as String,
      allergens: List<Allergen>.from(
        (map['allergens'] ?? []).map<Allergen>(
          (x) => Allergen.fromMap(x as Map<String, dynamic>),
        ),
      ),
      selectedallergens: List<dynamic>.from((map['selectedallergens'] ?? [])),
      allergensMaster: List<dynamic>.from((map['allergensMaster'] ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  String get formattedAllergens =>
      allergens.map((e) => e.name).toList().join(", ");

  factory VariationData.fromJson(String source) =>
      VariationData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VariationData(pvID: $pvID, name: $name, price: $price, displayPrice: $displayPrice, ingredients: $ingredients, isUnlimitedStock: $isUnlimitedStock, stock: $stock, allergens: $allergens, selectedallergens: $selectedallergens, allergensMaster: $allergensMaster)';
  }

  @override
  bool operator ==(covariant VariationData other) {
    if (identical(this, other)) return true;

    return other.pvID == pvID &&
        other.name == name &&
        other.price == price &&
        other.displayPrice == displayPrice &&
        other.ingredients == ingredients &&
        other.isUnlimitedStock == isUnlimitedStock &&
        other.stock == stock &&
        listEquals(other.allergens, allergens) &&
        listEquals(other.selectedallergens, selectedallergens) &&
        listEquals(other.allergensMaster, allergensMaster);
  }

  @override
  int get hashCode {
    return pvID.hashCode ^
        name.hashCode ^
        price.hashCode ^
        displayPrice.hashCode ^
        ingredients.hashCode ^
        isUnlimitedStock.hashCode ^
        stock.hashCode ^
        allergens.hashCode ^
        selectedallergens.hashCode ^
        allergensMaster.hashCode;
  }
}

class Allergen {
  final String id;
  final String name;
  Allergen({
    required this.id,
    required this.name,
  });

  Allergen copyWith({
    String? id,
    String? name,
  }) {
    return Allergen(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Allergen.fromMap(Map<String, dynamic> map) {
    return Allergen(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Allergen.fromJson(String source) =>
      Allergen.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Allergen(id: $id, name: $name)';

  @override
  bool operator ==(covariant Allergen other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class SelectedCategorie {
  final String cID;
  final String cName;
  SelectedCategorie({
    required this.cID,
    required this.cName,
  });

  SelectedCategorie copyWith({
    String? cID,
    String? cName,
  }) {
    return SelectedCategorie(
      cID: cID ?? this.cID,
      cName: cName ?? this.cName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cID': cID,
      'cName': cName,
    };
  }

  factory SelectedCategorie.fromMap(Map<String, dynamic> map) {
    return SelectedCategorie(
      cID: map['cID'] as String,
      cName: map['cName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectedCategorie.fromJson(String source) =>
      SelectedCategorie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SelectedCategorie(cID: $cID, cName: $cName)';

  @override
  bool operator ==(covariant SelectedCategorie other) {
    if (identical(this, other)) return true;

    return other.cID == cID && other.cName == cName;
  }

  @override
  int get hashCode => cID.hashCode ^ cName.hashCode;
}

class Availability {
  final bool isAllday;
  final List<dynamic> days;
  final List<Timing> timing;
  Availability({
    required this.isAllday,
    required this.days,
    required this.timing,
  });

  Availability copyWith({
    bool? isAllday,
    List<String>? days,
    List<Timing>? timing,
  }) {
    return Availability(
      isAllday: isAllday ?? this.isAllday,
      days: days ?? this.days,
      timing: timing ?? this.timing,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAllday': isAllday,
      'days': days,
      'timing': timing.map((x) => x.toMap()).toList(),
    };
  }

  factory Availability.fromMap(Map<String, dynamic> map) {
    return Availability(
      isAllday: map['isAllday'] as bool,
      days: List<dynamic>.from((map['days'] as List<dynamic>)),
      timing: List<Timing>.from(
        (map['timing'] ?? []).map<Timing>(
          (x) => Timing.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Availability.fromJson(String source) =>
      Availability.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Availability(isAllday: $isAllday, days: $days, timing: $timing)';

  @override
  bool operator ==(covariant Availability other) {
    if (identical(this, other)) return true;

    return other.isAllday == isAllday &&
        listEquals(other.days, days) &&
        listEquals(other.timing, timing);
  }

  @override
  int get hashCode => isAllday.hashCode ^ days.hashCode ^ timing.hashCode;
}

class Timing {
  final String startTime;
  final String endTime;
  Timing({
    required this.startTime,
    required this.endTime,
  });

  Timing copyWith({
    String? startTime,
    String? endTime,
  }) {
    return Timing(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory Timing.fromMap(Map<String, dynamic> map) {
    return Timing(
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Timing.fromJson(String source) =>
      Timing.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Timing(startTime: $startTime, endTime: $endTime)';

  String get formatTime =>
      '${convertToAMPM(startTime)} to ${convertToAMPM(endTime)}';

  @override
  bool operator ==(covariant Timing other) {
    if (identical(this, other)) return true;

    return other.startTime == startTime && other.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}
