import 'package:gitbook_mobile/core/network/dio_client.dart';

/// Mock implementation of TokenStorage for testing
class MockTokenStorage implements TokenStorage {
  String? _accessToken;
  String? _refreshToken;
  DateTime? _expiry;
  bool _shouldFailOnSave = false;

  MockTokenStorage({
    String? accessToken,
    String? refreshToken,
    DateTime? expiry,
  })  : _accessToken = accessToken,
        _refreshToken = refreshToken,
        _expiry = expiry;

  /// Configure the mock to fail on save operations
  void setShouldFailOnSave(bool value) {
    _shouldFailOnSave = value;
  }

  /// Set tokens directly for testing
  void setTokens({
    String? accessToken,
    String? refreshToken,
    DateTime? expiry,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _expiry = expiry;
  }

  @override
  Future<String?> getAccessToken() async {
    return _accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    return _refreshToken;
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    if (_shouldFailOnSave) {
      throw Exception('Mock save failure');
    }
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  @override
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _expiry = null;
  }

  @override
  Future<bool> hasValidToken() async {
    if (_accessToken == null || _accessToken!.isEmpty) {
      return false;
    }
    if (_expiry != null && _expiry!.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }
}
