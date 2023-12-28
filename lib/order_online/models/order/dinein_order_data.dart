// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class DineinOrderData {
  final String? orderID;
  final String? customerOrderID;
  final String? userID;
  final String? email;
  final String? phone;
  final String? amount;
  final String? deliveryType;
  final String? paymentStatus;
  final String? date;
  final dynamic status;
  DineinOrderData({
    this.orderID,
    this.customerOrderID,
    this.userID,
    this.email,
    this.phone,
    this.amount,
    this.deliveryType,
    this.paymentStatus,
    this.date,
    this.status,
  });

  DineinOrderData copyWith({
    String? orderID,
    String? customerOrderID,
    String? userID,
    String? email,
    String? phone,
    String? amount,
    String? deliveryType,
    String? paymentStatus,
    String? date,
    dynamic status,
  }) {
    return DineinOrderData(
      orderID: orderID ?? this.orderID,
      customerOrderID: customerOrderID ?? this.customerOrderID,
      userID: userID ?? this.userID,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'customerOrderID': customerOrderID,
      'userID': userID,
      'email': email,
      'phone': phone,
      'amount': amount,
      'deliveryType': deliveryType,
      'paymentStatus': paymentStatus,
      'date': date,
      'status': status,
    };
  }

  factory DineinOrderData.fromMap(Map<String, dynamic> map) {
    return DineinOrderData(
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      customerOrderID: map['customerOrderID'] != null
          ? map['customerOrderID'] as String
          : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      deliveryType:
          map['deliveryType'] != null ? map['deliveryType'] as String : null,
      paymentStatus:
          map['paymentStatus'] != null ? map['paymentStatus'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      status: map['status'] != null && map['status'] is Map<String, dynamic>
          ? Status.fromMap(map['status'] as Map<String, dynamic>)
          : map['status'] != null && map['status'] is String
              ? map['status']
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DineinOrderData.fromJson(String source) =>
      DineinOrderData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DineinOrderData(orderID: $orderID, customerOrderID: $customerOrderID, userID: $userID, email: $email, phone: $phone, amount: $amount, deliveryType: $deliveryType, paymentStatus: $paymentStatus, date: $date, status: $status)';
  }

  @override
  bool operator ==(covariant DineinOrderData other) {
    if (identical(this, other)) return true;

    return other.orderID == orderID &&
        other.customerOrderID == customerOrderID &&
        other.userID == userID &&
        other.email == email &&
        other.phone == phone &&
        other.amount == amount &&
        other.deliveryType == deliveryType &&
        other.paymentStatus == paymentStatus &&
        other.date == date &&
        other.status == status;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
        customerOrderID.hashCode ^
        userID.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        amount.hashCode ^
        deliveryType.hashCode ^
        paymentStatus.hashCode ^
        date.hashCode ^
        status.hashCode;
  }

}

class Status {
  final int? statusID;
  final String? statusHandle;
  final String? statusName;
  final String? statusDescription;
  Status({
    this.statusID,
    this.statusHandle,
    this.statusName,
    this.statusDescription,
  });

  Status copyWith({
    int? statusID,
    String? statusHandle,
    String? statusName,
    String? statusDescription,
  }) {
    return Status(
      statusID: statusID ?? this.statusID,
      statusHandle: statusHandle ?? this.statusHandle,
      statusName: statusName ?? this.statusName,
      statusDescription: statusDescription ?? this.statusDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusID': statusID,
      'statusHandle': statusHandle,
      'statusName': statusName,
      'statusDescription': statusDescription,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      statusID: map['statusID'] != null ? map['statusID'] as int : null,
      statusHandle:
          map['statusHandle'] != null ? map['statusHandle'] as String : null,
      statusName:
          map['statusName'] != null ? map['statusName'] as String : null,
      statusDescription: map['statusDescription'] != null
          ? map['statusDescription'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Status(statusID: $statusID, statusHandle: $statusHandle, statusName: $statusName, statusDescription: $statusDescription)';
  }

  @override
  bool operator ==(covariant Status other) {
    if (identical(this, other)) return true;

    return other.statusID == statusID &&
        other.statusHandle == statusHandle &&
        other.statusName == statusName &&
        other.statusDescription == statusDescription;
  }

  @override
  int get hashCode {
    return statusID.hashCode ^
        statusHandle.hashCode ^
        statusName.hashCode ^
        statusDescription.hashCode;
  }
}
