import 'package:flutter/foundation.dart';
import 'package:flutter_foodpage_plugin/menu_builder/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';

import '../../models/modifiers/dish_modifiers_collection.dart';
import '../../services/app_exception/app_exception.dart';
import '../../services/dishes/dish_modifiers_service.dart';
import '../common/base_controller.dart';

class DishModifiersController extends ChangeNotifier with BaseController {
  APIResponse<DishModifiersCollection> _modifiersCollection =
      APIResponse.initial();

  APIResponse<DishModifiersCollection> get modifiersCollection =>
      _modifiersCollection;

  DishModifierData? _selectedModifier;
  DishModifierData? get selectedModifier => _selectedModifier;

  void onChangeSelectedModifier(DishModifierData modifier) {
    _selectedModifier = modifier;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    listAllModifiers();
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

  Future<void> addModifier() async {
    // final payload = AddDishModifiersModel(name: name, groupItems: GroupItems(name:
    // , price: price, status: status, sort: sort),);
    // await DishModifiersService.addModifier(payload);
  }

  Future<void> updateModifier() async {
    // final payload = AddDishModifiersModel(name: name, groupItems: GroupItems(name:
    // , price: price, status: status, sort: sort),);
    // await DishModifiersService.updateModifiers(payload);
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
}
