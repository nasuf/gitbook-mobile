import 'dart:io';

import 'package:dio/dio.dart';

import '../../errors/app_exception.dart';

/// Interceptor for handling and transforming errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _handleError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  AppException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return const NoInternetException();
        }
        return NetworkException(
          message: 'Connection error: ${error.message}',
          originalError: error,
        );

      case DioExceptionType.badResponse:
        return _handleResponseError(error);

      case DioExceptionType.cancel:
        return const NetworkException(
          message: 'Request was cancelled',
          code: 'CANCELLED',
        );

      case DioExceptionType.badCertificate:
        return const NetworkException(
          message: 'Invalid SSL certificate',
          code: 'BAD_CERTIFICATE',
        );

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return const NoInternetException();
        }
        return UnknownException(
          message: error.message ?? 'An unknown error occurred',
          originalError: error,
        );
    }
  }

  AppException _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // Try to extract error message from response
    String? errorMessage;
    String? errorCode;

    if (data is Map<String, dynamic>) {
      errorMessage = data['message'] as String? ??
          data['error'] as String? ??
          data['error_description'] as String?;
      errorCode = data['code'] as String?;
    }

    switch (statusCode) {
      case 400:
        return ValidationException(
          message: errorMessage ?? 'Bad request',
          code: errorCode,
          originalError: error,
        );

      case 401:
        return const UnauthorizedException();

      case 403:
        return const ForbiddenException();

      case 404:
        return NotFoundException(
          message: errorMessage ?? 'Resource not found',
          originalError: error,
        );

      case 422:
        // Validation errors
        Map<String, List<String>>? fieldErrors;
        if (data is Map<String, dynamic> && data['errors'] is Map) {
          fieldErrors = (data['errors'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
              key,
              (value as List).map((e) => e.toString()).toList(),
            ),
          );
        }
        return ValidationException(
          message: errorMessage ?? 'Validation failed',
          fieldErrors: fieldErrors,
          originalError: error,
        );

      case 429:
        return const NetworkException(
          message: 'Too many requests. Please try again later.',
          code: 'RATE_LIMITED',
        );

      case 500:
      case 501:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: errorMessage ?? 'Server error occurred',
          statusCode: statusCode,
          originalError: error,
        );

      default:
        return NetworkException(
          message: errorMessage ?? 'Request failed with status $statusCode',
          code: statusCode?.toString(),
          originalError: error,
        );
    }
  }
}
