
import '../../../../order_online/models/auth/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static String get storageKey => 'user';

  static Future<bool> checkUserIsExist() async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey(storageKey);
  }

  static Future<bool> saveUserData({required LoginResponse data}) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString(storageKey, data.toJson());
  }

  static Future<LoginResponse?> readUserData() async {
    final instance = await SharedPreferences.getInstance();
    final data = instance.getString(storageKey);
    if (data == null) return null;
    return LoginResponse.fromJson(data);
  }

  static Future<bool> clearUserData() async {
    final instance = await SharedPreferences.getInstance();
    return instance.clear();
  }
}
