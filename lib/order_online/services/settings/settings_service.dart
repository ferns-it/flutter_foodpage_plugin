import '../../constants/api_endpoints.dart';
import '../../model/settings/save_shop_settings.dart';
import '../base_client.dart';

class SettingsService {
  static Future<SettingsData?> fetchShopSettings() async {
    final response =
        await BaseClient.get(api: ApiEndpoints.shopSettings, needAuth: true);
    if (response == null) return null;
    return SettingsData.fromJson(response);
  }

  static Future<SaveSettingsData?> saveShopSettings(
      {required SettingsData data}) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.saveShopSettings,
      data: data.toJson(),
      needAuth: true,
    );
    if (response == null) return null;
    return SaveSettingsData.fromJson(response);
  }
}
