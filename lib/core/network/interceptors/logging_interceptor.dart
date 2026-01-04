import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// Interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('┌─────────────────────────────────────────────────────');
    _log('│ 📤 REQUEST');
    _log('├─────────────────────────────────────────────────────');
    _log('│ ${options.method} ${options.uri}');

    if (options.headers.isNotEmpty) {
      _log('│ Headers:');
      options.headers.forEach((key, value) {
        if (key.toLowerCase() == 'authorization') {
          _log('│   $key: Bearer ***');
        } else {
          _log('│   $key: $value');
        }
      });
    }

    if (options.queryParameters.isNotEmpty) {
      _log('│ Query Parameters:');
      options.queryParameters.forEach((key, value) {
        _log('│   $key: $value');
      });
    }

    if (options.data != null) {
      _log('│ Body: ${_truncate(options.data.toString())}');
    }

    _log('└─────────────────────────────────────────────────────');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('┌─────────────────────────────────────────────────────');
    _log('│ 📥 RESPONSE');
    _log('├─────────────────────────────────────────────────────');
    _log('│ ${response.statusCode} ${response.requestOptions.uri}');
    _log('│ Data: ${_truncate(response.data.toString())}');
    _log('└─────────────────────────────────────────────────────');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('┌─────────────────────────────────────────────────────');
    _log('│ ❌ ERROR');
    _log('├─────────────────────────────────────────────────────');
    _log('│ ${err.type}');
    _log('│ ${err.requestOptions.method} ${err.requestOptions.uri}');

    if (err.response != null) {
      _log('│ Status: ${err.response?.statusCode}');
      _log('│ Data: ${_truncate(err.response?.data.toString() ?? '')}');
    }

    _log('│ Message: ${err.message}');
    _log('└─────────────────────────────────────────────────────');

    handler.next(err);
  }

  void _log(String message) {
    developer.log(message, name: 'HTTP');
  }

  String _truncate(String text, {int maxLength = 500}) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}... (truncated)';
  }
}
