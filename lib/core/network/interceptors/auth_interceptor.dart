import 'dart:async';

import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../dio_client.dart';

/// Callback for token refresh
typedef TokenRefreshCallback = Future<String?> Function(String? refreshToken);

/// Callback for handling auth failure (e.g., logout)
typedef AuthFailureCallback = Future<void> Function();

/// Interceptor for adding authentication headers and handling token refresh
class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final TokenRefreshCallback? onTokenRefresh;
  final AuthFailureCallback? onAuthFailure;

  /// Completer to handle concurrent refresh requests
  Completer<bool>? _refreshCompleter;

  AuthInterceptor({
    required this.tokenStorage,
    this.onTokenRefresh,
    this.onAuthFailure,
  });

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for certain endpoints
    if (_isPublicEndpoint(options.path)) {
      return handler.next(options);
    }

    final token = await tokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401 && !_isPublicEndpoint(err.requestOptions.path)) {
      // Token might be expired, try to refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the original request
        try {
          final token = await tokenStorage.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $token';

          final dio = Dio(BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          // If retry fails, call auth failure callback
          await onAuthFailure?.call();
          return handler.next(err);
        }
      } else {
        // Refresh failed, call auth failure callback
        await onAuthFailure?.call();
      }
    }

    handler.next(err);
  }

  bool _isPublicEndpoint(String path) {
    const publicEndpoints = [
      '/oauth/token',
      '/oauth/authorize',
    ];
    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }

  Future<bool> _refreshToken() async {
    // If already refreshing, wait for the result
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<bool>();

    try {
      final refreshToken = await tokenStorage.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        _refreshCompleter!.complete(false);
        return false;
      }

      // Use callback to refresh token
      if (onTokenRefresh != null) {
        final newToken = await onTokenRefresh!(refreshToken);
        if (newToken != null && newToken.isNotEmpty) {
          _refreshCompleter!.complete(true);
          return true;
        }
      }

      _refreshCompleter!.complete(false);
      return false;
    } catch (e) {
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _refreshCompleter = null;
    }
  }
}
