import 'package:flutter_foodpage_plugin/menu_builder/core/constants/api_endpoints.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/auth/auth_token_data.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

import '../../models/common/menu_builder_config.dart';

class AuthService {
  static Future<AuthTokenData?> getAccessToken(MenuBuilderConfig config) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.getToken,
      dataKeyChecking: false,
      needAuth: false,
      mode: config.mode,
      data: {"secretkey": config.authenticationKey},
    );
    if (response == null) return null;
    return AuthTokenData.fromJson(response).copyWith(mode: config.mode);
  }
}
