import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/category_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/dishes/dishes_category_service.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../constants/enums.dart';
import '../../models/common/api_response.dart';
import '../../services/app_exception/app_exception.dart';

class DishCategoryController extends ChangeNotifier with BaseController {
  APIResponse<DishCategoryCollectionModel> _dishCategoryCollection =
      APIResponse.initial();
  APIResponse<DishCategoryCollectionModel> get dishCollection =>
      _dishCategoryCollection;

  CategoryType _addCategoryType = CategoryType.parent;
  CategoryType get addCategoryType => _addCategoryType;

  void onChangeCategoryType(CategoryType? type) {
    if (type == null) return;
    _addCategoryType = type;
    notifyListeners();
  }

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  void onChangeSelectedCategory(String? selectedCategoryId) {
    if (selectedCategoryId == null) return;
    _selectedCategoryId = selectedCategoryId;
    notifyListeners();
  }

  String? _selectedParentCategoryId;
  String? get selectedParentCategoryId => _selectedParentCategoryId;

  void onChangeSelectedParentCategory(String? selectedParentCategoryId) {
    if (selectedParentCategoryId == null) return;
    _selectedParentCategoryId = selectedParentCategoryId;
    notifyListeners();
  }

  TreeViewController? _treeViewController;

  TreeViewController? get treeViewController => _treeViewController;

  void updateTreeViewController(TreeViewController controller) {
    _treeViewController = null;
    _treeViewController = controller;
    notifyListeners();
  }

  void resetSelectionInTreeView() {
    if (_treeViewController == null) return;
    _treeViewController = _treeViewController!.copyWith(selectedKey: null);
    notifyListeners();
  }

  @override
  Future<void> init() async {
    await fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      _dishCategoryCollection = APIResponse.loading();
      notifyListeners();

      final response = await DishesCategoryService.fetchCategoryList(id: '1');

      _dishCategoryCollection = response != null
          ? APIResponse.completed(response)
          : throwNotFoundException<DishCategoryCollectionModel>();

      inspect(_dishCategoryCollection);

      notifyListeners();
    } on AppExceptions catch (error) {
      _dishCategoryCollection =
          APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      _dishCategoryCollection =
          throwUnknownErrorException<DishCategoryCollectionModel>();
      notifyListeners();
    }
  }

  void addNewCategory(String name, String desc,
      {required VoidCallback onRequestRefresh}) async {
    try {
      if (name.isEmpty) return;
      if (_addCategoryType == CategoryType.child &&
          _selectedCategoryId == null) {
        //?? ADD TOAST
        return;
      }
      final parentId =
          _addCategoryType == CategoryType.parent ? "0" : _selectedCategoryId!;
      await DishesCategoryService.addNewCategory(
        name: name,
        description: desc,
        parentId: parentId,
      );
    } finally {
      onRequestRefresh();
    }
  }
}
