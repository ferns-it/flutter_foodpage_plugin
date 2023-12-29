import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  String get storageKey => 'auth_key';
  Future<bool> checkAuthKeyIsExist() async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey(storageKey);
  }

  Future<bool> saveAuthKeyData(String authKey) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString(storageKey, authKey);
  }

  Future<String?> readAuthKeyData() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString(storageKey);
    if (data == null) return null;
    return data;
  }

  Future<bool> clearAuthKeyData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.clear();
  }
}
