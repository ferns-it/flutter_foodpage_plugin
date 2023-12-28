// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class NewRequestsCollection {
  final String statusMessage;
  final String haveAdvance;
  final List<Enquirie> enquiries;
  final List<Enquirie> modifiedEnquiries;
  final List<dynamic> todayCancelledEnquiries;
  NewRequestsCollection({
    required this.statusMessage,
    required this.haveAdvance,
    required this.enquiries,
    required this.modifiedEnquiries,
    required this.todayCancelledEnquiries,
  });

  NewRequestsCollection copyWith({
    String? statusMessage,
    String? haveAdvance,
    List<Enquirie>? enquiries,
    List<Enquirie>? modifiedEnquiries,
    List<dynamic>? todayCancelledEnquiries,
  }) {
    return NewRequestsCollection(
      statusMessage: statusMessage ?? this.statusMessage,
      haveAdvance: haveAdvance ?? this.haveAdvance,
      enquiries: enquiries ?? this.enquiries,
      modifiedEnquiries: modifiedEnquiries ?? this.modifiedEnquiries,
      todayCancelledEnquiries:
          todayCancelledEnquiries ?? this.todayCancelledEnquiries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusMessage': statusMessage,
      'haveAdvance': haveAdvance,
      'enquiries': enquiries.map((x) => x.toMap()).toList(),
      'modified_enquiries': modifiedEnquiries.map((x) => x.toMap()).toList(),
      'today_cancelled_enquiries': todayCancelledEnquiries,
    };
  }

  factory NewRequestsCollection.fromMap(Map<String, dynamic> map) {
    return NewRequestsCollection(
        statusMessage: map['statusMessage'] as String,
        haveAdvance: map['haveAdvance'] as String,
        enquiries: List<Enquirie>.from(
          (map['enquiries'] as List<int>).map<Enquirie>(
            (x) => Enquirie.fromMap(x as Map<String, dynamic>),
          ),
        ),
        modifiedEnquiries: List<Enquirie>.from(
          (map['modified_enquiries'] as List<int>).map<Enquirie>(
            (x) => Enquirie.fromMap(x as Map<String, dynamic>),
          ),
        ),
        todayCancelledEnquiries: List<dynamic>.from(
          (map['today_cancelled_enquiries'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory NewRequestsCollection.fromJson(String source) =>
      NewRequestsCollection.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewRequestsCollection(statusMessage: $statusMessage, haveAdvance: $haveAdvance, enquiries: $enquiries, modified_enquiries: $modifiedEnquiries, today_cancelled_enquiries: $todayCancelledEnquiries)';
  }

  @override
  bool operator ==(covariant NewRequestsCollection other) {
    if (identical(this, other)) return true;

    return other.statusMessage == statusMessage &&
        other.haveAdvance == haveAdvance &&
        listEquals(other.enquiries, enquiries) &&
        listEquals(other.modifiedEnquiries, modifiedEnquiries) &&
        listEquals(other.todayCancelledEnquiries, todayCancelledEnquiries);
  }

  @override
  int get hashCode {
    return statusMessage.hashCode ^
        haveAdvance.hashCode ^
        enquiries.hashCode ^
        modifiedEnquiries.hashCode ^
        todayCancelledEnquiries.hashCode;
  }
}

class Enquirie {
  final String id;
  final String formattedID;
  final String name;
  final String phone;
  final String email;
  final String chairs;
  final String message;
  final String status;
  final String shopMessage;
  final String bookingTime;
  final String addedTime;
  final String advancePayment;
  final String advanceAmount;
  final String amountStatus;
  final String? paymentMethod;
  Enquirie({
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

  Enquirie copyWith({
    String? id,
    String? formattedID,
    String? name,
    String? phone,
    String? email,
    String? chairs,
    String? message,
    String? status,
    String? shopMessage,
    String? bookingTime,
    String? addedTime,
    String? advancePayment,
    String? advanceAmount,
    String? amountStatus,
    String? paymentMethod,
  }) {
    return Enquirie(
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
      'status': status,
      'shopMessage': shopMessage,
      'bookingTime': bookingTime,
      'addedTime': addedTime,
      'advancePayment': advancePayment,
      'advanceAmount': advanceAmount,
      'amountStatus': amountStatus,
      'paymentMethod': paymentMethod,
    };
  }

  factory Enquirie.fromMap(Map<String, dynamic> map) {
    return Enquirie(
      id: map['id'] as String,
      formattedID: map['formattedID'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      chairs: map['chairs'] as String,
      message: map['message'] as String,
      status: map['status'] as String,
      shopMessage: map['shopMessage'] as String,
      bookingTime: map['bookingTime'] as String,
      addedTime: map['addedTime'] as String,
      advancePayment: map['advancePayment'] as String,
      advanceAmount: map['advanceAmount'] as String,
      amountStatus: map['amountStatus'] as String,
      paymentMethod:
          map['paymentMethod'] != null ? map['paymentMethod'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Enquirie.fromJson(String source) =>
      Enquirie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Enquirie(id: $id, formattedID: $formattedID, name: $name, phone: $phone, email: $email, chairs: $chairs, message: $message, status: $status, shopMessage: $shopMessage, bookingTime: $bookingTime, addedTime: $addedTime, advancePayment: $advancePayment, advanceAmount: $advanceAmount, amountStatus: $amountStatus, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(covariant Enquirie other) {
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
