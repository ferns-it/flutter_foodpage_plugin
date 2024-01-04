import 'package:example/order_online/constants/app_colors.dart';
import 'package:example/order_online/controller/order/order_controller.dart';
import 'package:example/order_online/utils/build_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:get/get.dart';

class OnlineOrderPage extends GetView<OrderController> {
  const OnlineOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(
        title: "Online Orders",
        widget: Obx(() => Visibility(
              visible: controller.loading,
              child: const LinearProgressIndicator(
                backgroundColor: AppColors.kWhite,
              ),
            )),
      ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(8.0)),
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Click on 'FETCH' to list all the \navailable online orders",
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        controller.onChangeLoading(true);
                        final onlineOrders =
                            await FlutterFoodpageOrderOnline.getOnlineOrder(
                                filter: "all");
                        controller.onlineOrders.value = onlineOrders;
                      } catch (e) {
                        Get.snackbar('Error', 'User not authenticated',
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 25.0),
                            colorText: AppColors.primaryColor);
                      } finally {
                        controller.onChangeLoading(false);
                      }
                    },
                    child: const Text("FETCH"))
              ],
            ),
          ),
        ),
        const Expanded(child: _OnlineOrderDetailsWidget())
      ]),
    );
  }
}

class _OnlineOrderDetailsWidget extends GetView<OrderController> {
  const _OnlineOrderDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.onlineOrders.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 100.0,
              width: double.infinity,
              child: Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                color: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColors.secondaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        "",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ) // green shaped
                            ),
                        child: const Text(
                          "ONLINE ORDER",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 0.0,
                        bottom: 0.0,
                        top: 0.0,
                        child: Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: const BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                controller.onlineOrders[index].orderID ?? "N/A",
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 23.0),
                              ),
                              const Text(
                                "ORDER NO",
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
