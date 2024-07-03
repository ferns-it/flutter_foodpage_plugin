// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/constants/enums.dart';



class AuthTokenData {
  final String id;
  final String shopName;
  final String shopUrl;
  final String name;
  final String email;
  final String mobile;
  final String tableReservation;
  final String shopCustomToken;
  final String timezone;
  final String token;
  final DevelopmentMode mode;

  AuthTokenData({
    required this.id,
    required this.shopName,
    required this.shopUrl,
    required this.name,
    required this.email,
    required this.mobile,
    required this.tableReservation,
    required this.shopCustomToken,
    required this.timezone,
    required this.token,
    this.mode = DevelopmentMode.development,
  });

  AuthTokenData copyWith({
    String? id,
    String? shopName,
    String? shopUrl,
    String? name,
    String? email,
    String? mobile,
    String? tableReservation,
    String? shopCustomToken,
    String? timezone,
    String? token,
    DevelopmentMode? mode,
  }) {
    return AuthTokenData(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      shopUrl: shopUrl ?? this.shopUrl,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      tableReservation: tableReservation ?? this.tableReservation,
      shopCustomToken: shopCustomToken ?? this.shopCustomToken,
      timezone: timezone ?? this.timezone,
      token: token ?? this.token,
      mode: mode ?? this.mode,
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
      'tableReservation': tableReservation,
      'shopCustomToken': shopCustomToken,
      'timezone': timezone,
      'token': token,
    };
  }

  factory AuthTokenData.fromMap(Map<String, dynamic> map) {
    return AuthTokenData(
      id: map['id'] as String,
      shopName: map['shopName'] as String,
      shopUrl: map['shopUrl'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      tableReservation: map['tableReservation'] as String,
      shopCustomToken: map['shopCustomToken'] as String,
      timezone: map['timezone'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTokenData.fromJson(String source) =>
      AuthTokenData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthTokenData(id: $id, shopName: $shopName, shopUrl: $shopUrl, name: $name, email: $email, mobile: $mobile, tableReservation: $tableReservation, shopCustomToken: $shopCustomToken, timezone: $timezone, token: $token, mode: $mode)';
  }

  @override
  bool operator ==(covariant AuthTokenData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.shopName == shopName &&
        other.shopUrl == shopUrl &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile &&
        other.tableReservation == tableReservation &&
        other.shopCustomToken == shopCustomToken &&
        other.timezone == timezone &&
        other.token == token &&
        other.mode == mode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shopName.hashCode ^
        shopUrl.hashCode ^
        name.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        tableReservation.hashCode ^
        shopCustomToken.hashCode ^
        timezone.hashCode ^
        token.hashCode ^
        mode.hashCode;
  }
}
