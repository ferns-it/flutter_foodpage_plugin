import 'package:example/order_online/view/order/online_order_page.dart';
import 'package:example/order_online/view/shop/shop_status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controller/dashboard/dashboard_controller.dart';
import '../../utils/build_appbar.dart';
import '../login/login_page.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardItems = [
      "login",
      "online orders",
      "shop status",
    ];
    final labelItems = [
      "post",
      "get",
      "put"
    ];

    return Scaffold(
      appBar: buildAppbar(title: "Dashboard", widget: const SizedBox.shrink()),
      body: ListView.builder(
        itemCount: dashboardItems.length,
        itemBuilder: (context, index) {
          return _DashboardCard(
            itemName: dashboardItems[index],
            itemIndex: index,
            label: labelItems[index],

          );
        },
      ),
    );
  }
}

class _DashboardCard extends GetView<DashboardController> {
  const _DashboardCard(
     {
    super.key,
    required this.itemName,
    required this.itemIndex,
    required this.label,
  });
  final String itemName, label;
  final int itemIndex;
  @override
  Widget build(BuildContext context) {
    final navigationList = [const LoginPage(), const OnlineOrderPage(), const ShopStatusPage()];

    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          controller.onSelectedIndexChange(itemIndex);
          if (controller.selectedIndex == itemIndex) {
            Get.to(() => navigationList[itemIndex]);
          }
        },
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  itemName.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                  decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ) // green shaped
                      ),
                  child: Text(
                    label.toUpperCase(),
                    style: const TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  
  }
}
