import 'package:flutter_foodpage_plugin/menu_builder/models/common/api_response.dart';
import 'package:flutter_foodpage_plugin/menu_builder/services/app_exception/app_exception.dart';

mixin BaseController {
  void init();

  APIResponse<T> throwNotFoundException<T>() {
    return APIResponse.error(
      "The requested api data was not found.",
      exception: NotFoundException(),
    );
  }

  APIResponse<T> throwInvalidResponseFromServer<T>() {
    return APIResponse.error(
      "Invalid response from the server.",
      exception: InternalServerErrorException(),
    );
  }

  APIResponse<T> throwUnknownErrorException<T>() {
    final error = UnknwonErrorException();
    return APIResponse.error(
      error.prefix,
      exception: error,
    );
  }
}
