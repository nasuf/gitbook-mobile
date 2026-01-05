import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/storage/secure_token_storage.dart';
import 'package:gitbook_mobile/data/datasources/remote/gitbook_api_client.dart';
import 'package:gitbook_mobile/data/models/auth_model.dart';
import 'package:gitbook_mobile/data/models/user_model.dart';
import 'package:gitbook_mobile/data/repositories/auth_repository_impl.dart';
import 'package:gitbook_mobile/domain/entities/auth_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockGitBookApiClient extends Mock implements GitBookApiClient {}

class MockSecureTokenStorage extends Mock implements SecureTokenStorage {}

void main() {
  late MockGitBookApiClient mockApiClient;
  late MockSecureTokenStorage mockTokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockApiClient = MockGitBookApiClient();
    mockTokenStorage = MockSecureTokenStorage();
    repository = AuthRepositoryImpl(
      apiClient: mockApiClient,
      tokenStorage: mockTokenStorage,
    );
  });

  tearDown(() {
    repository.dispose();
  });

  group('loginWithApiToken', () {
    test('should save token and return user on success', () async {
      const token = 'test-api-token';
      const userModel = UserModel(
        id: 'user-123',
        displayName: 'Test User',
        email: 'test@example.com',
      );

      when(() => mockTokenStorage.saveTokens(accessToken: token))
          .thenAnswer((_) async {});
      when(() => mockApiClient.getCurrentUser())
          .thenAnswer((_) async => userModel);

      final user = await repository.loginWithApiToken(token);

      expect(user.id, 'user-123');
      expect(user.displayName, 'Test User');
      verify(() => mockTokenStorage.saveTokens(accessToken: token)).called(1);
      verify(() => mockApiClient.getCurrentUser()).called(1);
    });

    test('should clear token and rethrow on failure', () async {
      const token = 'invalid-token';

      when(() => mockTokenStorage.saveTokens(accessToken: token))
          .thenAnswer((_) async {});
      when(() => mockApiClient.getCurrentUser())
          .thenThrow(Exception('Invalid token'));
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      await expectLater(
        () => repository.loginWithApiToken(token),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('loginWithOAuth', () {
    test('should exchange code for tokens and return user', () async {
      const tokenResponse = TokenResponse(
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        expiresIn: 3600,
      );
      const userModel = UserModel(id: 'user-123', displayName: 'OAuth User');

      when(() => mockApiClient.getToken(
            grantType: 'authorization_code',
            code: 'auth-code',
            redirectUri: 'app://callback',
          )).thenAnswer((_) async => tokenResponse);
      when(() => mockTokenStorage.saveAuthData(
            accessToken: 'access-token',
            refreshToken: 'refresh-token',
            expiresIn: 3600,
          )).thenAnswer((_) async {});
      when(() => mockApiClient.getCurrentUser())
          .thenAnswer((_) async => userModel);

      final user = await repository.loginWithOAuth(
        authorizationCode: 'auth-code',
        redirectUri: 'app://callback',
      );

      expect(user.id, 'user-123');
      expect(user.displayName, 'OAuth User');
    });
  });

  group('refreshToken', () {
    test('should refresh token successfully', () async {
      const tokenResponse = TokenResponse(
        accessToken: 'new-access-token',
        refreshToken: 'new-refresh-token',
        expiresIn: 3600,
      );

      when(() => mockTokenStorage.getRefreshToken())
          .thenAnswer((_) async => 'old-refresh-token');
      when(() => mockApiClient.getToken(
            grantType: 'refresh_token',
            refreshToken: 'old-refresh-token',
          )).thenAnswer((_) async => tokenResponse);
      when(() => mockTokenStorage.saveAuthData(
            accessToken: 'new-access-token',
            refreshToken: 'new-refresh-token',
            expiresIn: 3600,
          )).thenAnswer((_) async {});

      await repository.refreshToken();

      verify(() => mockTokenStorage.saveAuthData(
            accessToken: 'new-access-token',
            refreshToken: 'new-refresh-token',
            expiresIn: 3600,
          )).called(1);
    });

    test('should throw when no refresh token available', () async {
      when(() => mockTokenStorage.getRefreshToken())
          .thenAnswer((_) async => null);

      expect(
        () => repository.refreshToken(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('logout', () {
    test('should clear tokens and emit unauthenticated state', () async {
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      await repository.logout();

      verify(() => mockTokenStorage.clearTokens()).called(1);
    });
  });

  group('isAuthenticated', () {
    test('should return true when valid token exists', () async {
      when(() => mockTokenStorage.hasValidToken())
          .thenAnswer((_) async => true);

      final result = await repository.isAuthenticated();

      expect(result, isTrue);
    });

    test('should return false when no valid token', () async {
      when(() => mockTokenStorage.hasValidToken())
          .thenAnswer((_) async => false);

      final result = await repository.isAuthenticated();

      expect(result, isFalse);
    });
  });

  group('getAuthState', () {
    test('should return authenticated state when token valid and user fetched', () async {
      const userModel = UserModel(id: 'user-123');

      when(() => mockTokenStorage.hasValidToken())
          .thenAnswer((_) async => true);
      when(() => mockApiClient.getCurrentUser())
          .thenAnswer((_) async => userModel);

      final state = await repository.getAuthState();

      expect(state.status, AuthStatus.authenticated);
      expect(state.userId, 'user-123');
    });

    test('should return unauthenticated when no token', () async {
      when(() => mockTokenStorage.hasValidToken())
          .thenAnswer((_) async => false);

      final state = await repository.getAuthState();

      expect(state.status, AuthStatus.unauthenticated);
    });

    test('should return unauthenticated when user fetch fails', () async {
      when(() => mockTokenStorage.hasValidToken())
          .thenAnswer((_) async => true);
      when(() => mockApiClient.getCurrentUser())
          .thenThrow(Exception('Unauthorized'));

      final state = await repository.getAuthState();

      expect(state.status, AuthStatus.unauthenticated);
    });
  });

  group('getAccessToken', () {
    test('should return token from storage', () async {
      when(() => mockTokenStorage.getAccessToken())
          .thenAnswer((_) async => 'test-token');

      final token = await repository.getAccessToken();

      expect(token, 'test-token');
    });
  });

  group('authStateChanges', () {
    test('should emit state changes', () async {
      when(() => mockTokenStorage.clearTokens()).thenAnswer((_) async {});

      expectLater(
        repository.authStateChanges,
        emits(isA<AuthState>().having(
          (s) => s.status,
          'status',
          AuthStatus.unauthenticated,
        )),
      );

      await repository.logout();
    });
  });
}
