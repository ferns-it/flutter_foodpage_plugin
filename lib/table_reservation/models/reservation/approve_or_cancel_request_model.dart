// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../constants/enums.dart';

class ApproveOrCancelRequestModel {
  final String reservationId;
  final ReservationStatusUpdate status;
  final String bookingDate;
  final String bookingTime;
  final String shopMessage;
  ApproveOrCancelRequestModel({
    required this.reservationId,
    required this.status,
    required this.bookingDate,
    required this.bookingTime,
    required this.shopMessage,
  });

  ApproveOrCancelRequestModel copyWith({
    String? reservationId,
    ReservationStatusUpdate? status,
    String? bookingDate,
    String? bookingTime,
    String? shopMessage,
  }) {
    return ApproveOrCancelRequestModel(
      reservationId: reservationId ?? this.reservationId,
      status: status ?? this.status,
      bookingDate: bookingDate ?? this.bookingDate,
      bookingTime: bookingTime ?? this.bookingTime,
      shopMessage: shopMessage ?? this.shopMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reservationId': reservationId,
      'status': status.label,
      'bookingDate': bookingDate,
      'bookingTime': bookingTime,
      'shopMessage': shopMessage,
    };
  }

  factory ApproveOrCancelRequestModel.fromMap(Map<String, dynamic> map) {
    return ApproveOrCancelRequestModel(
      reservationId: map['reservationId'] as String,
      status: ReservationStatusUpdate.fromLabel(map['status']),
      bookingDate: map['bookingDate'] as String,
      bookingTime: map['bookingTime'] as String,
      shopMessage: map['shopMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveOrCancelRequestModel.fromJson(String source) =>
      ApproveOrCancelRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpdateReservationRequestModel(reservationId: $reservationId, status: $status, bookingDate: $bookingDate, bookingTime: $bookingTime, shopMessage: $shopMessage)';
  }

  @override
  bool operator ==(covariant ApproveOrCancelRequestModel other) {
    if (identical(this, other)) return true;

    return other.reservationId == reservationId &&
        other.status == status &&
        other.bookingDate == bookingDate &&
        other.bookingTime == bookingTime &&
        other.shopMessage == shopMessage;
  }

  @override
  int get hashCode {
    return reservationId.hashCode ^
        status.hashCode ^
        bookingDate.hashCode ^
        bookingTime.hashCode ^
        shopMessage.hashCode;
  }
}
