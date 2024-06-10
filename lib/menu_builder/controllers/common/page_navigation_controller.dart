import 'package:flutter/material.dart';

class PageNavigationController extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void onChangePageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}
