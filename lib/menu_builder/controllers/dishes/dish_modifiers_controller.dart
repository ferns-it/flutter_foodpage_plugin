import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';

import '../../models/modifiers/add_dish_modifiers_model.dart';
import '../../models/modifiers/dish_modifiers_collection.dart';
import '../../services/app_exception/app_exception.dart';
import '../../services/dishes/dish_modifiers_service.dart';
import '../common/base_controller.dart';

class DishModifiersController extends ChangeNotifier with BaseController {
  APIResponse<DishModifiersCollection> _modifiersCollection =
      APIResponse.initial();

  APIResponse<DishModifiersCollection> get modifiersCollection =>
      _modifiersCollection;

  int get modifiersCount =>
      _modifiersCollection.data?.masterModifiers.length ?? 0;

  List<DishModifierData> get masterModifiers =>
      modifiersCollection.data?.masterModifiers ?? [];

  DishModifierData? _selectedModifier;

  DishModifierData? get selectedModifier => _selectedModifier;

  void onChangeSelectedModifier(DishModifierData modifier) {
    _selectedModifier = modifier;
    notifyListeners();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController groupName;
  late TextEditingController minimumController;
  late TextEditingController maximumController;

  late List<Map<String, dynamic>> modifierEntries;
  void addModifierEntry() {
    modifierEntries.add(_createModifierEntry());
    notifyListeners();
  }

  Map<String, dynamic> _createModifierEntry() {
    return {
      "name": TextEditingController(),
      "price": TextEditingController(),
    };
  }

  void removeModifierEntry(int index) {
    final entry = modifierEntries.removeAt(index);

    (entry["name"] as TextEditingController).dispose();
    (entry["price"] as TextEditingController).dispose();

    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  Future<void> init() async {
    groupName = TextEditingController();
    minimumController = TextEditingController();
    maximumController = TextEditingController();
    modifierEntries = [
      _createModifierEntry(),
    ];
    listAllModifiers();
  }

  String? _editModifierId;

  bool get editMode => _editModifierId != null;

  void onPressEditButton(int index) {
    try {
      final modifier = masterModifiers.elementAt(index);
      _editModifierId = modifier.id;
      groupName.text = modifier.name;
      minimumController.text = modifier.minimumRequired;
      maximumController.text = modifier.maximumRequired;
      final elements = modifier.groupItems.map(
        (item) {
          final price = double.parse(item.price) / 100;
          return {
            "modifierId": item.id,
            "name": TextEditingController()..text = item.name,
            "price": TextEditingController()..text = price.toStringAsFixed(2),
          };
        },
      );
      modifierEntries = List.from(elements);
    } finally {
      notifyListeners();
    }
  }

  Future<void> listAllModifiers() async {
    try {
      _modifiersCollection = APIResponse.loading();
      notifyListeners();

      final response = await DishModifiersService.getModifiersList();
      _modifiersCollection = response != null
          ? APIResponse.completed(response)
          : throwNotFoundException<DishModifiersCollection>();
      notifyListeners();
    } on AppExceptions catch (error) {
      _modifiersCollection = APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      _modifiersCollection =
          throwUnknownErrorException<DishModifiersCollection>();
      notifyListeners();
    }
  }

  Future<void> addOrUpdateModifier({required VoidCallback onSuccess}) async {
    try {
      _isLoading = true;
      notifyListeners();

      if (formKey.currentState?.validate() == true) {
        final name = groupName.text.trim();
        final minimum = minimumController.text.trim();
        final maximum = maximumController.text.trim();

        final payload = AddDishModifiersModel(
          name: name,
          minimumRequired: minimum,
          maximumRequired: maximum,
          groupItems: modifierEntries.where((data) {
            final optionName =
                (data["name"] as TextEditingController).text.trim();
            final price = (data["price"] as TextEditingController).text.trim();

            // Ignore completely empty modifier rows
            return optionName.isNotEmpty || price.isNotEmpty;
          }).mapIndexed((index, data) {
            final optionName =
                (data["name"] as TextEditingController).text.trim();
            final price = (data["price"] as TextEditingController).text.trim();

            return GroupItems(
              name: optionName,
              price: price,
              status: "Active",
              sort: (index + 1).toString(),
            );
          }).toList(),
        );

        if (editMode) {
          await DishModifiersService.updateModifiers(
            _editModifierId!,
            payload,
          );
        } else {
          await DishModifiersService.addModifier(payload);
        }

        onSuccess();
        clearFormEntries();
        listAllModifiers();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> disableEnableModifier(bool status) async {
    if (_selectedModifier?.id == null) return;
    final result = await DishModifiersService.disableEnableModifiers(
      _selectedModifier!.id,
      status,
    );
    if (result == APIResultType.failed) {
      // TODO: ADD TOAST HERE
      return;
    }
  }

  void clearFormEntries() {
    for (final entry in modifierEntries) {
      (entry["name"] as TextEditingController).dispose();
      (entry["price"] as TextEditingController).dispose();
    }

    _editModifierId = null;

    groupName.clear();
    minimumController.clear();
    maximumController.clear();

    modifierEntries = [
      _createModifierEntry(),
    ];

    notifyListeners();
  }
}
