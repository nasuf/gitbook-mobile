import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/organization_model.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';
import 'package:gitbook_mobile/domain/repositories/user_repository.dart';
import 'package:gitbook_mobile/domain/usecases/user_usecases.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

class FakeUserSettings extends Fake implements UserSettings {}

void main() {
  late MockUserRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeUserSettings());
  });

  setUp(() {
    mockRepository = MockUserRepository();
  });

  group('GetCurrentUserUseCase', () {
    late GetCurrentUserUseCase useCase;

    setUp(() {
      useCase = GetCurrentUserUseCase(mockRepository);
    });

    test('should return current user from repository', () async {
      const user = User(
        id: 'user-123',
        displayName: 'Test User',
        email: 'test@example.com',
      );
      when(() => mockRepository.getCurrentUser()).thenAnswer((_) async => user);

      final result = await useCase();

      expect(result.id, 'user-123');
      expect(result.displayName, 'Test User');
      verify(() => mockRepository.getCurrentUser()).called(1);
    });
  });

  group('GetCachedUserUseCase', () {
    late GetCachedUserUseCase useCase;

    setUp(() {
      useCase = GetCachedUserUseCase(mockRepository);
    });

    test('should return cached user when available', () async {
      const user = User(id: 'user-123');
      when(() => mockRepository.getCachedUser()).thenAnswer((_) async => user);

      final result = await useCase();

      expect(result, isNotNull);
      expect(result!.id, 'user-123');
    });

    test('should return null when no cached user', () async {
      when(() => mockRepository.getCachedUser()).thenAnswer((_) async => null);

      final result = await useCase();

      expect(result, isNull);
    });
  });

  group('GetUserSettingsUseCase', () {
    late GetUserSettingsUseCase useCase;

    setUp(() {
      useCase = GetUserSettingsUseCase(mockRepository);
    });

    test('should return user settings from repository', () async {
      const settings = UserSettings(
        themeMode: ThemeModeSetting.dark,
        fontSize: 18.0,
      );
      when(() => mockRepository.getUserSettings())
          .thenAnswer((_) async => settings);

      final result = await useCase();

      expect(result.themeMode, ThemeModeSetting.dark);
      expect(result.fontSize, 18.0);
    });
  });

  group('UpdateUserSettingsUseCase', () {
    late UpdateUserSettingsUseCase useCase;

    setUp(() {
      useCase = UpdateUserSettingsUseCase(mockRepository);
    });

    test('should call repository with settings', () async {
      const settings = UserSettings(offlineModeEnabled: true);
      when(() => mockRepository.updateUserSettings(any()))
          .thenAnswer((_) async {});

      await useCase(settings);

      verify(() => mockRepository.updateUserSettings(settings)).called(1);
    });
  });

  group('GetOrganizationsUseCase', () {
    late GetOrganizationsUseCase useCase;

    setUp(() {
      useCase = GetOrganizationsUseCase(mockRepository);
    });

    test('should return organizations from repository', () async {
      final orgs = [
        const OrganizationModel(id: 'org-1', title: 'Org One'),
        const OrganizationModel(id: 'org-2', title: 'Org Two'),
      ];
      when(() => mockRepository.getOrganizations(forceRefresh: false))
          .thenAnswer((_) async => orgs);

      final result = await useCase();

      expect(result.length, 2);
      expect(result[0].id, 'org-1');
    });

    test('should force refresh when requested', () async {
      when(() => mockRepository.getOrganizations(forceRefresh: true))
          .thenAnswer((_) async => []);

      await useCase(forceRefresh: true);

      verify(() => mockRepository.getOrganizations(forceRefresh: true)).called(1);
    });
  });

  group('GetCurrentOrganizationUseCase', () {
    late GetCurrentOrganizationUseCase useCase;

    setUp(() {
      useCase = GetCurrentOrganizationUseCase(mockRepository);
    });

    test('should return current organization', () async {
      const org = OrganizationModel(id: 'org-123', title: 'My Org');
      when(() => mockRepository.getCurrentOrganization())
          .thenAnswer((_) async => org);

      final result = await useCase();

      expect(result, isNotNull);
      expect(result!.id, 'org-123');
    });

    test('should return null when no current organization', () async {
      when(() => mockRepository.getCurrentOrganization())
          .thenAnswer((_) async => null);

      final result = await useCase();

      expect(result, isNull);
    });
  });

  group('SetCurrentOrganizationUseCase', () {
    late SetCurrentOrganizationUseCase useCase;

    setUp(() {
      useCase = SetCurrentOrganizationUseCase(mockRepository);
    });

    test('should call repository with organization id', () async {
      when(() => mockRepository.setCurrentOrganization(any()))
          .thenAnswer((_) async {});

      await useCase('org-123');

      verify(() => mockRepository.setCurrentOrganization('org-123')).called(1);
    });
  });
}
