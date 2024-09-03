import 'dart:convert';

import 'package:flutter_foodpage_plugin/menu_builder/core/utils/helper_utils.dart';

class ShopTimingModel {
  final String slotId;
  final String day;
  final String daytitle;
  final String openingTime;
  final String closingTime;
  final String status;

  ShopTimingModel({
    required this.slotId,
    required this.day,
    required this.daytitle,
    required this.openingTime,
    required this.closingTime,
    required this.status,
  });

  ShopTimingModel copyWith({
    String? slotId,
    String? day,
    String? daytitle,
    String? openingTime,
    String? closingTime,
    String? status,
  }) {
    return ShopTimingModel(
      slotId: slotId ?? this.slotId,
      day: day ?? this.day,
      daytitle: daytitle ?? this.daytitle,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slotId': slotId,
      'day': day,
      'daytitle': daytitle,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'status': status,
    };
  }

  factory ShopTimingModel.fromMap(Map<String, dynamic> map) {
    return ShopTimingModel(
      slotId: map['slotId'] as String,
      day: map['day'] as String,
      daytitle: map['daytitle'] as String,
      openingTime: map['openingTime'] as String,
      closingTime: map['closingTime'] as String,
      status: map['status'] as String,
    );
  }

  String get openingTimeIn12hrs => convertToAMPM(openingTime);

  String get closingTimeIn12hrs => convertToAMPM(closingTime);

  String toJson() => json.encode(toMap());

  factory ShopTimingModel.fromJson(String source) =>
      ShopTimingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopTimingModel(slotId: $slotId, day: $day, daytitle: $daytitle, openingTime: $openingTime, closingTime: $closingTime, status: $status)';
  }

  @override
  bool operator ==(covariant ShopTimingModel other) {
    if (identical(this, other)) return true;

    return other.slotId == slotId &&
        other.day == day &&
        other.daytitle == daytitle &&
        other.openingTime == openingTime &&
        other.closingTime == closingTime &&
        other.status == status;
  }

  @override
  int get hashCode {
    return slotId.hashCode ^
        day.hashCode ^
        daytitle.hashCode ^
        openingTime.hashCode ^
        closingTime.hashCode ^
        status.hashCode;
  }
}
