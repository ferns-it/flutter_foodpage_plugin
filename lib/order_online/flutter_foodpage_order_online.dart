library flutter_foodpage_plugin;

import 'dart:developer';

import 'package:flutter_foodpage_plugin/order_online/constants/enums.dart';
import 'package:flutter_foodpage_plugin/order_online/models/auth/auth_model.dart';
import 'package:flutter_foodpage_plugin/order_online/services/sharedpreference/user_preference.dart';
import 'package:flutter_foodpage_plugin/order_online/storage/auth/auth_prefs.dart';

import '../flutter_foodpage_plugin.dart';
import 'models/order/online_order_data.dart';

class FlutterFoodpageOrderOnline {
  static final _authPrefs = AuthPrefs();
  FlutterFoodpageOrderOnline._internal();

  static Future<FlutterFoodpageOrderOnline> initialize(
      {required String authenticationKey, required DevMode mode}) async {
    final instance = FlutterFoodpageOrderOnline._internal();
    final authModel = AuthModel(
      authenticatioKey: authenticationKey,
      mode: mode,
    );
    await _authPrefs.saveAuthKeyData(authModel);

    final response = await _getAccessToken(authKey: authenticationKey);
    if (response != null) {
      await UserPreference.saveUserData(data: response);
      log(response.toJson());
    }

    return instance;
  }

  static Future<LoginResponse?> _getAccessToken({required String authKey}) async {
    return await AuthService.getAccessToken(authKey: authKey);
  }
  // static Future<LoginResponse?> userLogin({required LoginRequest data}) async {
  //   return await AuthService.loginUser(data: data);
  // }

  Future<List<OnlineOrderData>> getOnlineOrder({required OnlineOrderFilter filter}) async {
    return await OrderService.fetchOnlineOrders(filter: filter);
  }

  Future<List<DineinOrderData>> getDineinOrder({required DineinOrderFilter filter}) async {
    return await OrderService.fetchDineinOrders(filter: filter);
  }

  // static Future<ViewOrderData?> getOrderDetails(
  //     {required String orderID}) async {
  //   return await OrderService.fetchOrderDetails(orderID: orderID);
  // }

  Future<OrderStatusUpdateData?> acceptOrder(
      {required OrderStatusAcceptRequest acceptMessage, required String orderID}) async {
    return await OrderStatusService.sendAcceptOrderStatus(orderID: orderID, data: acceptMessage);
  }

   Future<OrderStatusUpdateData?> dispatchOrder(
      {required OrderStatusDispatchRequest dispatchMessage,
      required String orderID}) async {
    return await OrderStatusService.sendDispatchOrderStatus(
        orderID: orderID, data: dispatchMessage);
  }

   Future<OrderStatusUpdateData?> rejectOrder(
      {required OrderStatusRejectRequest rejectMessage,
      required String orderID}) async {
    return await OrderStatusService.sendRejectOrderStatus(
        orderID: orderID, data: rejectMessage);
  }

  // static Future<List<DishData>> fetchAllDishes() async {
  //   return await DishesService.fetchAllDishes();
  // }

  // static Future<SettingsData?> fetchShopSettings() async {
  //   return await SettingsService.fetchShopSettings();
  // }

  // static Future<ShopProfileData?> fetchShopProfileDetails() async {
  //   return await ShopProfileService.fetchShopProfileData();
  // }

  // static Future<TimeData?> fetchTimeDetails() async {
  //   return await TimeService.fetchTimeData();
  // }

  // static Future<ShopStatusData?> changeShopStatus(
  //     {required String status}) async {
  //   return await ShopStatusService.fetchShopOpenStatus(argument: status);
  // }
}
