import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_initialise_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_request_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/dishes/dishes_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/helper_utils.dart';
import '../../models/dishes/dish_collection_model.dart';
import '../../services/app_exception/app_exception.dart';
import '../common/base_controller.dart';

class DishesController extends ChangeNotifier with BaseController {
  APIResponse<DishCollectionModel> _dishCollection = APIResponse.initial();

  APIResponse<DishCollectionModel> get dishCollection => _dishCollection;

  List<DishDetails> dishesList = [];

  int get totalDishes => dishCollection.data?.totalDishes ?? 0;

  APIResponse<DishViewDetailsModel> _viewDishDetails = APIResponse.initial();

  APIResponse<DishViewDetailsModel> get viewDishDetails => _viewDishDetails;

  bool get dishDetailsLoaded => viewDishDetails.data != null;

  AddDishInitializeDataModel? _addDishInitializeData;

  AddDishInitializeDataModel? get addDishInitializeData =>
      _addDishInitializeData;

  int get totalCategories => addDishInitializeData?.category.data.length ?? 0;

  List<String> get listOfAvailabilityDays =>
      _addDishInitializeData?.availability.data?.availability?.options ?? [];

  List<MasterAddonsInitialiseSubData> get listOfMasterAddons =>
      _addDishInitializeData?.masterAddons.data ?? [];

  //
  List<CategoryData> get listOfCategories =>
      (_addDishInitializeData?.category.data ?? [])
          .map((category) =>
              category.copyWith(childrens: category.childrens.toList()))
          .toList();

  List<CategoryData> get childCategories => listOfCategories
      .expand((category) => category.childrens)
      .map((category) => category)
      .toList();

  List<CategoryData> get categoriesWithProducts {
    final productCategoryIds = dishesList
        .expand((dish) => dish.categories)
        .map((category) => category.cID)
        .whereType<String>()
        .toSet();

    return listOfCategories.where((parentCategory) {
      // Parent category itself has a product
      if (productCategoryIds.contains(parentCategory.cID)) {
        return true;
      }

      // One of the child categories has a product
      return parentCategory.childrens.any(
        (childCategory) => productCategoryIds.contains(childCategory.cID),
      );
    }).toList();
  }

  late TextEditingController searchTextEditingController;
  bool _loadingDishAction = false;
  bool get loadingDishAction => _loadingDishAction;
  CategoryData get allCategory => CategoryData(name: "All", cID: "0");
  List<CategoryData> get menuCategories {
    return [
      allCategory,
      ...categoriesWithProducts,
    ];
  }

  // void refresh() => notifyListeners();

  // String? photo;

  // final ImagePicker _imagePicker = ImagePicker();

  // Future<void> pickDishImage() async {
  //   final image = await _imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 85,
  //   );

  //   if (image == null) {
  //     return;
  //   }

  //   photo = image.path;
  //   notifyListeners();
  // }

  // void removeDishImage() {
  //   photo = null;
  //   notifyListeners();
  // }

  @override
  Future<void> init() async {
    fetchDishes();
    await initializeAddDishRequiredData();
    activeDefaultSelectedInMenu();
    if (_addDishInitializeData?.dishtype.data.firstOrNull != null) {
      _dishType = _addDishInitializeData?.dishtype.data.first;
    }
  }

  void initializeSearchController() {
    searchTextEditingController = TextEditingController();
    searchTextEditingController.addListener(() {
      final query = searchTextEditingController.text;
      searchDishes(query);
    });
  }

  void disposeSearchController() {
    searchTextEditingController.dispose();
  }

  bool get isMealType => dishVariationType == DishVariationType.meal;

  List<Map<String, dynamic>> get activeEntries =>
      isMealType ? mealsFormEntries : variationsFormEntries;

  void addNewActiveEntry() =>
      isMealType ? addNewMealFormEntry() : addNewVariationFormEntry();

  void removeActiveEntry(int index) =>
      isMealType ? removeMealFormEntry(index) : removeVariationFormEntry(index);

  void duplicateActiveEntry(int index) => isMealType
      ? duplicateMealFormEntry(index)
      : duplicateVariationFormEntry(index);

  void onChangeActiveUnlimitedStock(int index, bool value) => isMealType
      ? onChangeMealUnlimitedStock(index, value)
      : onChangeVariationUnlimitedStock(index, value);
  Map<String, dynamic> get listOfMenus =>
      _addDishInitializeData?.productMenu.data ?? <String, dynamic>{};

  String? get defaultEntryKey => listOfMenus.entries.firstOrNull != null
      ? listOfMenus.entries.first.key
      : null;

  List<AllergensInitialiseSubData> get listOfAllergens =>
      _addDishInitializeData?.allergens.data ?? [];
  List<SpiceLevelInitializeSubData> get listOfSpiceLevels =>
      _addDishInitializeData?.spiceLevel.data ?? [];
  String? singleSelectedSpiceLevel;

  String? _selectedDishId;

  DishDetails? get selectedDish =>
      _selectedDishId != null && _dishCollection.data?.dishes != null
          ? _dishCollection.data?.dishes
              .firstWhereOrNull((x) => x.pID == _selectedDishId)
          : null;

  void onSelectDish(String? pId) => _selectedDishId = pId;

  bool get selectedDishDescIsEmpty =>
      selectedDish?.description.isEmpty ?? false;

  int _selectedCategoryIndex = -1;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  void onChangeCategoryIndex(int index) {
    _selectedCategoryIndex = index;
    notifyListeners();
  }

  String isFeaturedProduct = 'No';

  void setFeaturedProduct(String value) {
    isFeaturedProduct = value;
    notifyListeners();
  }

  bool isUnlimitedStock = false;

  final quantityController = TextEditingController();

  void onChangeUnlimitedStock(bool value) {
    isUnlimitedStock = value;

    if (value) {
      quantityController.clear();
    }

    notifyListeners();
  }

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

  DishVariationType _dishVariationType = DishVariationType.single;

  DishVariationType get dishVariationType => _dishVariationType;

  void onChangeDishVariationType(DishVariationType? type) {
    if (type == null) return;
    _dishVariationType = type;
    notifyListeners();
  }

  final singleVariationPriceController = TextEditingController();
  final singleVariationIngredientsController = TextEditingController();
  List<String> singleSelectedAllergens = <String>[];

  final GlobalKey<FormState> mealFormKey = GlobalKey<FormState>();

  Map<String, dynamic> get mealFormEntry => {
        "pvID": null,
        "name": TextEditingController(),
        "price": TextEditingController(),
        "ingredients": TextEditingController(),
        "quantity": TextEditingController(),
        "isUnlimitedStock": true,
        "allergens": <String>[],
        "addons": <String>[], // per-meal addonsMasterGroup ids
        "spiceLevel": null
      };

  late List<Map<String, dynamic>> mealsFormEntries = [mealFormEntry];

  bool checkMealEntryIsEmpty(int index) {
    final e = mealsFormEntries[index];
    return (e["name"] as TextEditingController).text.isEmpty &&
        (e["price"] as TextEditingController).text.isEmpty &&
        (e["allergens"] as List).isEmpty &&
        (e["addons"] as List).isEmpty;
  }

  // bool get mealsFormEntriesEmpty =>
  //     mealsFormEntries.length == 1 && checkMealEntryIsEmpty(0);
  bool get mealsFormEntriesEmpty => mealsFormEntries.every((e) =>
      (e["name"] as TextEditingController).text.trim().isEmpty &&
      (e["price"] as TextEditingController).text.trim().isEmpty);

  bool get activeEntriesEmpty =>
      isMealType ? mealsFormEntriesEmpty : variationsFormEntriesEmpty;

  void addNewMealFormEntry() {
    mealsFormEntries.add(mealFormEntry);
    notifyListeners();
  }

  void duplicateMealFormEntry(int index) {
    final e = mealsFormEntries[index];
    mealsFormEntries.add({
      "pvID": null,
      "name": TextEditingController()..text = e["name"].text,
      "price": TextEditingController()..text = e["price"].text,
      "ingredients": TextEditingController()..text = e["ingredients"].text,
      "quantity": TextEditingController()..text = e["quantity"].text,
      "isUnlimitedStock": e["isUnlimitedStock"] as bool? ?? true,
      "allergens": List<String>.from(e["allergens"]),
      "addons": List<String>.from(e["addons"]),
      "spiceLevel": e["spiceLevel"],
    });
    notifyListeners();
  }

  void onChangeMealUnlimitedStock(int index, bool value) {
    mealsFormEntries[index]["isUnlimitedStock"] = value;
    if (value) {
      (mealsFormEntries[index]["quantity"] as TextEditingController).clear();
    }
    notifyListeners();
  }

  void onToggleMealAddon(int index, String addonId) {
    final list = mealsFormEntries[index]["addons"] as List<String>;
    list.contains(addonId) ? list.remove(addonId) : list.add(addonId);
    notifyListeners();
  }

  final GlobalKey<FormState> variationFormKey = GlobalKey<FormState>();

  void onChangeVariationUnlimitedStock(
    int index,
    bool value,
  ) {
    variationsFormEntries[index]["isUnlimitedStock"] = value;

    if (value) {
      final quantityController =
          variationsFormEntries[index]["quantity"] as TextEditingController;

      quantityController.clear();
    }

    notifyListeners();
  }

  Map<String, dynamic> get variationFormEntry => {
        "name": TextEditingController(),
        "price": TextEditingController(),
        "ingredients": TextEditingController(),
        "quantity": TextEditingController(),
        "isUnlimitedStock": true,
        "allergens": <String>[],
        "spiceLevel": null
      };

  List<Map<String, dynamic>> variationsFormEntries = [
    {
      "name": TextEditingController(),
      "price": TextEditingController(),
      "ingredients": TextEditingController(),
      "quantity": TextEditingController(),
      "isUnlimitedStock": true,
      "allergens": <String>[],
      "spiceLevel": null
    }
  ];

  bool get variationsFormEntriesEmpty {
    if (variationsFormEntries.length != 1) {
      return false;
    }
    final entry = variationsFormEntries.first;
    final nameController = entry["name"] as TextEditingController;
    final price = entry["price"] as TextEditingController;
    final allergens = entry["allergens"] as List;
    if (nameController.text.isEmpty &&
        price.text.isEmpty &&
        allergens.isEmpty) {
      return true;
    }
    return false;
  }

  bool checkVariationEntryIsEmpty(int index) {
    final entry = variationsFormEntries[index];
    final nameController = entry["name"] as TextEditingController;
    final price = entry["price"] as TextEditingController;
    final allergens = entry["allergens"] as List;
    if (nameController.text.isEmpty &&
        price.text.isEmpty &&
        allergens.isEmpty) {
      return true;
    }
    return false;
  }

  // void onChangeAllergensSelection(
  //   int index,
  //   String? allergenId,
  // ) {
  //   if (allergenId == null) return;

  //   final isSingleVariation = dishVariationType == DishVariationType.single;
  //   final allergens = isSingleVariation
  //       ? singleSelectedAllergens
  //       : variationsFormEntries[index]["allergens"];

  //   if (allergens.contains(allergenId)) {
  //     allergens.remove(allergenId);
  //   } else {
  //     allergens.add(allergenId);
  //   }

  //   notifyListeners();
  // }
  // List<String> allergensFor(int index) => switch (dishVariationType) {
  //       DishVariationType.single => singleSelectedAllergens,
  //       DishVariationType.multiple =>
  //         variationsFormEntries[index]["allergens"] as List<String>,
  //       DishVariationType.meal =>
  //         mealsFormEntries[index]["allergens"] as List<String>,
  //     };

  List<String> allergensFor(int index) {
    switch (dishVariationType) {
      case DishVariationType.single:
        return singleSelectedAllergens;

      case DishVariationType.multiple:
        if (index < 0 || index >= variationsFormEntries.length) {
          return <String>[];
        }

        return variationsFormEntries[index]['allergens'] as List<String>;

      case DishVariationType.meal:
        if (index < 0 || index >= mealsFormEntries.length) {
          return <String>[];
        }

        return mealsFormEntries[index]['allergens'] as List<String>;
    }
  }

  String? spiceLevelFor(int index) {
    switch (dishVariationType) {
      case DishVariationType.single:
        return singleSelectedSpiceLevel;
      case DishVariationType.multiple:
        if (index < 0 || index >= variationsFormEntries.length) return null;
        return variationsFormEntries[index]['spiceLevel'] as String?;
      case DishVariationType.meal:
        if (index < 0 || index >= mealsFormEntries.length) return null;
        return mealsFormEntries[index]['spiceLevel'] as String?;
    }
  }

  void onChangeSpiceLevel(int index, String? name) {
    if (name == null) return;
    switch (dishVariationType) {
      case DishVariationType.single:
        singleSelectedSpiceLevel = name;
        break;
      case DishVariationType.multiple:
        if (index < 0 || index >= variationsFormEntries.length) return;
        variationsFormEntries[index]['spiceLevel'] = name;
        break;
      case DishVariationType.meal:
        if (index < 0 || index >= mealsFormEntries.length) return;
        mealsFormEntries[index]['spiceLevel'] = name;
        break;
    }
    notifyListeners();
  }
  // void onChangeAllergensSelection(int index, String? allergenId) {
  //   if (allergenId == null) return;
  //   final allergens = allergensFor(index);
  //   allergens.contains(allergenId)
  //       ? allergens.remove(allergenId)
  //       : allergens.add(allergenId);
  //   notifyListeners();
  // }

  void addNewVariationFormEntry() {
    variationsFormEntries.add(variationFormEntry);
    notifyListeners();
  }

  // void onChangeAllergensSelection(int index, String? allergenId) {
  //   if (allergenId == null) return;

  //   final allergens = switch (dishVariationType) {
  //     DishVariationType.single => singleSelectedAllergens,
  //     DishVariationType.multiple =>
  //       index >= 0 && index < variationsFormEntries.length
  //           ? variationsFormEntries[index]["allergens"] as List<String>
  //           : null,
  //     DishVariationType.meal => index >= 0 && index < mealsFormEntries.length
  //         ? mealsFormEntries[index]["allergens"] as List<String>
  //         : null,
  //   };

  //   if (allergens == null) return;

  //   if (allergens.contains(allergenId)) {
  //     allergens.remove(allergenId);
  //   } else {
  //     allergens.add(allergenId);
  //   }

  //   notifyListeners();
  // }

  void onChangeAllergensSelection(int index, String? allergenId) {
    if (allergenId == null) return;

    final allergens = allergensFor(index);

    // An invalid index returns an empty list. Do not update it.
    if (dishVariationType == DishVariationType.multiple &&
        (index < 0 || index >= variationsFormEntries.length)) {
      return;
    }

    if (dishVariationType == DishVariationType.meal &&
        (index < 0 || index >= mealsFormEntries.length)) {
      return;
    }

    if (allergens.contains(allergenId)) {
      allergens.remove(allergenId);
    } else {
      allergens.add(allergenId);
    }

    notifyListeners();
  }

  void removeVariationFormEntry(int index) {
    if (variationsFormEntries.length <= 1) return;
    _disposeEntry(variationsFormEntries.removeAt(index));
    notifyListeners();
  }

  void removeMealFormEntry(int index) {
    if (mealsFormEntries.length <= 1) return;
    _disposeEntry(mealsFormEntries.removeAt(index));
    notifyListeners();
  }

  void duplicateVariationFormEntry(int index) {
    final entry = variationsFormEntries[index];
    variationsFormEntries.add({
      "name": TextEditingController()..text = entry["name"].text,
      "price": TextEditingController()..text = entry["price"].text,
      "ingredients": TextEditingController()..text = entry["ingredients"].text,
      "quantity": TextEditingController()..text = entry["quantity"].text,
      "isUnlimitedStock": entry["isUnlimitedStock"] as bool? ?? true,
      // "allergens": List.from(entry["allergens"]),
      "allergens": List<String>.from(entry["allergens"]),
      "spiceLevel": entry["spiceLevel"],
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

  List<(TimeOfDay?, TimeOfDay?)> dishAvailabilityEntries =
      <(TimeOfDay?, TimeOfDay?)>[
    (null, null),
  ];

  void addAvailabilityEntries() {
    dishAvailabilityEntries = [...dishAvailabilityEntries, (null, null)];
    notifyListeners();
  }

  void removeAvailabilityEntries(int index) {
    dishAvailabilityEntries.removeAt(index);
    notifyListeners();
  }

  bool onStartTimeChange(int index, TimeOfDay time) {
    final endTime = dishAvailabilityEntries[index].$2;

    if (endTime != null) {
      final startMinutes = time.hour * 60 + time.minute;
      final endMinutes = endTime.hour * 60 + endTime.minute;

      if (startMinutes >= endMinutes) {
        return false;
      }
    }

    dishAvailabilityEntries[index] = (time, endTime);
    notifyListeners();

    return true;
  }

  bool onEndTimeChange(int index, TimeOfDay time) {
    final startTime = dishAvailabilityEntries[index].$1;

    if (startTime != null) {
      final startMinutes = startTime.hour * 60 + startTime.minute;
      final endMinutes = time.hour * 60 + time.minute;

      if (endMinutes <= startMinutes) {
        return false;
      }
    }

    dishAvailabilityEntries[index] = (startTime, time);
    notifyListeners();

    return true;
  }

  bool _allDaysEnabled = true;

  bool get allDaysEnabled => _allDaysEnabled;

  // void onChangeAllDaysEnable(bool? value) {
  //   if (value == null) return;
  //   _allDaysEnabled = value;
  //   // When All Days is enabled, specific day selections are unnecessary.
  //   // if (_allDaysEnabled) {
  //   //   availableDays.clear();
  //   // }
  //   notifyListeners();
  // }
  void onChangeAllDaysEnable(bool? value) {
    if (value == null) return;
    _allDaysEnabled = value;

    if (_allDaysEnabled) {
      availableDays
        ..clear()
        ..add('all_day');
    } else {
      availableDays.removeWhere(
        (day) => day == 'all_day',
      );
    }

    debugPrint('All Days enabled: $_allDaysEnabled');
    debugPrint('Selected days: $availableDays');

    notifyListeners();
  }

  List<String> availableDays = [];
  void onChangeAvailableDays(String day) {
    if (day == 'all_day') return;

    if (availableDays.contains(day)) {
      availableDays.remove(day);
    } else {
      availableDays.add(day);
    }

    _allDaysEnabled = false;

    notifyListeners();
  }
  // void onChangeAvailableDays(String day) {
  //   try {
  //     if (availableDays.contains(day)) {
  //       availableDays.remove(day);
  //       return;
  //     }
  //     availableDays.add(day);
  //   } finally {
  //     notifyListeners();
  //   }
  // }

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
  late TextEditingController descriptionController;
  late TextEditingController itemCodeController;

  String? _editDishId;

  String? get editDishId => _editDishId;

  void resetEditDishID() {
    _editDishId = null;
    notifyListeners();
  }

  void initializeAllFormControllers() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    itemCodeController = TextEditingController();
  }

  void disposeAllFormControllers() {
    nameController.dispose();
    descriptionController.dispose();
    itemCodeController.dispose();
  }

  Future<void> fetchDishes() async {
    if (_dishCollection.data == null) {
      _dishCollection = APIResponse.loading();
      notifyListeners();
    }

    try {
      final response = await DishesService.getDishesList();

      response.fold(
        (error) {
          _dishCollection = throwAppException<DishCollectionModel>(error);

          notifyListeners();
        },
        (result) {
          _dishCollection = APIResponse.completed(result);
          dishesList = List<DishDetails>.from(result.dishes);
          log(_dishCollection.toString());
          notifyListeners();
        },
      );
    } on AppExceptions catch (error) {
      _dishCollection = APIResponse.error(error.message, exception: error);
    } catch (_) {
      _dishCollection = throwUnknownErrorException<DishCollectionModel>();
    }
  }

  void updateCategoryList(int oldIndex, int newIndex, CategoryData category) {
    // Remove the category from the current list using its index
    final newListOfCategories = List<CategoryData>.from(listOfCategories);

    // Ensure valid indices to avoid out-of-bounds errors
    if (oldIndex < 0 || oldIndex >= newListOfCategories.length) {
      log('Invalid old index: $oldIndex');
      return;
    }

    // Remove the category at the old index
    newListOfCategories.removeAt(oldIndex);

    // Adjust newIndex if necessary
    if (newIndex > oldIndex) {
      newIndex -= 1; // Adjust because of the removed element
    }

    // Insert the category at the new index
    newListOfCategories.insert(newIndex, category);

    // Update the category list
    _addDishInitializeData?.category.data = List.from(newListOfCategories);
    notifyListeners();
  }

  List<DishDetails> filterDishesByCategory(CategoryData category) {
    if (category == allCategory) {
      return dishesList;
    }

    return dishesList
        .where((dish) => dish.categories.any((cat) => cat.cID == category.cID))
        .toList();
  }

  void searchDishes(String? query) {
    final dishesCollection = _dishCollection.data?.dishes ?? [];

    if (query == null || query.isEmpty) {
      dishesList = List<DishDetails>.from(dishesCollection);
      notifyListeners();
      return;
    }

    dishesList = dishesCollection
        .where((dish) => dish.name.toLowerCase().contains(query))
        .toList();

    notifyListeners();
  }

  void clearDishSearch() {
    searchTextEditingController.clear();
  }

  Future<void> initializeAddDishRequiredData() async {
    final response = await DishesService.initializeAddDishRequiredData();
    response.fold(
      (error) => Fluttertoast.showToast(msg: error.message),
      (requiredData) => _addDishInitializeData = requiredData,
    );
    notifyListeners();
  }

  Future<void> getDishDetails() async {
    final dishId = _selectedDishId;
    if (dishId == null) {
      _viewDishDetails = throwNotFoundException<DishViewDetailsModel>();
      notifyListeners();
      return;
    }

    _viewDishDetails = APIResponse.loading();
    notifyListeners();

    try {
      final response = await DishesService.getDishDetails(dishId);
      response.fold(
        (error) =>
            _viewDishDetails = throwAppException<DishViewDetailsModel>(error),
        (result) => _viewDishDetails = APIResponse.completed(result),
      );
    } on AppExceptions catch (error) {
      _viewDishDetails = APIResponse.error(error.message, exception: error);
    } catch (_) {
      _viewDishDetails = throwUnknownErrorException<DishViewDetailsModel>();
    } finally {
      notifyListeners();
    }
  }
  // Future<void> getDishDetails() async {
  //   if (selectedDish == null) {
  //     _viewDishDetails = throwNotFoundException<DishViewDetailsModel>();
  //     notifyListeners();
  //     return;
  //   }

  //   final dishId = selectedDish!.pID;
  //   _viewDishDetails = APIResponse.loading();
  //   notifyListeners();

  //   try {
  //     final response = await DishesService.getDishDetails(dishId);

  //     response.fold(
  //       (error) =>
  //           _viewDishDetails = throwAppException<DishViewDetailsModel>(error),
  //       (result) => _viewDishDetails = APIResponse.completed(result),
  //     );
  //   } on AppExceptions catch (error) {
  //     _viewDishDetails = APIResponse.error(error.message, exception: error);
  //   } catch (_) {
  //     _viewDishDetails = throwUnknownErrorException<DishViewDetailsModel>();
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  String _text(Map<String, dynamic> e, String key) =>
      (e[key] as TextEditingController).text.trim();
  bool _isUnlimited(Map<String, dynamic> e) =>
      e["isUnlimitedStock"] as bool? ?? true;

  int _quantity(Map<String, dynamic> e) =>
      _isUnlimited(e) ? 0 : (int.tryParse(_text(e, "quantity")) ?? 0);

  DishVariationItem _toVariationItem(Map<String, dynamic> e) =>
      DishVariationItem(
        pvID: e["pvID"]?.toString(),
        name: _text(e, "name"),
        price: _text(e, "price"),
        isUnlimitedStock: _isUnlimited(e) ? 1 : 0,
        quantity: _quantity(e),
        allergensMaster: List<String>.from(e["allergens"] ?? []),
        ingredients: _text(e, "ingredients"),
        spiceLevel: e["spiceLevel"] as String?,
      );

  MealItem _toMealItem(Map<String, dynamic> e) => MealItem(
        pvID: e["pvID"]?.toString(),
        name: _text(e, "name"),
        price: _text(e, "price"),
        isUnlimitedStock: _isUnlimited(e) ? 1 : 0,
        quantity: _quantity(e),
        allergensMaster: List<String>.from(e["allergens"] ?? []),
        ingredients: _text(e, "ingredients"),
        addonsMasterGroup: List<String>.from(e["addons"] ?? []),
        spiceLevel: e["spiceLevel"] as String?,
      );

  void _disposeEntry(Map<String, dynamic> e) {
    for (final v in e.values) {
      if (v is TextEditingController) v.dispose();
    }
  }

  String? _validateItemEntries(
      List<Map<String, dynamic>> entries, String label) {
    if (entries.isEmpty) return "Add at least one $label.";
    for (final e in entries) {
      final name = _text(e, "name");
      final price = double.tryParse(_text(e, "price"));
      if (name.isEmpty) {
        return "${capitalizeFirstLetter(label)} name cannot be empty.";
      }
      if (price == null || price <= 0) {
        return "Please enter a valid price for $name.";
      }
      if (!_isUnlimited(e)) {
        final qty = int.tryParse(_text(e, "quantity"));
        if (qty == null || qty <= 0) {
          return "Please enter a valid quantity for $name.";
        }
      }
    }
    return null;
  }

  String? _validateDish() {
    if (selectedDishCategories.isEmpty) return "Categories are not selected.";
    if (_dishType == null) {
      return "Dish Type (Veg or Non Veg) Field is not selected";
    }
    switch (dishVariationType) {
      case DishVariationType.single:
        final price =
            double.tryParse(singleVariationPriceController.text.trim());
        if (price == null || price <= 0) return "Please enter a valid price.";
        if (!isUnlimitedStock) {
          final q = int.tryParse(quantityController.text.trim());
          if (q == null || q <= 0) return "Please enter a valid quantity.";
        }
        return null;
      case DishVariationType.multiple:
        return _validateItemEntries(variationsFormEntries, "variation");
      case DishVariationType.meal:
        return _validateItemEntries(mealsFormEntries, "meal");
    }
  }

  // Future<ResponseResult> addOrUpdateDish() async {
  //   try {
  //     if (addNewDishFormKey.currentState?.validate() == false) {
  //       return ResponseResult.failure;
  //     }

  //     if (_loadingDishAction) return ResponseResult.pending;

  //     _loadingDishAction = true;
  //     notifyListeners();

  //     // final isMultiVariation = dishVariationType == DishVariationType.multiple;
  //     final isSingle = dishVariationType == DishVariationType.single;
  //     final isMultiVariation = dishVariationType == DishVariationType.multiple;
  //     final isMeal = dishVariationType == DishVariationType.meal;

  //     if (isMultiVariation && variationsFormEntriesEmpty) {
  //       showToastMessage("Variations cannot be empty");
  //       return ResponseResult.failure;
  //     }
  //     if (isMultiVariation) {
  //       for (final entry in variationsFormEntries) {
  //         final nameController = entry["name"] as TextEditingController;
  //         final priceController = entry["price"] as TextEditingController;
  //         final quantityController = entry["quantity"] as TextEditingController;
  //         final isUnlimited = entry["isUnlimitedStock"] as bool? ?? true;

  //         if (nameController.text.trim().isEmpty) {
  //           showToastMessage("Variation name cannot be empty.");
  //           return ResponseResult.failure;
  //         }

  //         final price = double.tryParse(
  //           priceController.text.trim(),
  //         );

  //         if (price == null || price <= 0) {
  //           showToastMessage("Please enter a valid variation price.");
  //           return ResponseResult.failure;
  //         }

  //         if (!isUnlimited) {
  //           final quantity = int.tryParse(
  //             quantityController.text.trim(),
  //           );

  //           if (quantity == null || quantity <= 0) {
  //             showToastMessage(
  //               "Please enter a valid quantity for ${nameController.text}.",
  //             );
  //             return ResponseResult.failure;
  //           }
  //         }
  //       }
  //     }
  //     if (isMeal) {
  //       if (mealsFormEntriesEmpty) {
  //         showToastMessage("Meals cannot be empty");
  //         return ResponseResult.failure;
  //       }
  //       final error = _validateItemEntries(mealsFormEntries, "meal");
  //       if (error != null) {
  //         showToastMessage(error);
  //         return ResponseResult.failure;
  //       }
  //     }
  //     if (selectedDishCategories.isEmpty) {
  //       showToastMessage("Categories are not selected.");
  //       return ResponseResult.failure;
  //     }
  //     // Check dish type is empty
  //     if (_dishType == null) {
  //       showToastMessage("Dish Type (Veg or Non Veg) Field is not selected");
  //       return ResponseResult.failure;
  //     }
  //     // Validate single dish quantity only
  //     if (isSingle && !isUnlimitedStock) {
  //       final quantity = int.tryParse(quantityController.text.trim());

  //       if (quantity == null || quantity <= 0) {
  //         showToastMessage("Please enter a valid quantity.");
  //         return ResponseResult.failure;
  //       }
  //     }

  //     // Check if variationsFormEntries has at least one entry
  //     // final productType = !isMultiVariation ? "single" : "variation";
  //     final productType = isSingle
  //         ? "single"
  //         : isMeal
  //             ? "meal"
  //             : "variation";

  //     // Check and initialize addonsMasterGroup
  //     final addonsMasterGroup = choosedMasterAddons
  //         .where((addon) => addon.id != null)
  //         .map((addon) => addon.id!)
  //         .toList();

  //     // Initialize isOnlineReq and isDineinReq based on _onlineStatus and _dineInStatus
  //     final isOnlineReq = _onlineStatus ? 'Yes' : 'No';
  //     final isDineinReq = _dineInStatus ? 'Yes' : 'No';

  //     // Extract values from variationsFormEntries and validate
  //     final priceReq = double.tryParse(singleVariationPriceController.text);

  //     // final quantityReq = int.tryParse(quantityController.text.trim());
  //     final quantityReq =
  //         isUnlimitedStock ? 0 : int.tryParse(quantityController.text.trim());

  //     // Initialize and validate listOfParentCategoriesId and listOfSubCategoriesId
  //     final listOfParentCategoriesId = choosedParentCategory
  //         .where((e) => e.$1 != null)
  //         .map((e) => e.$1!)
  //         .toList();
  //     final listOfSubCategoriesId = choosedSubCategories
  //         .where((e) => e.$3 != null)
  //         .map((e) => e.$3!)
  //         .toList();

  //     // Combine categories into listOfCategories and ensure it's not empty
  //     final listOfCategories = [
  //       ...listOfParentCategoriesId,
  //       ...listOfSubCategoriesId
  //     ];
  //     // Initialize allDayAvailable based on allDaysEnabled
  //     final allDayAvailable = allDaysEnabled ? "on" : null;

  //     final timing = dishAvailabilityEntries
  //         .where((entry) => entry.$1 != null && entry.$2 != null)
  //         .map((entry) => {
  //               "startTime": convertTimeOfDayTo24hr(entry.$1!),
  //               "endTime": convertTimeOfDayTo24hr(entry.$2!),
  //             })
  //         .toList();

  //     // ---------- single ----------
  //     final single = isSingle
  //         ? SingleDishDetails(
  //             price: singleVariationPriceController.text.trim(),
  //             isUnlimitedStock: isUnlimitedStock ? 1 : 0,
  //             quantity: isUnlimitedStock
  //                 ? 0
  //                 : int.parse(quantityController.text.trim()),
  //             allergensMaster: List<String>.from(singleSelectedAllergens),
  //             ingredients: singleVariationIngredientsController.text.trim(),
  //           )
  //         : null;

  //     // Extract variations data and validate each entry
  //     // final variations = isMultiVariation
  //     //     ? variationsFormEntries.map((entry) {
  //     //         final nameController = entry["name"] as TextEditingController;
  //     //         final price = entry["price"] as TextEditingController;
  //     //         final allergens = (entry["allergens"] as List).cast<String>();
  //     //         final ingredientsController =
  //     //             entry["ingredients"] as TextEditingController;
  //     //         final quantityController =
  //     //             entry["quantity"] as TextEditingController;
  //     //         final isUnlimited = entry["isUnlimitedStock"] as bool? ?? true;

  //     //         final quantity =
  //     //             isUnlimited ? 0 : int.parse(quantityController.text.trim());
  //     //         return VariationDishData(
  //     //           pvID: null,
  //     //           name: nameController.text,
  //     //           price: double.parse(price.text),
  //     //           allergensMaster: allergens,
  //     //           ingredients: ingredientsController.text,
  //     //           isUnlimitedStock: isUnlimited ? 1 : 0,
  //     //           quantity: quantity,
  //     //         );
  //     //       }).toList()
  //     //     : const <VariationDishData>[];
  //     // ---------- variations ----------
  //     // final variations = isMultiVariation
  //     //     ? variationsFormEntries.map((e) {
  //     //         final isUnlimited = e["isUnlimitedStock"] as bool? ?? true;
  //     //         return DishVariationItem(
  //     //           name: _text(e, "name"),
  //     //           price: _text(e, "price"),
  //     //           isUnlimitedStock: isUnlimited ? 1 : 0,
  //     //           quantity: isUnlimited ? 0 : int.parse(_text(e, "quantity")),
  //     //           allergensMaster: List<String>.from(e["allergens"]),
  //     //           ingredients: _text(e, "ingredients"),
  //     //         );
  //     //       }).toList()
  //     //     : <DishVariationItem>[];
  //     final variations = isMultiVariation && variationsFormEntries.isNotEmpty
  //         ? DishVariationItem(
  //             name: _text(variationsFormEntries.first, "name"),
  //             price: _text(variationsFormEntries.first, "price"),
  //             isUnlimitedStock:
  //                 variationsFormEntries.first["isUnlimitedStock"] as bool? ??
  //                         true
  //                     ? 1
  //                     : 0,
  //             quantity:
  //                 (variationsFormEntries.first["isUnlimitedStock"] as bool? ??
  //                         true)
  //                     ? 0
  //                     : int.parse(
  //                         _text(variationsFormEntries.first, "quantity"),
  //                       ),
  //             allergensMaster: List<String>.from(
  //               variationsFormEntries.first["allergens"] ?? [],
  //             ),
  //             ingredients: _text(variationsFormEntries.first, "ingredients"),
  //           )
  //         : null;
  //     final meals = isMeal
  //         ? MealItem(
  //             name: _text(mealsFormEntries.first, "name"),
  //             price: _text(mealsFormEntries.first, "price"),
  //             isUnlimitedStock:
  //                 mealsFormEntries.first["isUnlimitedStock"] as bool? ?? true
  //                     ? 1
  //                     : 0,
  //             quantity:
  //                 (mealsFormEntries.first["isUnlimitedStock"] as bool? ?? true)
  //                     ? 0
  //                     : int.parse(_text(mealsFormEntries.first, "quantity")),
  //             allergensMaster: List<String>.from(
  //               mealsFormEntries.first["allergens"] ?? [],
  //             ),
  //             ingredients: _text(mealsFormEntries.first, "ingredients"),
  //             addonsMasterGroup: List<String>.from(
  //               mealsFormEntries.first["addons"] ?? [],
  //             ),
  //           )
  //         : null;
  //     // ---------- payload ----------
  //     final payload = AddDishRequestModel(
  //       allergns: singleSelectedAllergens,
  //       isUnlimitedStock: isSingle && isUnlimitedStock ? 1 : 0,
  //       quantity: isSingle ? (isUnlimitedStock ? 0 : quantityReq) : 0,
  //       price: priceReq,
  //       productType: productType,
  //       type: dishType,
  //       activeStatus: 1,
  //       online: isOnlineReq,
  //       dining: isDineinReq,
  //       featured: isFeaturedProduct,
  //       ingredients: singleVariationIngredientsController.text,
  //       name: nameController.text,
  //       description: descriptionController.text,
  //       category: listOfCategories,
  //       allDayAvailable: allDayAvailable,
  //       availability: availableDays,
  //       timing: timing,
  //       addonsMasterGroup: addonsMasterGroup,
  //       productMenuGroup: choosedMenus,
  //       itemCode: itemCodeController.text,
  //       variationsSelectOnlyOne: VariationsSelectOnlyOne(
  //         ifSingle: single,
  //         ifVariation: variations != null
  //             ? VariationDetails(variations: variations)
  //             : null,
  //         ifMeal: isMeal && meals != null ? MealDetails(meal: meals) : null,
  //       ),
  //     );
  //     log(payload.toJson().toString());

  //     // Construct payload based on whether there's a single entry or variations
  //     // final payload = !isMultiVariation
  //     //     ? AddDishRequestModel(
  //     //         productType: productType,
  //     //         type: dishType,
  //     //         activeStatus: 1,
  //     //         price: priceReq,
  //     //         online: isOnlineReq,
  //     //         dining: isDineinReq,
  //     //         featured: isFeaturedProduct,
  //     //         name: nameController.text,
  //     //         description: descriptionController.text,
  //     //         ingredients: singleVariationIngredientsController.text,
  //     //         allergns: singleSelectedAllergens,
  //     //         category: listOfCategories,
  //     //         allDayAvailable: allDayAvailable,
  //     //         availability: availableDays,
  //     //         timing: timing,
  //     //         isUnlimitedStock: isUnlimitedStock ? 1 : 0,
  //     //         quantity: isUnlimitedStock ? 0 : quantityReq,
  //     //         addonsMasterGroup: addonsMasterGroup,
  //     //         productMenuGroup: choosedMenus,
  //     //         itemCode: itemCodeController.text,
  //     //       )
  //     //     : AddDishRequestWithVariationModel(
  //     //         productType: productType,
  //     //         type: dishType,
  //     //         activeStatus: 1,
  //     //         variations: variations,
  //     //         online: isOnlineReq,
  //     //         dining: isDineinReq,
  //     //         featured: isFeaturedProduct,
  //     //         name: nameController.text,
  //     //         description: descriptionController.text,
  //     //         category: listOfCategories,
  //     //         addonsMasterGroup: addonsMasterGroup,
  //     //         allDayAvailable: allDayAvailable,
  //     //         availability: availableDays,
  //     //         timing: timing,
  //     //         productMenuGroup: choosedMenus,
  //     //         itemCode: itemCodeController.text,
  //     //       );

  //     // Perform either update or addition based on editDishId
  //     if (editDishId != null) {
  //       final response = await DishesService.updateDish(
  //         editDishId!,
  //         payload,
  //       );

  //       return response.fold((error) {
  //         Fluttertoast.showToast(msg: error.message);
  //         return ResponseResult.failure;
  //       }, (success) {
  //         Fluttertoast.showToast(msg: "Dish updated successfully!");
  //         return ResponseResult.success;
  //       });
  //     } else {
  //       final response = await DishesService.addNewDish(payload);
  //       return response.fold((error) {
  //         Fluttertoast.showToast(msg: error.message);
  //         return ResponseResult.failure;
  //       }, (success) {
  //         Fluttertoast.showToast(msg: "Dish added successfully!");
  //         return ResponseResult.success;
  //       });
  //     }

  //     // Return success if everything goes well
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: "Failed to save dish!");
  //     // Return failure in case of any exception
  //     return ResponseResult.failure;
  //   } finally {
  //     _loadingDishAction = false;
  //     notifyListeners();
  //     // Always fetch dishes after attempting to add/update
  //     fetchDishes();
  //   }
  // }
  Future<ResponseResult> addOrUpdateDish() async {
    if (_loadingDishAction) return ResponseResult.pending;
    if (addNewDishFormKey.currentState?.validate() == false) {
      return ResponseResult.failure;
    }

    final validationError = _validateDish();
    if (validationError != null) {
      showToastMessage(validationError);
      return ResponseResult.failure;
    }

    _loadingDishAction = true;
    notifyListeners();

    bool updated = false;

    try {
      final payload = _buildPayload();
      log('Dish payload: ${payload.toJson()}');

      // ---------- UPDATE ----------
      if (editDishId != null) {
        final response = await DishesService.updateDish(editDishId!, payload);

        final result = response.fold((error) {
          Fluttertoast.showToast(msg: error.message);
          return ResponseResult.failure;
        }, (_) {
          Fluttertoast.showToast(msg: "Dish updated successfully!");
          return ResponseResult.success;
        });

        updated = result == ResponseResult.success;
        return result;
      }

      // ---------- ADD ----------
      final response = await DishesService.addNewDish(payload);
      return response.fold((error) {
        Fluttertoast.showToast(msg: error.message);
        return ResponseResult.failure;
      }, (_) {
        Fluttertoast.showToast(msg: "Dish added successfully!");
        return ResponseResult.success;
      });
    } catch (e) {
      log("addOrUpdateDish error: $e");
      Fluttertoast.showToast(msg: "Failed to save dish!");
      return ResponseResult.failure;
    } finally {
      _loadingDishAction = false;
      notifyListeners();
      fetchDishes().then((_) {
        if (updated) getDishDetails();
      });
    }
  }

  AddDishRequestModel _buildPayload() {
    final isSingle = dishVariationType == DishVariationType.single;
    final isVariation = dishVariationType == DishVariationType.multiple;
    final isMeal = dishVariationType == DishVariationType.meal;

    final productType = isSingle
        ? "single"
        : isMeal
            ? "meal"
            : "variation";

    final categoryIds = [
      ...choosedParentCategory.where((e) => e.$1 != null).map((e) => e.$1!),
      ...choosedSubCategories.where((e) => e.$3 != null).map((e) => e.$3!),
    ];

    // Initialize allDayAvailable based on allDaysEnabled
    final allDayAvailable = allDaysEnabled ? "on" : null;

    // Extract timing data and validate each entry
    final timing = dishAvailabilityEntries
        .where((entry) => entry.$1 != null && entry.$2 != null)
        .map((entry) {
      final formatStartTime = convertTimeOfDayTo24hr(entry.$1!);
      final formatEndTime = convertTimeOfDayTo24hr(entry.$2!);
      return {
        "startTime": formatStartTime,
        "endTime": formatEndTime,
      };
    }).toList();

    final singleQty = isUnlimitedStock
        ? 0
        : (int.tryParse(quantityController.text.trim()) ?? 0);

    final single = isSingle
        ? SingleDishDetails(
            pvID: editDishId != null
                ? viewDishDetails.data?.variationData.firstOrNull?.pvID
                : null,
            price: singleVariationPriceController.text.trim(),
            isUnlimitedStock: isUnlimitedStock ? 1 : 0,
            quantity: singleQty,
            allergensMaster: List<String>.from(singleSelectedAllergens),
            ingredients: singleVariationIngredientsController.text.trim(),
            spiceLevel: singleSelectedSpiceLevel,
          )
        : null;

    return AddDishRequestModel(
      productType: productType,
      type: dishType,
      activeStatus: 1,
      online: _onlineStatus ? 'Yes' : 'No',
      dining: _dineInStatus ? 'Yes' : 'No',
      featured: isFeaturedProduct,
      name: nameController.text,
      description: descriptionController.text,
      itemCode: itemCodeController.text,
      category: categoryIds,
      allDayAvailable: allDayAvailable,
      availability: availableDays,
      timing: timing,
      // Single-only fields; the model omits them for variation/meal.
      price: isSingle
          ? double.tryParse(singleVariationPriceController.text.trim())
          : null,
      isUnlimitedStock: isSingle ? (isUnlimitedStock ? 1 : 0) : null,
      quantity: isSingle ? singleQty : null,
      allergns: isSingle ? singleSelectedAllergens : const [],
      ingredients:
          isSingle ? singleVariationIngredientsController.text.trim() : null,

      // For meals, addons live inside each meal. Confirm with the backend
      // whether the top-level list should be empty here.
      addonsMasterGroup: isMeal
          ? <String>[]
          : choosedMasterAddons
              .where((a) => a.id != null)
              .map((a) => a.id!)
              .toList(),
      productMenuGroup: choosedMenus,
      variationsSelectOnlyOne: VariationsSelectOnlyOne(
        ifSingle: single,
        ifVariation: isVariation
            ? VariationDetails(
                variations:
                    variationsFormEntries.map(_toVariationItem).toList())
            : null,
        ifMeal: isMeal
            ? MealDetails(meal: mealsFormEntries.map(_toMealItem).toList())
            : null,
      ),
    );
  }

  void onPressEditButton() {
    if (selectedDish == null) return;

    _editDishId = selectedDish?.pID;

    // View Dish Details Completed Checking
    if (viewDishDetails.status != APIResponseStatus.completed) return;
    final dishData = viewDishDetails.data!;

    // Dish Name & Description
    nameController.text = dishData.basicData.name;
    descriptionController.text = removeHtmlTags(dishData.basicData.description);
    itemCodeController.text = dishData.basicData.itemCode;

    // Dish Type
    // final dishType = selectedDish?.type;
    // _dishType = dishType;
    final dishType = selectedDish?.type;
    _dishType = (dishType == null || dishType.isEmpty)
        ? _addDishInitializeData?.dishtype.data.firstOrNull
        : dishType;

    // Online & Dine In Status
    final onlineStatus = selectedDish?.online == "Yes";
    final dineInStatus = selectedDish?.dining == "Yes";
    _onlineStatus = onlineStatus;
    _dineInStatus = dineInStatus;

    // Featured Product
    isFeaturedProduct = selectedDish?.featured ?? "No";

    // Category
    List<CategoryData> selectedCategories = [];
    selectedDish?.categories.forEach((selectedCategory) {
      for (var category in listOfCategories) {
        if (selectedCategory.cID == category.cID) {
          selectedCategories.add(category);
        }
      }
    });

    List<CategoryData> updatedCategories = List.from(selectedCategories);

    for (int index = 0; index < selectedCategories.length; index++) {
      var selectedCategory = selectedCategories[index];
      for (var category in listOfCategories) {
        if (selectedCategory.cID == category.cID) {
          final selectedChildrenIds =
              selectedCategory.childrens.map((child) => child.cID).toList();
          final updatedChildren = category.childrens
              .where((child) => selectedChildrenIds.contains(child.cID))
              .toList();

          var updatedCategory = updatedCategories[index];
          updatedCategory =
              updatedCategory.copyWith(childrens: updatedChildren);
          updatedCategories[index] = updatedCategory;
        }
      }
    }

    selectedDishCategories = List.from(updatedCategories);
    Map<String, dynamic> _entryFromDetails(VariationData v,
        {bool isMeal = false}) {
      final unlimited = v.isUnlimited;
      return <String, dynamic>{
        "pvID": v.pvID.isEmpty ? null : v.pvID,
        "name": TextEditingController(text: v.name),
        "price": TextEditingController(text: v.price),
        "ingredients":
            TextEditingController(text: removeHtmlTags(v.ingredients)),
        "quantity": TextEditingController(text: unlimited ? "" : v.stock),
        "isUnlimitedStock": unlimited,
        "allergens": v.allergenIds,
        if (isMeal)
          "addons": <String>[], // TODO: map once the meal addon key is known
      };
    }

    final productType =
        selectedDish?.productType ?? dishData.basicData.productType;

    switch (productType) {
      case "meal":
        mealsFormEntries = dishData.variationData
            .map((m) => _entryFromDetails(m, isMeal: true))
            .toList();
        if (mealsFormEntries.isEmpty) mealsFormEntries = [mealFormEntry];
        onChangeDishVariationType(DishVariationType.meal);
        break;

      case "variation":
        variationsFormEntries =
            dishData.variationData.map(_entryFromDetails).toList();
        if (variationsFormEntries.isEmpty) {
          variationsFormEntries = [variationFormEntry];
        }
        onChangeDishVariationType(DishVariationType.multiple);
        break;

      default:
        if (dishData.variationData.isNotEmpty) {
          final v = dishData.variationData.first;
          singleVariationPriceController.text = v.price;
          singleSelectedAllergens = v.allergenIds;
          singleSelectedSpiceLevel = v.spiceLevel;
          singleVariationIngredientsController.text =
              removeHtmlTags(v.ingredients);
          isUnlimitedStock = v.isUnlimited;
          quantityController.text = isUnlimitedStock ? "" : v.stock;
        }
        onChangeDishVariationType(DishVariationType.single);
    }
    // Modifiers
    final modifiers = dishData.selectedAddonGroups
        .map(
          (e) => MasterAddonsInitialiseSubData(
            id: e["id"],
            title: e["name"],
          ),
        )
        .toList();
    choosedMasterAddons = List.from(modifiers);

    // Menus List
    choosedMenus = List<String>.from(dishData.selectedMenuList.map((menu) {
      return menu["id"] as String;
    }));
    if (choosedMenus.isEmpty) {
      activeDefaultSelectedInMenu();
    }

    // Availability
    final allDaysEnabled = dishData.availability.isAllday;
    final days = dishData.availability.days;
    final timings = dishData.availability.timing;
    _allDaysEnabled = allDaysEnabled;
    availableDays = List.from(days);
    final timingsElements = timings.map((e) {
      return (parseTimeOfDay(e.startTime), parseTimeOfDay(e.endTime));
    }).toList();
    dishAvailabilityEntries = timingsElements;

    notifyListeners();
  }

  Future<void> updateDishStatus() async {
    try {
      if (selectedDish == null) return;
      final response = await DishesService.updateDishStatus(
        productID: viewDishDetails.data!.basicData.pID,
        activeStatus: selectedDish!.active,
      );
      response.fold((error) {
        Fluttertoast.showToast(msg: error.message);
      }, (_) {
        getDishDetails();
        fetchDishes();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to update dish status!");
    } finally {
      _loadingDishAction = false;
      notifyListeners();
    }
  }

  Future<void> deleteDish() async {
    try {
      if (_loadingDishAction == true) return;
      _loadingDishAction = true;
      notifyListeners();
      if (viewDishDetails.data?.basicData == null) return;
      final response = await DishesService.deleteProduct(
        productID: viewDishDetails.data!.basicData.pID,
      );
      response.fold((error) {
        Fluttertoast.showToast(msg: error.message);
      }, (_) {
        fetchDishes();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to delete dish!");
    } finally {
      _loadingDishAction = false;
      notifyListeners();
    }
  }

  void resetFormEntries() {
    _dishType = null;
    if (_addDishInitializeData?.dishtype.data.firstOrNull != null) {
      _dishType = _addDishInitializeData?.dishtype.data.first;
    }
    _onlineStatus = true;
    _dineInStatus = true;
    onChangeDishVariationType(DishVariationType.single);
    for (final e in variationsFormEntries) _disposeEntry(e);
    for (final e in mealsFormEntries) _disposeEntry(e);
    variationsFormEntries = [variationFormEntry];
    mealsFormEntries = [mealFormEntry];
    _editDishId = null;
    isFeaturedProduct = 'No';
    isUnlimitedStock = false;
    _selectedCategoryIndex = -1;
    // variationsFormEntries.clear();
    // variationsFormEntries.add(variationFormEntry);
    choosedMasterAddons.clear();
    selectedDishCategories.clear();
    dishAvailabilityEntries.clear();
    dishAvailabilityEntries = <(TimeOfDay?, TimeOfDay?)>[
      (null, null),
    ];
    _allDaysEnabled = true;
    availableDays.clear();
    choosedMenus.clear();
    nameController.clear();
    descriptionController.clear();
    addNewDishFormKey.currentState?.reset();
    singleVariationPriceController.clear();
    singleVariationIngredientsController.clear();
    singleSelectedAllergens.clear();
    singleSelectedSpiceLevel = null;
    itemCodeController.clear();
    quantityController.clear();
    // mealsFormEntries = [mealFormEntry];
    // photo = null;
    activeDefaultSelectedInMenu();
  }
}
