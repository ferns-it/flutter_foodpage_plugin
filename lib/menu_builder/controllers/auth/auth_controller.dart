import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/menu_builder_config.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/auth/auth_service.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/shared_preference/auth_preference.dart';

import '../../models/auth/auth_token_data.dart';
import '../../models/common/api_response.dart';

class AuthController extends ChangeNotifier with BaseController {
  APIResponse<AuthTokenData> _authenticationDetails = APIResponse.initial();

  APIResponse<AuthTokenData> get authenticationDetails =>
      _authenticationDetails;

  MenuBuilderConfig? _builderConfig;

  MenuBuilderConfig? get builderConfig => _builderConfig;

  Future<void> loginMenuBuilder(MenuBuilderConfig config) async {
    try {
      _setAuthenticationLoading();
      await Future.delayed(const Duration(seconds: 2));

      final prefs = AuthPreference();
      final authResponse = await AuthService.getAccessToken(config);

      _builderConfig = config;

      authResponse.fold(
        (error) => _setAuthenticationError(error),
        (response) async {
          await prefs.saveAuthKeyData(response);
          _setAuthenticationSuccess(response);
        },
      );
    } catch (e) {
      _setUnknownError();
    }
  }

  void _setAuthenticationLoading() {
    _authenticationDetails = APIResponse.loading();
    notifyListeners();
  }

  void _setAuthenticationError(dynamic error) {
    _authenticationDetails = throwAppException(error);
    notifyListeners();
  }

  void _setAuthenticationSuccess(AuthTokenData response) {
    _authenticationDetails = APIResponse.completed(response);
    notifyListeners();
  }

  void _setUnknownError() {
    _authenticationDetails = throwUnknownErrorException<AuthTokenData>();
    notifyListeners();
  }
}
