import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/errors/app_exception.dart';
import 'package:gitbook_mobile/core/network/interceptors/error_interceptor.dart';

void main() {
  group('ErrorInterceptor', () {
    late ErrorInterceptor interceptor;

    setUp(() {
      interceptor = ErrorInterceptor();
    });

    group('timeout errors', () {
      test('should convert connection timeout to TimeoutException', () {
        final error = DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<TimeoutException>());
        expect((handler.lastError?.error as TimeoutException).code, 'TIMEOUT');
      });

      test('should convert send timeout to TimeoutException', () {
        final error = DioException(
          type: DioExceptionType.sendTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<TimeoutException>());
      });

      test('should convert receive timeout to TimeoutException', () {
        final error = DioException(
          type: DioExceptionType.receiveTimeout,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<TimeoutException>());
      });
    });

    group('connection errors', () {
      test('should convert SocketException to NoInternetException', () {
        final error = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/test'),
          error: const SocketException('No route to host'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NoInternetException>());
        expect((handler.lastError?.error as NoInternetException).code, 'NO_INTERNET');
      });

      test('should convert other connection errors to NetworkException', () {
        final error = DioException(
          type: DioExceptionType.connectionError,
          requestOptions: RequestOptions(path: '/test'),
          message: 'Connection failed',
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NetworkException>());
      });
    });

    group('cancelled requests', () {
      test('should convert cancelled request to NetworkException', () {
        final error = DioException(
          type: DioExceptionType.cancel,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NetworkException>());
        expect((handler.lastError?.error as NetworkException).code, 'CANCELLED');
      });
    });

    group('certificate errors', () {
      test('should convert bad certificate to NetworkException', () {
        final error = DioException(
          type: DioExceptionType.badCertificate,
          requestOptions: RequestOptions(path: '/test'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NetworkException>());
        expect((handler.lastError?.error as NetworkException).code, 'BAD_CERTIFICATE');
      });
    });

    group('unknown errors', () {
      test('should convert SocketException in unknown to NoInternetException', () {
        final error = DioException(
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(path: '/test'),
          error: const SocketException('Network unreachable'),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NoInternetException>());
      });

      test('should convert other unknown errors to UnknownException', () {
        final error = DioException(
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions(path: '/test'),
          message: 'Something went wrong',
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<UnknownException>());
      });
    });

    group('HTTP status code errors', () {
      test('should convert 400 to ValidationException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 400,
            data: {'message': 'Invalid input'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ValidationException>());
        expect((handler.lastError?.error as ValidationException).message, 'Invalid input');
      });

      test('should convert 401 to UnauthorizedException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<UnauthorizedException>());
        expect((handler.lastError?.error as UnauthorizedException).code, 'UNAUTHORIZED');
      });

      test('should convert 403 to ForbiddenException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ForbiddenException>());
        expect((handler.lastError?.error as ForbiddenException).code, 'FORBIDDEN');
      });

      test('should convert 404 to NotFoundException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 404,
            data: {'message': 'Page not found'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NotFoundException>());
        expect((handler.lastError?.error as NotFoundException).message, 'Page not found');
      });

      test('should convert 422 to ValidationException with field errors', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 422,
            data: {
              'message': 'Validation failed',
              'errors': {
                'email': ['Invalid format', 'Already exists'],
                'name': ['Required'],
              },
            },
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ValidationException>());

        final exception = handler.lastError?.error as ValidationException;
        expect(exception.message, 'Validation failed');
        expect(exception.fieldErrors?['email'], ['Invalid format', 'Already exists']);
        expect(exception.fieldErrors?['name'], ['Required']);
      });

      test('should convert 429 to NetworkException with RATE_LIMITED code', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 429,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NetworkException>());
        expect((handler.lastError?.error as NetworkException).code, 'RATE_LIMITED');
      });

      test('should convert 500 to ServerException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 500,
            data: {'message': 'Internal server error'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ServerException>());
        expect((handler.lastError?.error as ServerException).statusCode, 500);
      });

      test('should convert 502 to ServerException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 502,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ServerException>());
        expect((handler.lastError?.error as ServerException).statusCode, 502);
      });

      test('should convert 503 to ServerException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 503,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ServerException>());
        expect((handler.lastError?.error as ServerException).statusCode, 503);
      });

      test('should convert 504 to ServerException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 504,
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<ServerException>());
        expect((handler.lastError?.error as ServerException).statusCode, 504);
      });

      test('should convert unknown status code to NetworkException', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 418, // I'm a teapot
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect(handler.rejectCalled, isTrue);
        expect(handler.lastError?.error, isA<NetworkException>());
        expect((handler.lastError?.error as NetworkException).code, '418');
      });
    });

    group('error message extraction', () {
      test('should extract message from response data', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 400,
            data: {'message': 'Custom error message'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect((handler.lastError?.error as AppException).message, 'Custom error message');
      });

      test('should extract error from response data', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 400,
            data: {'error': 'Error message'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect((handler.lastError?.error as AppException).message, 'Error message');
      });

      test('should extract error_description from response data', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 400,
            data: {'error_description': 'OAuth error description'},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect((handler.lastError?.error as AppException).message, 'OAuth error description');
      });

      test('should use default message when no message in response', () {
        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/test'),
          response: Response(
            statusCode: 400,
            data: {},
            requestOptions: RequestOptions(path: '/test'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        interceptor.onError(error, handler);

        expect((handler.lastError?.error as AppException).message, 'Bad request');
      });
    });
  });
}

/// Mock handler for error interceptor using noSuchMethod
class MockErrorInterceptorHandler implements ErrorInterceptorHandler {
  bool nextCalled = false;
  bool resolveCalled = false;
  bool rejectCalled = false;
  DioException? lastError;

  @override
  void next(DioException err) {
    nextCalled = true;
    lastError = err;
  }

  @override
  void resolve(Response response) {
    resolveCalled = true;
  }

  @override
  void reject(DioException err) {
    rejectCalled = true;
    lastError = err;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
