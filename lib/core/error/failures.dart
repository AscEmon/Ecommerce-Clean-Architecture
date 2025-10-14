import 'package:equatable/equatable.dart';
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server failures for API errors
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Cache failures for local storage errors
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});
}

/// Network failures for connectivity issues
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});
}

/// Authentication failures for auth-related errors
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required super.message, super.statusCode});
}

/// Validation failures for input validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.statusCode});
}

