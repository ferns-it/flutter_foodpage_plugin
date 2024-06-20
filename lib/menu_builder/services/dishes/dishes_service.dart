import 'dart:convert';
import 'dart:developer';

import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

import '../../constants/api_endpoints.dart';
import '../../models/dishes/dish_collection_model.dart';

class DishesService {
  static Future<DishCollectionModel?> getDishesList() async {
    final productsListJsonResponse = await BaseClient.get(
      needAuth: true,
      api: ApiEndpoints.products,
    );
    if (productsListJsonResponse == null) return null;
    final dishes = (jsonDecode(productsListJsonResponse) as List).map((e) {
      return DishDetails.fromMap(e);
    }).toList();
    return DishCollectionModel(dishes: dishes);
  }

  static Future<DishViewDetailsModel?> getDishDetails(String dishId) async {
    final dishDetailsView = await BaseClient.get(
      needAuth: true,
      api: ApiEndpoints.productDetailsView + dishId,
      dataKeyChecking: true,
      dataKey: "productData",
    );
    if (dishDetailsView == null) return null;
    inspect(jsonDecode(dishDetailsView));
    return DishViewDetailsModel.fromJson(dishDetailsView);
  }
}
