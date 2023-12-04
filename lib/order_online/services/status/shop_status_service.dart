import '../../constants/api_endpoints.dart';
import '../../model/status/shop_status_data.dart';
import '../base_client.dart';

class ShopStatusService {
  static Future<ShopStatusData?> fetchShopOpenStatus(
      {required String argument}) async {
    final response = await BaseClient.put(
        api: ApiEndpoints.shopStatus,
        needAuthentication: true,
        params: argument,
        queryParameters: {'statusType': argument});
    if (response == null) return null;
    return ShopStatusData.fromJson(response);
  }
}