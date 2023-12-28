import 'package:example/order_online/constants/app_colors.dart';
import 'package:example/order_online/controller/shop/shop_controller.dart';
import 'package:example/order_online/utils/build_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:get/get.dart';

class ShopStatusPage extends GetView<ShopController> {
  const ShopStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(
        title: "Shop Status",
        widget: Obx(() => Visibility(
              visible: controller.loading,
              child: const LinearProgressIndicator(
                backgroundColor: AppColors.kWhite,
              ),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.kWhite),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            try {
                              controller.onChangeLoading(true);
                              controller.onChangeSelectedIndex(0);
                              final status =
                                  await FlutterFoodpagePlugin.changeShopStatus(
                                      status: "open");
                              if (status != null) {
                                controller.onChangeShopStatus(status);
                              }
                            } catch (e) {
                              Get.snackbar('Error', 'User not authenticated',
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 25.0),
                                  colorText: AppColors.primaryColor);
                              controller.onChangeSelectedIndex(-1);
                            } finally {
                              controller.onChangeLoading(false);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.selectedIndex == 0
                                    ? AppColors.secondaryColor
                                    : AppColors.kWhite,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                              child: Text(
                                "OPEN",
                                style: TextStyle(
                                    color: controller.selectedIndex == 0
                                        ? AppColors.primaryColor
                                        : AppColors.kBlack),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            try {
                              controller.onChangeLoading(true);
                              controller.onChangeSelectedIndex(1);
                              final status =
                                  await FlutterFoodpagePlugin.changeShopStatus(
                                      status: "close");
                              if (status != null) {
                                controller.onChangeShopStatus(status);
                              }
                            } catch (e) {
                              Get.snackbar('Error', 'User not authenticated',
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 25.0),
                                  colorText: AppColors.primaryColor);
                              controller.onChangeSelectedIndex(-1);
                            } finally {
                              controller.onChangeLoading(false);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: controller.selectedIndex == 1
                                    ? AppColors.secondaryColor
                                    : AppColors.kWhite,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                              child: Text(
                                "CLOSE",
                                style: TextStyle(
                                    color: controller.selectedIndex == 1
                                        ? AppColors.primaryColor
                                        : AppColors.kBlack),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            Obx(() => Text(controller.shopStatus?.messages ?? ""))
          ],
        ),
      ),
    );
  }
}
