import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_foodpage_plugin/table_reservation/constants/api_endpoints.dart';

import '../table_reservation/exceptions/app_exceptions.dart';

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
        onResponse: responseInterceptorHandler,
        // onError: errorResponseHandler,
      ),
    );

  static void responseInterceptorHandler(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final data = response.data;
    final res = jsonDecode(data);
    response.data = jsonEncode(res['data']);
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

    const authKey = '5521bacd985f98bbcb30c9e0f1a242ae';

    final response = await dio.get<String>(
      url,
      queryParameters: queryParameters,
      options: Options(headers: {"x-shopToken": authKey}),
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
    const authKey = '5521bacd985f98bbcb30c9e0f1a242ae';

    final response = await dio.post<String>(
      api,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: {"x-shopToken": authKey}),
    );
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
    Map<String, dynamic>? additionalHeaders,
  }) async {
    const authKey = '5521bacd985f98bbcb30c9e0f1a242ae';

    // Prepare headers with the additional headers if not null
    Map<String, dynamic> headers = {"x-shopToken": authKey};
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    final response = await dio.put<String>(
      api + params,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers), // Use the prepared headers
    );

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
