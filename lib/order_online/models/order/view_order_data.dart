// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ViewOrderData {
  final String? orderID;
  final String? customerOrderID;
  final String? userID;
  final String? email;
  final String? phone;
  final String? amount;
  final String? discount;
  final String? deliveryCharge;
  final String? deliveryNotes;
  final String? deliveryType;
  final String? paymentStatus;
  final String? paymentGatway;
  final String? transactionID;
  final String? approxDeliveryTime;
  final String? takeaWayTime;
  final String? orderedAt;
  final String? message;
  final String? status;
  final String? currencyType;
  final List<LineItems> lineItems;
  final DeliveryAddressDetails? deliveryAddress;
  ViewOrderData({
    this.orderID,
    this.customerOrderID,
    this.userID,
    this.email,
    this.phone,
    this.amount,
    this.discount,
    this.deliveryCharge,
    this.deliveryNotes,
    this.deliveryType,
    this.paymentStatus,
    this.paymentGatway,
    this.transactionID,
    this.approxDeliveryTime,
    this.takeaWayTime,
    this.orderedAt,
    this.message,
    this.status,
    this.currencyType,
    this.lineItems = const [],
    this.deliveryAddress,
  });

  ViewOrderData copyWith({
    String? orderID,
    String? customerOrderID,
    String? userID,
    String? email,
    String? phone,
    String? amount,
    String? discount,
    String? deliveryCharge,
    String? deliveryNotes,
    String? deliveryType,
    String? paymentStatus,
    String? paymentGatway,
    String? transactionID,
    String? approxDeliveryTime,
    String? takeaWayTime,
    String? orderedAt,
    String? message,
    String? status,
    String? currencyType,
    List<LineItems>? lineItems,
    DeliveryAddressDetails? deliveryAddress,
  }) {
    return ViewOrderData(
      orderID: orderID ?? this.orderID,
      customerOrderID: customerOrderID ?? this.customerOrderID,
      userID: userID ?? this.userID,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      discount: discount ?? this.discount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentGatway: paymentGatway ?? this.paymentGatway,
      transactionID: transactionID ?? this.transactionID,
      approxDeliveryTime: approxDeliveryTime ?? this.approxDeliveryTime,
      takeaWayTime: takeaWayTime ?? this.takeaWayTime,
      orderedAt: orderedAt ?? this.orderedAt,
      message: message ?? this.message,
      status: status ?? this.status,
      currencyType: currencyType ?? this.currencyType,
      lineItems: lineItems ?? this.lineItems,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
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
      'discount': discount,
      'deliveryCharge': deliveryCharge,
      'deliveryNotes': deliveryNotes,
      'deliveryType': deliveryType,
      'paymentStatus': paymentStatus,
      'paymentGatway': paymentGatway,
      'transactionID': transactionID,
      'approxDeliveryTime': approxDeliveryTime,
      'takeaWayTime': takeaWayTime,
      'orderedAt': orderedAt,
      'message': message,
      'status': status,
      'currencyType': currencyType,
      'lineItems': lineItems.map((x) => x.toMap()).toList(),
      'deliveryAddress': deliveryAddress?.toMap(),
    };
  }

  factory ViewOrderData.fromMap(Map<String, dynamic> map) {
    return ViewOrderData(
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      customerOrderID: map['customerOrderID'] != null
          ? map['customerOrderID'] as String
          : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      deliveryCharge: map['deliveryCharge'] != null
          ? map['deliveryCharge'] as String
          : null,
      deliveryNotes:
          map['deliveryNotes'] != null ? map['deliveryNotes'] as String : null,
      deliveryType:
          map['deliveryType'] != null ? map['deliveryType'] as String : null,
      paymentStatus:
          map['paymentStatus'] != null ? map['paymentStatus'] as String : null,
      paymentGatway:
          map['paymentGatway'] != null ? map['paymentGatway'] as String : null,
      transactionID:
          map['transactionID'] != null ? map['transactionID'] as String : null,
      approxDeliveryTime: map['approxDeliveryTime'] != null
          ? map['approxDeliveryTime'] as String
          : null,
      takeaWayTime:
          map['takeaWayTime'] != null ? map['takeaWayTime'] as String : null,
      orderedAt: map['orderedAt'] != null ? map['orderedAt'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      currencyType:
          map['currencyType'] != null ? map['currencyType'] as String : null,
      lineItems: map['lineItems'] != null
          ? List<LineItems>.from(
              (map['lineItems'] as List<dynamic>).map<LineItems>(
                (x) => LineItems.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      deliveryAddress: map['deliveryAddress'] != null
          ? DeliveryAddressDetails.fromMap(
              map['deliveryAddress'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewOrderData.fromJson(String source) =>
      ViewOrderData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ViewOrderData(orderID: $orderID, customerOrderID: $customerOrderID, userID: $userID, email: $email, phone: $phone, amount: $amount, discount: $discount, deliveryCharge: $deliveryCharge, deliveryNotes: $deliveryNotes, deliveryType: $deliveryType, paymentStatus: $paymentStatus, paymentGatway: $paymentGatway, transactionID: $transactionID, approxDeliveryTime: $approxDeliveryTime, takeaWayTime: $takeaWayTime, orderedAt: $orderedAt, message: $message, status: $status, currencyType: $currencyType, lineItems: $lineItems, deliveryAddress: $deliveryAddress)';
  }

  @override
  bool operator ==(covariant ViewOrderData other) {
    if (identical(this, other)) return true;

    return other.orderID == orderID &&
        other.customerOrderID == customerOrderID &&
        other.userID == userID &&
        other.email == email &&
        other.phone == phone &&
        other.amount == amount &&
        other.discount == discount &&
        other.deliveryCharge == deliveryCharge &&
        other.deliveryNotes == deliveryNotes &&
        other.deliveryType == deliveryType &&
        other.paymentStatus == paymentStatus &&
        other.paymentGatway == paymentGatway &&
        other.transactionID == transactionID &&
        other.approxDeliveryTime == approxDeliveryTime &&
        other.takeaWayTime == takeaWayTime &&
        other.orderedAt == orderedAt &&
        other.message == message &&
        other.status == status &&
        other.currencyType == currencyType &&
        listEquals(other.lineItems, lineItems) &&
        other.deliveryAddress == deliveryAddress;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
        customerOrderID.hashCode ^
        userID.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        amount.hashCode ^
        discount.hashCode ^
        deliveryCharge.hashCode ^
        deliveryNotes.hashCode ^
        deliveryType.hashCode ^
        paymentStatus.hashCode ^
        paymentGatway.hashCode ^
        transactionID.hashCode ^
        approxDeliveryTime.hashCode ^
        takeaWayTime.hashCode ^
        orderedAt.hashCode ^
        message.hashCode ^
        status.hashCode ^
        currencyType.hashCode ^
        lineItems.hashCode ^
        deliveryAddress.hashCode;
  }

}

class LineItems {
  final String? identifierName;
  final String? name;
  final String? description;
  final String? photo;
  final String? variationName;
  final String? ingredients;
  final String? price;
  final String? quantity;
  final String? formattedPrice;
  final List<AddonsDetails> addons;
  LineItems({
    this.identifierName,
    this.name,
    this.description,
    this.photo,
    this.variationName,
    this.ingredients,
    this.price,
    this.quantity,
    this.formattedPrice,
    this.addons = const [],
  });

  LineItems copyWith({
    String? identifierName,
    String? name,
    String? description,
    String? photo,
    String? variationName,
    String? ingredients,
    String? price,
    String? quantity,
    String? formattedPrice,
    List<AddonsDetails>? addons,
  }) {
    return LineItems(
      identifierName: identifierName ?? this.identifierName,
      name: name ?? this.name,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      variationName: variationName ?? this.variationName,
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      addons: addons ?? this.addons,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identifierName': identifierName,
      'name': name,
      'description': description,
      'photo': photo,
      'variationName': variationName,
      'ingredients': ingredients,
      'price': price,
      'quantity': quantity,
      'formattedPrice': formattedPrice,
      'addons': addons.map((x) => x.toMap()).toList(),
    };
  }

  factory LineItems.fromMap(Map<String, dynamic> map) {
    return LineItems(
      identifierName: map['identifierName'] != null
          ? map['identifierName'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      photo: map['photo'] != null ? map['photo'] as String : null,
      variationName:
          map['variationName'] != null ? map['variationName'] as String : null,
      ingredients:
          map['ingredients'] != null ? map['ingredients'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      formattedPrice: map['formattedPrice'] != null
          ? map['formattedPrice'] as String
          : null,
      addons: map['addons'] != null
          ? List<AddonsDetails>.from(
              (map['addons'] as List<dynamic>).map<AddonsDetails>(
                (x) => AddonsDetails.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory LineItems.fromJson(String source) =>
      LineItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LineItems(identifierName: $identifierName, name: $name, description: $description, photo: $photo, variationName: $variationName, ingredients: $ingredients, price: $price, quantity: $quantity, formattedPrice: $formattedPrice, addons: $addons)';
  }

  @override
  bool operator ==(covariant LineItems other) {
    if (identical(this, other)) return true;

    return other.identifierName == identifierName &&
        other.name == name &&
        other.description == description &&
        other.photo == photo &&
        other.variationName == variationName &&
        other.ingredients == ingredients &&
        other.price == price &&
        other.quantity == quantity &&
        other.formattedPrice == formattedPrice &&
        listEquals(other.addons, addons);
  }

  @override
  int get hashCode {
    return identifierName.hashCode ^
        name.hashCode ^
        description.hashCode ^
        photo.hashCode ^
        variationName.hashCode ^
        ingredients.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        formattedPrice.hashCode ^
        addons.hashCode;
  }

}

class DeliveryAddressDetails {
  final String? customerName;
  final String? line1;
  final String? line2;
  final String? town;
  final String? postcode;
  final String? county;
  final String? landmark;
  DeliveryAddressDetails({
    this.customerName,
    this.line1,
    this.line2,
    this.town,
    this.postcode,
    this.county,
    this.landmark,
  });

  DeliveryAddressDetails copyWith({
    String? customerName,
    String? line1,
    String? line2,
    String? town,
    String? postcode,
    String? county,
    String? landmark,
  }) {
    return DeliveryAddressDetails(
      customerName: customerName ?? this.customerName,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      town: town ?? this.town,
      postcode: postcode ?? this.postcode,
      county: county ?? this.county,
      landmark: landmark ?? this.landmark,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerName': customerName,
      'line1': line1,
      'line2': line2,
      'town': town,
      'postcode': postcode,
      'county': county,
      'landmark': landmark,
    };
  }

  factory DeliveryAddressDetails.fromMap(Map<String, dynamic> map) {
    return DeliveryAddressDetails(
      customerName:
          map['customerName'] != null ? map['customerName'] as String : null,
      line1: map['line1'] != null ? map['line1'] as String : null,
      line2: map['line2'] != null ? map['line2'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      county: map['county'] != null ? map['county'] as String : null,
      landmark: map['landmark'] != null ? map['landmark'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryAddressDetails.fromJson(String source) =>
      DeliveryAddressDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DeliveryAddressDetails(customerName: $customerName, line1: $line1, line2: $line2, town: $town, postcode: $postcode, county: $county, landmark: $landmark)';
  }

  @override
  bool operator ==(covariant DeliveryAddressDetails other) {
    if (identical(this, other)) return true;

    return other.customerName == customerName &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.town == town &&
        other.postcode == postcode &&
        other.county == county &&
        other.landmark == landmark;
  }

  @override
  int get hashCode {
    return customerName.hashCode ^
        line1.hashCode ^
        line2.hashCode ^
        town.hashCode ^
        postcode.hashCode ^
        county.hashCode ^
        landmark.hashCode;
  }

 
}

class AddonsDetails {
  final String? opaID;
  final String? opID;
  final String? name;
  final String? price;
  AddonsDetails({
    this.opaID,
    this.opID,
    this.name,
    this.price,
  });

  AddonsDetails copyWith({
    String? opaID,
    String? opID,
    String? name,
    String? price,
  }) {
    return AddonsDetails(
      opaID: opaID ?? this.opaID,
      opID: opID ?? this.opID,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'opaID': opaID,
      'opID': opID,
      'name': name,
      'price': price,
    };
  }

  factory AddonsDetails.fromMap(Map<String, dynamic> map) {
    return AddonsDetails(
      opaID: map['opaID'] != null ? map['opaID'] as String : null,
      opID: map['opID'] != null ? map['opID'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddonsDetails.fromJson(String source) =>
      AddonsDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddonsDetails(opaID: $opaID, opID: $opID, name: $name, price: $price)';
  }

  @override
  bool operator ==(covariant AddonsDetails other) {
    if (identical(this, other)) return true;

    return other.opaID == opaID &&
        other.opID == opID &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode {
    return opaID.hashCode ^ opID.hashCode ^ name.hashCode ^ price.hashCode;
  }

}
