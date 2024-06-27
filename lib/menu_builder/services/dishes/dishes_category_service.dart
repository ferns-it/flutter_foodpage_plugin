import 'dart:convert';

import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/category_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

import '../../constants/api_endpoints.dart';
import '../../models/dishes/category_success_response.dart';

class DishesCategoryService {
  static Future<DishCategoryCollectionModel?> fetchCategoryList({
    required String id,
    bool developmentURL = true,
  }) async {
    final categoryListJsonResponse = await BaseClient.get(
      baseUrl: !developmentURL
          ? ApiEndpoints.productionUrl2
          : ApiEndpoints.developmentUrl2,
      api: ApiEndpoints.categoryList,
      params: '$id-SHOP',
      dataKey: "data",
      dataKeyChecking: true,
    );
    if (categoryListJsonResponse == null) return null;
    final categories =
        (jsonDecode(categoryListJsonResponse)["items"] as List).map((e) {
      return CategoryDataModel.fromMap(e);
    }).toList();
    return DishCategoryCollectionModel(categories: categories);
  }

  static Future<CategorySuccessResponse?> addNewCategory({
    required String name,
    required String description,
    required String parentId,
  }) async {
    final payload = {
      "name": name,
      "description": description,
      "parentId": parentId,
    };
    final response = await BaseClient.post(
      api: ApiEndpoints.addNewCategory,
      data: payload,
      needAuth: true,
    );
    if (response == null) return null;
    return CategorySuccessResponse.fromJson(response);
  }
}
