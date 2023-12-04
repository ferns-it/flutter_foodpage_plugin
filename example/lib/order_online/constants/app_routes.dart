
import 'package:example/order_online/constants/route_names.dart';
import 'package:example/order_online/view/login/login_page.dart';
import 'package:example/order_online/view/order/online_order_page.dart';
import 'package:example/order_online/view/shop/shop_status_page.dart';
import 'package:get/get.dart';

import '../bindings/app_binding.dart';
import '../view/dashboard/dashboardPage.dart';

List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
  GetPage(
    name: RouteNames.kDashBoard,
    page: () => const DashboardPage(),
    binding: AppBinding(),
  ),
  GetPage(
    name: RouteNames.kLogin,
    page: () => const LoginPage(),
    binding: AppBinding(),
  ),
  GetPage(
    name: RouteNames.kOnlineOrders,
    page: () => const OnlineOrderPage(),
    binding: AppBinding(),
  ),
  GetPage(
    name: RouteNames.kShopStatus,
    page: () => const ShopStatusPage(),
    binding: AppBinding(),
  ),
];
