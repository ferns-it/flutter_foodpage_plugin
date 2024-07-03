import 'package:flutter_foodpage_plugin/menu_builder/models/auth/auth_token_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  String get storageKey => 'auth_key';
  Future<bool> checkAuthKeyIsExist() async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey(storageKey);
  }

  Future<bool> saveAuthKeyData(AuthTokenData model) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString(storageKey, model.toJson());
  }

  Future<AuthTokenData?> readAuthKeyData() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString(storageKey);
    if (data == null) return null;
    return AuthTokenData.fromJson(data);
  }

  Future<bool> clearAuthKeyData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.clear();
  }
}
