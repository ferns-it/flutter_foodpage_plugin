// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_foodpage_plugin/table_reservation/constants/enums.dart';

class ReservationNoticationHistoryModel {
  final List<ReservationNotificationModel> reservations;
  ReservationNoticationHistoryModel({
    this.reservations = const [],
  });

  ReservationNoticationHistoryModel copyWith({
    List<ReservationNotificationModel>? reservations,
  }) {
    return ReservationNoticationHistoryModel(
      reservations: reservations ?? this.reservations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reservations': reservations.map((x) => x.toMap()).toList(),
    };
  }

  factory ReservationNoticationHistoryModel.fromMap(Map<String, dynamic> map) {
    return ReservationNoticationHistoryModel(
      reservations: List<ReservationNotificationModel>.from(
        (map['reservations'] as List<int>).map<ReservationNotificationModel>(
          (x) =>
              ReservationNotificationModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationNoticationHistoryModel.fromJson(String source) =>
      ReservationNoticationHistoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReservationNoticationHistoryModel(reservations: $reservations)';

  @override
  bool operator ==(covariant ReservationNoticationHistoryModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.reservations, reservations);
  }

  @override
  int get hashCode => reservations.hashCode;
}

class ReservationNotificationModel {
  final String reservationId;
  final bool newChatMessage;
  final bool newReservation;
  final DateTime? openedDateTime;
  ReservationNotificationModel({
    required this.reservationId,
    this.newChatMessage = false,
    this.newReservation = false,
    this.openedDateTime,
  });

  ReservationNotificationModel copyWith({
    String? reservationId,
    ReservationStatus? status,
    bool? newChatMessage,
    bool? newReservation,
    DateTime? openedDateTime,
  }) {
    return ReservationNotificationModel(
      reservationId: reservationId ?? this.reservationId,
      newChatMessage: newChatMessage ?? this.newChatMessage,
      newReservation: newReservation ?? this.newReservation,
      openedDateTime: openedDateTime ?? this.openedDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reservationId': reservationId,
      'newChatMessage': newChatMessage,
      'newReservation': newReservation,
      'openedDateTime': openedDateTime?.toIso8601String(),
    };
  }

  factory ReservationNotificationModel.fromMap(Map<String, dynamic> map) {
    return ReservationNotificationModel(
      reservationId: map['reservationId'] as String,
      newChatMessage: map['newChatMessage'] as bool,
      newReservation: map['newReservation'] as bool,
      openedDateTime: map['openedDateTime'] != null
          ? DateTime.parse(map['openedDateTime'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());
  bool get opened => openedDateTime != null;

  factory ReservationNotificationModel.fromJson(String source) =>
      ReservationNotificationModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReservationNotificationModel(reservationId: $reservationId, newChatMessage: $newChatMessage, newReservation: $newReservation, openedDateTime: $openedDateTime)';
  }

  @override
  bool operator ==(covariant ReservationNotificationModel other) {
    if (identical(this, other)) return true;

    return other.reservationId == reservationId &&
        other.newChatMessage == newChatMessage &&
        other.newReservation == newReservation &&
        other.openedDateTime == openedDateTime;
  }

  @override
  int get hashCode {
    return reservationId.hashCode ^
        newChatMessage.hashCode ^
        newReservation.hashCode ^
        openedDateTime.hashCode;
  }
}
