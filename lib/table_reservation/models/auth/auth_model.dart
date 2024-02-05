// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';

class AuthModel {
  final String authenticatioKey;
  final DevelopmentMode mode;
  AuthModel({
    required this.authenticatioKey,
    this.mode = DevelopmentMode.release,
  });

  AuthModel copyWith({
    String? authenticatioKey,
    DevelopmentMode? mode,
  }) {
    return AuthModel(
      authenticatioKey: authenticatioKey ?? this.authenticatioKey,
      mode: mode ?? this.mode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authenticatioKey': authenticatioKey,
      'mode': mode.name,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      authenticatioKey: map['authenticatioKey'] as String,
      mode: DevelopmentMode.fromName(map['mode'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthModel(authenticatioKey: $authenticatioKey, mode: $mode)';

  @override
  bool operator ==(covariant AuthModel other) {
    if (identical(this, other)) return true;

    return other.authenticatioKey == authenticatioKey && other.mode == mode;
  }

  @override
  int get hashCode => authenticatioKey.hashCode ^ mode.hashCode;
}
