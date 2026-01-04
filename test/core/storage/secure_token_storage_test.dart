import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/storage/secure_token_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SecureTokenStorage', () {
    late SecureTokenStorage storage;
    late MockFlutterSecureStorage mockSecureStorage;

    setUp(() {
      mockSecureStorage = MockFlutterSecureStorage();
      storage = SecureTokenStorage(storage: mockSecureStorage);
    });

    tearDown(() {
      mockSecureStorage.clear();
    });

    group('getAccessToken', () {
      test('should return null when no token stored', () async {
        final token = await storage.getAccessToken();
        expect(token, isNull);
      });

      test('should return stored access token', () async {
        await mockSecureStorage.write(key: 'access_token', value: 'test-token');

        final token = await storage.getAccessToken();
        expect(token, 'test-token');
      });
    });

    group('getRefreshToken', () {
      test('should return null when no refresh token stored', () async {
        final token = await storage.getRefreshToken();
        expect(token, isNull);
      });

      test('should return stored refresh token', () async {
        await mockSecureStorage.write(key: 'refresh_token', value: 'refresh-123');

        final token = await storage.getRefreshToken();
        expect(token, 'refresh-123');
      });
    });

    group('saveTokens', () {
      test('should save access token', () async {
        await storage.saveTokens(accessToken: 'new-access-token');

        final token = await mockSecureStorage.read(key: 'access_token');
        expect(token, 'new-access-token');
      });

      test('should save both access and refresh tokens', () async {
        await storage.saveTokens(
          accessToken: 'access-123',
          refreshToken: 'refresh-456',
        );

        final accessToken = await mockSecureStorage.read(key: 'access_token');
        final refreshToken = await mockSecureStorage.read(key: 'refresh_token');

        expect(accessToken, 'access-123');
        expect(refreshToken, 'refresh-456');
      });

      test('should not overwrite refresh token if not provided', () async {
        await mockSecureStorage.write(key: 'refresh_token', value: 'existing-refresh');

        await storage.saveTokens(accessToken: 'new-access');

        final refreshToken = await mockSecureStorage.read(key: 'refresh_token');
        expect(refreshToken, 'existing-refresh');
      });
    });

    group('clearTokens', () {
      test('should clear all tokens', () async {
        await mockSecureStorage.write(key: 'access_token', value: 'access');
        await mockSecureStorage.write(key: 'refresh_token', value: 'refresh');
        await mockSecureStorage.write(key: 'token_expiry', value: '2024-12-31');

        await storage.clearTokens();

        final accessToken = await mockSecureStorage.read(key: 'access_token');
        final refreshToken = await mockSecureStorage.read(key: 'refresh_token');
        final expiry = await mockSecureStorage.read(key: 'token_expiry');

        expect(accessToken, isNull);
        expect(refreshToken, isNull);
        expect(expiry, isNull);
      });
    });

    group('hasValidToken', () {
      test('should return false when no token', () async {
        final isValid = await storage.hasValidToken();
        expect(isValid, isFalse);
      });

      test('should return false when token is empty', () async {
        await mockSecureStorage.write(key: 'access_token', value: '');

        final isValid = await storage.hasValidToken();
        expect(isValid, isFalse);
      });

      test('should return true when token exists and not expired', () async {
        await mockSecureStorage.write(key: 'access_token', value: 'valid-token');

        final isValid = await storage.hasValidToken();
        expect(isValid, isTrue);
      });

      test('should return true when token exists without expiry', () async {
        await mockSecureStorage.write(key: 'access_token', value: 'token-no-expiry');

        final isValid = await storage.hasValidToken();
        expect(isValid, isTrue);
      });

      test('should return false when token is expired', () async {
        await mockSecureStorage.write(key: 'access_token', value: 'expired-token');
        await mockSecureStorage.write(
          key: 'token_expiry',
          value: DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
        );

        final isValid = await storage.hasValidToken();
        expect(isValid, isFalse);
      });

      test('should return true when token is not yet expired', () async {
        await mockSecureStorage.write(key: 'access_token', value: 'valid-token');
        await mockSecureStorage.write(
          key: 'token_expiry',
          value: DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        );

        final isValid = await storage.hasValidToken();
        expect(isValid, isTrue);
      });
    });

    group('saveTokenExpiry', () {
      test('should save token expiry', () async {
        final expiry = DateTime.parse('2024-12-31T23:59:59.000Z');
        await storage.saveTokenExpiry(expiry);

        final stored = await mockSecureStorage.read(key: 'token_expiry');
        expect(stored, '2024-12-31T23:59:59.000Z');
      });
    });

    group('getTokenExpiry', () {
      test('should return null when no expiry stored', () async {
        final expiry = await storage.getTokenExpiry();
        expect(expiry, isNull);
      });

      test('should return stored expiry', () async {
        await mockSecureStorage.write(
          key: 'token_expiry',
          value: '2024-12-31T23:59:59.000Z',
        );

        final expiry = await storage.getTokenExpiry();
        expect(expiry, DateTime.parse('2024-12-31T23:59:59.000Z'));
      });

      test('should return null for invalid expiry format', () async {
        await mockSecureStorage.write(key: 'token_expiry', value: 'invalid-date');

        final expiry = await storage.getTokenExpiry();
        expect(expiry, isNull);
      });
    });

    group('saveAuthData', () {
      test('should save access and refresh tokens', () async {
        await storage.saveAuthData(
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
        );

        final accessToken = await mockSecureStorage.read(key: 'access_token');
        final refreshToken = await mockSecureStorage.read(key: 'refresh_token');

        expect(accessToken, 'access-token');
        expect(refreshToken, 'refresh-token');
      });

      test('should calculate and save expiry from expiresIn', () async {
        final beforeSave = DateTime.now();

        await storage.saveAuthData(
          accessToken: 'token',
          expiresIn: 3600, // 1 hour
        );

        final afterSave = DateTime.now();
        final expiryStr = await mockSecureStorage.read(key: 'token_expiry');
        final expiry = DateTime.parse(expiryStr!);

        // Expiry should be approximately 1 hour from now
        expect(
          expiry.isAfter(beforeSave.add(const Duration(minutes: 59))),
          isTrue,
        );
        expect(
          expiry.isBefore(afterSave.add(const Duration(minutes: 61))),
          isTrue,
        );
      });

      test('should not save expiry when expiresIn is null', () async {
        await storage.saveAuthData(accessToken: 'token');

        final expiry = await mockSecureStorage.read(key: 'token_expiry');
        expect(expiry, isNull);
      });
    });
  });
}

/// Mock implementation of FlutterSecureStorage for testing
class MockFlutterSecureStorage implements FlutterSecureStorage {
  final Map<String, String> _storage = {};

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _storage[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) {
      _storage[key] = value;
    } else {
      _storage.remove(key);
    }
  }

  @override
  Future<void> delete({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _storage.remove(key);
  }

  @override
  Future<void> deleteAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _storage.clear();
  }

  @override
  Future<Map<String, String>> readAll({
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return Map.from(_storage);
  }

  @override
  Future<bool> containsKey({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _storage.containsKey(key);
  }

  @override
  IOSOptions get iOptions => const IOSOptions();

  @override
  AndroidOptions get aOptions => const AndroidOptions();

  @override
  LinuxOptions get lOptions => const LinuxOptions();

  @override
  WebOptions get webOptions => const WebOptions();

  @override
  MacOsOptions get mOptions => const MacOsOptions();

  @override
  WindowsOptions get wOptions => const WindowsOptions();

  void clear() {
    _storage.clear();
  }

  @override
  Future<bool> isCupertinoProtectedDataAvailable() async => true;

  @override
  Stream<bool> get onCupertinoProtectedDataAvailabilityChanged =>
      Stream.value(true);

  @override
  void registerListener({
    required String key,
    required ValueChanged<String?> listener,
  }) {}

  @override
  void unregisterAllListeners() {}

  @override
  void unregisterListener({
    required String key,
    ValueChanged<String?>? listener,
  }) {}

  @override
  void unregisterAllListenersForKey({required String key}) {}
}
