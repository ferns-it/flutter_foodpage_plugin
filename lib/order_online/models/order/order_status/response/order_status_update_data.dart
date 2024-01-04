// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderStatusUpdateData {
  final String? messages;
  final OrderDetails? order;
  OrderStatusUpdateData({
    this.messages,
    this.order,
  });

  OrderStatusUpdateData copyWith({
    String? messages,
    OrderDetails? order,
  }) {
    return OrderStatusUpdateData(
      messages: messages ?? this.messages,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messages': messages,
      'order': order?.toMap(),
    };
  }

  factory OrderStatusUpdateData.fromMap(Map<String, dynamic> map) {
    return OrderStatusUpdateData(
      messages: map['messages'] != null ? map['messages'] as String : null,
      order: map['order'] != null ? OrderDetails.fromMap(map['order'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderStatusUpdateData.fromJson(String source) => OrderStatusUpdateData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderStatusUpdateData(messages: $messages, order: $order)';

  @override
  bool operator ==(covariant OrderStatusUpdateData other) {
    if (identical(this, other)) return true;
  
    return 
      other.messages == messages &&
      other.order == order;
  }

  @override
  int get hashCode => messages.hashCode ^ order.hashCode;
}


class OrderDetails {
  final String? orderID;
  final String? customerOrderID;
  final String? shopID;
  final String? userID;
  final String? email;
  final String? phone;
  final String? amount;
  final String? discount;
  final String? specialDiscount;
  final String? couponCode;
  final String? couponType;
  final String? couponValue;
  final String? couponAmount;
  final String? deliveryType;
  final String? dineinType;
  final String? diningTableNo;
  final String? waiterID;
  final String? deliveryCharge;
  final String? paymentStatus;
  final String? paymentGatway;
  final String? paidAmoundStatus;
  final String? transactionID;
  final String? approxDeliveryTime;
  final String? deliveryNotes;
  final String? deliveryLocation;
  final String? takeawayTime;
  final String? orderedAt;
  final String? status;
  final String? rejected;
  final String? rejectedReason;
  final String? message;
  final String? cashAndCard;
  final String? refundAmount;
  final String? refundDate;
  final String? refundID;
  final String? offlineID;
  final String? offlineOrderID;
  final String? source;
  OrderDetails({
    this.orderID,
    this.customerOrderID,
    this.shopID,
    this.userID,
    this.email,
    this.phone,
    this.amount,
    this.discount,
    this.specialDiscount,
    this.couponCode,
    this.couponType,
    this.couponValue,
    this.couponAmount,
    this.deliveryType,
    this.dineinType,
    this.diningTableNo,
    this.waiterID,
    this.deliveryCharge,
    this.paymentStatus,
    this.paymentGatway,
    this.paidAmoundStatus,
    this.transactionID,
    this.approxDeliveryTime,
    this.deliveryNotes,
    this.deliveryLocation,
    this.takeawayTime,
    this.orderedAt,
    this.status,
    this.rejected,
    this.rejectedReason,
    this.message,
    this.cashAndCard,
    this.refundAmount,
    this.refundDate,
    this.refundID,
    this.offlineID,
    this.offlineOrderID,
    this.source,
  });
  

  OrderDetails copyWith({
    String? orderID,
    String? customerOrderID,
    String? shopID,
    String? userID,
    String? email,
    String? phone,
    String? amount,
    String? discount,
    String? specialDiscount,
    String? couponCode,
    String? couponType,
    String? couponValue,
    String? couponAmount,
    String? deliveryType,
    String? dineinType,
    String? diningTableNo,
    String? waiterID,
    String? deliveryCharge,
    String? paymentStatus,
    String? paymentGatway,
    String? paidAmoundStatus,
    String? transactionID,
    String? approxDeliveryTime,
    String? deliveryNotes,
    String? deliveryLocation,
    String? takeawayTime,
    String? orderedAt,
    String? status,
    String? rejected,
    String? rejectedReason,
    String? message,
    String? cashAndCard,
    String? refundAmount,
    String? refundDate,
    String? refundID,
    String? offlineID,
    String? offlineOrderID,
    String? source,
  }) {
    return OrderDetails(
      orderID: orderID ?? this.orderID,
      customerOrderID: customerOrderID ?? this.customerOrderID,
      shopID: shopID ?? this.shopID,
      userID: userID ?? this.userID,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      amount: amount ?? this.amount,
      discount: discount ?? this.discount,
      specialDiscount: specialDiscount ?? this.specialDiscount,
      couponCode: couponCode ?? this.couponCode,
      couponType: couponType ?? this.couponType,
      couponValue: couponValue ?? this.couponValue,
      couponAmount: couponAmount ?? this.couponAmount,
      deliveryType: deliveryType ?? this.deliveryType,
      dineinType: dineinType ?? this.dineinType,
      diningTableNo: diningTableNo ?? this.diningTableNo,
      waiterID: waiterID ?? this.waiterID,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentGatway: paymentGatway ?? this.paymentGatway,
      paidAmoundStatus: paidAmoundStatus ?? this.paidAmoundStatus,
      transactionID: transactionID ?? this.transactionID,
      approxDeliveryTime: approxDeliveryTime ?? this.approxDeliveryTime,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      takeawayTime: takeawayTime ?? this.takeawayTime,
      orderedAt: orderedAt ?? this.orderedAt,
      status: status ?? this.status,
      rejected: rejected ?? this.rejected,
      rejectedReason: rejectedReason ?? this.rejectedReason,
      message: message ?? this.message,
      cashAndCard: cashAndCard ?? this.cashAndCard,
      refundAmount: refundAmount ?? this.refundAmount,
      refundDate: refundDate ?? this.refundDate,
      refundID: refundID ?? this.refundID,
      offlineID: offlineID ?? this.offlineID,
      offlineOrderID: offlineOrderID ?? this.offlineOrderID,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'customerOrderID': customerOrderID,
      'shopID': shopID,
      'userID': userID,
      'email': email,
      'phone': phone,
      'amount': amount,
      'discount': discount,
      'specialDiscount': specialDiscount,
      'couponCode': couponCode,
      'couponType': couponType,
      'couponValue': couponValue,
      'couponAmount': couponAmount,
      'deliveryType': deliveryType,
      'dineinType': dineinType,
      'diningTableNo': diningTableNo,
      'waiterID': waiterID,
      'deliveryCharge': deliveryCharge,
      'paymentStatus': paymentStatus,
      'paymentGatway': paymentGatway,
      'paidAmoundStatus': paidAmoundStatus,
      'transactionID': transactionID,
      'approxDeliveryTime': approxDeliveryTime,
      'deliveryNotes': deliveryNotes,
      'deliveryLocation': deliveryLocation,
      'takeawayTime': takeawayTime,
      'orderedAt': orderedAt,
      'status': status,
      'rejected': rejected,
      'rejectedReason': rejectedReason,
      'message': message,
      'cashAndCard': cashAndCard,
      'refundAmount': refundAmount,
      'refundDate': refundDate,
      'refundID': refundID,
      'offlineID': offlineID,
      'offlineOrderID': offlineOrderID,
      'source': source,
    };
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      orderID: map['orderID'] != null ? map['orderID'] as String : null,
      customerOrderID: map['customerOrderID'] != null ? map['customerOrderID'] as String : null,
      shopID: map['shopID'] != null ? map['shopID'] as String : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      amount: map['amount'] != null ? map['amount'] as String : null,
      discount: map['discount'] != null ? map['discount'] as String : null,
      specialDiscount: map['specialDiscount'] != null ? map['specialDiscount'] as String : null,
      couponCode: map['couponCode'] != null ? map['couponCode'] as String : null,
      couponType: map['couponType'] != null ? map['couponType'] as String : null,
      couponValue: map['couponValue'] != null ? map['couponValue'] as String : null,
      couponAmount: map['couponAmount'] != null ? map['couponAmount'] as String : null,
      deliveryType: map['deliveryType'] != null ? map['deliveryType'] as String : null,
      dineinType: map['dineinType'] != null ? map['dineinType'] as String : null,
      diningTableNo: map['diningTableNo'] != null ? map['diningTableNo'] as String : null,
      waiterID: map['waiterID'] != null ? map['waiterID'] as String : null,
      deliveryCharge: map['deliveryCharge'] != null ? map['deliveryCharge'] as String : null,
      paymentStatus: map['paymentStatus'] != null ? map['paymentStatus'] as String : null,
      paymentGatway: map['paymentGatway'] != null ? map['paymentGatway'] as String : null,
      paidAmoundStatus: map['paidAmoundStatus'] != null ? map['paidAmoundStatus'] as String : null,
      transactionID: map['transactionID'] != null ? map['transactionID'] as String : null,
      approxDeliveryTime: map['approxDeliveryTime'] != null ? map['approxDeliveryTime'] as String : null,
      deliveryNotes: map['deliveryNotes'] != null ? map['deliveryNotes'] as String : null,
      deliveryLocation: map['deliveryLocation'] != null ? map['deliveryLocation'] as String : null,
      takeawayTime: map['takeawayTime'] != null ? map['takeawayTime'] as String : null,
      orderedAt: map['orderedAt'] != null ? map['orderedAt'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      rejected: map['rejected'] != null ? map['rejected'] as String : null,
      rejectedReason: map['rejectedReason'] != null ? map['rejectedReason'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      cashAndCard: map['cashAndCard'] != null ? map['cashAndCard'] as String : null,
      refundAmount: map['refundAmount'] != null ? map['refundAmount'] as String : null,
      refundDate: map['refundDate'] != null ? map['refundDate'] as String : null,
      refundID: map['refundID'] != null ? map['refundID'] as String : null,
      offlineID: map['offlineID'] != null ? map['offlineID'] as String : null,
      offlineOrderID: map['offlineOrderID'] != null ? map['offlineOrderID'] as String : null,
      source: map['source'] != null ? map['source'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetails.fromJson(String source) => OrderDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderDetails(orderID: $orderID, customerOrderID: $customerOrderID, shopID: $shopID, userID: $userID, email: $email, phone: $phone, amount: $amount, discount: $discount, specialDiscount: $specialDiscount, couponCode: $couponCode, couponType: $couponType, couponValue: $couponValue, couponAmount: $couponAmount, deliveryType: $deliveryType, dineinType: $dineinType, diningTableNo: $diningTableNo, waiterID: $waiterID, deliveryCharge: $deliveryCharge, paymentStatus: $paymentStatus, paymentGatway: $paymentGatway, paidAmoundStatus: $paidAmoundStatus, transactionID: $transactionID, approxDeliveryTime: $approxDeliveryTime, deliveryNotes: $deliveryNotes, deliveryLocation: $deliveryLocation, takeawayTime: $takeawayTime, orderedAt: $orderedAt, status: $status, rejected: $rejected, rejectedReason: $rejectedReason, message: $message, cashAndCard: $cashAndCard, refundAmount: $refundAmount, refundDate: $refundDate, refundID: $refundID, offlineID: $offlineID, offlineOrderID: $offlineOrderID, source: $source)';
  }

  @override
  bool operator ==(covariant OrderDetails other) {
    if (identical(this, other)) return true;
  
    return 
      other.orderID == orderID &&
      other.customerOrderID == customerOrderID &&
      other.shopID == shopID &&
      other.userID == userID &&
      other.email == email &&
      other.phone == phone &&
      other.amount == amount &&
      other.discount == discount &&
      other.specialDiscount == specialDiscount &&
      other.couponCode == couponCode &&
      other.couponType == couponType &&
      other.couponValue == couponValue &&
      other.couponAmount == couponAmount &&
      other.deliveryType == deliveryType &&
      other.dineinType == dineinType &&
      other.diningTableNo == diningTableNo &&
      other.waiterID == waiterID &&
      other.deliveryCharge == deliveryCharge &&
      other.paymentStatus == paymentStatus &&
      other.paymentGatway == paymentGatway &&
      other.paidAmoundStatus == paidAmoundStatus &&
      other.transactionID == transactionID &&
      other.approxDeliveryTime == approxDeliveryTime &&
      other.deliveryNotes == deliveryNotes &&
      other.deliveryLocation == deliveryLocation &&
      other.takeawayTime == takeawayTime &&
      other.orderedAt == orderedAt &&
      other.status == status &&
      other.rejected == rejected &&
      other.rejectedReason == rejectedReason &&
      other.message == message &&
      other.cashAndCard == cashAndCard &&
      other.refundAmount == refundAmount &&
      other.refundDate == refundDate &&
      other.refundID == refundID &&
      other.offlineID == offlineID &&
      other.offlineOrderID == offlineOrderID &&
      other.source == source;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
      customerOrderID.hashCode ^
      shopID.hashCode ^
      userID.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      amount.hashCode ^
      discount.hashCode ^
      specialDiscount.hashCode ^
      couponCode.hashCode ^
      couponType.hashCode ^
      couponValue.hashCode ^
      couponAmount.hashCode ^
      deliveryType.hashCode ^
      dineinType.hashCode ^
      diningTableNo.hashCode ^
      waiterID.hashCode ^
      deliveryCharge.hashCode ^
      paymentStatus.hashCode ^
      paymentGatway.hashCode ^
      paidAmoundStatus.hashCode ^
      transactionID.hashCode ^
      approxDeliveryTime.hashCode ^
      deliveryNotes.hashCode ^
      deliveryLocation.hashCode ^
      takeawayTime.hashCode ^
      orderedAt.hashCode ^
      status.hashCode ^
      rejected.hashCode ^
      rejectedReason.hashCode ^
      message.hashCode ^
      cashAndCard.hashCode ^
      refundAmount.hashCode ^
      refundDate.hashCode ^
      refundID.hashCode ^
      offlineID.hashCode ^
      offlineOrderID.hashCode ^
      source.hashCode;
  }
}
