import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_endpoints.dart';
import 'exceptions/app_exceptions.dart';
import 'sharedpreference/user_preference.dart';

class BaseClient {
  static const _connectionTimeOut = Duration(milliseconds: 30000);
  static const _recieveTimeOut = Duration(milliseconds: 30000);
  static ResponseType get responeType => ResponseType.json;

  static BaseOptions get _baseOptions => BaseOptions(
        connectTimeout: _connectionTimeOut,
        receiveTimeout: _recieveTimeOut,
        baseUrl: ApiEndpoints.baseUrl,
        contentType: "application/json",
        responseType: responeType,
      );

  static Dio get dio => Dio(_baseOptions)
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: requestInterceptorHandler,
        onResponse: responseInterceptorHandler,
        onError: errorResponseHandler,
      ),
    );

  static void requestInterceptorHandler(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final needAuth = (options.headers["needToken"] as bool);
    if (!needAuth) return handler.next(options);
    final user = await UserPreference.readUserData();
    if (user == null || user.token == null) {
      return handler.reject(
        DioError(requestOptions: options, error: "User not authenticated"),
      );
    }

    options.headers.remove("needToken");
    // options.headers.addAll({"x-user": user.token});
    options.headers.addAll({"Authorization": 'Bearer ${user.token}'});

    handler.next(options);
  }

  static void responseInterceptorHandler(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final data = response.data;
    final res = jsonDecode(data);
    final error = res is List && res.isNotEmpty ? false : res['error'];

    if (error == true || error is int) {
      final errMsg = res['error'];

      return handler.reject(DioException(
        requestOptions: response.requestOptions,
        error: InvalidRequest(message: errMsg),
        type: DioErrorType.badResponse,
      ));
    }
    return handler.next(response);
  }

  static void errorResponseHandler(
    DioException error,
    ErrorInterceptorHandler handler,
  ) {
    final response = error.response?.data;
    final status = error.response?.statusCode ?? 500;
    final errorObject = response is String ? jsonDecode(response) : null;

    String? message;

    if (errorObject is Map<String, dynamic>) {
      message =
          errorObject["messages"]["error"] ?? errorObject['No order found'];
    }

    if (error.error is SocketException) {
      throw ConnectionLostException();
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      throw TimeOutException();
    }

    switch (status) {
      //unauthorized
      case 401:
        throw TokenExpiredException();
      //forbidden
      case 403:
        throw UnAuthorizedException(
          message: message ??
              "Sorry, you are not authorized to access this resource.",
        );
      //not found
      case 404:
        throw NotFoundException(
          message: message ?? "Oops, we couldn't find your request.",
        );
      default:
        throw InternalServerException(
          message:
              message ?? "Oops, something went wrong. Please try again later.",
        );
    }
  }

  //GET
  static Future<String?> get({
    bool needAuth = false,
    String? baseUrl,
    required String api,
    String params = '',
    Map<String, dynamic>? queryParameters,
  }) async {
    final url = baseUrl != null ? baseUrl + api + params : api + params;

    final response = await dio.get<String>(
      url,
      queryParameters: queryParameters,
      options: Options(headers: {"needToken": needAuth}),
    );
    return response.data;
  }

  //POST
  static Future<String?> post({
    bool needAuth = false,
    String? baseUrl,
    required String api,
    required Object data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post<String>(api,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {"needToken": needAuth}));
    return response.data;
  }

  //PUT
  static Future<String?> put({
    bool needAuthentication = false,
    String? baseUrl,
    required String api,
    String params = '',
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.put<String>(api + params,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {'needToken': needAuthentication}));
    return response.data;
  }

  //DELETE
  static Future<String?> delete({
    bool needAuthentication = false,
    String? baseUrl,
    required String api,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.delete<String>(
      api,
      data: data,
      queryParameters: queryParameters,
    );
    return response.data;
  }
}
