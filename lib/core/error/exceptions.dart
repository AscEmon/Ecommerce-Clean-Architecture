/// Base exception class for the application
class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException({required this.message, this.statusCode});

  @override
  String toString() =>
      statusCode != null ? message : '$message (Status Code: $statusCode)';
}

/// Server exception for API errors
class ServerException extends AppException {
  ServerException({required super.message, super.statusCode});
}

/// Cache exception for local storage errors
class CacheException extends AppException {
  CacheException({required super.message, super.statusCode});
}

/// Network exception for connectivity issues
class NetworkException extends AppException {
  NetworkException({required super.message, super.statusCode});
}

/// Authentication exception for auth-related errors
class AuthenticationException extends AppException {
  AuthenticationException({required super.message, super.statusCode});
}

/// Validation exception for input validation errors
class ValidationException extends AppException {
  ValidationException({required super.message, super.statusCode});
}

/// Bad request exception for 400 errors
class BadRequestException extends AppException {
  BadRequestException({required super.message, super.statusCode = 400});
}

/// Unauthorized exception for 401/403 errors
class UnauthorizedException extends AppException {
  UnauthorizedException({required super.message, super.statusCode = 401});
}

/// Not found exception for 404 errors
class NotFoundException extends AppException {
  NotFoundException({required super.message, super.statusCode = 404});
}

/// Timeout exception for connection timeouts
class TimeoutException extends AppException {
  TimeoutException({required super.message, super.statusCode});
}

/// Request cancelled exception
class RequestCancelledException extends AppException {
  RequestCancelledException({required super.message, super.statusCode});
}

