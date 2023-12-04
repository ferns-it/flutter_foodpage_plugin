// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShopProfileData {
  final String? shopName;
  final String? contactName;
  final String? email;
  final String? mobile;
  final String? phone;
  final String? address1;
  final String? address2;
  final String? town;
  final String? country;
  final String? postcode;
  final String? shopStatus;
  ShopProfileData({
    this.shopName,
    this.contactName,
    this.email,
    this.mobile,
    this.phone,
    this.address1,
    this.address2,
    this.town,
    this.country,
    this.postcode,
    this.shopStatus,
  });

  ShopProfileData copyWith({
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
    String? shopStatus,
  }) {
    return ShopProfileData(
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
      shopStatus: shopStatus ?? this.shopStatus,
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
      'shopStatus': shopStatus,
    };
  }

  factory ShopProfileData.fromMap(Map<String, dynamic> map) {
    return ShopProfileData(
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      contactName: map['contactName'] != null ? map['contactName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address1: map['address1'] != null ? map['address1'] as String : null,
      address2: map['address2'] != null ? map['address2'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      shopStatus: map['shopStatus'] != null ? map['shopStatus'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopProfileData.fromJson(String source) => ShopProfileData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShopProfileData(shopName: $shopName, contactName: $contactName, email: $email, mobile: $mobile, phone: $phone, address1: $address1, address2: $address2, town: $town, country: $country, postcode: $postcode, shopStatus: $shopStatus)';
  }

  @override
  bool operator ==(covariant ShopProfileData other) {
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
      other.shopStatus == shopStatus;
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
      shopStatus.hashCode;
  }
}
