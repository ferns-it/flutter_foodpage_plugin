import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
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

  int _selectedDishIndex = -1;
  int get selectedDishIndex => _selectedDishIndex;

  DishDetails? get selectedDish => _selectedDishIndex != -1
      ? _dishCollection.data!.dishes.elementAt(_selectedDishIndex)
      : null;

  @override
  void init() {
    fetchDishes();
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
      _viewDishDetails = response != null
          ? APIResponse.completed(response)
          : throwNotFoundException<DishViewDetailsModel>();
      notifyListeners();
    } on AppExceptions catch (error) {
      _viewDishDetails = APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      _viewDishDetails = throwUnknownErrorException<DishViewDetailsModel>();
      notifyListeners();
    }
  }
}
