import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/network/interceptors/auth_interceptor.dart';

import '../../../mocks/mock_token_storage.dart';

void main() {
  group('AuthInterceptor', () {
    late MockTokenStorage tokenStorage;
    late AuthInterceptor interceptor;

    setUp(() {
      tokenStorage = MockTokenStorage();
    });

    group('onRequest', () {
      test('should add Authorization header when token is available', () async {
        tokenStorage.setTokens(accessToken: 'test_token');
        interceptor = AuthInterceptor(tokenStorage: tokenStorage);

        final options = RequestOptions(path: '/orgs');
        final handler = MockRequestInterceptorHandler();

        await interceptor.onRequest(options, handler);

        expect(handler.nextCalled, isTrue);
        expect(options.headers['Authorization'], 'Bearer test_token');
      });

      test('should not add Authorization header when token is null', () async {
        tokenStorage.setTokens(accessToken: null);
        interceptor = AuthInterceptor(tokenStorage: tokenStorage);

        final options = RequestOptions(path: '/orgs');
        final handler = MockRequestInterceptorHandler();

        await interceptor.onRequest(options, handler);

        expect(handler.nextCalled, isTrue);
        expect(options.headers['Authorization'], isNull);
      });

      test('should not add Authorization header when token is empty', () async {
        tokenStorage.setTokens(accessToken: '');
        interceptor = AuthInterceptor(tokenStorage: tokenStorage);

        final options = RequestOptions(path: '/orgs');
        final handler = MockRequestInterceptorHandler();

        await interceptor.onRequest(options, handler);

        expect(handler.nextCalled, isTrue);
        expect(options.headers['Authorization'], isNull);
      });

      test('should skip auth for oauth/token endpoint', () async {
        tokenStorage.setTokens(accessToken: 'test_token');
        interceptor = AuthInterceptor(tokenStorage: tokenStorage);

        final options = RequestOptions(path: '/oauth/token');
        final handler = MockRequestInterceptorHandler();

        await interceptor.onRequest(options, handler);

        expect(handler.nextCalled, isTrue);
        expect(options.headers['Authorization'], isNull);
      });

      test('should skip auth for oauth/authorize endpoint', () async {
        tokenStorage.setTokens(accessToken: 'test_token');
        interceptor = AuthInterceptor(tokenStorage: tokenStorage);

        final options = RequestOptions(path: '/oauth/authorize');
        final handler = MockRequestInterceptorHandler();

        await interceptor.onRequest(options, handler);

        expect(handler.nextCalled, isTrue);
        expect(options.headers['Authorization'], isNull);
      });
    });

    group('onError', () {
      test('should pass through non-401 errors', () async {
        tokenStorage.setTokens(accessToken: 'test_token');
        interceptor = AuthInterceptor(tokenStorage: tokenStorage);

        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/orgs'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/orgs'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(handler.nextCalled, isTrue);
      });

      test('should attempt token refresh on 401 error', () async {
        tokenStorage.setTokens(
          accessToken: 'expired_token',
          refreshToken: 'refresh_token',
        );

        var refreshCalled = false;
        interceptor = AuthInterceptor(
          tokenStorage: tokenStorage,
          onTokenRefresh: (refreshToken) async {
            refreshCalled = true;
            expect(refreshToken, 'refresh_token');
            await tokenStorage.saveTokens(accessToken: 'new_token');
            return 'new_token';
          },
        );

        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/orgs'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/orgs'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(refreshCalled, isTrue);
      });

      test('should call onAuthFailure when token refresh fails', () async {
        tokenStorage.setTokens(
          accessToken: 'expired_token',
          refreshToken: 'refresh_token',
        );

        var authFailureCalled = false;
        interceptor = AuthInterceptor(
          tokenStorage: tokenStorage,
          onTokenRefresh: (refreshToken) async {
            return null; // Refresh failed
          },
          onAuthFailure: () async {
            authFailureCalled = true;
          },
        );

        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/orgs'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/orgs'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(authFailureCalled, isTrue);
      });

      test('should call onAuthFailure when no refresh token available', () async {
        tokenStorage.setTokens(
          accessToken: 'expired_token',
          refreshToken: null,
        );

        var authFailureCalled = false;
        interceptor = AuthInterceptor(
          tokenStorage: tokenStorage,
          onAuthFailure: () async {
            authFailureCalled = true;
          },
        );

        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/orgs'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/orgs'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(authFailureCalled, isTrue);
      });

      test('should not attempt refresh for public endpoints', () async {
        tokenStorage.setTokens(
          accessToken: 'token',
          refreshToken: 'refresh_token',
        );

        var refreshCalled = false;
        interceptor = AuthInterceptor(
          tokenStorage: tokenStorage,
          onTokenRefresh: (refreshToken) async {
            refreshCalled = true;
            return 'new_token';
          },
        );

        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/oauth/token'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/oauth/token'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(refreshCalled, isFalse);
      });
    });

    group('concurrent refresh handling', () {
      test('should only make one refresh request for concurrent 401s', () async {
        tokenStorage.setTokens(
          accessToken: 'expired_token',
          refreshToken: 'refresh_token',
        );

        var refreshCallCount = 0;
        interceptor = AuthInterceptor(
          tokenStorage: tokenStorage,
          onTokenRefresh: (refreshToken) async {
            refreshCallCount++;
            await Future.delayed(const Duration(milliseconds: 100));
            await tokenStorage.saveTokens(accessToken: 'new_token');
            return 'new_token';
          },
        );

        final error1 = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/orgs'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/orgs'),
          ),
        );

        final error2 = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/spaces'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/spaces'),
          ),
        );

        final handler1 = MockErrorInterceptorHandler();
        final handler2 = MockErrorInterceptorHandler();

        // Start both requests concurrently
        await Future.wait([
          interceptor.onError(error1, handler1),
          interceptor.onError(error2, handler2),
        ]);

        // Only one refresh should have been made
        expect(refreshCallCount, 1);
      });
    });

    group('token refresh exception handling', () {
      test('should handle exception during token refresh gracefully', () async {
        tokenStorage.setTokens(
          accessToken: 'expired_token',
          refreshToken: 'refresh_token',
        );

        var authFailureCalled = false;
        interceptor = AuthInterceptor(
          tokenStorage: tokenStorage,
          onTokenRefresh: (refreshToken) async {
            throw Exception('Network error during refresh');
          },
          onAuthFailure: () async {
            authFailureCalled = true;
          },
        );

        final error = DioException(
          type: DioExceptionType.badResponse,
          requestOptions: RequestOptions(path: '/orgs'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/orgs'),
          ),
        );

        final handler = MockErrorInterceptorHandler();
        await interceptor.onError(error, handler);

        expect(authFailureCalled, isTrue);
        expect(handler.nextCalled, isTrue);
      });
    });
  });
}

/// Mock handler for request interceptor using noSuchMethod
class MockRequestInterceptorHandler implements RequestInterceptorHandler {
  bool nextCalled = false;
  bool resolveCalled = false;
  bool rejectCalled = false;

  @override
  void next(RequestOptions requestOptions) {
    nextCalled = true;
  }

  @override
  void resolve(Response response, [bool callFollowingResponseInterceptor = false]) {
    resolveCalled = true;
  }

  @override
  void reject(DioException error, [bool callFollowingErrorInterceptor = false]) {
    rejectCalled = true;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
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
