// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../core/constants/enums.dart';
import '../../services/app_exception/app_exception.dart';

class APIResponse<T> {
  APIResponseStatus? status;
  T? data;
  String? message;
  AppExceptions? exception;

  APIResponse(this.status, this.data, this.message);

  APIResponse.initial() : status = APIResponseStatus.initial;

  APIResponse.loading() : status = APIResponseStatus.loading;

  factory APIResponse.completed(T? data) {
    if (data == null) {
      throw GenericAppException(
        prefix: 'Data is null when completed',
        message: 'Data cannot be null in completed state',
      );
    }
    return APIResponse<T>(
      APIResponseStatus.completed,
      data,
      null,
    );
  }

  APIResponse.error(this.message, {this.exception})
      : status = APIResponseStatus.error;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) completed,
    required R Function(String? message, AppExceptions? exceptions) error,
  }) {
    switch (status) {
      case APIResponseStatus.initial:
        return initial();
      case APIResponseStatus.loading:
        return loading();
      case APIResponseStatus.completed:
        return completed(data as T);
      case APIResponseStatus.error:
        return error(message, exception);
      default:
        throw GenericAppException(
          prefix: 'Unhandled API Response Status',
          message: 'Unhandled APIResponseStatus: $status',
        );
    }
  }

  @override
  String toString() =>
      'APIResponse(data: $data, message: $message, status: $status)';

  @override
  bool operator ==(covariant APIResponse<T> other) {
    if (identical(this, other)) return true;

    return other.data == data && other.message == message;
  }

  @override
  int get hashCode => data.hashCode ^ message.hashCode;
}
