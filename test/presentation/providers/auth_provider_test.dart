import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/auth_entity.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';
import 'package:gitbook_mobile/domain/repositories/auth_repository.dart';
import 'package:gitbook_mobile/domain/repositories/user_repository.dart';
import 'package:gitbook_mobile/presentation/providers/auth_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockUserRepository mockUserRepository;
  late StreamController<AuthState> authStateController;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockUserRepository = MockUserRepository();
    authStateController = StreamController<AuthState>.broadcast();

    when(() => mockAuthRepository.authStateChanges)
        .thenAnswer((_) => authStateController.stream);
  });

  tearDown(() {
    authStateController.close();
  });

  group('AuthUiState', () {
    test('should have default values', () {
      const state = AuthUiState();

      expect(state.status, AuthStatus.unauthenticated);
      expect(state.user, isNull);
      expect(state.error, isNull);
      expect(state.isLoading, isFalse);
    });

    test('should copy with new values', () {
      const state = AuthUiState(
        status: AuthStatus.authenticated,
        user: User(id: 'user-123'),
      );

      final copied = state.copyWith(isLoading: true);

      expect(copied.status, AuthStatus.authenticated);
      expect(copied.user?.id, 'user-123');
      expect(copied.isLoading, isTrue);
    });

    test('isAuthenticated should return true when authenticated', () {
      const state = AuthUiState(status: AuthStatus.authenticated);

      expect(state.isAuthenticated, isTrue);
      expect(state.isUnauthenticated, isFalse);
    });

    test('isUnauthenticated should return true when unauthenticated', () {
      const state = AuthUiState(status: AuthStatus.unauthenticated);

      expect(state.isAuthenticated, isFalse);
      expect(state.isUnauthenticated, isTrue);
    });
  });

  group('AuthNotifier', () {
    late AuthNotifier notifier;

    setUp(() {
      when(() => mockAuthRepository.isAuthenticated())
          .thenAnswer((_) async => false);

      notifier = AuthNotifier(
        authRepository: mockAuthRepository,
        userRepository: mockUserRepository,
      );
    });

    test('should check auth status on init', () async {
      // Wait for async initialization
      await Future.delayed(Duration.zero);

      verify(() => mockAuthRepository.isAuthenticated()).called(1);
    });

    test('loginWithApiToken should update state on success', () async {
      const user = User(id: 'user-123', displayName: 'Test');
      when(() => mockAuthRepository.loginWithApiToken(any()))
          .thenAnswer((_) async => user);

      await notifier.loginWithApiToken('test-token');

      expect(notifier.state.isAuthenticated, isTrue);
      expect(notifier.state.user?.id, 'user-123');
    });

    test('loginWithApiToken should set error on failure', () async {
      when(() => mockAuthRepository.loginWithApiToken(any()))
          .thenThrow(Exception('Invalid token'));

      await notifier.loginWithApiToken('invalid-token');

      expect(notifier.state.status, AuthStatus.error);
      expect(notifier.state.error, isNotNull);
    });

    test('loginWithOAuth should update state on success', () async {
      const user = User(id: 'user-456');
      when(() => mockAuthRepository.loginWithOAuth(
            authorizationCode: any(named: 'authorizationCode'),
            redirectUri: any(named: 'redirectUri'),
          )).thenAnswer((_) async => user);

      await notifier.loginWithOAuth(
        authorizationCode: 'code',
        redirectUri: 'app://callback',
      );

      expect(notifier.state.isAuthenticated, isTrue);
      expect(notifier.state.user?.id, 'user-456');
    });

    test('logout should clear state', () async {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});
      when(() => mockUserRepository.clearCache()).thenAnswer((_) async {});

      await notifier.logout();

      expect(notifier.state.isUnauthenticated, isTrue);
      expect(notifier.state.user, isNull);
    });

    test('clearError should remove error from state', () async {
      when(() => mockAuthRepository.loginWithApiToken(any()))
          .thenThrow(Exception('Error'));

      await notifier.loginWithApiToken('bad-token');
      expect(notifier.state.error, isNotNull);

      notifier.clearError();
      expect(notifier.state.error, isNull);
    });

    test('checkAuthStatus should set authenticated when cached user exists', () async {
      const user = User(id: 'cached-user');
      when(() => mockAuthRepository.isAuthenticated())
          .thenAnswer((_) async => true);
      when(() => mockUserRepository.getCachedUser())
          .thenAnswer((_) async => user);

      await notifier.checkAuthStatus();

      expect(notifier.state.isAuthenticated, isTrue);
      expect(notifier.state.user?.id, 'cached-user');
    });

    test('checkAuthStatus should fetch user when no cache', () async {
      const user = User(id: 'fetched-user');
      when(() => mockAuthRepository.isAuthenticated())
          .thenAnswer((_) async => true);
      when(() => mockUserRepository.getCachedUser())
          .thenAnswer((_) async => null);
      when(() => mockUserRepository.getCurrentUser())
          .thenAnswer((_) async => user);

      await notifier.checkAuthStatus();

      expect(notifier.state.isAuthenticated, isTrue);
      expect(notifier.state.user?.id, 'fetched-user');
    });
  });
}
