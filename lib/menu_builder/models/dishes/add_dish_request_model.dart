// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'add_dish_data.dart';

class AddDishRequestModel with AddDishData {
  final String? productType;
  final String? type;
  final String? online;
  final String? dining;
  final String? featured;
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
  final String? itemCode;
  final VariationsSelectOnlyOne variationsSelectOnlyOne;

  AddDishRequestModel({
    this.productType,
    this.type,
    this.online,
    this.dining,
    this.featured,
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
    this.itemCode,
    required this.variationsSelectOnlyOne,
  });

  AddDishRequestModel copyWith({
    String? productType,
    String? type,
    String? online,
    String? dining,
    String? featured,
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
    String? itemCode,
    VariationsSelectOnlyOne? variationsSelectOnlyOne,
  }) {
    return AddDishRequestModel(
      productType: productType ?? this.productType,
      type: type ?? this.type,
      online: online ?? this.online,
      dining: dining ?? this.dining,
      featured: featured ?? this.featured,
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
      itemCode: itemCode ?? this.itemCode,
      variationsSelectOnlyOne:
          variationsSelectOnlyOne ?? this.variationsSelectOnlyOne,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final isSingle = productType == 'single';
    final isVariation = productType == 'variation';
    final isMeal = productType == 'meal';

    return <String, dynamic>{
      'productType': productType,
      'type': type,
      'online': online,
      'dining': dining,
      'featured': featured,
      'name': name,
      'description': description,
      'photo': photo,
      'category': category,
      'activeStatus': activeStatus,
      'productMenuGroup': productMenuGroup,
      if (isSingle) ...{
        'price': price,
        'isUnlimitedStock': isUnlimitedStock,
        'quantity': quantity,
        'allergensMaster': allergns,
        'ingredients': ingredients,
      },
      // Top-level list, as in your old AddDishRequestWithVariationModel.
      if (isVariation && variationsSelectOnlyOne.ifVariation != null)
        'variations': variationsSelectOnlyOne.ifVariation!.variations
            .map((e) => e.toMap())
            .toList(),
      if (isMeal && variationsSelectOnlyOne.ifMeal != null)
        'meal':
            variationsSelectOnlyOne.ifMeal!.meal.map((e) => e.toMap()).toList(),
      'allDayAvailable': allDayAvailable,
      'availability': availability,
      'timing': timing,
      'addonsMasterGroup': addonsMasterGroup,
      'itemCode': itemCode,
      'variations_Select_Only_One': variationsSelectOnlyOne.toMap(),
    };
  }

  factory AddDishRequestModel.fromMap(Map<String, dynamic> map) {
    return AddDishRequestModel(
      productType:
          map['productType'] != null ? map['productType'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      online: map['online'] != null ? map['online'] as String : null,
      dining: map['dining'] != null ? map['dining'] as String : null,
      featured: map['featured'] != null ? map['featured'] as String : null,
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
      allergns: List<String>.from(
        (map['allergns'] ?? const <dynamic>[]).map((e) => e.toString()),
      ),
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
      itemCode: map['itemCode'],
      variationsSelectOnlyOne: VariationsSelectOnlyOne.fromMap(
        map['variations_Select_Only_One'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AddDishRequestModel.fromJson(String source) =>
      AddDishRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddDishRequestModel(productType: $productType, type: $type, online: $online, dining: $dining, featured: $featured, name: $name, description: $description, photo: $photo, category: $category, activeStatus: $activeStatus, productMenuGroup: $productMenuGroup, price: $price, isUnlimitedStock: $isUnlimitedStock, quantity: $quantity, allergns: $allergns, ingredients: $ingredients, allDayAvailable: $allDayAvailable, availability: $availability, timing: $timing, addonsMasterGroup: $addonsMasterGroup, itemCode: $itemCode, variationsSelectOnlyOne: $variationsSelectOnlyOne)';
  }

  @override
  bool operator ==(covariant AddDishRequestModel other) {
    if (identical(this, other)) return true;

    return other.productType == productType &&
        other.type == type &&
        other.online == online &&
        other.dining == dining &&
        other.featured == featured &&
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
        listEquals(other.addonsMasterGroup, addonsMasterGroup) &&
        other.itemCode == itemCode &&
        other.variationsSelectOnlyOne == variationsSelectOnlyOne;
  }

  @override
  int get hashCode {
    return productType.hashCode ^
        type.hashCode ^
        online.hashCode ^
        dining.hashCode ^
        featured.hashCode ^
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
        addonsMasterGroup.hashCode ^
        itemCode.hashCode ^
        variationsSelectOnlyOne.hashCode;
  }
}

class VariationsSelectOnlyOne {
  final SingleDishDetails? ifSingle;
  final VariationDetails? ifVariation;
  final MealDetails? ifMeal;
  VariationsSelectOnlyOne({
    this.ifSingle,
    this.ifVariation,
    this.ifMeal,
  });

  VariationsSelectOnlyOne copyWith({
    SingleDishDetails? ifSingle,
    VariationDetails? ifVariation,
    MealDetails? ifMeal,
  }) {
    return VariationsSelectOnlyOne(
      ifSingle: ifSingle ?? this.ifSingle,
      ifVariation: ifVariation ?? this.ifVariation,
      ifMeal: ifMeal ?? this.ifMeal,
    );
  }

  Map<String, dynamic> toMap() => {
        if (ifSingle != null) 'ifSingle': ifSingle!.toMap(),
        if (ifVariation != null) 'ifVariation': ifVariation!.toMap(),
        if (ifMeal != null) 'ifMeal': ifMeal!.toMap(),
      };

  factory VariationsSelectOnlyOne.fromMap(Map<String, dynamic> map) {
    return VariationsSelectOnlyOne(
      ifSingle: map['ifSingle'] != null
          ? SingleDishDetails.fromMap(map['ifSingle'] as Map<String, dynamic>)
          : null,
      ifVariation: map['ifVariation'] != null
          ? VariationDetails.fromMap(map['ifVariation'] as Map<String, dynamic>)
          : null,
      ifMeal: map['ifMeal'] != null
          ? MealDetails.fromMap(map['ifMeal'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariationsSelectOnlyOne.fromJson(String source) =>
      VariationsSelectOnlyOne.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VariationsSelectOnlyOne(ifSingle: $ifSingle, ifVariation: $ifVariation, ifMeal: $ifMeal)';

  @override
  bool operator ==(covariant VariationsSelectOnlyOne other) {
    if (identical(this, other)) return true;

    return other.ifSingle == ifSingle &&
        other.ifVariation == ifVariation &&
        other.ifMeal == ifMeal;
  }

  @override
  int get hashCode =>
      ifSingle.hashCode ^ ifVariation.hashCode ^ ifMeal.hashCode;
}

class SingleDishDetails {
  final String? pvID;
  final String? price;
  final int? isUnlimitedStock;
  final int? quantity;
  final List<dynamic>? allergensMaster;
  final String? ingredients;
  SingleDishDetails({
    this.pvID,
    this.price,
    this.isUnlimitedStock,
    this.quantity,
    this.allergensMaster,
    this.ingredients,
  });

  SingleDishDetails copyWith({
    String? pvID,
    String? price,
    int? isUnlimitedStock,
    int? quantity,
    List<dynamic>? allergensMaster,
    String? ingredients,
  }) {
    return SingleDishDetails(
      pvID: pvID ?? this.pvID,
      price: price ?? this.price,
      isUnlimitedStock: isUnlimitedStock ?? this.isUnlimitedStock,
      quantity: quantity ?? this.quantity,
      allergensMaster: allergensMaster ?? this.allergensMaster,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (pvID != null) 'pvID': pvID,
      'price': price,
      'isUnlimitedStock': isUnlimitedStock,
      'quantity': quantity,
      'allergensMaster': allergensMaster,
      'ingredients': ingredients,
    };
  }

  factory SingleDishDetails.fromMap(Map<String, dynamic> map) {
    return SingleDishDetails(
      pvID: map['pvID']?.toString(),
      price: map['price'] != null ? map['price'] as String : null,
      isUnlimitedStock: map['isUnlimitedStock'] != null
          ? map['isUnlimitedStock'] as int
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      allergensMaster: map['allergensMaster'] != null
          ? List<dynamic>.from((map['allergensMaster'] as List<dynamic>))
          : null,
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleDishDetails.fromJson(String source) =>
      SingleDishDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SingleDishDetails(pvID :$pvID, price: $price, isUnlimitedStock: $isUnlimitedStock, quantity: $quantity, allergensMaster: $allergensMaster, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant SingleDishDetails other) {
    if (identical(this, other)) return true;

    return other.pvID == pvID &&
        other.price == price &&
        other.isUnlimitedStock == isUnlimitedStock &&
        other.quantity == quantity &&
        listEquals(other.allergensMaster, allergensMaster) &&
        other.ingredients == ingredients;
  }

  @override
  int get hashCode {
    return pvID.hashCode ^
        price.hashCode ^
        isUnlimitedStock.hashCode ^
        quantity.hashCode ^
        allergensMaster.hashCode ^
        ingredients.hashCode;
  }
}

class VariationDetails {
  final List<DishVariationItem> variations;

  VariationDetails({required this.variations});

  Map<String, dynamic> toMap() => {
        'variations': variations.map((e) => e.toMap()).toList(),
      };

  factory VariationDetails.fromMap(Map<String, dynamic> map) {
    final raw = map['variations'];
    return VariationDetails(
      variations: raw is List
          ? raw
              .map((e) => DishVariationItem.fromMap(
                  Map<String, dynamic>.from(e as Map)))
              .toList()
          : raw is Map
              ? [DishVariationItem.fromMap(Map<String, dynamic>.from(raw))]
              : <DishVariationItem>[],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'VariationDetails(variations: $variations)';

  @override
  bool operator ==(covariant VariationDetails other) =>
      identical(this, other) || listEquals(other.variations, variations);

  @override
  int get hashCode => variations.hashCode;
}
// class VariationDetails {
//   final DishVariationItem variations;

//   VariationDetails({
//     required this.variations,
//   });

//   VariationDetails copyWith({
//     DishVariationItem? variations,
//   }) {
//     return VariationDetails(
//       variations: variations ?? this.variations,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'variations': variations.toMap(),
//     };
//   }

//   factory VariationDetails.fromMap(Map<String, dynamic> map) {
//     return VariationDetails(
//       variations: DishVariationItem.fromMap(
//         map['variations'] as Map<String, dynamic>,
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory VariationDetails.fromJson(String source) => VariationDetails.fromMap(
//         json.decode(source) as Map<String, dynamic>,
//       );

//   @override
//   String toString() => 'VariationDetails(variations: $variations)';

//   @override
//   bool operator ==(covariant VariationDetails other) {
//     if (identical(this, other)) return true;
//     return other.variations == variations;
//   }

//   @override
//   int get hashCode => variations.hashCode;
// }

class DishVariationItem {
  final String? pvID;
  final String? name;
  final String? price;
  final int? isUnlimitedStock;
  final int? quantity;
  final List<dynamic>? allergensMaster;
  final String? ingredients;
  DishVariationItem({
    this.pvID,
    this.name,
    this.price,
    this.isUnlimitedStock,
    this.quantity,
    this.allergensMaster,
    this.ingredients,
  });

  DishVariationItem copyWith({
    String? pvID,
    String? name,
    String? price,
    int? isUnlimitedStock,
    int? quantity,
    List<dynamic>? allergensMaster,
    String? ingredients,
  }) {
    return DishVariationItem(
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
      if (pvID != null) 'pvID': pvID,
      'name': name,
      'price': price,
      'isUnlimitedStock': isUnlimitedStock,
      'quantity': quantity,
      'allergensMaster': allergensMaster,
      'ingredients': ingredients,
    };
  }

  factory DishVariationItem.fromMap(Map<String, dynamic> map) {
    return DishVariationItem(
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      isUnlimitedStock: map['isUnlimitedStock'] != null
          ? map['isUnlimitedStock'] as int
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      allergensMaster: map['allergensMaster'] != null
          ? List<dynamic>.from((map['allergensMaster'] as List<dynamic>))
          : null,
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
      pvID: map['pvID']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DishVariationItem.fromJson(String source) =>
      DishVariationItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DishVariationItem( pvID :$pvID, name: $name, price: $price, isUnlimitedStock: $isUnlimitedStock, quantity: $quantity, allergensMaster: $allergensMaster, ingredients: $ingredients)';
  }

  @override
  bool operator ==(covariant DishVariationItem other) {
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

class MealDetails {
  final List<MealItem> meal;

  MealDetails({required this.meal});

  Map<String, dynamic> toMap() => {
        'meal': meal.map((e) => e.toMap()).toList(),
      };

  factory MealDetails.fromMap(Map<String, dynamic> map) {
    final raw = map['meal'];
    return MealDetails(
      meal: raw is List
          ? raw
              .map((e) => MealItem.fromMap(Map<String, dynamic>.from(e as Map)))
              .toList()
          : raw is Map
              ? [MealItem.fromMap(Map<String, dynamic>.from(raw))]
              : <MealItem>[],
    );
  }
}
// class MealDetails {
//   final MealItem meal;

//   MealDetails({required this.meal});

//   Map<String, dynamic> toMap() => {
//         'meal': meal.toMap(),
//       };

//   factory MealDetails.fromMap(Map<String, dynamic> map) {
//     return MealDetails(
//       meal: MealItem.fromMap(
//         map['meal'] as Map<String, dynamic>,
//       ),
//     );
//   }
// }

class MealItem {
  final String? pvID;
  final String? name;
  final String? price;
  final int? isUnlimitedStock;
  final int? quantity;
  final List<dynamic>? allergensMaster;
  final String? ingredients;
  final List<dynamic>? addonsMasterGroup;
  MealItem({
    this.pvID,
    this.name,
    this.price,
    this.isUnlimitedStock,
    this.quantity,
    this.allergensMaster,
    this.ingredients,
    this.addonsMasterGroup,
  });

  MealItem copyWith({
    String? pvID,
    String? name,
    String? price,
    int? isUnlimitedStock,
    int? quantity,
    List<dynamic>? allergensMaster,
    String? ingredients,
    List<dynamic>? addonsMasterGroup,
  }) {
    return MealItem(
      pvID: pvID ?? this.pvID,
      name: name ?? this.name,
      price: price ?? this.price,
      isUnlimitedStock: isUnlimitedStock ?? this.isUnlimitedStock,
      quantity: quantity ?? this.quantity,
      allergensMaster: allergensMaster ?? this.allergensMaster,
      ingredients: ingredients ?? this.ingredients,
      addonsMasterGroup: addonsMasterGroup ?? this.addonsMasterGroup,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (pvID != null) 'pvID': pvID,
      'name': name,
      'price': price,
      'isUnlimitedStock': isUnlimitedStock,
      'quantity': quantity,
      'allergensMaster': allergensMaster,
      'ingredients': ingredients,
      'addonsMasterGroup': addonsMasterGroup,
    };
  }

  factory MealItem.fromMap(Map<String, dynamic> map) {
    return MealItem(
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      isUnlimitedStock: map['isUnlimitedStock'] != null
          ? map['isUnlimitedStock'] as int
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      allergensMaster: map['allergensMaster'] != null
          ? List<dynamic>.from((map['allergensMaster'] as List<dynamic>))
          : null,
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
      addonsMasterGroup: map['addonsMasterGroup'] != null
          ? List<dynamic>.from((map['addonsMasterGroup'] as List<dynamic>))
          : null,
      pvID: map['pvID']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MealItem.fromJson(String source) =>
      MealItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MealItem(pvID :$pvID, name: $name, price: $price, isUnlimitedStock: $isUnlimitedStock, quantity: $quantity, allergensMaster: $allergensMaster, ingredients: $ingredients, addonsMasterGroup: $addonsMasterGroup)';
  }

  @override
  bool operator ==(covariant MealItem other) {
    if (identical(this, other)) return true;

    return other.pvID == pvID &&
        other.name == name &&
        other.price == price &&
        other.isUnlimitedStock == isUnlimitedStock &&
        other.quantity == quantity &&
        listEquals(other.allergensMaster, allergensMaster) &&
        other.ingredients == ingredients &&
        listEquals(other.addonsMasterGroup, addonsMasterGroup);
  }

  @override
  int get hashCode {
    return pvID.hashCode ^
        name.hashCode ^
        price.hashCode ^
        isUnlimitedStock.hashCode ^
        quantity.hashCode ^
        allergensMaster.hashCode ^
        ingredients.hashCode ^
        addonsMasterGroup.hashCode;
  }
}
