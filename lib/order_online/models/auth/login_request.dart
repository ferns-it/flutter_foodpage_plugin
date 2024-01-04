// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequest {
  final String? username;
  final String? password;
  final String? deviceId;
  LoginRequest({
    this.username,
    this.password,
    this.deviceId,
  });

  LoginRequest copyWith({
    String? username,
    String? password,
    String? deviceId,
  }) {
    return LoginRequest(
      username: username ?? this.username,
      password: password ?? this.password,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'deviceId': deviceId,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      deviceId: map['deviceId'] != null ? map['deviceId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) => LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginRequest(username: $username, password: $password, deviceId: $deviceId)';

  @override
  bool operator ==(covariant LoginRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.password == password &&
      other.deviceId == deviceId;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode ^ deviceId.hashCode;
}
