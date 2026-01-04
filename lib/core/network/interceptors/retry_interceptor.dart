import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

/// Interceptor for retrying failed requests
class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration retryDelay;
  final List<int> retryableStatusCodes;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.retryableStatusCodes = const [408, 500, 502, 503, 504],
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final shouldRetry = _shouldRetry(err);
    final retryCount = _getRetryCount(err.requestOptions);

    if (shouldRetry && retryCount < maxRetries) {
      await _retry(err, handler, retryCount);
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    // Retry on connection errors
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }

    // Retry on specific status codes
    if (err.response != null &&
        retryableStatusCodes.contains(err.response!.statusCode)) {
      return true;
    }

    // Retry on socket exceptions
    if (err.error is SocketException) {
      return true;
    }

    return false;
  }

  int _getRetryCount(RequestOptions options) {
    return options.extra['retryCount'] as int? ?? 0;
  }

  Future<void> _retry(
    DioException err,
    ErrorInterceptorHandler handler,
    int retryCount,
  ) async {
    final delay = retryDelay * (retryCount + 1); // Exponential backoff
    await Future.delayed(delay);

    final options = err.requestOptions;
    options.extra['retryCount'] = retryCount + 1;

    try {
      final dio = Dio();
      final response = await dio.fetch(options);
      handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        handler.next(e);
      } else {
        handler.next(
          DioException(
            requestOptions: options,
            error: e,
          ),
        );
      }
    }
  }
}
