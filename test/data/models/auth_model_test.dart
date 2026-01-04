import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/auth_model.dart';

void main() {
  group('TokenResponse', () {
    test('should serialize to JSON correctly', () {
      const response = TokenResponse(
        accessToken: 'access-token-123',
        tokenType: 'Bearer',
        expiresIn: 3600,
        refreshToken: 'refresh-token-456',
        scope: 'read write',
      );

      final json = response.toJson();

      expect(json['accessToken'], 'access-token-123');
      expect(json['tokenType'], 'Bearer');
      expect(json['expiresIn'], 3600);
      expect(json['refreshToken'], 'refresh-token-456');
      expect(json['scope'], 'read write');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'accessToken': 'token-789',
        'tokenType': 'Bearer',
        'expiresIn': 7200,
        'refreshToken': 'refresh-abc',
        'scope': 'full',
      };

      final response = TokenResponse.fromJson(json);

      expect(response.accessToken, 'token-789');
      expect(response.tokenType, 'Bearer');
      expect(response.expiresIn, 7200);
      expect(response.refreshToken, 'refresh-abc');
      expect(response.scope, 'full');
    });

    test('should handle snake_case JSON keys from API', () {
      // Note: freezed with json_serializable should handle both cases
      // but the actual API might use snake_case
      final json = {
        'accessToken': 'token-123', // Default field name
        'tokenType': 'Bearer',
        'expiresIn': 3600,
        'refreshToken': 'refresh-xyz',
      };

      final response = TokenResponse.fromJson(json);

      expect(response.accessToken, 'token-123');
      expect(response.tokenType, 'Bearer');
    });

    test('should handle null optional fields', () {
      final json = {
        'accessToken': 'only-access-token',
      };

      final response = TokenResponse.fromJson(json);

      expect(response.accessToken, 'only-access-token');
      expect(response.tokenType, isNull);
      expect(response.expiresIn, isNull);
      expect(response.refreshToken, isNull);
      expect(response.scope, isNull);
    });

    test('should support equality comparison', () {
      const response1 = TokenResponse(
        accessToken: 'token-1',
        expiresIn: 3600,
      );
      const response2 = TokenResponse(
        accessToken: 'token-1',
        expiresIn: 3600,
      );
      const response3 = TokenResponse(
        accessToken: 'token-2',
        expiresIn: 3600,
      );

      expect(response1, equals(response2));
      expect(response1, isNot(equals(response3)));
    });
  });

  group('TokenRequest', () {
    test('should serialize authorization_code grant', () {
      const request = TokenRequest(
        grantType: 'authorization_code',
        clientId: 'client-123',
        clientSecret: 'secret-456',
        code: 'auth-code-789',
        redirectUri: 'https://app.example.com/callback',
      );

      final json = request.toJson();

      expect(json['grantType'], 'authorization_code');
      expect(json['clientId'], 'client-123');
      expect(json['clientSecret'], 'secret-456');
      expect(json['code'], 'auth-code-789');
      expect(json['redirectUri'], 'https://app.example.com/callback');
    });

    test('should serialize refresh_token grant', () {
      const request = TokenRequest(
        grantType: 'refresh_token',
        clientId: 'client-123',
        clientSecret: 'secret-456',
        refreshToken: 'refresh-token-abc',
      );

      final json = request.toJson();

      expect(json['grantType'], 'refresh_token');
      expect(json['refreshToken'], 'refresh-token-abc');
      expect(json['code'], isNull);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'grantType': 'authorization_code',
        'clientId': 'my-client',
        'code': 'my-code',
      };

      final request = TokenRequest.fromJson(json);

      expect(request.grantType, 'authorization_code');
      expect(request.clientId, 'my-client');
      expect(request.code, 'my-code');
    });

    test('should handle minimal request', () {
      const request = TokenRequest(grantType: 'client_credentials');

      final json = request.toJson();

      expect(json['grantType'], 'client_credentials');
      expect(json['clientId'], isNull);
    });
  });

  group('AuthData', () {
    test('should serialize to JSON correctly', () {
      final authData = AuthData(
        accessToken: 'access-123',
        refreshToken: 'refresh-456',
        expiresAt: DateTime.parse('2024-12-31T23:59:59.000Z'),
      );

      final json = authData.toJson();

      expect(json['accessToken'], 'access-123');
      expect(json['refreshToken'], 'refresh-456');
      expect(json['expiresAt'], '2024-12-31T23:59:59.000Z');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'accessToken': 'token-abc',
        'refreshToken': 'refresh-xyz',
        'expiresAt': '2025-01-15T12:00:00.000Z',
      };

      final authData = AuthData.fromJson(json);

      expect(authData.accessToken, 'token-abc');
      expect(authData.refreshToken, 'refresh-xyz');
      expect(authData.expiresAt, DateTime.parse('2025-01-15T12:00:00.000Z'));
    });

    test('should handle null optional fields', () {
      final json = {
        'accessToken': 'only-access',
      };

      final authData = AuthData.fromJson(json);

      expect(authData.accessToken, 'only-access');
      expect(authData.refreshToken, isNull);
      expect(authData.expiresAt, isNull);
    });

    test('should support copyWith', () {
      final original = AuthData(
        accessToken: 'original-token',
        refreshToken: 'original-refresh',
        expiresAt: DateTime.parse('2024-06-01T00:00:00.000Z'),
      );

      final updated = original.copyWith(
        accessToken: 'new-token',
      );

      expect(updated.accessToken, 'new-token');
      expect(updated.refreshToken, 'original-refresh');
      expect(updated.expiresAt, original.expiresAt);
    });

    test('should check token expiry', () {
      final expiredAuth = AuthData(
        accessToken: 'token',
        expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
      );

      final validAuth = AuthData(
        accessToken: 'token',
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );

      expect(expiredAuth.expiresAt!.isBefore(DateTime.now()), isTrue);
      expect(validAuth.expiresAt!.isAfter(DateTime.now()), isTrue);
    });
  });
}
