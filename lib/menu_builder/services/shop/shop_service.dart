import 'dart:convert';

import 'package:flutter_foodpage_plugin/menu_builder/core/constants/api_endpoints.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/shop/shop_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/shop/shop_timing_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

class ShopService {
  static Future<ShopDetailsModel?> getShopDetails() async {
    final response = await BaseClient.get(
      api: ApiEndpoints.shopDetails,
      dataKeyChecking: false,
    );
    if (response == null) return null;
    return ShopDetailsModel.fromJson(response);
  }

  static Future<Map<String, List<ShopTimingModel>>?>
      getShopTimingDetails() async {
    final response = await BaseClient.get(
      api: ApiEndpoints.shopTiming,
      dataKeyChecking: false,
    );
    if (response == null) return null;
    final parsedResponse = jsonDecode(response) as Map<String, dynamic>;
    return parsedResponse.map((key, value) {
      if (value is List) {
        return MapEntry(
          key,
          value.map((e) => ShopTimingModel.fromMap(e)).toList(),
        );
      }
      return MapEntry(key, []);
    });
  }
}
