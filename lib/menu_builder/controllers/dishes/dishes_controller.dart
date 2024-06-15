import 'package:flutter/material.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/dishes/dishes_service.dart';

import '../../models/dishes/dish_collection_model.dart';
import '../../services/app_exception/app_exception.dart';
import '../common/base_controller.dart';

class DishesController extends ChangeNotifier with BaseController {
  APIResponse<DishCollectionModel> dishCollection = APIResponse.initial();

  @override
  void init() {
    fetchDishes();
  }

  Future<void> fetchDishes() async {
    try {
      dishCollection = APIResponse.loading();
      notifyListeners();

      final response = await DishesService.getDishesList();

      dishCollection = response != null
          ? APIResponse.completed(response)
          : throwNotFoundException<DishCollectionModel>();

      notifyListeners();
    } on AppExceptions catch (error) {
      dishCollection = APIResponse.error(error.message, exception: error);
      notifyListeners();
    } catch (e) {
      dishCollection = throwUnknownErrorException<DishCollectionModel>();
      notifyListeners();
    }
  }
}
