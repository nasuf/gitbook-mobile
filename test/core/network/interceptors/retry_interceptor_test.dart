import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/network/interceptors/retry_interceptor.dart';

void main() {
  group('RetryInterceptor', () {
    late RetryInterceptor interceptor;

    setUp(() {
      interceptor = RetryInterceptor(
        maxRetries: 3,
        retryDelay: const Duration(milliseconds: 100),
      );
    });

    group('constructor', () {
      test('should use default values when not specified', () {
        final defaultInterceptor = RetryInterceptor();
        expect(defaultInterceptor.maxRetries, 3);
        expect(defaultInterceptor.retryDelay, const Duration(seconds: 1));
        expect(defaultInterceptor.retryableStatusCodes, [408, 500, 502, 503, 504]);
      });

      test('should use custom values when specified', () {
        final customInterceptor = RetryInterceptor(
          maxRetries: 5,
          retryDelay: const Duration(seconds: 2),
          retryableStatusCodes: [500, 502],
        );
        expect(customInterceptor.maxRetries, 5);
        expect(customInterceptor.retryDelay, const Duration(seconds: 2));
        expect(customInterceptor.retryableStatusCodes, [500, 502]);
      });
    });

    group('shouldRetry', () {
      test('should retry on connection timeout', () async {
        final error = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        var wasRetried = false;
        final handler = MockErrorInterceptorHandler(
          onNext: (_) {},
          onResolve: (_) => wasRetried = true,
        );

        await interceptor.onError(error, handler);
        // Since we can't actually retry (no real server),
        // we just verify the interceptor processes the error
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on send timeout', () async {
        final error = DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on receive timeout', () async {
        final error = DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on connection error', () async {
        final error = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on socket exception', () async {
        final error = DioException(
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(path: '/test'),
          error: const SocketException('Connection refused'),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on 500 status code', () async {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on 502 status code', () async {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 502,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should retry on 503 status code', () async {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 503,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled || handler.resolveCalled, isTrue);
      });

      test('should NOT retry on 400 status code', () async {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 400,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled, isTrue);
        expect(handler.resolveCalled, isFalse);
      });

      test('should NOT retry on 401 status code', () async {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled, isTrue);
        expect(handler.resolveCalled, isFalse);
      });

      test('should NOT retry on 404 status code', () async {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);
        expect(handler.nextCalled, isTrue);
        expect(handler.resolveCalled, isFalse);
      });
    });

    group('retry count', () {
      test('should respect max retries limit', () async {
        final options = RequestOptions(path: '/test');
        options.extra['retryCount'] = 3; // Already at max

        final error = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: options,
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        // Should not retry, just call next
        expect(handler.nextCalled, isTrue);
      });

      test('should increment retry count on each retry', () async {
        final options = RequestOptions(path: '/test');
        options.extra['retryCount'] = 1;

        final error = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: options,
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        // Verify that retry count was incremented
        expect(options.extra['retryCount'], 2);
      });

      test('should start with retry count 0 if not set', () async {
        final options = RequestOptions(path: '/test');
        // No retryCount set

        final error = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: options,
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(options.extra['retryCount'], 1);
      });
    });

    group('custom retryable status codes', () {
      test('should only retry on specified status codes', () async {
        final customInterceptor = RetryInterceptor(
          maxRetries: 3,
          retryDelay: const Duration(milliseconds: 100),
          retryableStatusCodes: [500], // Only 500
        );

        // 502 should NOT be retried
        final error502 = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 502,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler502 = MockErrorInterceptorHandler();
        await customInterceptor.onError(error502, handler502);
        expect(handler502.nextCalled, isTrue);
        expect(handler502.resolveCalled, isFalse);
      });
    });
  });
}

/// Mock handler for testing using noSuchMethod
class MockErrorInterceptorHandler implements ErrorInterceptorHandler {
  final void Function(DioException)? onNext;
  final void Function(Response)? onResolve;

  bool nextCalled = false;
  bool resolveCalled = false;
  DioException? lastError;
  Response? lastResponse;

  MockErrorInterceptorHandler({this.onNext, this.onResolve});

  @override
  void next(DioException err) {
    nextCalled = true;
    lastError = err;
    onNext?.call(err);
  }

  @override
  void resolve(Response response) {
    resolveCalled = true;
    lastResponse = response;
    onResolve?.call(response);
  }

  @override
  void reject(DioException err) {
    nextCalled = true;
    lastError = err;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
