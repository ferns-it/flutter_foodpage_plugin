import 'package:flutter/material.dart';

import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/menu_builder_config.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/auth/auth_service.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/shared_preference/auth_preference.dart';

import '../../models/auth/auth_token_data.dart';
import '../../models/common/api_response.dart';
import '../../services/app_exception/app_exception.dart';

class AuthController extends ChangeNotifier with BaseController {
  APIResponse<AuthTokenData> _authenticationDetails = APIResponse.initial();

  APIResponse<AuthTokenData> get authenticationDetails =>
      _authenticationDetails;

  MenuBuilderConfig? _builderConfig;

  MenuBuilderConfig? get builderConfig => _builderConfig;

  Future<void> loginMenuBuilder(MenuBuilderConfig config) async {
    try {
      _authenticationDetails = APIResponse.loading();
      notifyListeners();
      await Future.delayed(const Duration(seconds: 2));
      final prefs = AuthPreference();
      final authResponse = await AuthService.getAccessToken(config);

      if (authResponse != null) {
        await prefs.saveAuthKeyData(authResponse);
      }

      _authenticationDetails = authResponse != null
          ? APIResponse.completed(authResponse)
          : throwNotFoundException<AuthTokenData>();

      _builderConfig = config;

      notifyListeners();
    } on AppExceptions catch (error) {
      _authenticationDetails =
          APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      _authenticationDetails = throwUnknownErrorException<AuthTokenData>();
      notifyListeners();
    }
  }
}
