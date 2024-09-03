import 'package:flutter/foundation.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/shop/shop_service.dart';

import '../../core/utils/helper_utils.dart';
import '../../models/shop/shop_timing_model.dart';

class ShopController extends ChangeNotifier with BaseController {
  Map<String, List<ShopTimingModel>>? _shopTimingDetails;

  Map<String, List<ShopTimingModel>>? get shopTimingDetails =>
      _shopTimingDetails;

  List<String> get shopAvailableDays => shopTimingDetails?.keys.toList() ?? [];

  String get shopAvailableDaysStartEnd =>
      "${convertFirstCharacterToUpperCase(shopAvailableDays.first)} to ${convertFirstCharacterToUpperCase(shopAvailableDays.last)}";

  @override
  Future<void> init() {
    getShopTimingDetails();
    return super.init();
  }

  Future<void> getShopTimingDetails() async {
    final shopTimingDetails = await ShopService.getShopTimingDetails();
    _shopTimingDetails = shopTimingDetails;
  }
}