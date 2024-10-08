import 'dart:convert';
import 'dart:developer';

import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/category_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';

import '../../core/constants/api_endpoints.dart';
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

  static Future<APIResultType> updateCategory({
    required String name,
    required String description,
    required String cID,
  }) async {
    try {
      final payload = {
        "name": name,
        "description": description,
      };
      final response = await BaseClient.put(
        api: ApiEndpoints.updateCategory,
        params: cID,
        data: payload,
        needAuth: true,
      );
      if (response == null) return APIResultType.failed;
      return APIResultType.success;
    } on Exception catch (e) {
      log(e.toString(), name: "updateExistingCategory");
      return APIResultType.failed;
    }
  }

  static Future<APIResultType> disableEnableCategory(
      String cID, String status) async {
    try {
      final response = await BaseClient.put(
        api: ApiEndpoints.statusUpdateCategory,
        params: cID,
        data: jsonEncode({"status": status}),
      );
      if (response == null) return APIResultType.failed;
      return APIResultType.success;
    } on Exception catch (e) {
      log(e.toString(), name: "disableEnableCategory");
      return APIResultType.failed;
    }
  }
}
