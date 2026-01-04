/// Base exception class for the app
sealed class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Network related exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// No internet connection
class NoInternetException extends NetworkException {
  const NoInternetException()
      : super(
          message: 'No internet connection',
          code: 'NO_INTERNET',
        );
}

/// Request timeout
class TimeoutException extends NetworkException {
  const TimeoutException()
      : super(
          message: 'Request timed out',
          code: 'TIMEOUT',
        );
}

/// Server error (5xx)
class ServerException extends NetworkException {
  final int? statusCode;

  const ServerException({
    super.message = 'Server error occurred',
    super.code = 'SERVER_ERROR',
    this.statusCode,
    super.originalError,
  });
}

/// Authentication exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Unauthorized (401)
class UnauthorizedException extends AuthException {
  const UnauthorizedException()
      : super(
          message: 'Unauthorized. Please login again.',
          code: 'UNAUTHORIZED',
        );
}

/// Forbidden (403)
class ForbiddenException extends AuthException {
  const ForbiddenException()
      : super(
          message: 'You do not have permission to access this resource.',
          code: 'FORBIDDEN',
        );
}

/// Token expired
class TokenExpiredException extends AuthException {
  const TokenExpiredException()
      : super(
          message: 'Session expired. Please login again.',
          code: 'TOKEN_EXPIRED',
        );
}

/// Resource not found (404)
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
    super.originalError,
  });
}

/// Validation error
class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    this.fieldErrors,
    super.originalError,
  });
}

/// Cache related exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code = 'CACHE_ERROR',
    super.originalError,
  });
}

/// Unknown error
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unknown error occurred',
    super.code = 'UNKNOWN',
    super.originalError,
  });
}
