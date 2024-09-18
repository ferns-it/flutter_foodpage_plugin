import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/enums.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/category_data_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/app_exception/app_exception.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';
import 'package:fpdart/fpdart.dart';

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

  static Future<Either<AppExceptions, CategorySuccessResponse>> addNewCategory({
    required String name,
    required String description,
    required String parentId,
  }) async {
    final payload = {
      "name": name,
      "description": description,
      "parentId": parentId,
    };

    try {
      final response = await BaseClient.post(
        api: ApiEndpoints.addNewCategory,
        data: payload,
        needAuth: true,
      );

      return response != null
          ? Right(CategorySuccessResponse.fromJson(response))
          : Left(InternalServerErrorException());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, APIResultType>> updateCategory({
    required String name,
    required String description,
    required String cID,
  }) async {
    final payload = {
      "name": name,
      "description": description,
    };

    try {
      final response = await BaseClient.put(
        api: ApiEndpoints.updateCategory,
        params: cID,
        data: payload,
        needAuth: true,
      );

      return response != null
          ? const Right(APIResultType.success)
          : Left(InternalServerErrorException());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (e) {
      log(e.toString(), name: "updateExistingCategory");
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, APIResultType>> disableEnableCategory(
      String cID, String status) async {
    try {
      final response = await BaseClient.put(
        api: ApiEndpoints.statusUpdateCategory,
        params: cID,
        needAuth: true,
        data: jsonEncode({"status": status}),
      );

      return response != null
          ? const Right(APIResultType.success)
          : Left(InternalServerErrorException());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (e) {
      log(e.toString(), name: "disableEnableCategory");
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, APIResultType>> updateCategorySortOrder(
      String cID, int newOrderIndex) async {
    try {
      final response = await BaseClient.post(
        api: ApiEndpoints.updateCategorySortOrder,
        needAuth: true,
        data: jsonEncode({
          "categorylist": [
            {"categoryId": cID, "sortOrder": newOrderIndex}
          ]
        }),
      );

      return response != null
          ? const Right(APIResultType.success)
          : Left(InternalServerErrorException());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (e) {
      log(e.toString(), name: "updateCategorySortOrder");
      return Left(InternalServerErrorException());
    }
  }
}
