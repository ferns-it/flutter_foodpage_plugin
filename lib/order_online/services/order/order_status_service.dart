import 'package:flutter_foodpage_plugin/order_online/model/order/order_status/request/order_status_dispatch_request.dart';
import 'package:flutter_foodpage_plugin/order_online/model/order/order_status/request/order_status_reject_request.dart';

import '../../constants/api_endpoints.dart';
import '../../model/order/order_status/request/order_status_Accept_request.dart';
import '../../model/order/order_status/response/order_status_update_data.dart';
import '../base_client.dart';

class OrderStatusService {
  static Future<OrderStatusUpdateData?> sendAcceptOrderStatus(
      {required String orderID, required OrderStatusAcceptRequest data}) async {
    final response = await BaseClient.put(
        api: ApiEndpoints.acceptOrder,
        params: orderID,
        needAuthentication: true,
        data: data.toJson());
    if (response == null) return null;
    return OrderStatusUpdateData.fromJson(response);
  }

  static Future<OrderStatusUpdateData?> sendRejectOrderStatus(
      {required String orderID, required OrderStatusRejectRequest data}) async {
    final response = await BaseClient.put(
        api: ApiEndpoints.rejectOrder,
        params: orderID,
        needAuthentication: true,
        data: data.toJson());

    if (response == null) return null;
    return OrderStatusUpdateData.fromJson(response);
  }

  static Future<OrderStatusUpdateData?> sendDispatchOrderStatus(
      {required String orderID,
      required OrderStatusDispatchRequest data}) async {
    final response = await BaseClient.put(
        api: ApiEndpoints.dispatchOrder,
        params: orderID,
        needAuthentication: true,
        data: data.toJson());
    if (response == null) return null;
    return OrderStatusUpdateData.fromJson(response);
  }
}
