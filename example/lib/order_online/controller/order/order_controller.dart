
import 'package:flutter_foodpage_plugin/order_online/model/order/online_order_data.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final onlineOrders = <OnlineOrderData>[].obs;

  final _loading = false.obs;
  bool get loading => _loading.value;

  void onChangeLoading(bool status) => _loading(status);
  
}
