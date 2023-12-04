//EXAMPLE FOR POST METHOD

import 'package:example/order_online/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:flutter_foodpage_plugin/order_online/constants/app_export.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../custom/custom_widgets.dart';
import '../../utils/build_appbar.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(
        title: "Login",
        widget: Obx(() => Visibility(
              visible: controller.loading,
              child: const LinearProgressIndicator(
                backgroundColor: AppColors.kWhite,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                hintText: "Username",
                textEditingController: controller.userTextController,
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Password",
                textEditingController: controller.passwordTextController,
              ),
              const SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  final username = controller.userTextController.text;
                  final password = controller.passwordTextController.text;
                  final data = LoginRequest(
                      username: username,
                      password: password,
                      deviceId: "deviceId");
                  if (username.isEmpty && password.isEmpty ||
                      username.isEmpty ||
                      password.isEmpty) {
                    Get.snackbar(
                        'Required', 'Username or password should not be empty',
                        snackPosition: SnackPosition.BOTTOM,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25.0),
                        colorText: AppColors.primaryColor);
                  } else {
                    try {
                      controller.onChangeLoading(true);
                      final user =
                          await FlutterFoodpagePlugin.userLogin(data: data);
                      if (user != null) {
                        controller.onChangeUser(user);
                      }
                    } catch (e) {
                      Get.snackbar('Invalid Credentials',
                          'Incorrect username or password',
                          snackPosition: SnackPosition.BOTTOM,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 25.0),
                          colorText: AppColors.primaryColor);
                    } finally {
                      controller.onChangeLoading(false);
                    }
                  }
                },
                child: const Text("LOGIN"),
              ),
              const SizedBox(height: 50.0),

              Obx(() => Visibility(visible: controller.user != null,child: const _ShopDetailsCard()))

              
            ],
          ),
        ),
      ),
    );
  }
}

class _ShopDetailsCard extends GetView<AuthController> {
  const _ShopDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: Card(
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: const BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ) // green shaped
                    ),
                child: Text(
                  controller.user?.shopName?.toUpperCase() ?? "N/A",
                  style: const TextStyle(
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
                  width: 70.0,
                  decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        controller.user?.id ?? "N/A",
                        style: const TextStyle(
                            color: AppColors.primaryColor, fontSize: 35.0),
                      ),
                      const Text(
                        "Shop ID",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
