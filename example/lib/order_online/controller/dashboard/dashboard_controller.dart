import 'package:get/get.dart';

class DashboardController extends GetxController {
  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;

  void onSelectedIndexChange(int index) => _selectedIndex(index);
}
