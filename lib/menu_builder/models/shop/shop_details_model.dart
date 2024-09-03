import 'dart:convert';

class ShopDetailsModel {
  final String shopName;
  final String contactName;
  final String email;
  final String mobile;
  final String phone;
  final String address1;
  final String address2;
  final String town;
  final String country;
  final String postcode;
  final String vatID;
  final String shopStatus;
  final String onlinedispatchMessage;
  final String takeawaydispatchMessage;
  ShopDetailsModel({
    required this.shopName,
    required this.contactName,
    required this.email,
    required this.mobile,
    required this.phone,
    required this.address1,
    required this.address2,
    required this.town,
    required this.country,
    required this.postcode,
    required this.vatID,
    required this.shopStatus,
    required this.onlinedispatchMessage,
    required this.takeawaydispatchMessage,
  });

  ShopDetailsModel copyWith({
    String? shopName,
    String? contactName,
    String? email,
    String? mobile,
    String? phone,
    String? address1,
    String? address2,
    String? town,
    String? country,
    String? postcode,
    String? vatID,
    String? shopStatus,
    String? onlinedispatchMessage,
    String? takeawaydispatchMessage,
  }) {
    return ShopDetailsModel(
      shopName: shopName ?? this.shopName,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      phone: phone ?? this.phone,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      town: town ?? this.town,
      country: country ?? this.country,
      postcode: postcode ?? this.postcode,
      vatID: vatID ?? this.vatID,
      shopStatus: shopStatus ?? this.shopStatus,
      onlinedispatchMessage: onlinedispatchMessage ?? this.onlinedispatchMessage,
      takeawaydispatchMessage: takeawaydispatchMessage ?? this.takeawaydispatchMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shopName': shopName,
      'contactName': contactName,
      'email': email,
      'mobile': mobile,
      'phone': phone,
      'address1': address1,
      'address2': address2,
      'town': town,
      'country': country,
      'postcode': postcode,
      'vatID': vatID,
      'shopStatus': shopStatus,
      'onlinedispatchMessage': onlinedispatchMessage,
      'takeawaydispatchMessage': takeawaydispatchMessage,
    };
  }

  factory ShopDetailsModel.fromMap(Map<String, dynamic> map) {
    return ShopDetailsModel(
      shopName: map['shopName'] as String,
      contactName: map['contactName'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      phone: map['phone'] as String,
      address1: map['address1'] as String,
      address2: map['address2'] as String,
      town: map['town'] as String,
      country: map['country'] as String,
      postcode: map['postcode'] as String,
      vatID: map['vatID'] as String,
      shopStatus: map['shopStatus'] as String,
      onlinedispatchMessage: map['onlinedispatchMessage'] as String,
      takeawaydispatchMessage: map['takeawaydispatchMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopDetailsModel.fromJson(String source) => ShopDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopDetailsModel(shopName: $shopName, contactName: $contactName, email: $email, mobile: $mobile, phone: $phone, address1: $address1, address2: $address2, town: $town, country: $country, postcode: $postcode, vatID: $vatID, shopStatus: $shopStatus, onlinedispatchMessage: $onlinedispatchMessage, takeawaydispatchMessage: $takeawaydispatchMessage)';
  }

  @override
  bool operator ==(covariant ShopDetailsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.shopName == shopName &&
      other.contactName == contactName &&
      other.email == email &&
      other.mobile == mobile &&
      other.phone == phone &&
      other.address1 == address1 &&
      other.address2 == address2 &&
      other.town == town &&
      other.country == country &&
      other.postcode == postcode &&
      other.vatID == vatID &&
      other.shopStatus == shopStatus &&
      other.onlinedispatchMessage == onlinedispatchMessage &&
      other.takeawaydispatchMessage == takeawaydispatchMessage;
  }

  @override
  int get hashCode {
    return shopName.hashCode ^
      contactName.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      phone.hashCode ^
      address1.hashCode ^
      address2.hashCode ^
      town.hashCode ^
      country.hashCode ^
      postcode.hashCode ^
      vatID.hashCode ^
      shopStatus.hashCode ^
      onlinedispatchMessage.hashCode ^
      takeawaydispatchMessage.hashCode;
  }
}