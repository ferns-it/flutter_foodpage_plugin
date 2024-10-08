import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/controllers/common/base_controller.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/category_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/dishes/dishes_category_service.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../core/constants/enums.dart';
import '../../models/common/api_response.dart';
import '../../models/dishes/add_dish_initialise_data_model.dart';
import '../../services/app_exception/app_exception.dart';

class DishCategoryController extends ChangeNotifier with BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  APIResponse<DishCategoryCollectionModel> _dishCategoryCollection =
      APIResponse.initial();
  APIResponse<DishCategoryCollectionModel> get categoriesCollection =>
      _dishCategoryCollection;

  int get totalCategories => categoriesCollection.data?.totalCategories ?? 0;

  CategoryType _addCategoryType = CategoryType.parent;
  CategoryType get addCategoryType => _addCategoryType;

  void onChangeCategoryType(CategoryType? type) {
    if (type == null) return;
    _addCategoryType = type;
    notifyListeners();
  }

  CategoryData? _selectedCategory;
  CategoryData? get selectedCategory => _selectedCategory;

  bool get editMode => _selectedCategory != null;

  String? _selectedCategoryId;
  String? get selectedCategoryId => _selectedCategoryId;

  void onChangeSelectedCategoryId(String? selectedCategoryId) {
    try {
      if (selectedCategoryId == null) return;
      _selectedCategoryId = selectedCategoryId;
    } finally {
      notifyListeners();
    }
  }

  void onPressCategory(CategoryData? selectedCategory) {
    try {
      if (selectedCategory?.name == null) return;
      _selectedCategory = selectedCategory;
      nameController.text = selectedCategory!.name!;
      descriptionController.text = selectedCategory.description!;
    } finally {
      notifyListeners();
    }
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
    nameController = TextEditingController();
    descriptionController = TextEditingController();
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

  void addNewCategory({required VoidCallback onRequestRefresh}) async {
    if (formKey.currentState?.validate() == false) return;
    if (_addCategoryType == CategoryType.child && _selectedCategoryId == null) {
      //?? ADD TOAST
      return;
    }
    final parentId =
        _addCategoryType == CategoryType.parent ? "0" : _selectedCategoryId!;
    await DishesCategoryService.addNewCategory(
      name: nameController.text,
      description: descriptionController.text,
      parentId: parentId,
    );

    onRequestRefresh();

    formKey.currentState?.reset();
    nameController.clear();
    descriptionController.clear();
  }

  void updateCategory({required VoidCallback onRequestRefresh}) async {
    try {
      if (formKey.currentState?.validate() == false) return;
      if (selectedCategory?.cID == null) {
        //?? ADD TOAST
        return;
      }

      await DishesCategoryService.updateCategory(
        name: nameController.text,
        description: descriptionController.text,
        cID: selectedCategory!.cID!,
      );

      onRequestRefresh();

      formKey.currentState?.reset();
      nameController.clear();
      descriptionController.clear();
      _selectedCategory = null;
    } finally {
      notifyListeners();
    }
  }

  void disableEnableCategory({required VoidCallback onRequestRefresh}) async {
    try {
      if (selectedCategory?.cID == null) {
        //?? ADD TOAST
        return;
      }
      await DishesCategoryService.disableEnableCategory(
        selectedCategory!.cID!,
        selectedCategory?.categoryStatus == "Active" ? "Inactive" : "Active",
      );

      onRequestRefresh();
      formKey.currentState?.reset();
      nameController.clear();
      descriptionController.clear();
      _selectedCategory = null;
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
