// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../constants/enums.dart';

class NewReservationModel {
  final int userID;
  final String name;
  final String phone;
  final String email;
  final String chairs;
  final String? message;
  final String? shopmessage;
  final String bookingTime;
  final ConditionValues advancePayment;
  final String advanceAmount;
  final AmountStatusRequest? amountStatus;
  final PaymentMethod paymentMethod;
  final String? transactionID;
  final String source;
  NewReservationModel({
    required this.userID,
    required this.name,
    required this.phone,
    required this.email,
    required this.chairs,
    required this.message,
    required this.shopmessage,
    required this.bookingTime,
    required this.advancePayment,
    required this.advanceAmount,
    required this.amountStatus,
    required this.paymentMethod,
    required this.transactionID,
    this.source = 'Flutter',
  });

  NewReservationModel copyWith({
    int? userID,
    String? name,
    String? phone,
    String? email,
    String? chairs,
    String? message,
    String? shopmessage,
    String? bookingTime,
    ConditionValues? advancePayment,
    String? advanceAmount,
    AmountStatusRequest? amountStatus,
    PaymentMethod? paymentMethod,
    String? transactionID,
    String? source,
  }) {
    return NewReservationModel(
      userID: userID ?? this.userID,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      chairs: chairs ?? this.chairs,
      message: message ?? this.message,
      shopmessage: shopmessage ?? this.shopmessage,
      bookingTime: bookingTime ?? this.bookingTime,
      advancePayment: advancePayment ?? this.advancePayment,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      amountStatus: amountStatus ?? this.amountStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionID: transactionID ?? this.transactionID,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'name': name,
      'phone': phone,
      'email': email,
      'chairs': chairs,
      'message': message,
      'shopmessage': shopmessage,
      'bookingTime': bookingTime,
      'advancePayment': advancePayment.label,
      'advanceAmount': advanceAmount,
      'amountStatus': amountStatus?.name,
      'paymentMethod': paymentMethod.name,
      'transactionID': transactionID,
      'source': source,
    };
  }

  factory NewReservationModel.fromMap(Map<String, dynamic> map) {
    return NewReservationModel(
      userID: map['userID'] as int,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      chairs: map['chairs'] as String,
      message: map['message'] != null ? map['message'] as String : null,
      shopmessage:
          map['shopmessage'] != null ? map['shopmessage'] as String : null,
      bookingTime: map['bookingTime'] as String,
      advancePayment: ConditionValues.fromLabel(map['advancePayment']),
      advanceAmount: map['advanceAmount'] as String,
      amountStatus: map['amountStatus'] != null
          ? AmountStatusRequest.fromLabel(map['amountStatus'])
          : null,
      paymentMethod: PaymentMethod.fromLabel(map['paymentMethod']),
      transactionID:
          map['transactionID'] != null ? map['transactionID'] as String : null,
      source: map['source'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewReservationModel.fromJson(String source) =>
      NewReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewReservationModel(userID: $userID, name: $name, phone: $phone, email: $email, chairs: $chairs, message: $message, shopmessage: $shopmessage, bookingTime: $bookingTime, advancePayment: $advancePayment, advanceAmount: $advanceAmount, amountStatus: $amountStatus, paymentMethod: $paymentMethod, transactionID: $transactionID, source: $source)';
  }

  @override
  bool operator ==(covariant NewReservationModel other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.chairs == chairs &&
        other.message == message &&
        other.shopmessage == shopmessage &&
        other.bookingTime == bookingTime &&
        other.advancePayment == advancePayment &&
        other.advanceAmount == advanceAmount &&
        other.amountStatus == amountStatus &&
        other.paymentMethod == paymentMethod &&
        other.transactionID == transactionID &&
        other.source == source;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        chairs.hashCode ^
        message.hashCode ^
        shopmessage.hashCode ^
        bookingTime.hashCode ^
        advancePayment.hashCode ^
        advanceAmount.hashCode ^
        amountStatus.hashCode ^
        paymentMethod.hashCode ^
        transactionID.hashCode ^
        source.hashCode;
  }
}
