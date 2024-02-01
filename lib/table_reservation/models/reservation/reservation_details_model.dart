// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../constants/enums.dart';

class ReservationDetailsModel {
  final String bookingOver;
  final ReservationProfile reservationProfile;
  final List<ChatMessage> chatMessages;
  final String advanceAmount;
  ReservationDetailsModel({
    required this.bookingOver,
    required this.reservationProfile,
    required this.chatMessages,
    required this.advanceAmount,
  });

  ReservationDetailsModel copyWith({
    String? bookingOver,
    ReservationProfile? reservationProfile,
    List<ChatMessage>? chatMessages,
    String? advanceAmount,
  }) {
    return ReservationDetailsModel(
      bookingOver: bookingOver ?? this.bookingOver,
      reservationProfile: reservationProfile ?? this.reservationProfile,
      chatMessages: chatMessages ?? this.chatMessages,
      advanceAmount: advanceAmount ?? this.advanceAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookingOver': bookingOver,
      'reservationProfile': reservationProfile.toMap(),
      'chatMessages': chatMessages.map((x) => x.toMap()).toList(),
      'AdvanceAmount': advanceAmount,
    };
  }

  factory ReservationDetailsModel.fromMap(Map<String, dynamic> map) {
    return ReservationDetailsModel(
      bookingOver: map['bookingOver'] as String,
      reservationProfile: ReservationProfile.fromMap(
          map['reservationProfile'] as Map<String, dynamic>),
      chatMessages: List<ChatMessage>.from(
        (map['chatMessages'] ?? []).map<ChatMessage>(
          (x) => ChatMessage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      advanceAmount: map['AdvanceAmount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationDetailsModel.fromJson(String source) =>
      ReservationDetailsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReservationDetailsModel(bookingOver: $bookingOver, reservationProfile: $reservationProfile, chatMessages: $chatMessages, AdvanceAmount: $advanceAmount)';
  }

  @override
  bool operator ==(covariant ReservationDetailsModel other) {
    if (identical(this, other)) return true;

    return other.bookingOver == bookingOver &&
        other.reservationProfile == reservationProfile &&
        listEquals(other.chatMessages, chatMessages) &&
        other.advanceAmount == advanceAmount;
  }

  @override
  int get hashCode {
    return bookingOver.hashCode ^
        reservationProfile.hashCode ^
        chatMessages.hashCode ^
        advanceAmount.hashCode;
  }
}

class ReservationProfile {
  final String? id;
  final String? formattedID;
  final String? shopID;
  final String? userID;
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
  final String? transactionID;
  final String? messagingOtp;

  ReservationProfile({
    required this.id,
    required this.formattedID,
    required this.shopID,
    required this.userID,
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
    required this.transactionID,
    required this.messagingOtp,
  });

  ReservationProfile copyWith({
    String? id,
    String? formattedID,
    String? shopID,
    String? userID,
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
    String? transactionID,
    String? messagingOtp,
  }) {
    return ReservationProfile(
      id: id ?? this.id,
      formattedID: formattedID ?? this.formattedID,
      shopID: shopID ?? this.shopID,
      userID: userID ?? this.userID,
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
      transactionID: transactionID ?? this.transactionID,
      messagingOtp: messagingOtp ?? this.messagingOtp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'formattedID': formattedID,
      'shopID': shopID,
      'userID': userID,
      'name': name,
      'phone': phone,
      'email': email,
      'chairs': chairs,
      'message': message,
      'status': status?.label,
      'shopMessage': shopMessage,
      'bookingTime': bookingTime,
      'addedTime': addedTime,
      'advancePayment': advancePayment,
      'advanceAmount': advanceAmount,
      'amountStatus': amountStatus,
      'paymentMethod': paymentMethod,
      'transactionID': transactionID,
      'messagingOtp': messagingOtp,
    };
  }

  factory ReservationProfile.fromMap(Map<String, dynamic> map) {
    return ReservationProfile(
      id: map['id'] != null ? map['id'] as String : null,
      formattedID:
          map['formattedID'] != null ? map['formattedID'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
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
      transactionID:
          map['transactionID'] != null ? map['transactionID'] as String : null,
      messagingOtp:
          map['messagingOtp'] != null ? map['messagingOtp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationProfile.fromJson(String source) =>
      ReservationProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReservationProfile(id: $id, formattedID: $formattedID, shopID: $shopID, userID: $userID, name: $name, phone: $phone, email: $email, chairs: $chairs, message: $message, status: $status, shopMessage: $shopMessage, bookingTime: $bookingTime, addedTime: $addedTime, advancePayment: $advancePayment, advanceAmount: $advanceAmount, amountStatus: $amountStatus, paymentMethod: $paymentMethod, transactionID: $transactionID, messagingOtp: $messagingOtp)';
  }

  @override
  bool operator ==(covariant ReservationProfile other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.formattedID == formattedID &&
        other.shopID == shopID &&
        other.userID == userID &&
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
        other.paymentMethod == paymentMethod &&
        other.transactionID == transactionID &&
        other.messagingOtp == messagingOtp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        formattedID.hashCode ^
        shopID.hashCode ^
        userID.hashCode ^
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
        paymentMethod.hashCode ^
        transactionID.hashCode ^
        messagingOtp.hashCode;
  }
}

class ChatMessage {
  final String? reservationId;
  final String? id;
  final String? shopID;
  final String? userID;
  final String? relationID;
  final String? source;
  final String? userEmail;
  final String? userPhone;
  final String? message;
  final String? auther;
  final String? addedTime;
  final bool socketMessage;
  ChatMessage({
    this.reservationId,
    required this.id,
    this.shopID,
    this.userID,
    this.relationID,
    this.source,
    this.userEmail,
    this.userPhone,
    this.message,
    this.auther,
    this.addedTime,
    this.socketMessage = false,
  });

  ChatMessage copyWith({
    String? reservationId,
    String? id,
    String? shopID,
    String? userID,
    String? relationID,
    String? source,
    String? userEmail,
    String? userPhone,
    String? message,
    String? auther,
    String? addedTime,
    bool? socketMessage,
  }) {
    return ChatMessage(
      reservationId: reservationId ?? this.reservationId,
      id: id ?? this.id,
      shopID: shopID ?? this.shopID,
      userID: userID ?? this.userID,
      relationID: relationID ?? this.relationID,
      source: source ?? this.source,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      message: message ?? this.message,
      auther: auther ?? this.auther,
      addedTime: addedTime ?? this.addedTime,
      socketMessage: socketMessage ?? this.socketMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reservationId': reservationId,
      'id': id,
      'shopID': shopID,
      'userID': userID,
      'relationID': relationID,
      'source': source,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'message': message,
      'auther': auther,
      'addedTime': addedTime,
      'socketMessage': socketMessage,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      reservationId:
          map['reservationId'] != null ? map['reservationId'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
      relationID:
          map['relationID'] != null ? map['relationID'] as String : null,
      source: map['source'] != null ? map['source'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userPhone: map['userPhone'] != null ? map['userPhone'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      auther: map['auther'] != null ? map['auther'] as String : null,
      addedTime: map['addedTime'] != null ? map['addedTime'] as String : null,
      socketMessage: map['socketMessage'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(reservationId: $reservationId, id: $id, shopID: $shopID, userID: $userID, relationID: $relationID, source: $source, userEmail: $userEmail, userPhone: $userPhone, message: $message, auther: $auther, addedTime: $addedTime, socketMessage: $socketMessage)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.reservationId == reservationId &&
        other.id == id &&
        other.shopID == shopID &&
        other.userID == userID &&
        other.relationID == relationID &&
        other.source == source &&
        other.userEmail == userEmail &&
        other.userPhone == userPhone &&
        other.message == message &&
        other.auther == auther &&
        other.addedTime == addedTime &&
        other.socketMessage == socketMessage;
  }

  @override
  int get hashCode {
    return reservationId.hashCode ^
        id.hashCode ^
        shopID.hashCode ^
        userID.hashCode ^
        relationID.hashCode ^
        source.hashCode ^
        userEmail.hashCode ^
        userPhone.hashCode ^
        message.hashCode ^
        auther.hashCode ^
        addedTime.hashCode ^
        socketMessage.hashCode;
  }
}
