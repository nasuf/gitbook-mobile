import 'package:dio/dio.dart';

import '../dio_client.dart';

/// Interceptor for adding authentication headers
class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;

  AuthInterceptor({required this.tokenStorage});

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
    if (err.response?.statusCode == 401) {
      // Token might be expired, try to refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the original request
        try {
          final token = await tokenStorage.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $token';

          final dio = Dio();
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }

    handler.next(err);
  }

  bool _isPublicEndpoint(String path) {
    const publicEndpoints = [
      '/oauth/token',
    ];
    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }

  Future<bool> _refreshToken() async {
    // TODO: Implement token refresh logic
    // This should call the refresh token endpoint and update stored tokens
    return false;
  }
}
