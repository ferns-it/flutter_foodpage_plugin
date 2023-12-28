import 'package:flutter_foodpage_plugin/order_online/constants/api_endpoints.dart';
import 'package:flutter_foodpage_plugin/order_online/models/auth/login_request.dart';
import 'package:flutter_foodpage_plugin/order_online/models/auth/login_response.dart';
import 'package:flutter_foodpage_plugin/order_online/services/base_client.dart';
import 'package:flutter_foodpage_plugin/order_online/services/sharedpreference/user_preference.dart';

class AuthService {
  static Future<LoginResponse?> loginUser({required LoginRequest data}) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.loginUser,
      data: data.toJson(),
    );
    if (response == null) return null;
    final userData = LoginResponse.fromJson(response);
    UserPreference.saveUserData(data: userData);
    return LoginResponse.fromJson(response);
  }
}
