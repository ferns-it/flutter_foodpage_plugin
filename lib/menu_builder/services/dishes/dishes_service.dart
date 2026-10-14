import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
          ? const Right(ResponseResult.success)
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

  // Add new dish with photo upload (FormData)
  // static Future<Either<AppExceptions, Map<String, dynamic>>>
  //     addNewDishWithPhoto(
  //   AddDishData data,
  //   String? photoPath,
  // ) async {
  //   try {
  //     // If no photo path, use regular addNewDish
  //     if (photoPath == null || photoPath.isEmpty) {
  //       return addNewDish(data);
  //     }

  //     final formData = await _buildFormDataFromDishData(data, photoPath);
  //     log('Uploading with FormData - fields: ${formData.fields.length}, files: ${formData.files.length}',
  //         name: "addNewDishWithPhoto");

  //     final response = await BaseClient.postFormData(
  //       api: ApiEndpoints.addNewProduct,
  //       needAuth: true,
  //       data: formData,
  //     );

  //     log('Response received: $response', name: "addNewDishWithPhoto");
  //     if (response == null) {
  //       log('Response is null', name: "addNewDishWithPhoto");
  //       return Left(InternalServerErrorException());
  //     }

  //     final enCodeData = jsonDecode(response);
  //     log('Decoded response: $enCodeData', name: "addNewDishWithPhoto");
  //     return Right(enCodeData);
  //   } on DioException catch (e) {
  //     log('DioException: ${e.message}, Response: ${e.response?.data}',
  //         name: "addNewDishWithPhoto");
  //     return Left(e.error is AppExceptions
  //         ? e.error as AppExceptions
  //         : InternalServerErrorException());
  //   } catch (e) {
  //     log('Exception: $e', name: "addNewDishWithPhoto");
  //     return Left(InternalServerErrorException());
  //   }
  // }

  // Update dish with photo upload (FormData)
  // static Future<Either<AppExceptions, Map<String, dynamic>>>
  //     updateDishWithPhoto(
  //   String dishId,
  //   AddDishData data,
  //   String? photoPath,
  // ) async {
  //   try {
  //     // If no photo path, use regular updateDish
  //     if (photoPath == null || photoPath.isEmpty) {
  //       return updateDish(dishId, data);
  //     }

  //     final formData = await _buildFormDataFromDishData(data, photoPath);

  //     final response = await BaseClient.putFormData(
  //       api: "${ApiEndpoints.updateProduct}$dishId",
  //       needAuth: true,
  //       data: formData,
  //     );
  //     if (response == null) return Left(InternalServerErrorException());

  //     final enCodeData = jsonDecode(response);
  //     return Right(enCodeData);
  //   } on DioException catch (e) {
  //     return Left(e.error is AppExceptions
  //         ? e.error as AppExceptions
  //         : InternalServerErrorException());
  //   } catch (e) {
  //     log(e.toString(), name: "updateDishWithPhoto");
  //     return Left(InternalServerErrorException());
  //   }
  // }

  // Recursively flattens maps/lists into bracket-notation form fields
  // static void _addField(
  //   List<MapEntry<String, String>> fields,
  //   String key,
  //   dynamic value,
  // ) {
  //   if (value == null) return;

  //   if (value is Map) {
  //     value.forEach((k, v) => _addField(fields, '$key[$k]', v));
  //   } else if (value is List) {
  //     for (var i = 0; i < value.length; i++) {
  //       _addField(fields, '$key[$i]', value[i]);
  //     }
  //   } else {
  //     fields.add(MapEntry(key, value.toString()));
  //   }
  // }

  // static Future<FormData> _buildFormDataFromDishData(
  //   AddDishData data,
  //   String photoPath,
  // ) async {
  //   final dataMap =
  //       jsonDecode(jsonEncode(data.toMap())) as Map<String, dynamic>;

  //   final formData = FormData();

  //   for (final entry in dataMap.entries) {
  //     if (entry.key == 'photo') continue; // sent as a file below
  //     _addField(formData.fields, entry.key, entry.value);
  //   }

  //   final file = File(photoPath);
  //   if (await file.exists()) {
  //     formData.files.add(MapEntry(
  //       'photo',
  //       await MultipartFile.fromFile(
  //         photoPath,
  //         filename: photoPath.split(Platform.pathSeparator).last,
  //       ),
  //     ));
  //   } else {
  //     log('Photo file does not exist: $photoPath', name: "FormDataBuilder");
  //   }

  //   log(
  //     'FormData fields: ${formData.fields}',
  //     name: "FormDataBuilder",
  //   );

  //   for (final entry in formData.files) {
  //     log(
  //       'File field: ${entry.key}, filename: ${entry.value.filename}',
  //       name: "FormDataBuilder",
  //     );
  //   }

  //   return formData;
  // }
}
