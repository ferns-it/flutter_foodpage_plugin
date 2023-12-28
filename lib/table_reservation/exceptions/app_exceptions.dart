abstract class AppExceptions implements Exception {
  final String message;
  final String prefix;

  AppExceptions({
    required this.message,
    required this.prefix,
  });
}

class ConnectionLostException extends AppExceptions {
  ConnectionLostException()
      : super(
          message: 'Check your connection and try again.',
          prefix: 'No Internet Connection',
        );
}

class TimeOutException extends AppExceptions {
  TimeOutException()
      : super(
          message: "Network is slow, So that the connection time is out",
          prefix: 'No Internet Connection',
        );
}

class InvalidRequest extends AppExceptions {
  InvalidRequest({required String message})
      : super(
          message: message,
          prefix: "Invalid Credentials",
        );
}

class TokenExpiredException extends AppExceptions {
  TokenExpiredException()
      : super(
          message: "Your session expired. Please login again.",
          prefix: "Error",
        );
}

class BadRequestException extends AppExceptions {
  BadRequestException()
      : super(
          message: 'Something went wrong, Please try again.',
          prefix: 'Unable To Process',
        );
}

class NotFoundException extends AppExceptions {
  NotFoundException({required String message})
      : super(message: message, prefix: 'Unable To Process');
}

class FetchDataException extends AppExceptions {
  FetchDataException({required String message})
      : super(message: message, prefix: 'Unable to Process');
}

class ApiNotRespondingException extends AppExceptions {
  ApiNotRespondingException({required String message})
      : super(message: message, prefix: 'Api not responding');
}

class UnAuthorizedException extends AppExceptions {
  UnAuthorizedException({required String message})
      : super(message: message, prefix: 'Bad Request');
}

class InternalServerException extends AppExceptions {
  InternalServerException({required String message})
      : super(message: message, prefix: 'Internal Server Exception');
}
