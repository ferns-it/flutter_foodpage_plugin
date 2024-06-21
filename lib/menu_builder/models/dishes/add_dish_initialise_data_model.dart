// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddDishInitializeDataModel {
  final TypeInitialiseData type;
  final DishtypeInitialiseData dishtype;
  final AvailabilityInitialiseData availability;
  final CategoryInitialiseData category;
  final StatusInitialiseData status;
  final ProductMenuInitialiseData productMenu;
  final TimingInitialiseData timing;
  final MasterAddonsInitialiseData masterAddons;
  final AllergensInitialiseData allergens;
  AddDishInitializeDataModel(
      {required this.type,
      required this.dishtype,
      required this.availability,
      required this.category,
      required this.status,
      required this.productMenu,
      required this.timing,
      required this.masterAddons,
      required this.allergens});

  AddDishInitializeDataModel copyWith({
    TypeInitialiseData? type,
    DishtypeInitialiseData? dishtype,
    AvailabilityInitialiseData? availability,
    CategoryInitialiseData? category,
    StatusInitialiseData? status,
    ProductMenuInitialiseData? productMenu,
    TimingInitialiseData? timing,
    MasterAddonsInitialiseData? masterAddons,
    AllergensInitialiseData? allergens,
  }) {
    return AddDishInitializeDataModel(
        type: type ?? this.type,
        dishtype: dishtype ?? this.dishtype,
        availability: availability ?? this.availability,
        category: category ?? this.category,
        status: status ?? this.status,
        productMenu: productMenu ?? this.productMenu,
        timing: timing ?? this.timing,
        masterAddons: masterAddons ?? this.masterAddons,
        allergens: allergens ?? this.allergens);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toMap(),
      'dishtype': dishtype.toMap(),
      'availability': availability.toMap(),
      'category': category.toMap(),
      'status': status.toMap(),
      'productMenu': productMenu.toMap(),
      'timing': timing.toMap(),
      'masterAddons': masterAddons.toMap(),
      'allergens': allergens.toMap(),
    };
  }

  factory AddDishInitializeDataModel.fromMap(Map<String, dynamic> map) {
    return AddDishInitializeDataModel(
        type: TypeInitialiseData.fromMap(map['type'] as Map<String, dynamic>),
        dishtype: DishtypeInitialiseData.fromMap(
            map['dishtype'] as Map<String, dynamic>),
        availability: AvailabilityInitialiseData.fromMap(
            map['availability'] as Map<String, dynamic>),
        category: CategoryInitialiseData.fromMap(
            map['category'] as Map<String, dynamic>),
        status:
            StatusInitialiseData.fromMap(map['status'] as Map<String, dynamic>),
        productMenu: ProductMenuInitialiseData.fromMap(
            map['productMenu'] as Map<String, dynamic>),
        timing:
            TimingInitialiseData.fromMap(map['timing'] as Map<String, dynamic>),
        masterAddons: MasterAddonsInitialiseData.fromMap(
            map['masterAddons'] as Map<String, dynamic>),
        allergens: AllergensInitialiseData.fromMap(
            map['allergens'] as Map<String, dynamic>));
  }

  String toJson() => json.encode(toMap());

  factory AddDishInitializeDataModel.fromJson(String source) =>
      AddDishInitializeDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddDishInitialiseData(type: $type, dishtype: $dishtype, availability: $availability, category: $category, status: $status, timing: $timing, masterAddons: $masterAddons, productMenu: $productMenu, allergens: $allergens)';
  }

  @override
  bool operator ==(covariant AddDishInitializeDataModel other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.dishtype == dishtype &&
        other.availability == availability &&
        other.category == category &&
        other.status == status &&
        other.timing == timing &&
        other.masterAddons == masterAddons &&
        other.productMenu == productMenu &&
        other.allergens == allergens;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        dishtype.hashCode ^
        availability.hashCode ^
        category.hashCode ^
        status.hashCode ^
        timing.hashCode ^
        masterAddons.hashCode ^
        productMenu.hashCode ^
        allergens.hashCode;
  }
}

class TypeInitialiseData {
  final String? control;
  final List<String>? data;
  TypeInitialiseData({
    this.control,
    this.data,
  });

  TypeInitialiseData copyWith({
    String? control,
    List<String>? data,
  }) {
    return TypeInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data,
    };
  }

  factory TypeInitialiseData.fromMap(Map<String, dynamic> map) {
    return TypeInitialiseData(
        control: map['control'] != null ? map['control'] as String : null,
        data: map['data'] != null
            ? List<String>.from(
                (map['data'] as List<dynamic>),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory TypeInitialiseData.fromJson(String source) =>
      TypeInitialiseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypeInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant TypeInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class DishtypeInitialiseData {
  final String? control;
  final List<String>? data;
  DishtypeInitialiseData({
    this.control,
    this.data,
  });

  DishtypeInitialiseData copyWith({
    String? control,
    List<String>? data,
  }) {
    return DishtypeInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data,
    };
  }

  factory DishtypeInitialiseData.fromMap(Map<String, dynamic> map) {
    return DishtypeInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: map['data'] != null
          ? List<String>.from((map['data'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DishtypeInitialiseData.fromJson(String source) =>
      DishtypeInitialiseData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DishtypeInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant DishtypeInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class AvailabilityInitialiseData {
  final String? control;
  final AvailabilityInitialiseSubData? data;
  AvailabilityInitialiseData({
    this.control,
    this.data,
  });

  AvailabilityInitialiseData copyWith({
    String? control,
    AvailabilityInitialiseSubData? data,
  }) {
    return AvailabilityInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data?.toMap(),
    };
  }

  factory AvailabilityInitialiseData.fromMap(Map<String, dynamic> map) {
    return AvailabilityInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: map['data'] != null
          ? AvailabilityInitialiseSubData.fromMap(
              map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailabilityInitialiseData.fromJson(String source) =>
      AvailabilityInitialiseData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AvailabilityInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant AvailabilityInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && other.data == data;
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class AvailabilityInitialiseSubData {
  final String? allDayAvailable;
  final AvailabilityData? availability;
  AvailabilityInitialiseSubData({
    this.allDayAvailable,
    this.availability,
  });

  AvailabilityInitialiseSubData copyWith({
    String? allDayAvailable,
    AvailabilityData? availability,
  }) {
    return AvailabilityInitialiseSubData(
      allDayAvailable: allDayAvailable ?? this.allDayAvailable,
      availability: availability ?? this.availability,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'allDayAvailable': allDayAvailable,
      'availability': availability?.toMap(),
    };
  }

  factory AvailabilityInitialiseSubData.fromMap(Map<String, dynamic> map) {
    return AvailabilityInitialiseSubData(
      allDayAvailable: map['allDayAvailable'] != null
          ? map['allDayAvailable'] as String
          : null,
      availability: map['availability'] != null
          ? AvailabilityData.fromMap(
              map['availability'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailabilityInitialiseSubData.fromJson(String source) =>
      AvailabilityInitialiseSubData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AvailabilityInitialiseSubData(allDayAvailable: $allDayAvailable, availability: $availability)';

  @override
  bool operator ==(covariant AvailabilityInitialiseSubData other) {
    if (identical(this, other)) return true;

    return other.allDayAvailable == allDayAvailable &&
        other.availability == availability;
  }

  @override
  int get hashCode => allDayAvailable.hashCode ^ availability.hashCode;
}

class AvailabilityData {
  final String? control;
  final List<String>? options;
  AvailabilityData({
    this.control,
    this.options,
  });

  AvailabilityData copyWith({
    String? control,
    List<String>? options,
  }) {
    return AvailabilityData(
      control: control ?? this.control,
      options: options ?? this.options,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'options': options,
    };
  }

  factory AvailabilityData.fromMap(Map<String, dynamic> map) {
    return AvailabilityData(
      control: map['control'] != null ? map['control'] as String : null,
      options: map['options'] != null
          ? List<String>.from((map['options'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailabilityData.fromJson(String source) =>
      AvailabilityData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AvailabilityData(control: $control, options: $options)';

  @override
  bool operator ==(covariant AvailabilityData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.options, options);
  }

  @override
  int get hashCode => control.hashCode ^ options.hashCode;
}

class CategoryInitialiseData {
  final String? control;
  final List<CategoryInitialiseSubData>? data;
  CategoryInitialiseData({
    this.control,
    this.data,
  });

  CategoryInitialiseData copyWith({
    String? control,
    List<CategoryInitialiseSubData>? data,
  }) {
    return CategoryInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryInitialiseData.fromMap(Map<String, dynamic> map) {
    return CategoryInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: map['data'] != null
          ? List<CategoryInitialiseSubData>.from(
              (map['data'] as List<dynamic>).map<CategoryInitialiseSubData?>(
                (x) => CategoryInitialiseSubData.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryInitialiseData.fromJson(String source) =>
      CategoryInitialiseData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant CategoryInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class CategoryInitialiseSubData {
  final String? cID;
  final String? name;
  final String? description;
  final String? shopID;
  final String? shopSpecificID;
  final String? status;
  final String? parentID;
  final String? defaultFlag;
  final String? sortOrder;
  final List<CategoryInitialiseSubChildrensData>? childrens;
  CategoryInitialiseSubData({
    this.cID,
    this.name,
    this.description,
    this.shopID,
    this.shopSpecificID,
    this.status,
    this.parentID,
    this.defaultFlag,
    this.sortOrder,
    this.childrens,
  });

  CategoryInitialiseSubData copyWith({
    String? cID,
    String? name,
    String? description,
    String? shopID,
    String? shopSpecificID,
    String? status,
    String? parentID,
    String? defaultFlag,
    String? sortOrder,
    List<CategoryInitialiseSubChildrensData>? children,
  }) {
    return CategoryInitialiseSubData(
      cID: cID ?? this.cID,
      name: name ?? this.name,
      description: description ?? this.description,
      shopID: shopID ?? this.shopID,
      shopSpecificID: shopSpecificID ?? this.shopSpecificID,
      status: status ?? this.status,
      parentID: parentID ?? this.parentID,
      defaultFlag: defaultFlag ?? this.defaultFlag,
      sortOrder: sortOrder ?? this.sortOrder,
      childrens: childrens ?? this.childrens,
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
      'childrens': childrens?.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryInitialiseSubData.fromMap(Map<String, dynamic> map) {
    return CategoryInitialiseSubData(
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
      childrens: map['childrens'] != null
          ? List<CategoryInitialiseSubChildrensData>.from(
              (map['childrens'] as List<dynamic>)
                  .map<CategoryInitialiseSubChildrensData?>(
                (x) => CategoryInitialiseSubChildrensData.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryInitialiseSubData.fromJson(String source) =>
      CategoryInitialiseSubData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryInitialiseSubData(cID: $cID, name: $name, description: $description, shopID: $shopID, shopSpecificID: $shopSpecificID, status: $status, parentID: $parentID, defaultFlag: $defaultFlag, sortOrder: $sortOrder, childrens: $childrens)';
  }

  @override
  bool operator ==(covariant CategoryInitialiseSubData other) {
    if (identical(this, other)) return true;

    return other.cID == cID &&
        other.name == name &&
        other.description == description &&
        other.shopID == shopID &&
        other.shopSpecificID == shopSpecificID &&
        other.status == status &&
        other.parentID == parentID &&
        other.defaultFlag == defaultFlag &&
        other.sortOrder == sortOrder &&
        listEquals(other.childrens, childrens);
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
        sortOrder.hashCode ^
        childrens.hashCode;
  }
}

class CategoryInitialiseSubChildrensData {
  final String? cID;
  final String? name;
  final String? description;
  final String? shopID;
  final String? shopSpecificID;
  final String? status;
  final String? parentID;
  final String? defaultFlag;
  final String? sortOrder;
  CategoryInitialiseSubChildrensData({
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

  CategoryInitialiseSubChildrensData copyWith({
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
    return CategoryInitialiseSubChildrensData(
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

  factory CategoryInitialiseSubChildrensData.fromMap(Map<String, dynamic> map) {
    return CategoryInitialiseSubChildrensData(
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

  factory CategoryInitialiseSubChildrensData.fromJson(String source) =>
      CategoryInitialiseSubChildrensData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryInitialiseSubChildrensData(cID: $cID, name: $name, description: $description, shopID: $shopID, shopSpecificID: $shopSpecificID, status: $status, parentID: $parentID, defaultFlag: $defaultFlag, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(covariant CategoryInitialiseSubChildrensData other) {
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

class StatusInitialiseData {
  final String? control;
  final List<String> data;
  StatusInitialiseData({
    this.control,
    required this.data,
  });

  StatusInitialiseData copyWith({
    String? control,
    List<String>? data,
  }) {
    return StatusInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data,
    };
  }

  factory StatusInitialiseData.fromMap(Map<String, dynamic> map) {
    return StatusInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: List<String>.from((map['data'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusInitialiseData.fromJson(String source) =>
      StatusInitialiseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StatusInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant StatusInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class TimingInitialiseData {
  final String? control;
  final List<TimingInitialiseSubData> data;
  TimingInitialiseData({
    this.control,
    required this.data,
  });

  TimingInitialiseData copyWith({
    String? control,
    List<TimingInitialiseSubData>? data,
  }) {
    return TimingInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory TimingInitialiseData.fromMap(Map<String, dynamic> map) {
    return TimingInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: List<TimingInitialiseSubData>.from(
        (map['data'] as List<dynamic>).map<TimingInitialiseSubData>(
          (x) => TimingInitialiseSubData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimingInitialiseData.fromJson(String source) =>
      TimingInitialiseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TimingInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant TimingInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class TimingInitialiseSubData {
  final String? startTime;
  final String? endTime;
  TimingInitialiseSubData({
    this.startTime,
    this.endTime,
  });

  TimingInitialiseSubData copyWith({
    String? startTime,
    String? endTime,
  }) {
    return TimingInitialiseSubData(
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

  factory TimingInitialiseSubData.fromMap(Map<String, dynamic> map) {
    return TimingInitialiseSubData(
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimingInitialiseSubData.fromJson(String source) =>
      TimingInitialiseSubData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TimingInitialiseSubData(startTime: $startTime, endTime: $endTime)';

  @override
  bool operator ==(covariant TimingInitialiseSubData other) {
    if (identical(this, other)) return true;

    return other.startTime == startTime && other.endTime == endTime;
  }

  @override
  int get hashCode => startTime.hashCode ^ endTime.hashCode;
}

class MasterAddonsInitialiseData {
  final String? control;
  final List<MasterAddonsInitialiseSubData> data;
  MasterAddonsInitialiseData({
    this.control,
    required this.data,
  });

  MasterAddonsInitialiseData copyWith({
    String? control,
    List<MasterAddonsInitialiseSubData>? data,
  }) {
    return MasterAddonsInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory MasterAddonsInitialiseData.fromMap(Map<String, dynamic> map) {
    return MasterAddonsInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: List<MasterAddonsInitialiseSubData>.from(
        (map['data'] as List<dynamic>).map<MasterAddonsInitialiseSubData>(
          (x) =>
              MasterAddonsInitialiseSubData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MasterAddonsInitialiseData.fromJson(String source) =>
      MasterAddonsInitialiseData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MasterAddonsInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant MasterAddonsInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class MasterAddonsInitialiseSubData {
  final String? id;
  final String? title;
  MasterAddonsInitialiseSubData({
    this.id,
    this.title,
  });

  MasterAddonsInitialiseSubData copyWith({
    String? id,
    String? title,
  }) {
    return MasterAddonsInitialiseSubData(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
    };
  }

  factory MasterAddonsInitialiseSubData.fromMap(Map<String, dynamic> map) {
    return MasterAddonsInitialiseSubData(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MasterAddonsInitialiseSubData.fromJson(String source) =>
      MasterAddonsInitialiseSubData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MasterAddonsInitialiseSubData(id: $id, title: $title)';

  @override
  bool operator ==(covariant MasterAddonsInitialiseSubData other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

class ProductMenuInitialiseData {
  final String? control;
  final Map<String, dynamic>? data;
  ProductMenuInitialiseData({
    this.control,
    this.data,
  });

  ProductMenuInitialiseData copyWith({
    String? control,
    Map<String, dynamic>? data,
  }) {
    return ProductMenuInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data,
    };
  }

  factory ProductMenuInitialiseData.fromMap(Map<String, dynamic> map) {
    return ProductMenuInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: map['data'] != null
          ? Map<String, dynamic>.from((map['data'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductMenuInitialiseData.fromJson(String source) =>
      ProductMenuInitialiseData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductMenuInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant ProductMenuInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && mapEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class AllergensInitialiseData {
  final String? control;
  final List<AllergensInitialiseSubData>? data;
  AllergensInitialiseData({
    this.control,
    this.data,
  });

  AllergensInitialiseData copyWith({
    String? control,
    List<AllergensInitialiseSubData>? data,
  }) {
    return AllergensInitialiseData(
      control: control ?? this.control,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'control': control,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory AllergensInitialiseData.fromMap(Map<String, dynamic> map) {
    return AllergensInitialiseData(
      control: map['control'] != null ? map['control'] as String : null,
      data: map['data'] != null
          ? List<AllergensInitialiseSubData>.from(
              (map['data'] as List<dynamic>).map<AllergensInitialiseSubData?>(
                (x) => AllergensInitialiseSubData.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllergensInitialiseData.fromJson(String source) =>
      AllergensInitialiseData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AllergensInitialiseData(control: $control, data: $data)';

  @override
  bool operator ==(covariant AllergensInitialiseData other) {
    if (identical(this, other)) return true;

    return other.control == control && listEquals(other.data, data);
  }

  @override
  int get hashCode => control.hashCode ^ data.hashCode;
}

class AllergensInitialiseSubData {
  final String? id;
  final String? name;
  final String? icon;
  AllergensInitialiseSubData({
    this.id,
    this.name,
    this.icon,
  });

  AllergensInitialiseSubData copyWith({
    String? id,
    String? name,
    String? icon,
  }) {
    return AllergensInitialiseSubData(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
    };
  }

  factory AllergensInitialiseSubData.fromMap(Map<String, dynamic> map) {
    return AllergensInitialiseSubData(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllergensInitialiseSubData.fromJson(String source) =>
      AllergensInitialiseSubData.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AllergensInitialiseSubData(id: $id, name: $name, icon: $icon)';

  @override
  bool operator ==(covariant AllergensInitialiseSubData other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.icon == icon;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ icon.hashCode;
}
