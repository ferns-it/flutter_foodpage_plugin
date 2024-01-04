// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class OnlineOrderData   {
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
  final DeliveryAddress? deliveryAddress;
  final User? user;
  OnlineOrderData({
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
    this.deliveryAddress,
    this.user,
  });

  OnlineOrderData copyWith({
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
    DeliveryAddress? deliveryAddress,
    User? user,
  }) {
    return OnlineOrderData(
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
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      user: user ?? this.user,
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
      'status': status?.toMap(),
      'deliveryAddress': deliveryAddress?.toMap(),
      'user': user?.toMap(),
    };
  }

  factory OnlineOrderData.fromMap(Map<String, dynamic> map) {
    return OnlineOrderData(
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
          : map['status'] != null && map['status'] is String ? map['status'] : null,
      deliveryAddress: map['deliveryAddress'] != null
          ? DeliveryAddress.fromMap(
              map['deliveryAddress'] as Map<String, dynamic>)
          : null,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnlineOrderData.fromJson(String source) =>
      OnlineOrderData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OnlineOrderData(orderID: $orderID, customerOrderID: $customerOrderID, userID: $userID, email: $email, phone: $phone, amount: $amount, deliveryType: $deliveryType, paymentStatus: $paymentStatus, date: $date, status: $status, deliveryAddress: $deliveryAddress, user: $user)';
  }

  @override
  bool operator ==(covariant OnlineOrderData other) {
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
        other.status == status &&
        other.deliveryAddress == deliveryAddress &&
        other.user == user;
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
        status.hashCode ^
        deliveryAddress.hashCode ^
        user.hashCode;
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

class DeliveryAddress {
  final String? oaID;
  final String? customerName;
  final String? line1;
  final String? line2;
  final String? town;
  final String? postcode;
  final String? county;
  DeliveryAddress({
    this.oaID,
    this.customerName,
    this.line1,
    this.line2,
    this.town,
    this.postcode,
    this.county,
  });

  DeliveryAddress copyWith({
    String? oaID,
    String? customerName,
    String? line1,
    String? line2,
    String? town,
    String? postcode,
    String? county,
  }) {
    return DeliveryAddress(
      oaID: oaID ?? this.oaID,
      customerName: customerName ?? this.customerName,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      town: town ?? this.town,
      postcode: postcode ?? this.postcode,
      county: county ?? this.county,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oaID': oaID,
      'customerName': customerName,
      'line1': line1,
      'line2': line2,
      'town': town,
      'postcode': postcode,
      'county': county,
    };
  }

  factory DeliveryAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryAddress(
      oaID: map['oaID'] != null ? map['oaID'] as String : null,
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      line1: map['line1'] != null ? map['line1'] as String : null,
      line2: map['line2'] != null ? map['line2'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      county: map['county'] != null ? map['county'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryAddress.fromJson(String source) =>
      DeliveryAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryAddress(oaID: $oaID, customerName: $customerName, line1: $line1, line2: $line2, town: $town, postcode: $postcode, county: $county)';
  }

  @override
  bool operator ==(covariant DeliveryAddress other) {
    if (identical(this, other)) return true;

    return other.oaID == oaID &&
        other.customerName == customerName &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.town == town &&
        other.postcode == postcode &&
        other.county == county;
  }

  @override
  int get hashCode {
    return oaID.hashCode ^
        customerName.hashCode ^
        line1.hashCode ^
        line2.hashCode ^
        town.hashCode ^
        postcode.hashCode ^
        county.hashCode;
  }

  String get fullAddress => line2 != null
      ? '$line1, $line2, $town, $county, $postcode'
      : '$line1, $town, $county, $postcode';
}

class User {
  final String? userFirstName;
  final String? userLastName;
  final String? userAddress;
  final String? userPostCode;
  User({
    this.userFirstName,
    this.userLastName,
    this.userAddress,
    this.userPostCode,
  });

  User copyWith({
    String? userFirstName,
    String? userLastName,
    String? userAddress,
    String? userPostCode,
  }) {
    return User(
      userFirstName: userFirstName ?? this.userFirstName,
      userLastName: userLastName ?? this.userLastName,
      userAddress: userAddress ?? this.userAddress,
      userPostCode: userPostCode ?? this.userPostCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'userAddress': userAddress,
      'userPostCode': userPostCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userFirstName:
          map['userFirstName'] != null ? map['userFirstName'] as String : null,
      userLastName:
          map['userLastName'] != null ? map['userLastName'] as String : null,
      userAddress:
          map['userAddress'] != null ? map['userAddress'] as String : null,
      userPostCode:
          map['userPostCode'] != null ? map['userPostCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(userFirstName: $userFirstName, userLastName: $userLastName, userAddress: $userAddress, userPostCode: $userPostCode)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userFirstName == userFirstName &&
        other.userLastName == userLastName &&
        other.userAddress == userAddress &&
        other.userPostCode == userPostCode;
  }

  @override
  int get hashCode {
    return userFirstName.hashCode ^
        userLastName.hashCode ^
        userAddress.hashCode ^
        userPostCode.hashCode;
  }

}
