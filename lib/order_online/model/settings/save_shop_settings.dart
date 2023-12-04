// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SaveSettingsData {
  final String? messages;
  final SettingsData? shopsettings;
  SaveSettingsData({
    this.messages,
    this.shopsettings,
  });

  SaveSettingsData copyWith({
    String? messages,
    SettingsData? shopsettings,
  }) {
    return SaveSettingsData(
      messages: messages ?? this.messages,
      shopsettings: shopsettings ?? this.shopsettings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages,
      'shopsettings': shopsettings?.toMap(),
    };
  }

  factory SaveSettingsData.fromMap(Map<String, dynamic> map) {
    return SaveSettingsData(
      messages: map['messages'] != null ? map['messages'] as String : null,
      shopsettings: map['shopsettings'] != null ? SettingsData.fromMap(map['shopsettings'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaveSettingsData.fromJson(String source) => SaveSettingsData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SaveSettingsData(messages: $messages, shopsettings: $shopsettings)';

  @override
  bool operator ==(covariant SaveSettingsData other) {
    if (identical(this, other)) return true;
  
    return 
      other.messages == messages &&
      other.shopsettings == shopsettings;
  }

  @override
  int get hashCode => messages.hashCode ^ shopsettings.hashCode;
}

class SettingsData {
  final String? shopPostcode;
  final String? currencyType;
  final String? takeAway;
  final String? homeDelivery;
  final String? discountTakeAway;
  final String? minAmtForTakAwayDiscnt;
  final String? deliveryMinAmount;
  final String? deliveryMinAmountType;
  final String? discountHomeDelivery;
  final String? minAmtForHomDelvryDiscnt;
  final String? distanceType;
  final String? freeDelivery;
  final String? freeDeliveryRadius;
  final String? freeDeliveryMinOrder;
  final String? deliveryChargeType;
  final String? minDeliveryCharge;
  final String? ratePerMile;
  final String? maxDeliveryRadius;
  final String? preOrder;
  final String? preOrderBefore;
  final String? minWaitingTime;
  final String? fixedDeliveryCharge;
  final String? updated_at;
  final String? shopStatus;
  SettingsData({
    this.shopPostcode,
    this.currencyType,
    this.takeAway,
    this.homeDelivery,
    this.discountTakeAway,
    this.minAmtForTakAwayDiscnt,
    this.deliveryMinAmount,
    this.deliveryMinAmountType,
    this.discountHomeDelivery,
    this.minAmtForHomDelvryDiscnt,
    this.distanceType,
    this.freeDelivery,
    this.freeDeliveryRadius,
    this.freeDeliveryMinOrder,
    this.deliveryChargeType,
    this.minDeliveryCharge,
    this.ratePerMile,
    this.maxDeliveryRadius,
    this.preOrder,
    this.preOrderBefore,
    this.minWaitingTime,
    this.fixedDeliveryCharge,
    this.updated_at,
    this.shopStatus,
  });

  SettingsData copyWith({
    String? shopPostcode,
    String? currencyType,
    String? takeAway,
    String? homeDelivery,
    String? discountTakeAway,
    String? minAmtForTakAwayDiscnt,
    String? deliveryMinAmount,
    String? deliveryMinAmountType,
    String? discountHomeDelivery,
    String? minAmtForHomDelvryDiscnt,
    String? distanceType,
    String? freeDelivery,
    String? freeDeliveryRadius,
    String? freeDeliveryMinOrder,
    String? deliveryChargeType,
    String? minDeliveryCharge,
    String? ratePerMile,
    String? maxDeliveryRadius,
    String? preOrder,
    String? preOrderBefore,
    String? minWaitingTime,
    String? fixedDeliveryCharge,
    String? updated_at,
    String? shopStatus,
  }) {
    return SettingsData(
      shopPostcode: shopPostcode ?? this.shopPostcode,
      currencyType: currencyType ?? this.currencyType,
      takeAway: takeAway ?? this.takeAway,
      homeDelivery: homeDelivery ?? this.homeDelivery,
      discountTakeAway: discountTakeAway ?? this.discountTakeAway,
      minAmtForTakAwayDiscnt: minAmtForTakAwayDiscnt ?? this.minAmtForTakAwayDiscnt,
      deliveryMinAmount: deliveryMinAmount ?? this.deliveryMinAmount,
      deliveryMinAmountType: deliveryMinAmountType ?? this.deliveryMinAmountType,
      discountHomeDelivery: discountHomeDelivery ?? this.discountHomeDelivery,
      minAmtForHomDelvryDiscnt: minAmtForHomDelvryDiscnt ?? this.minAmtForHomDelvryDiscnt,
      distanceType: distanceType ?? this.distanceType,
      freeDelivery: freeDelivery ?? this.freeDelivery,
      freeDeliveryRadius: freeDeliveryRadius ?? this.freeDeliveryRadius,
      freeDeliveryMinOrder: freeDeliveryMinOrder ?? this.freeDeliveryMinOrder,
      deliveryChargeType: deliveryChargeType ?? this.deliveryChargeType,
      minDeliveryCharge: minDeliveryCharge ?? this.minDeliveryCharge,
      ratePerMile: ratePerMile ?? this.ratePerMile,
      maxDeliveryRadius: maxDeliveryRadius ?? this.maxDeliveryRadius,
      preOrder: preOrder ?? this.preOrder,
      preOrderBefore: preOrderBefore ?? this.preOrderBefore,
      minWaitingTime: minWaitingTime ?? this.minWaitingTime,
      fixedDeliveryCharge: fixedDeliveryCharge ?? this.fixedDeliveryCharge,
      updated_at: updated_at ?? this.updated_at,
      shopStatus: shopStatus ?? this.shopStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopPostcode': shopPostcode,
      'currencyType': currencyType,
      'takeAway': takeAway,
      'homeDelivery': homeDelivery,
      'discountTakeAway': discountTakeAway,
      'minAmtForTakAwayDiscnt': minAmtForTakAwayDiscnt,
      'deliveryMinAmount': deliveryMinAmount,
      'deliveryMinAmountType': deliveryMinAmountType,
      'discountHomeDelivery': discountHomeDelivery,
      'minAmtForHomDelvryDiscnt': minAmtForHomDelvryDiscnt,
      'distanceType': distanceType,
      'freeDelivery': freeDelivery,
      'freeDeliveryRadius': freeDeliveryRadius,
      'freeDeliveryMinOrder': freeDeliveryMinOrder,
      'deliveryChargeType': deliveryChargeType,
      'minDeliveryCharge': minDeliveryCharge,
      'ratePerMile': ratePerMile,
      'maxDeliveryRadius': maxDeliveryRadius,
      'preOrder': preOrder,
      'preOrderBefore': preOrderBefore,
      'minWaitingTime': minWaitingTime,
      'fixedDeliveryCharge': fixedDeliveryCharge,
      'updated_at': updated_at,
      'shopStatus': shopStatus,
    };
  }

  factory SettingsData.fromMap(Map<String, dynamic> map) {
    return SettingsData(
      shopPostcode: map['shopPostcode'] != null ? map['shopPostcode'] as String : null,
      currencyType: map['currencyType'] != null ? map['currencyType'] as String : null,
      takeAway: map['takeAway'] != null ? map['takeAway'] as String : null,
      homeDelivery: map['homeDelivery'] != null ? map['homeDelivery'] as String : null,
      discountTakeAway: map['discountTakeAway'] != null ? map['discountTakeAway'] as String : null,
      minAmtForTakAwayDiscnt: map['minAmtForTakAwayDiscnt'] != null ? map['minAmtForTakAwayDiscnt'] as String : null,
      deliveryMinAmount: map['deliveryMinAmount'] != null ? map['deliveryMinAmount'] as String : null,
      deliveryMinAmountType: map['deliveryMinAmountType'] != null ? map['deliveryMinAmountType'] as String : null,
      discountHomeDelivery: map['discountHomeDelivery'] != null ? map['discountHomeDelivery'] as String : null,
      minAmtForHomDelvryDiscnt: map['minAmtForHomDelvryDiscnt'] != null ? map['minAmtForHomDelvryDiscnt'] as String : null,
      distanceType: map['distanceType'] != null ? map['distanceType'] as String : null,
      freeDelivery: map['freeDelivery'] != null ? map['freeDelivery'] as String : null,
      freeDeliveryRadius: map['freeDeliveryRadius'] != null ? map['freeDeliveryRadius'] as String : null,
      freeDeliveryMinOrder: map['freeDeliveryMinOrder'] != null ? map['freeDeliveryMinOrder'] as String : null,
      deliveryChargeType: map['deliveryChargeType'] != null ? map['deliveryChargeType'] as String : null,
      minDeliveryCharge: map['minDeliveryCharge'] != null ? map['minDeliveryCharge'] as String : null,
      ratePerMile: map['ratePerMile'] != null ? map['ratePerMile'] as String : null,
      maxDeliveryRadius: map['maxDeliveryRadius'] != null ? map['maxDeliveryRadius'] as String : null,
      preOrder: map['preOrder'] != null ? map['preOrder'] as String : null,
      preOrderBefore: map['preOrderBefore'] != null ? map['preOrderBefore'] as String : null,
      minWaitingTime: map['minWaitingTime'] != null ? map['minWaitingTime'] as String : null,
      fixedDeliveryCharge: map['fixedDeliveryCharge'] != null ? map['fixedDeliveryCharge'] as String : null,
      updated_at: map['updated_at'] != null ? map['updated_at'] as String : null,
      shopStatus: map['shopStatus'] != null ? map['shopStatus'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsData.fromJson(String source) => SettingsData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettingsData(shopPostcode: $shopPostcode, currencyType: $currencyType, takeAway: $takeAway, homeDelivery: $homeDelivery, discountTakeAway: $discountTakeAway, minAmtForTakAwayDiscnt: $minAmtForTakAwayDiscnt, deliveryMinAmount: $deliveryMinAmount, deliveryMinAmountType: $deliveryMinAmountType, discountHomeDelivery: $discountHomeDelivery, minAmtForHomDelvryDiscnt: $minAmtForHomDelvryDiscnt, distanceType: $distanceType, freeDelivery: $freeDelivery, freeDeliveryRadius: $freeDeliveryRadius, freeDeliveryMinOrder: $freeDeliveryMinOrder, deliveryChargeType: $deliveryChargeType, minDeliveryCharge: $minDeliveryCharge, ratePerMile: $ratePerMile, maxDeliveryRadius: $maxDeliveryRadius, preOrder: $preOrder, preOrderBefore: $preOrderBefore, minWaitingTime: $minWaitingTime, fixedDeliveryCharge: $fixedDeliveryCharge, updated_at: $updated_at, shopStatus: $shopStatus)';
  }

  @override
  bool operator ==(covariant SettingsData other) {
    if (identical(this, other)) return true;
  
    return 
      other.shopPostcode == shopPostcode &&
      other.currencyType == currencyType &&
      other.takeAway == takeAway &&
      other.homeDelivery == homeDelivery &&
      other.discountTakeAway == discountTakeAway &&
      other.minAmtForTakAwayDiscnt == minAmtForTakAwayDiscnt &&
      other.deliveryMinAmount == deliveryMinAmount &&
      other.deliveryMinAmountType == deliveryMinAmountType &&
      other.discountHomeDelivery == discountHomeDelivery &&
      other.minAmtForHomDelvryDiscnt == minAmtForHomDelvryDiscnt &&
      other.distanceType == distanceType &&
      other.freeDelivery == freeDelivery &&
      other.freeDeliveryRadius == freeDeliveryRadius &&
      other.freeDeliveryMinOrder == freeDeliveryMinOrder &&
      other.deliveryChargeType == deliveryChargeType &&
      other.minDeliveryCharge == minDeliveryCharge &&
      other.ratePerMile == ratePerMile &&
      other.maxDeliveryRadius == maxDeliveryRadius &&
      other.preOrder == preOrder &&
      other.preOrderBefore == preOrderBefore &&
      other.minWaitingTime == minWaitingTime &&
      other.fixedDeliveryCharge == fixedDeliveryCharge &&
      other.updated_at == updated_at &&
      other.shopStatus == shopStatus;
  }

  @override
  int get hashCode {
    return shopPostcode.hashCode ^
      currencyType.hashCode ^
      takeAway.hashCode ^
      homeDelivery.hashCode ^
      discountTakeAway.hashCode ^
      minAmtForTakAwayDiscnt.hashCode ^
      deliveryMinAmount.hashCode ^
      deliveryMinAmountType.hashCode ^
      discountHomeDelivery.hashCode ^
      minAmtForHomDelvryDiscnt.hashCode ^
      distanceType.hashCode ^
      freeDelivery.hashCode ^
      freeDeliveryRadius.hashCode ^
      freeDeliveryMinOrder.hashCode ^
      deliveryChargeType.hashCode ^
      minDeliveryCharge.hashCode ^
      ratePerMile.hashCode ^
      maxDeliveryRadius.hashCode ^
      preOrder.hashCode ^
      preOrderBefore.hashCode ^
      minWaitingTime.hashCode ^
      fixedDeliveryCharge.hashCode ^
      updated_at.hashCode ^
      shopStatus.hashCode;
  }
}
