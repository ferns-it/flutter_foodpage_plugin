import 'package:shared_preferences/shared_preferences.dart';

import '../../../table_reservation/models/auth/auth_model.dart';

class AuthPreference {
  String get storageKey => 'auth_key';
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
