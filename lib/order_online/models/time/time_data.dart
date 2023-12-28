// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TimeData {
  final List<TimeDetails> monday;
  final List<TimeDetails> tuesday;
  final List<TimeDetails> wednesday;
  final List<TimeDetails> thursday;
  final List<TimeDetails> friday;
  final List<TimeDetails> saturday;
  final List<TimeDetails> sunday;
  TimeData({
    this.monday = const <TimeDetails>[],
    this.tuesday = const <TimeDetails>[],
    this.wednesday = const <TimeDetails>[],
    this.thursday = const <TimeDetails>[],
    this.friday = const <TimeDetails>[],
    this.saturday = const <TimeDetails>[],
    this.sunday = const <TimeDetails>[],
  });

  TimeData copyWith({
    List<TimeDetails>? monday,
    List<TimeDetails>? tuesday,
    List<TimeDetails>? wednesday,
    List<TimeDetails>? thursday,
    List<TimeDetails>? friday,
    List<TimeDetails>? saturday,
    List<TimeDetails>? sunday,
  }) {
    return TimeData(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'monday': monday.map((x) => x.toMap()).toList(),
      'tuesday': tuesday.map((x) => x.toMap()).toList(),
      'wednesday': wednesday.map((x) => x.toMap()).toList(),
      'thursday': thursday.map((x) => x.toMap()).toList(),
      'friday': friday.map((x) => x.toMap()).toList(),
      'saturday': saturday.map((x) => x.toMap()).toList(),
      'sunday': sunday.map((x) => x.toMap()).toList(),
    };
  }

  factory TimeData.fromMap(Map<String, dynamic> map) {
    return TimeData(
      monday: List<TimeDetails>.from(
        (map['monday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      tuesday: List<TimeDetails>.from(
        (map['tuesday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      wednesday: List<TimeDetails>.from(
        (map['wednesday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      thursday: List<TimeDetails>.from(
        (map['thursday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      friday: List<TimeDetails>.from(
        (map['friday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      saturday: List<TimeDetails>.from(
        (map['saturday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sunday: List<TimeDetails>.from(
        (map['sunday'] as List<dynamic>).map<TimeDetails?>(
          (x) => TimeDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeData.fromJson(String source) =>
      TimeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeData(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }

  @override
  bool operator ==(covariant TimeData other) {
    if (identical(this, other)) return true;

    return listEquals(other.monday, monday) &&
        listEquals(other.tuesday, tuesday) &&
        listEquals(other.wednesday, wednesday) &&
        listEquals(other.thursday, thursday) &&
        listEquals(other.friday, friday) &&
        listEquals(other.saturday, saturday) &&
        listEquals(other.sunday, sunday);
  }

  @override
  int get hashCode {
    return monday.hashCode ^
        tuesday.hashCode ^
        wednesday.hashCode ^
        thursday.hashCode ^
        friday.hashCode ^
        saturday.hashCode ^
        sunday.hashCode;
  }
}

class TimeDetails {
  final String? slotId;
  final String? day;
  final String? daytitle;
  final String? openingTime;
  final String? closingTime;
  final String? status;
  TimeDetails({
    this.slotId,
    this.day,
    this.daytitle,
    this.openingTime,
    this.closingTime,
    this.status,
  });

  TimeDetails copyWith({
    String? slotId,
    String? day,
    String? daytitle,
    String? openingTime,
    String? closingTime,
    String? status,
  }) {
    return TimeDetails(
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

  factory TimeDetails.fromMap(Map<String, dynamic> map) {
    return TimeDetails(
      slotId: map['slotId'] != null ? map['slotId'] as String : null,
      day: map['day'] != null ? map['day'] as String : null,
      daytitle: map['daytitle'] != null ? map['daytitle'] as String : null,
      openingTime:
          map['openingTime'] != null ? map['openingTime'] as String : null,
      closingTime:
          map['closingTime'] != null ? map['closingTime'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeDetails.fromJson(String source) =>
      TimeDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeDetails(slotId: $slotId, day: $day, daytitle: $daytitle, openingTime: $openingTime, closingTime: $closingTime, status: $status)';
  }

  @override
  bool operator ==(covariant TimeDetails other) {
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

