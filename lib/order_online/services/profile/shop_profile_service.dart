import '../../constants/api_endpoints.dart';
import '../../model/profile/shop_profile_data.dart';
import '../base_client.dart';

class ShopProfileService {
    static Future<ShopProfileData?> fetchShopProfileData() async {
    final response = await BaseClient.get(
        api: ApiEndpoints.shopProfileDetails, needAuth: true);
    if (response == null) return null;
    return ShopProfileData.fromJson(response);
  }
}