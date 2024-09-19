import 'package:dio/dio.dart';
import 'package:flutter_foodpage_plugin/menu_builder/core/constants/api_endpoints.dart';
import 'package:flutter_foodpage_plugin/menu_builder/models/auth/auth_token_data.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/app_exception/app_exception.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/base_client.dart';
import 'package:fpdart/fpdart.dart';

import '../../models/common/menu_builder_config.dart';

class AuthService {
  static Future<Either<AppExceptions, AuthTokenData>> getAccessToken(
      MenuBuilderConfig config) async {
    try {
      final response = await BaseClient.post(
        api: ApiEndpoints.getToken,
        dataKeyChecking: false,
        needAuth: false,
        mode: config.mode,
        data: {"secretkey": config.authenticationKey},
      );
      if (response == null) return Left(InternalServerErrorException());
      return Right(
          AuthTokenData.fromJson(response).copyWith(mode: config.mode));
    } on DioException catch (e) {
      return Left(e.error is AppExceptions
          ? e.error as AppExceptions
          : InternalServerErrorException());
    } catch (_) {
      return Left(InternalServerErrorException());
    }
  }
}
