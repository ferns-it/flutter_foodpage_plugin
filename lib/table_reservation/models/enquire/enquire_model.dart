// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../constants/enums.dart';

class EnquirieModel {
  final String? id;
  final String? formattedID;
  final String? name;
  final String? phone;
  final String? email;
  final String? chairs;
  final String? message;
  final ReservationStatus? status;
  final String? shopMessage;
  final String? bookingTime;
  final String? addedTime;
  final String? advancePayment;
  final String? advanceAmount;
  final AmountStatus? amountStatus;
  final String? paymentMethod;
  EnquirieModel({
    required this.id,
    required this.formattedID,
    required this.name,
    required this.phone,
    required this.email,
    required this.chairs,
    required this.message,
    required this.status,
    required this.shopMessage,
    required this.bookingTime,
    required this.addedTime,
    required this.advancePayment,
    required this.advanceAmount,
    required this.amountStatus,
    required this.paymentMethod,
  });

  EnquirieModel copyWith({
    String? id,
    String? formattedID,
    String? name,
    String? phone,
    String? email,
    String? chairs,
    String? message,
    ReservationStatus? status,
    String? shopMessage,
    String? bookingTime,
    String? addedTime,
    String? advancePayment,
    String? advanceAmount,
    AmountStatus? amountStatus,
    String? paymentMethod,
  }) {
    return EnquirieModel(
      id: id ?? this.id,
      formattedID: formattedID ?? this.formattedID,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      chairs: chairs ?? this.chairs,
      message: message ?? this.message,
      status: status ?? this.status,
      shopMessage: shopMessage ?? this.shopMessage,
      bookingTime: bookingTime ?? this.bookingTime,
      addedTime: addedTime ?? this.addedTime,
      advancePayment: advancePayment ?? this.advancePayment,
      advanceAmount: advanceAmount ?? this.advanceAmount,
      amountStatus: amountStatus ?? this.amountStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'formattedID': formattedID,
      'name': name,
      'phone': phone,
      'email': email,
      'chairs': chairs,
      'message': message,
      'status': status?.name,
      'shopMessage': shopMessage,
      'bookingTime': bookingTime,
      'addedTime': addedTime,
      'advancePayment': advancePayment,
      'advanceAmount': advanceAmount,
      'amountStatus': amountStatus,
      'paymentMethod': paymentMethod,
    };
  }

  factory EnquirieModel.fromMap(Map<String, dynamic> map) {
    return EnquirieModel(
      id: map['id'] != null ? map['id'] as String : null,
      formattedID:
          map['formattedID'] != null ? map['formattedID'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      chairs: map['chairs'] != null ? map['chairs'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null
          ? ReservationStatus.fromLabel(map['status'])
          : ReservationStatus.initial,
      shopMessage:
          map['shopMessage'] != null ? map['shopMessage'] as String : null,
      bookingTime:
          map['bookingTime'] != null ? map['bookingTime'] as String : null,
      addedTime: map['addedTime'] != null ? map['addedTime'] as String : null,
      advancePayment: map['advancePayment'] != null
          ? map['advancePayment'] as String
          : null,
      advanceAmount:
          map['advanceAmount'] != null ? map['advanceAmount'] as String : null,
      amountStatus: map['amountStatus'] != null
          ? AmountStatus.fromLabel(map['amountStatus'])
          : AmountStatus.initial,
      paymentMethod:
          map['paymentMethod'] != null ? map['paymentMethod'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnquirieModel.fromJson(String source) =>
      EnquirieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EnquirieModel(id: $id, formattedID: $formattedID, name: $name, phone: $phone, email: $email, chairs: $chairs, message: $message, status: $status, shopMessage: $shopMessage, bookingTime: $bookingTime, addedTime: $addedTime, advancePayment: $advancePayment, advanceAmount: $advanceAmount, amountStatus: $amountStatus, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(covariant EnquirieModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.formattedID == formattedID &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.chairs == chairs &&
        other.message == message &&
        other.status == status &&
        other.shopMessage == shopMessage &&
        other.bookingTime == bookingTime &&
        other.addedTime == addedTime &&
        other.advancePayment == advancePayment &&
        other.advanceAmount == advanceAmount &&
        other.amountStatus == amountStatus &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        formattedID.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        chairs.hashCode ^
        message.hashCode ^
        status.hashCode ^
        shopMessage.hashCode ^
        bookingTime.hashCode ^
        addedTime.hashCode ^
        advancePayment.hashCode ^
        advanceAmount.hashCode ^
        amountStatus.hashCode ^
        paymentMethod.hashCode;
  }
}
