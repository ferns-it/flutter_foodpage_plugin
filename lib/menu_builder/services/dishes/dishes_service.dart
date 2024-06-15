import 'dart:convert';

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
}
