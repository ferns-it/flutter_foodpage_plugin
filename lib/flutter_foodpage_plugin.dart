library flutter_foodpage_plugin;

import 'package:flutter_foodpage_plugin/order_online/model/order/online_order_data.dart';

import 'order_online/constants/app_export.dart';

class FlutterFoodpagePlugin {
  static Future<LoginResponse?> userLogin({required LoginRequest data}) async {
    return await AuthService.loginUser(data: data);
  }

  static Future<List<OnlineOrderData>> getOnlineOrder(
      {required String filter}) async {
    return await OrderService.fetchOnlineOrders(filter: filter);
  }

  static Future<List<DineinOrderData>> getDineinOrder(
      {required String filter}) async {
    return await OrderService.fetchDineinOrders(filter: filter);
  }

  static Future<ViewOrderData?> getOrderDetails(
      {required String orderID}) async {
    return await OrderService.fetchOrderDetails(orderID: orderID);
  }

  static Future<OrderStatusUpdateData?> acceptOrder(
      {required OrderStatusAcceptRequest acceptMessage,
      required String orderID}) async {
    return await OrderStatusService.sendAcceptOrderStatus(
        orderID: orderID, data: acceptMessage);
  }

  static Future<OrderStatusUpdateData?> dispatchOrder(
      {required OrderStatusDispatchRequest dispatchMessage,
      required String orderID}) async {
    return await OrderStatusService.sendDispatchOrderStatus(
        orderID: orderID, data: dispatchMessage);
  }

  static Future<OrderStatusUpdateData?> rejectOrder(
      {required OrderStatusRejectRequest rejectMessage,
      required String orderID}) async {
    return await OrderStatusService.sendRejectOrderStatus(
        orderID: orderID, data: rejectMessage);
  }

  static Future<List<DishData>> fetchAllDishes() async {
    return await DishesService.fetchAllDishes();
  }

  static Future<SettingsData?> fetchShopSettings() async {
    return await SettingsService.fetchShopSettings();
  }

  static Future<ShopProfileData?> fetchShopProfileDetails() async {
    return await ShopProfileService.fetchShopProfileData();
  }

  static Future<TimeData?> fetchTimeDetails() async {
    return await TimeService.fetchTimeData();
  }

  static Future<ShopStatusData?> changeShopStatus(
      {required String status}) async {
    return await ShopStatusService.fetchShopOpenStatus(argument: status);
  }
}

