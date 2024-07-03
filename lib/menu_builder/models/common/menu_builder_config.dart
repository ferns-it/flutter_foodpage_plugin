// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/constants/enums.dart';

class MenuBuilderConfig {
  final String authenticationKey;
  final DevelopmentMode mode;
  MenuBuilderConfig({
    required this.authenticationKey,
    this.mode = DevelopmentMode.release,
  });

  MenuBuilderConfig copyWith({
    String? authenticationKey,
    DevelopmentMode? mode,
  }) {
    return MenuBuilderConfig(
      authenticationKey: authenticationKey ?? this.authenticationKey,
      mode: mode ?? this.mode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authenticatioKey': authenticationKey,
      'mode': mode.name,
    };
  }

  factory MenuBuilderConfig.fromMap(Map<String, dynamic> map) {
    return MenuBuilderConfig(
      authenticationKey: map['authenticatioKey'] as String,
      mode: DevelopmentMode.fromName(map['mode'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuBuilderConfig.fromJson(String source) =>
      MenuBuilderConfig.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthModel(authenticatioKey: $authenticationKey, mode: $mode)';

  @override
  bool operator ==(covariant MenuBuilderConfig other) {
    if (identical(this, other)) return true;

    return other.authenticationKey == authenticationKey && other.mode == mode;
  }

  @override
  int get hashCode => authenticationKey.hashCode ^ mode.hashCode;
}
