import 'dart:convert';

import '../../constants/api_endpoints.dart';
import '../../model/order/dinein_order_data.dart';
import '../../model/order/online_order_data.dart';
import '../../model/order/view_order_data.dart';
import '../base_client.dart';

class OrderService {
  static Future<List<OnlineOrderData>> fetchOnlineOrders(
      {required String filter}) async {
    final response = await BaseClient.get(
      api: ApiEndpoints.onlineOrderList,
      params: filter,
      needAuth: true,
    );
    if (response == null) return <OnlineOrderData>[];
    final decodedJson = jsonDecode(response);
    final onlineOrders = decodedJson as List;
    final orderList = onlineOrders.map((item) {
      return OnlineOrderData.fromMap(item as Map<String, dynamic>);
    }).toList();
    return orderList;
  }
  
    static Future<List<DineinOrderData>> fetchDineinOrders(
      {required String filter}) async {
    final response = await BaseClient.get(
        api: ApiEndpoints.diningOrderList, params: filter, needAuth: true);

    if (response == null) return <DineinOrderData>[];
    final decodedJson = jsonDecode(response);
    final dineinOrders = decodedJson as List;
    final ordersList = dineinOrders.map((item) {
      return DineinOrderData.fromMap(item as Map<String, dynamic>);
    }).toList();
    return ordersList; 
  }

    static Future<ViewOrderData?> fetchOrderDetails(
      {required String orderID}) async {
    final response = await BaseClient.get(
        api: ApiEndpoints.orderDetails, params: orderID, needAuth: true);
    if (response == null) return null;
    return ViewOrderData.fromJson(response);
  }
}
