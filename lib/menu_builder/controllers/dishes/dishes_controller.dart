import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_initialise_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_request_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/dishes/dishes_service.dart';

import '../../models/dishes/dish_collection_model.dart';
import '../../services/app_exception/app_exception.dart';
import '../common/base_controller.dart';

class DishesController extends ChangeNotifier with BaseController {
  APIResponse<DishCollectionModel> _dishCollection = APIResponse.initial();
  APIResponse<DishCollectionModel> get dishCollection => _dishCollection;

  APIResponse<DishViewDetailsModel> _viewDishDetails = APIResponse.initial();
  APIResponse<DishViewDetailsModel> get viewDishDetails => _viewDishDetails;

  AddDishInitializeDataModel? _addDishInitializeData;
  AddDishInitializeDataModel? get addDishInitializeData =>
      _addDishInitializeData;

  List<String> get listOfAvailabilityDays =>
      _addDishInitializeData?.availability.data?.availability?.options ?? [];
  List<MasterAddonsInitialiseSubData> get listOfMasterAddons =>
      _addDishInitializeData?.masterAddons.data ?? [];
  List<CategoryInitialiseSubData> get listOfCategories =>
      _addDishInitializeData?.category.data ?? [];
  Map<String, dynamic> get listOfMenus =>
      _addDishInitializeData?.productMenu.data ?? <String, dynamic>{};
  List<AllergensInitialiseSubData> get listOfAllergens =>
      _addDishInitializeData?.allergens.data ?? [];

  int _selectedDishIndex = -1;
  int get selectedDishIndex => _selectedDishIndex;

  DishDetails? get selectedDish => _selectedDishIndex != -1
      ? _dishCollection.data!.dishes.elementAt(_selectedDishIndex)
      : null;

  String? _dishType;
  String get dishType => _dishType ?? "";

  void onChangeDishType(String dishType) {
    _dishType = dishType;
    notifyListeners();
  }

  bool _onlineStatus = false;
  bool _dineInStatus = false;
  bool get onlineStatus => _onlineStatus;
  bool get dineInStatus => _dineInStatus;

  void onChangeOnlineStatus(bool status) {
    _onlineStatus = status;
    notifyListeners();
  }

  void onChangeDineInStatus(bool status) {
    _dineInStatus = status;
    notifyListeners();
  }

  final GlobalKey<FormState> variationFormKey = GlobalKey<FormState>();

  Map<String, dynamic> get variationFormEntry => {
        "name": TextEditingController(),
        "price": TextEditingController(),
        "ingredients": TextEditingController(),
        "allergens": <AllergensInitialiseSubData>[]
      };

  List<Map<String, dynamic>> variationsFormEntries = [
    {
      "name": TextEditingController(),
      "price": TextEditingController(),
      "ingredients": TextEditingController(),
      "allergens": <AllergensInitialiseSubData>[]
    }
  ];

  bool get variationsFormEntriesEmpty {
    if (variationsFormEntries.length != 1) {
      return false;
    }
    final entry = variationsFormEntries.first;
    final nameController = entry["name"] as TextEditingController;
    final price = entry["price"] as TextEditingController;
    final ingredients = entry["allergens"] as List;
    if (nameController.text.isEmpty &&
        price.text.isEmpty &&
        ingredients.isEmpty) {
      return true;
    }
    return false;
  }

  bool checkVariationEntryIsEmpty(int index) {
    final entry = variationsFormEntries[index];
    final nameController = entry["name"] as TextEditingController;
    final price = entry["price"] as TextEditingController;
    final ingredients = entry["allergens"] as List;
    if (nameController.text.isEmpty &&
        price.text.isEmpty &&
        ingredients.isEmpty) {
      return true;
    }
    return false;
  }

  void onChangeAllergensSelection(
    int index,
    AllergensInitialiseSubData allergen,
  ) {
    if (variationsFormEntries[index]["allergens"].contains(allergen)) {
      variationsFormEntries[index]["allergens"].remove(allergen);
      notifyListeners();
      return;
    }
    variationsFormEntries[index]["allergens"].add(allergen);
    notifyListeners();
  }

  void addNewVariationFormEntry() {
    variationsFormEntries.add(variationFormEntry);
    notifyListeners();
  }

  void removeVariationFormEntry(int index) {
    variationsFormEntries.removeAt(index);
    notifyListeners();
  }

  void duplicateVariationFormEntry(int index) {
    final entry = variationsFormEntries[index];
    variationsFormEntries.add({
      "name": TextEditingController()..text = entry["name"].text,
      "price": TextEditingController()..text = entry["price"].text,
      "ingredients": TextEditingController()..text = entry["ingredients"].text,
      "allergens": List.from(entry["allergens"]),
    });
    notifyListeners();
  }

  List<MasterAddonsInitialiseSubData> choosedMasterAddons = [];

  void onChooseMasterAddons(MasterAddonsInitialiseSubData addon) {
    try {
      if (choosedMasterAddons.contains(addon)) {
        choosedMasterAddons.remove(addon);
        return;
      }
      choosedMasterAddons.add(addon);
    } finally {
      notifyListeners();
    }
  }

  AddDishSideSheetType _activeSideSheetType = AddDishSideSheetType.variation;
  AddDishSideSheetType get activeSideSheetType => _activeSideSheetType;

  void onChangeSideSheetType(AddDishSideSheetType type) {
    _activeSideSheetType = type;
    notifyListeners();
  }

  List<CategoryInitialiseSubData> selectedDishCategories = [];

  void whenSelectParentCategory(CategoryInitialiseSubData parentCategory) {
    try {
      final contains = selectedDishCategories.any((category) {
        return category.cID == parentCategory.cID;
      });
      if (!contains) {
        selectedDishCategories.add(
          parentCategory.copyWith(childrens: [...parentCategory.childrens]),
        );
        return;
      }
      selectedDishCategories.removeWhere((category) {
        return category.cID != null && category.cID == parentCategory.cID;
      });
    } finally {
      notifyListeners();
    }
  }

  void whenSelectSubCategory(
    String? parentCId,
    CategoryInitialiseSubChildrensData child,
  ) {
    try {
      final parentCategory = selectedDishCategories
          .firstWhereOrNull((e) => parentCId != null && e.cID == parentCId);
      if (parentCategory != null) {
        if (parentCategory.childrens.contains(child)) {
          parentCategory.childrens.remove(child);
        } else {
          parentCategory.childrens.add(child);
        }
      }
    } finally {
      notifyListeners();
    }
  }

  bool checkParentIsSelected(CategoryInitialiseSubData parentCategory) {
    if (selectedDishCategories.isEmpty) return false;
    return selectedDishCategories.any((category) {
      return category.cID == parentCategory.cID;
    });
  }

  bool checkChildIsSelected(
    String? parentCId,
    CategoryInitialiseSubChildrensData child,
  ) {
    if (selectedDishCategories.isEmpty) return false;
    final parentCategory = selectedDishCategories.firstWhereOrNull((e) {
      return parentCId != null && e.cID == parentCId;
    });
    return parentCategory != null && parentCategory.childrens.contains(child);
  }

  final GlobalKey<FormState> addNewDishFormKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController variationNameController;
  late TextEditingController variationPriceController;
  late TextEditingController descriptionController;
  late TextEditingController ingrediantsController;
  late TextEditingController allergensController;
  late TextEditingController newCategoryNameController;
  late TextEditingController newCategoryDescriptionController;

  @override
  Future<void> init() async {
    fetchDishes();
    initializeAddDishRequiredData();
    _dishType = _addDishInitializeData?.dishtype.data.firstOrNull;
  }

  void initalizeAllFormControllers() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    quantityController = TextEditingController();
    variationNameController = TextEditingController();
    variationPriceController = TextEditingController();
    descriptionController = TextEditingController();
    ingrediantsController = TextEditingController();
    allergensController = TextEditingController();
    newCategoryNameController = TextEditingController();
    newCategoryDescriptionController = TextEditingController();
  }

  void disposeAllFormControllers() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    variationNameController.dispose();
    variationPriceController.dispose();
    descriptionController.dispose();
    ingrediantsController.dispose();
    allergensController.dispose();
    newCategoryNameController.dispose();
    newCategoryDescriptionController.dispose();
  }

  Future<void> fetchDishes() async {
    try {
      _dishCollection = APIResponse.loading();
      notifyListeners();

      final response = await DishesService.getDishesList();

      _dishCollection = response != null
          ? APIResponse.completed(response)
          : throwNotFoundException<DishCollectionModel>();

      notifyListeners();
    } on AppExceptions catch (error) {
      _dishCollection = APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      _dishCollection = throwUnknownErrorException<DishCollectionModel>();
      notifyListeners();
    }
  }

  Future<void> initializeAddDishRequiredData() async {
    final requiredData = await DishesService.initializeAddDishRequiredData();
    _addDishInitializeData = requiredData;
    notifyListeners();
  }

  void onSelectDish(int index) => _selectedDishIndex = index;

  Future<void> getDishDetails() async {
    try {
      if (selectedDish == null) {
        _viewDishDetails = throwNotFoundException<DishViewDetailsModel>();
        notifyListeners();
        return;
      }

      final dishId = selectedDish!.pID;

      _viewDishDetails = APIResponse.loading();
      notifyListeners();

      final response = await DishesService.getDishDetails(dishId);
      log(response.toString());
      _viewDishDetails = response != null
          ? APIResponse.completed(response)
          : throwNotFoundException<DishViewDetailsModel>();
      notifyListeners();

      inspect(_viewDishDetails);
    } on AppExceptions catch (error) {
      _viewDishDetails = APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      _viewDishDetails = throwUnknownErrorException<DishViewDetailsModel>();
      notifyListeners();
    }
  }

  Future<void> addNewDish() async {
    final payload = AddDishRequestModel(
      productType: "single",
    );

    final response = await DishesService.addNewDish(payload);
  }
}
