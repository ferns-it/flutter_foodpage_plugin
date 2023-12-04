import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/order_online/constants/app_export.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late TextEditingController userTextController;
  late TextEditingController passwordTextController;
  late TextEditingController shopNameTextController;
  late TextEditingController tokenTextController;

  final _user = Rxn<LoginResponse>();
  LoginResponse? get user => _user.value;

  final _loading = false.obs;
  bool get loading => _loading.value;

  void onChangeUser(LoginResponse data) => _user(data);

  void onChangeLoading(bool status) => _loading(status);

  @override
  void onInit() {
    userTextController = TextEditingController();
    passwordTextController = TextEditingController();
    shopNameTextController = TextEditingController();
    tokenTextController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userTextController.dispose();
    passwordTextController.dispose();
    shopNameTextController.dispose();
    tokenTextController.dispose();
    super.dispose();
  }
}
