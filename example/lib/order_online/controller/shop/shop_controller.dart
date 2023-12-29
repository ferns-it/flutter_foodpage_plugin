import 'package:flutter_foodpage_plugin/flutter_foodpage_plugin.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  final _selectedIndex = (-1).obs;
  int get selectedIndex => _selectedIndex.value;

  final _selectedTag = false.obs;
  bool get selectedTag => _selectedTag.value;

  final _shopStatus = Rxn<ShopStatusData>();
  ShopStatusData? get shopStatus => _shopStatus.value;

  final _loading = false.obs;
  bool get loading => _loading.value;

  void onChangeSelectedTag() => _selectedTag(!_selectedTag.value);

  void onChangeSelectedIndex(int index) => _selectedIndex(index);

  void onChangeShopStatus(ShopStatusData data) => _shopStatus(data);

  void onChangeLoading(bool status) => _loading(status);
}
