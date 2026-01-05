import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/auth_entity.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';
import 'package:gitbook_mobile/domain/repositories/auth_repository.dart';
import 'package:gitbook_mobile/domain/usecases/auth_usecases.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('LoginWithOAuthUseCase', () {
    late LoginWithOAuthUseCase useCase;

    setUp(() {
      useCase = LoginWithOAuthUseCase(mockRepository);
    });

    test('should call repository with correct parameters', () async {
      const user = User(id: 'user-123', displayName: 'Test User');
      when(() => mockRepository.loginWithOAuth(
            authorizationCode: any(named: 'authorizationCode'),
            redirectUri: any(named: 'redirectUri'),
          )).thenAnswer((_) async => user);

      final result = await useCase(
        authorizationCode: 'auth-code',
        redirectUri: 'app://callback',
      );

      expect(result.id, 'user-123');
      verify(() => mockRepository.loginWithOAuth(
            authorizationCode: 'auth-code',
            redirectUri: 'app://callback',
          )).called(1);
    });
  });

  group('LoginWithApiTokenUseCase', () {
    late LoginWithApiTokenUseCase useCase;

    setUp(() {
      useCase = LoginWithApiTokenUseCase(mockRepository);
    });

    test('should call repository with token', () async {
      const user = User(id: 'user-123');
      when(() => mockRepository.loginWithApiToken(any()))
          .thenAnswer((_) async => user);

      final result = await useCase('test-token');

      expect(result.id, 'user-123');
      verify(() => mockRepository.loginWithApiToken('test-token')).called(1);
    });
  });

  group('LogoutUseCase', () {
    late LogoutUseCase useCase;

    setUp(() {
      useCase = LogoutUseCase(mockRepository);
    });

    test('should call repository logout', () async {
      when(() => mockRepository.logout()).thenAnswer((_) async {});

      await useCase();

      verify(() => mockRepository.logout()).called(1);
    });
  });

  group('CheckAuthStatusUseCase', () {
    late CheckAuthStatusUseCase useCase;

    setUp(() {
      useCase = CheckAuthStatusUseCase(mockRepository);
    });

    test('should return true when authenticated', () async {
      when(() => mockRepository.isAuthenticated())
          .thenAnswer((_) async => true);

      final result = await useCase();

      expect(result, isTrue);
    });

    test('should return false when not authenticated', () async {
      when(() => mockRepository.isAuthenticated())
          .thenAnswer((_) async => false);

      final result = await useCase();

      expect(result, isFalse);
    });
  });

  group('GetAuthStateUseCase', () {
    late GetAuthStateUseCase useCase;

    setUp(() {
      useCase = GetAuthStateUseCase(mockRepository);
    });

    test('should return auth state from repository', () async {
      const state = AuthState(
        status: AuthStatus.authenticated,
        userId: 'user-123',
      );
      when(() => mockRepository.getAuthState()).thenAnswer((_) async => state);

      final result = await useCase();

      expect(result.status, AuthStatus.authenticated);
      expect(result.userId, 'user-123');
    });
  });

  group('RefreshTokenUseCase', () {
    late RefreshTokenUseCase useCase;

    setUp(() {
      useCase = RefreshTokenUseCase(mockRepository);
    });

    test('should call repository refresh token', () async {
      when(() => mockRepository.refreshToken()).thenAnswer((_) async {});

      await useCase();

      verify(() => mockRepository.refreshToken()).called(1);
    });
  });

  group('ObserveAuthStateUseCase', () {
    late ObserveAuthStateUseCase useCase;

    setUp(() {
      useCase = ObserveAuthStateUseCase(mockRepository);
    });

    test('should return stream from repository', () {
      final stream = Stream.value(const AuthState(
        status: AuthStatus.authenticated,
        userId: 'user-123',
      ));
      when(() => mockRepository.authStateChanges).thenAnswer((_) => stream);

      final result = useCase();

      expect(result, isA<Stream<AuthState>>());
    });
  });
}
