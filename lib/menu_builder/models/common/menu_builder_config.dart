// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../core/constants/enums.dart';

class MenuBuilderConfig {
  final String authenticationKey;
  final DevelopmentMode mode;
  final String geminiAPIKey;

  MenuBuilderConfig({
    required this.authenticationKey,
    required this.geminiAPIKey,
    this.mode = DevelopmentMode.release,
  });

  MenuBuilderConfig copyWith({
    String? authenticationKey,
    DevelopmentMode? mode,
    String? geminiAPIKey,
  }) {
    return MenuBuilderConfig(
      authenticationKey: authenticationKey ?? this.authenticationKey,
      mode: mode ?? this.mode,
      geminiAPIKey: geminiAPIKey ?? this.geminiAPIKey,
    );
  }
}
