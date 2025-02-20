import 'package:flutter_foodpage_plugin/order_online/models/auth/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  String get storageKey => 'flutter_foodpage_order_online_auth_key_';
  Future<bool> checkAuthKeyIsExist() async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey(storageKey);
  }

  Future<bool> saveAuthKeyData(AuthModel model) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString(storageKey, model.toJson());
  }

  Future<AuthModel?> readAuthKeyData() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString(storageKey);
    if (data == null) return null;
    return AuthModel.fromJson(data);
  }

  Future<bool> clearAuthKeyData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.clear();
  }
}