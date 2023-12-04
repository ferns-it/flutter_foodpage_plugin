import 'package:example/order_online/controller/auth/auth_controller.dart';
import 'package:example/order_online/controller/order/order_controller.dart';
import 'package:example/order_online/controller/shop/shop_controller.dart';
import 'package:get/get.dart';

import '../controller/dashboard/dashboard_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => OrderController(),fenix: true);
    Get.lazyPut(() => ShopController(),fenix: true);

  }
}
