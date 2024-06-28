import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_initialise_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_request_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/dishes/dishes_service.dart';

import '../../core/utils/helper_utils.dart';
import '../../models/dishes/add_dish_request_with_variation_model.dart';
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
  List<CategoryData> get listOfCategories =>
      _addDishInitializeData?.category.data ?? [];
  Map<String, dynamic> get listOfMenus =>
      _addDishInitializeData?.productMenu.data ?? <String, dynamic>{};

  String? get defaultEntryKey => listOfMenus.entries.firstOrNull != null
      ? listOfMenus.entries.first.key
      : null;
  List<AllergensInitialiseSubData> get listOfAllergens =>
      _addDishInitializeData?.allergens.data ?? [];

  int _selectedDishIndex = -1;
  int get selectedDishIndex => _selectedDishIndex;

  DishDetails? get selectedDish =>
      _selectedDishIndex != -1 && _dishCollection.data?.dishes != null
          ? _dishCollection.data?.dishes.elementAt(_selectedDishIndex)
          : null;

  String? _dishType;
  String get dishType => _dishType ?? "";

  void onChangeDishType(String dishType) {
    _dishType = dishType;
    notifyListeners();
  }

  bool _onlineStatus = true;
  bool _dineInStatus = true;
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

  List<CategoryData> selectedDishCategories = [];

  List<(String?, String?)> get choosedParentCategory =>
      selectedDishCategories.map((e) => (e.cID, e.name)).toList();

  List<(String?, String?, String?, String?)> get choosedSubCategories =>
      selectedDishCategories.expand((parentCategory) {
        return parentCategory.childrens.map((child) {
          return (
            parentCategory.cID,
            parentCategory.name,
            child.cID,
            child.name
          );
        });
      }).toList();

  void whenSelectParentCategory(CategoryData parentCategory) {
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
    CategoryData child,
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

  bool checkParentIsSelected(CategoryData parentCategory) {
    if (selectedDishCategories.isEmpty) return false;
    return selectedDishCategories.any((category) {
      return category.cID == parentCategory.cID;
    });
  }

  bool checkChildIsSelected(
    String? parentCId,
    CategoryData child,
  ) {
    if (selectedDishCategories.isEmpty) return false;
    final parentCategory = selectedDishCategories.firstWhereOrNull((e) {
      return parentCId != null && e.cID == parentCId;
    });
    return parentCategory != null && parentCategory.childrens.contains(child);
  }

  void removeParentCategory(String? parentCId) {
    if (parentCId == null) return;
    selectedDishCategories.removeWhere((category) => category.cID == parentCId);
    notifyListeners();
  }

  void removeChildCategory(String? parentCId, String? childCID) {
    try {
      if (childCID == null) return;
      final parentCategory = selectedDishCategories.firstWhereOrNull((e) {
        return parentCId != null && e.cID == parentCId;
      });
      if (parentCategory == null) return;
      parentCategory.childrens.removeWhere((category) {
        return category.cID == childCID;
      });
    } finally {
      notifyListeners();
    }
  }

  List<(TimeOfDay?, TimeOfDay?)> dishAvailabilityEntries = [
    (null, null),
  ];

  void addAvailabilityEntries() {
    dishAvailabilityEntries.add((null, null));
    notifyListeners();
  }

  void removeAvailabilityEntries(int index) {
    dishAvailabilityEntries.removeAt(index);
    notifyListeners();
  }

  void onStartTimeChange(int index, TimeOfDay time) {
    dishAvailabilityEntries[index] = (time, dishAvailabilityEntries[index].$2);
    notifyListeners();
  }

  void onEndTimeChange(int index, TimeOfDay time) {
    dishAvailabilityEntries[index] = (dishAvailabilityEntries[index].$1, time);
    notifyListeners();
  }

  bool _allDaysEnabled = true;
  bool get allDaysEnabled => _allDaysEnabled;

  void onChangeAllDaysEnable(bool? value) {
    if (value == null) return;
    _allDaysEnabled = value;
    notifyListeners();
  }

  List<String> availableDays = [];

  void onChangeAvailableDays(String day) {
    try {
      if (availableDays.contains(day)) {
        availableDays.remove(day);
        return;
      }
      availableDays.add(day);
    } finally {
      notifyListeners();
    }
  }

  bool checkDaysIsSelected(String day) {
    return availableDays.contains(day);
  }

  List<String> choosedMenus = [];

  void onChangeChooseMenus(String key) {
    try {
      if (choosedMenus.contains(key)) {
        choosedMenus.remove(key);
        return;
      }
      choosedMenus.add(key);
    } finally {
      notifyListeners();
    }
  }

  bool checkMenuIsSelected(String key) => choosedMenus.contains(key);

  void activeDefaultSelectedInMenu() {
    if (listOfMenus.entries.firstOrNull == null) return;
    final defaultEntry = listOfMenus.entries.first;
    if (choosedMenus.contains(defaultEntry.key)) return;
    choosedMenus.insert(0, defaultEntry.key);
  }

  final GlobalKey<FormState> addNewDishFormKey = GlobalKey<FormState>();
  late TextEditingController nameController;
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
    await initializeAddDishRequiredData();
    activeDefaultSelectedInMenu();
    if (_addDishInitializeData?.dishtype.data.firstOrNull != null) {
      _dishType = _addDishInitializeData?.dishtype.data.first;
    }
  }

  void initalizeAllFormControllers() {
    nameController = TextEditingController();

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
    try {
      if (variationsFormEntries.isEmpty) return;

      final productType =
          variationsFormEntries.length == 1 ? "single" : "variation";
      final addonsMasterGroup = choosedMasterAddons
          .where((addon) => addon.id != null)
          .map((addon) => addon.id!)
          .toList();
      final isOnlineReq = _onlineStatus ? 'Yes' : 'No';
      final isDineinReq = _dineInStatus ? 'Yes' : 'No';

      final singleEntry = variationsFormEntries.first;
      final priceController = singleEntry["price"] as TextEditingController;
      final priceReq = double.parse(priceController.text);

      final ingredientsController =
          singleEntry["ingredients"] as TextEditingController;
      final allergens =
          singleEntry["allergens"] as List<AllergensInitialiseSubData>;
      final allergensIds =
          allergens.where((e) => e.id != null).map((e) => e.id!).toList();

      final listOfParentCategoriesId = choosedParentCategory
          .where((e) => e.$1 != null)
          .map((e) => e.$1!)
          .toList();
      final listOfSubCategoriesId = choosedSubCategories
          .where((e) => e.$3 != null)
          .map((e) => e.$3!)
          .toList();
      final listOfCategories = [
        ...listOfParentCategoriesId,
        ...listOfSubCategoriesId
      ];

      final variations = variationsFormEntries.map((entry) {
        final nameController = entry["name"] as TextEditingController;
        final allergens = entry["allergens"];
        final price = entry["price"] as TextEditingController;
        return VariationDishData(
          pvID: null,
          name: nameController.text,
          price: double.parse(price.text),
          allergensMaster: allergens.map((e) => e.id).toList(),
          ingredients: ingredientsController.text,
          isUnlimitedStock: 1,
          quantity: 0,
        );
      }).toList();

      final allDayAvailable = allDaysEnabled ? "on" : null;

      final timing = dishAvailabilityEntries
          .where((entry) => entry.$1 != null && entry.$2 != null)
          .map((entry) {
        final formatStartTime = convertTimeOfDayTo24hr(entry.$1!);
        final formatEndTime = convertTimeOfDayTo24hr(entry.$2!);
        final time = {"startTime": formatStartTime, "endTime": formatEndTime};
        return time;
      }).toList();

      final payload = variationsFormEntries.length == 1
          ? AddDishRequestModel(
              productType: productType,
              type: dishType,
              activeStatus: 1,
              price: priceReq,
              isUnlimitedStock: 1,
              online: isOnlineReq,
              dining: isDineinReq,
              name: nameController.text,
              description: descriptionController.text,
              ingredients: ingredientsController.text,
              allergns: allergensIds,
              category: listOfCategories,
              allDayAvailable: allDayAvailable,
              availability: availableDays,
              timing: timing,
              quantity: 0,
              addonsMasterGroup: addonsMasterGroup,
              productMenuGroup: choosedMenus,
            )
          : AddDishRequestWithVariationModel(
              productType: productType,
              type: dishType,
              activeStatus: 1,
              variations: variations,
              online: isOnlineReq,
              dining: isDineinReq,
              name: nameController.text,
              description: descriptionController.text,
              category: listOfCategories,
              addonsMasterGroup: addonsMasterGroup,
              allDayAvailable: allDayAvailable,
              availability: availableDays,
              timing: timing,
              productMenuGroup: choosedMenus,
            );

      final response = await DishesService.addNewDish(payload);
      inspect(response);
    } finally {
      fetchDishes();
    }
  }

  Future<void> deleteDish() async {
    try {
      if (viewDishDetails.data?.basicData == null) return;
      await DishesService.deleteProduct(
        productID: viewDishDetails.data!.basicData.pID,
      );
    } finally {
      fetchDishes();
    }
  }
}
