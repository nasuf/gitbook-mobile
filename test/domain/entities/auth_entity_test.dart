import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/auth_entity.dart';

void main() {
  group('AuthState', () {
    test('should have default values', () {
      const state = AuthState();

      expect(state.status, AuthStatus.unauthenticated);
      expect(state.userId, isNull);
      expect(state.error, isNull);
      expect(state.isLoading, isFalse);
    });

    test('should create authenticated state', () {
      const state = AuthState(
        status: AuthStatus.authenticated,
        userId: 'user-123',
      );

      expect(state.isAuthenticated, isTrue);
      expect(state.isUnauthenticated, isFalse);
      expect(state.userId, 'user-123');
    });

    test('should create unauthenticated state', () {
      const state = AuthState(status: AuthStatus.unauthenticated);

      expect(state.isAuthenticated, isFalse);
      expect(state.isUnauthenticated, isTrue);
    });

    test('should create error state', () {
      const state = AuthState(
        status: AuthStatus.error,
        error: 'Authentication failed',
      );

      expect(state.status, AuthStatus.error);
      expect(state.error, 'Authentication failed');
    });

    test('should create authenticating state', () {
      const state = AuthState(
        status: AuthStatus.authenticating,
        isLoading: true,
      );

      expect(state.status, AuthStatus.authenticating);
      expect(state.isLoading, isTrue);
    });
  });

  group('AuthStatus', () {
    test('should have all expected values', () {
      expect(AuthStatus.values, contains(AuthStatus.unauthenticated));
      expect(AuthStatus.values, contains(AuthStatus.authenticating));
      expect(AuthStatus.values, contains(AuthStatus.authenticated));
      expect(AuthStatus.values, contains(AuthStatus.error));
    });

    test('should have 4 statuses', () {
      expect(AuthStatus.values.length, 4);
    });
  });

  group('LoginMethod', () {
    test('should have all expected values', () {
      expect(LoginMethod.values, contains(LoginMethod.oauth));
      expect(LoginMethod.values, contains(LoginMethod.apiToken));
    });

    test('should have 2 methods', () {
      expect(LoginMethod.values.length, 2);
    });
  });

  group('OAuthConfig', () {
    test('should create with required fields', () {
      const config = OAuthConfig(
        clientId: 'test-client-id',
        redirectUri: 'app://callback',
        authorizationEndpoint: 'https://auth.example.com/authorize',
        tokenEndpoint: 'https://auth.example.com/token',
      );

      expect(config.clientId, 'test-client-id');
      expect(config.redirectUri, 'app://callback');
      expect(config.authorizationEndpoint, 'https://auth.example.com/authorize');
      expect(config.tokenEndpoint, 'https://auth.example.com/token');
    });

    test('should have default scopes', () {
      const config = OAuthConfig(
        clientId: 'test-client-id',
        redirectUri: 'app://callback',
        authorizationEndpoint: 'https://auth.example.com/authorize',
        tokenEndpoint: 'https://auth.example.com/token',
      );

      expect(config.scopes, contains('content:read'));
      expect(config.scopes, contains('content:write'));
    });

    test('should allow custom scopes', () {
      const config = OAuthConfig(
        clientId: 'test-client-id',
        redirectUri: 'app://callback',
        authorizationEndpoint: 'https://auth.example.com/authorize',
        tokenEndpoint: 'https://auth.example.com/token',
        scopes: ['read', 'write', 'admin'],
      );

      expect(config.scopes.length, 3);
      expect(config.scopes, contains('admin'));
    });
  });
}
