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
import '../../models/dishes/add_dish_request_with_variation_model.dart';
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

  List<CategoryData> get listOfCategories =>
      (_addDishInitializeData?.category.data ?? [])
          .map((category) =>
              category.copyWith(childrens: category.childrens.toList()))
          .toList();

  List<CategoryData> get childCategories => listOfCategories
      .expand((category) => category.childrens)
      .map((category) => category)
      .toList();

  late TextEditingController searchTextEditingController;

  bool _loadingDishAction = false;

  bool get loadingDishAction => _loadingDishAction;

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
  }

  void disposeSearchController() {
    searchTextEditingController.dispose();
  }

  Map<String, dynamic> get listOfMenus =>
      _addDishInitializeData?.productMenu.data ?? <String, dynamic>{};

  String? get defaultEntryKey => listOfMenus.entries.firstOrNull != null
      ? listOfMenus.entries.first.key
      : null;

  List<AllergensInitialiseSubData> get listOfAllergens =>
      _addDishInitializeData?.allergens.data ?? [];

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

  final GlobalKey<FormState> variationFormKey = GlobalKey<FormState>();

  Map<String, dynamic> get variationFormEntry => {
        "name": TextEditingController(),
        "price": TextEditingController(),
        "ingredients": TextEditingController(),
        "allergens": <String>[]
      };

  List<Map<String, dynamic>> variationsFormEntries = [
    {
      "name": TextEditingController(),
      "price": TextEditingController(),
      "ingredients": TextEditingController(),
      "allergens": <String>[]
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

  void onChangeAllergensSelection(
    int index,
    String? allergenId,
  ) {
    if (allergenId == null) return;

    final isSingleVariation = dishVariationType == DishVariationType.single;
    final allergens = isSingleVariation
        ? singleSelectedAllergens
        : variationsFormEntries[index]["allergens"];

    if (allergens.contains(allergenId)) {
      allergens.remove(allergenId);
    } else {
      allergens.add(allergenId);
    }

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
  late TextEditingController descriptionController;

  String? _editDishId;

  String? get editDishId => _editDishId;

  void resetEditDishID() {
    _editDishId = null;
    notifyListeners();
  }

  void initializeAllFormControllers() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  void disposeAllFormControllers() {
    nameController.dispose();
    descriptionController.dispose();
  }

  Future<void> fetchDishes() async {
    _dishCollection = APIResponse.loading();
    notifyListeners();

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

  Future<void> initializeAddDishRequiredData() async {
    final response = await DishesService.initializeAddDishRequiredData();
    response.fold(
      (error) => Fluttertoast.showToast(msg: error.message),
      (requiredData) => _addDishInitializeData = requiredData,
    );
    notifyListeners();
  }

  Future<void> getDishDetails() async {
    if (selectedDish == null) {
      _viewDishDetails = throwNotFoundException<DishViewDetailsModel>();
      notifyListeners();
      return;
    }

    final dishId = selectedDish!.pID;
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

  Future<ResponseResult> addOrUpdateDish() async {
    try {
      if (addNewDishFormKey.currentState?.validate() == false) {
        return ResponseResult.failure;
      }

      if (_loadingDishAction) return ResponseResult.pending;

      _loadingDishAction = true;
      notifyListeners();

      final isMultiVariation = dishVariationType == DishVariationType.multiple;

      if (isMultiVariation && variationsFormEntriesEmpty) {
        showToastMessage("Variations cannot be empty");
        return ResponseResult.failure;
      }

      if (selectedDishCategories.isEmpty) {
        showToastMessage("Categories are not selected.");
        return ResponseResult.failure;
      }
      // Check dish type is empty
      if (_dishType == null) {
        showToastMessage("Dish Type (Veg or Non Veg) Field is not selected");
        return ResponseResult.failure;
      }

      // Check if variationsFormEntries has at least one entry
      final productType = !isMultiVariation ? "single" : "variation";

      // Check and initialize addonsMasterGroup
      final addonsMasterGroup = choosedMasterAddons
          .where((addon) => addon.id != null)
          .map((addon) => addon.id!)
          .toList();

      // Initialize isOnlineReq and isDineinReq based on _onlineStatus and _dineInStatus
      final isOnlineReq = _onlineStatus ? 'Yes' : 'No';
      final isDineinReq = _dineInStatus ? 'Yes' : 'No';

      // Extract values from variationsFormEntries and validate
      final priceReq = double.tryParse(singleVariationPriceController.text);

      // Initialize and validate listOfParentCategoriesId and listOfSubCategoriesId
      final listOfParentCategoriesId = choosedParentCategory
          .where((e) => e.$1 != null)
          .map((e) => e.$1!)
          .toList();
      final listOfSubCategoriesId = choosedSubCategories
          .where((e) => e.$3 != null)
          .map((e) => e.$3!)
          .toList();

      // Combine categories into listOfCategories and ensure it's not empty
      final listOfCategories = [
        ...listOfParentCategoriesId,
        ...listOfSubCategoriesId
      ];

      // Extract variations data and validate each entry
      final variations = isMultiVariation
          ? variationsFormEntries.map((entry) {
              final nameController = entry["name"] as TextEditingController;
              final price = entry["price"] as TextEditingController;
              final allergens = (entry["allergens"] as List).cast<String>();
              final ingredientsController =
                  entry["ingredients"] as TextEditingController;
              return VariationDishData(
                pvID: null,
                name: nameController.text,
                price: double.parse(price.text),
                allergensMaster: allergens,
                ingredients: ingredientsController.text,
                isUnlimitedStock: 1,
                quantity: 0,
              );
            }).toList()
          : const <VariationDishData>[];

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

      // Construct payload based on whether there's a single entry or variations
      final payload = !isMultiVariation
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
              ingredients: singleVariationIngredientsController.text,
              allergns: singleSelectedAllergens,
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
              // Ensure nameController is initialized
              description: descriptionController.text,
              category: listOfCategories,
              addonsMasterGroup: addonsMasterGroup,
              allDayAvailable: allDayAvailable,
              availability: availableDays,
              timing: timing,
              productMenuGroup: choosedMenus,
            );

      // Perform either update or addition based on editDishId
      if (editDishId != null) {
        final response = await DishesService.updateDish(
          editDishId!,
          payload,
        );

        return response.fold((error) {
          Fluttertoast.showToast(msg: error.message);
          return ResponseResult.failure;
        }, (success) {
          Fluttertoast.showToast(msg: "Dish updated successfully!");
          return ResponseResult.success;
        });
      } else {
        final response = await DishesService.addNewDish(payload);
        return response.fold((error) {
          Fluttertoast.showToast(msg: error.message);
          return ResponseResult.failure;
        }, (success) {
          Fluttertoast.showToast(msg: "Dish added successfully!");
          return ResponseResult.success;
        });
      }

      // Return success if everything goes well
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to save dish!");
      // Return failure in case of any exception
      return ResponseResult.failure;
    } finally {
      _loadingDishAction = false;
      notifyListeners();
      // Always fetch dishes after attempting to add/update
      fetchDishes();
    }
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

    // Dish Type
    final dishType = selectedDish?.type;
    _dishType = dishType;

    // Online & Dine In Status
    final onlineStatus = selectedDish?.online == "Yes";
    final dineInStatus = selectedDish?.dining == "Yes";
    _onlineStatus = onlineStatus;
    _dineInStatus = dineInStatus;

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

    final hasMultipleVariations = dishData.variationData.length > 1;

    if (hasMultipleVariations) {
      // Variation Form Entries
      final elements = dishData.variationData
          .map((variation) => {
                "pvID": variation.pvID,
                "name": TextEditingController()..text = variation.name,
                "price": TextEditingController()..text = variation.price,
                "ingredients": TextEditingController()
                  ..text = variation.ingredients,
                "isUnlimitedStock": variation.isUnlimitedStock,
                "allergens": variation.selectedallergens,
              })
          .toList();
      variationsFormEntries = List.from(elements);
      onChangeDishVariationType(DishVariationType.multiple);
    } else if (dishData.variationData.isNotEmpty) {
      final variation = dishData.variationData.first;
      singleVariationPriceController.text = variation.price;
      singleSelectedAllergens = variation.allergens.map((e) => e.id).toList();
      singleVariationIngredientsController.text = variation.ingredients;
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
    variationsFormEntries.clear();
    variationsFormEntries.add(variationFormEntry);
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

    activeDefaultSelectedInMenu();
  }
}
