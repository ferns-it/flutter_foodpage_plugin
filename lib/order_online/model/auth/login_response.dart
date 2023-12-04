// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponse {
  final String? id;
  final String? shopName;
  final String? shopUrl;
  final String? name;
  final String? email;
  final String? mobile;
  final String? token;
  final String? deviceId;
  LoginResponse({
    this.id,
    this.shopName,
    this.shopUrl,
    this.name,
    this.email,
    this.mobile,
    this.token,
    this.deviceId,
  });

  LoginResponse copyWith({
    String? id,
    String? shopName,
    String? shopUrl,
    String? name,
    String? email,
    String? mobile,
    String? token,
    String? deviceId,
  }) {
    return LoginResponse(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      shopUrl: shopUrl ?? this.shopUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      token: token ?? this.token,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'shopName': shopName,
      'shopUrl': shopUrl,
      'name': name,
      'email': email,
      'mobile': mobile,
      'token': token,
      'deviceId': deviceId,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      id: map['id'] != null ? map['id'] as String : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      shopUrl: map['shopUrl'] != null ? map['shopUrl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      deviceId: map['deviceId'] != null ? map['deviceId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponse.fromJson(String source) => LoginResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponse(id: $id, shopName: $shopName, shopUrl: $shopUrl, name: $name, email: $email, mobile: $mobile, token: $token, deviceId: $deviceId)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.shopName == shopName &&
      other.shopUrl == shopUrl &&
      other.name == name &&
      other.email == email &&
      other.mobile == mobile &&
      other.token == token &&
      other.deviceId == deviceId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      shopName.hashCode ^
      shopUrl.hashCode ^
      name.hashCode ^
      email.hashCode ^
      mobile.hashCode ^
      token.hashCode ^
      deviceId.hashCode;
  }
}
