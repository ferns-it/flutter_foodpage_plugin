import 'dart:convert';
import 'dart:developer';

import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_data.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/constants/enums.dart';
import '../../models/dishes/add_dish_initialise_data_model.dart';
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
    return DishViewDetailsModel.fromJson(dishDetailsView);
  }

  static Future<Map<String, dynamic>?> addNewDish(AddDishData data) async {
    final response = await BaseClient.post(
      api: ApiEndpoints.addNewProduct,
      needAuth: true,
      data: data.toJson(),
    );
    if (response == null) return null;
    final enCodeData = jsonDecode(response);
    return enCodeData;
  }

  static Future<Map<String, dynamic>?> updateDish(
    String dishId,
    AddDishData data,
  ) async {
    final response = await BaseClient.put(
      api: "${ApiEndpoints.updateProduct}$dishId",
      needAuth: true,
      data: data.toJson(),
    );
    if (response == null) return null;
    final enCodeData = jsonDecode(response);
    return enCodeData;
  }

  static Future<AddDishInitializeDataModel?>
      initializeAddDishRequiredData() async {
    final response = await BaseClient.get(
      api: ApiEndpoints.initialiseAddDish,
      needAuth: true,
    );
    if (response == null) return null;
    final responseData = AddDishInitializeDataModel.fromJson(response);
    return responseData;
  }

  static Future<Map<String, dynamic>?> deleteProduct(
      {required String productID}) async {
    final response = await BaseClient.delete(
      api: "${ApiEndpoints.deleteProduct}$productID",
      needAuth: true,
    );
    if (response == null) return null;
    final encodedData = jsonDecode(response);
    return encodedData;
  }

  static Future<ResponseResult> updateDishStatus(
      {required bool activeStatus, required String productID}) async {
    try {
      final response = await BaseClient.put(
        api: "${ApiEndpoints.updateProductStatus}$productID",
        needAuth: true,
        data: json.encode({"status": activeStatus ? "0" : "1"}),
      );
      if (response == null) return ResponseResult.failure;
      return ResponseResult.success;
    } on Exception catch (e) {
      log(e.toString(), name: "updateDishStatus");
      return ResponseResult.failure;
    }
  }
}
