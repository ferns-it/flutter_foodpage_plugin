import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/add_dish_data.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/dishes/dish_view_details_model.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/constants/enums.dart';
import '../../models/dishes/add_dish_initialise_data_model.dart';
import '../../models/dishes/dish_collection_model.dart';
import '../app_exception/app_exception.dart';

class DishesService {
  static Future<Either<AppExceptions, DishCollectionModel>>
      getDishesList() async {
    try {
      final productsListJsonResponse = await BaseClient.get(
        needAuth: true,
        api: ApiEndpoints.products,
      );
      if (productsListJsonResponse == null) {
        return Left(InternalServerErrorException());
      }

      final dishes = (jsonDecode(productsListJsonResponse) as List).map((e) {
        return DishDetails.fromMap(e);
      }).toList();
      return Right(DishCollectionModel(dishes: dishes));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, DishViewDetailsModel>> getDishDetails(
      String dishId) async {
    try {
      final dishDetailsView = await BaseClient.get(
        needAuth: true,
        api: ApiEndpoints.productDetailsView + dishId,
        dataKeyChecking: true,
        dataKey: "productData",
      );
      if (dishDetailsView == null) return Left(InternalServerErrorException());

      return Right(DishViewDetailsModel.fromJson(dishDetailsView));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, Map<String, dynamic>>> addNewDish(
      AddDishData data) async {
    try {
      final response = await BaseClient.post(
        api: ApiEndpoints.addNewProduct,
        needAuth: true,
        data: data.toJson(),
      );
      if (response == null) return Left(InternalServerErrorException());

      final enCodeData = jsonDecode(response);
      return Right(enCodeData);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, Map<String, dynamic>>> updateDish(
    String dishId,
    AddDishData data,
  ) async {
    try {
      final response = await BaseClient.put(
        api: "${ApiEndpoints.updateProduct}$dishId",
        needAuth: true,
        data: data.toJson(),
      );
      if (response == null) return Left(InternalServerErrorException());

      final enCodeData = jsonDecode(response);
      return Right(enCodeData);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, AddDishInitializeDataModel>>
      initializeAddDishRequiredData() async {
    try {
      final response = await BaseClient.get(
        api: ApiEndpoints.initialiseAddDish,
        needAuth: true,
      );
      if (response == null) return Left(InternalServerErrorException());

      final responseData = AddDishInitializeDataModel.fromJson(response);
      return Right(responseData);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, Map<String, dynamic>>> deleteProduct({
    required String productID,
  }) async {
    try {
      final response = await BaseClient.delete(
        api: "${ApiEndpoints.deleteProduct}$productID",
        needAuth: true,
      );
      if (response == null) return Left(InternalServerErrorException());

      final encodedData = jsonDecode(response);
      return Right(encodedData);
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }

  static Future<Either<AppExceptions, ResponseResult>> updateDishStatus({
    required bool activeStatus,
    required String productID,
  }) async {
    try {
      final response = await BaseClient.put(
        api: "${ApiEndpoints.updateProductStatus}$productID",
        needAuth: true,
        data: json.encode({"status": activeStatus ? "0" : "1"}),
      );
      return response != null
          ? Right(ResponseResult.success)
          : Left(InternalServerErrorException());
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (e) {
      log(e.toString(), name: "updateDishStatus");
      return Left(InternalServerErrorException());
    }
  }
}
