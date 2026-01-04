import 'package:dio/dio.dart';
import 'package:gitbook_mobile/core/network/dio_client.dart';
import 'package:gitbook_mobile/core/network/interceptors/auth_interceptor.dart';

import 'mock_token_storage.dart';

/// Mock implementation of DioClient for testing
class MockDioClient implements DioClient {
  final List<MockRequest> requests = [];
  final Map<String, MockResponse> responses = {};
  Exception? nextError;

  @override
  final TokenStorage tokenStorage;

  @override
  TokenRefreshCallback? onTokenRefresh;

  @override
  AuthFailureCallback? onAuthFailure;

  MockDioClient({TokenStorage? tokenStorage})
      : tokenStorage = tokenStorage ?? MockTokenStorage();

  @override
  Dio get dio => throw UnimplementedError('Mock does not use real Dio');

  /// Set up a mock response for a specific path
  void mockResponse(String path, Map<String, dynamic> data, {int statusCode = 200}) {
    responses[path] = MockResponse(data: data, statusCode: statusCode);
  }

  /// Set an error to be thrown on next request
  void setNextError(Exception error) {
    nextError = error;
  }

  /// Clear all mock data
  void reset() {
    requests.clear();
    responses.clear();
    nextError = null;
  }

  Future<Response<T>> _handleRequest<T>(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    requests.add(MockRequest(
      method: method,
      path: path,
      data: data,
      queryParameters: queryParameters,
    ));

    if (nextError != null) {
      final error = nextError!;
      nextError = null;
      throw error;
    }

    final mockResponse = responses[path];
    if (mockResponse != null) {
      return Response<T>(
        data: mockResponse.data as T,
        statusCode: mockResponse.statusCode,
        requestOptions: RequestOptions(path: path),
      );
    }

    // Default empty response
    return Response<T>(
      data: <String, dynamic>{} as T,
      statusCode: 200,
      requestOptions: RequestOptions(path: path),
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest<T>('GET', path, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest<T>('POST', path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest<T>('PUT', path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest<T>('PATCH', path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _handleRequest<T>('DELETE', path, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response<T>> upload<T>(
    String path, {
    required FormData data,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) async {
    return _handleRequest<T>('POST', path, data: data);
  }
}

/// Represents a mock request for verification
class MockRequest {
  final String method;
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;

  MockRequest({
    required this.method,
    required this.path,
    this.data,
    this.queryParameters,
  });
}

/// Represents a mock response
class MockResponse {
  final dynamic data;
  final int statusCode;

  MockResponse({required this.data, this.statusCode = 200});
}
