import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/organization_model.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';
import 'package:gitbook_mobile/domain/repositories/user_repository.dart';
import 'package:gitbook_mobile/presentation/providers/user_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  setUpAll(() {
    registerFallbackValue(const UserSettings());
  });

  group('UserSettingsState', () {
    test('should have default values', () {
      const state = UserSettingsState();

      expect(state.settings.themeMode, ThemeModeSetting.system);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('should copy with new values', () {
      const state = UserSettingsState(isLoading: true);

      final copied = state.copyWith(
        settings: const UserSettings(themeMode: ThemeModeSetting.dark),
        isLoading: false,
      );

      expect(copied.settings.themeMode, ThemeModeSetting.dark);
      expect(copied.isLoading, isFalse);
    });
  });

  group('UserSettingsNotifier', () {
    late UserSettingsNotifier notifier;

    setUp(() {
      when(() => mockRepository.getUserSettings())
          .thenAnswer((_) async => const UserSettings());
    });

    test('should load settings on init', () async {
      notifier = UserSettingsNotifier(mockRepository);

      // Wait for async initialization
      await Future.delayed(Duration.zero);

      verify(() => mockRepository.getUserSettings()).called(1);
    });

    test('should update theme mode', () async {
      when(() => mockRepository.updateUserSettings(any()))
          .thenAnswer((_) async {});

      notifier = UserSettingsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      await notifier.updateThemeMode(ThemeModeSetting.dark);

      expect(notifier.state.settings.themeMode, ThemeModeSetting.dark);
    });

    test('should update offline mode', () async {
      when(() => mockRepository.updateUserSettings(any()))
          .thenAnswer((_) async {});

      notifier = UserSettingsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      await notifier.updateOfflineMode(true);

      expect(notifier.state.settings.offlineModeEnabled, isTrue);
    });

    test('should update editor mode', () async {
      when(() => mockRepository.updateUserSettings(any()))
          .thenAnswer((_) async {});

      notifier = UserSettingsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      await notifier.updateEditorMode(EditorMode.markdown);

      expect(notifier.state.settings.defaultEditorMode, EditorMode.markdown);
    });

    test('should update font size', () async {
      when(() => mockRepository.updateUserSettings(any()))
          .thenAnswer((_) async {});

      notifier = UserSettingsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      await notifier.updateFontSize(20.0);

      expect(notifier.state.settings.fontSize, 20.0);
    });
  });

  group('OrganizationsState', () {
    test('should have default values', () {
      const state = OrganizationsState();

      expect(state.organizations, isEmpty);
      expect(state.currentOrganization, isNull);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('should copy with new values', () {
      const org = OrganizationModel(id: 'org-1', title: 'Org One');
      const state = OrganizationsState(organizations: [org]);

      final copied = state.copyWith(currentOrganization: org);

      expect(copied.organizations.length, 1);
      expect(copied.currentOrganization?.id, 'org-1');
    });
  });

  group('OrganizationsNotifier', () {
    late OrganizationsNotifier notifier;

    test('should load organizations on init', () async {
      final orgs = [
        const OrganizationModel(id: 'org-1', title: 'Org One'),
        const OrganizationModel(id: 'org-2', title: 'Org Two'),
      ];
      when(() => mockRepository.getOrganizations())
          .thenAnswer((_) async => orgs);
      when(() => mockRepository.getCurrentOrganization())
          .thenAnswer((_) async => orgs.first);

      notifier = OrganizationsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      expect(notifier.state.organizations.length, 2);
      expect(notifier.state.currentOrganization?.id, 'org-1');
    });

    test('should refresh organizations', () async {
      final orgs = [
        const OrganizationModel(id: 'org-1', title: 'Org One'),
      ];
      when(() => mockRepository.getOrganizations())
          .thenAnswer((_) async => orgs);
      when(() => mockRepository.getOrganizations(forceRefresh: true))
          .thenAnswer((_) async => orgs);
      when(() => mockRepository.getCurrentOrganization())
          .thenAnswer((_) async => orgs.first);

      notifier = OrganizationsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      await notifier.refresh();

      verify(() => mockRepository.getOrganizations(forceRefresh: true)).called(1);
    });

    test('should set current organization', () async {
      const org1 = OrganizationModel(id: 'org-1', title: 'Org One');
      const org2 = OrganizationModel(id: 'org-2', title: 'Org Two');
      final orgs = [org1, org2];

      when(() => mockRepository.getOrganizations())
          .thenAnswer((_) async => orgs);
      when(() => mockRepository.getCurrentOrganization())
          .thenAnswer((_) async => org1);
      when(() => mockRepository.setCurrentOrganization(any()))
          .thenAnswer((_) async {});

      notifier = OrganizationsNotifier(mockRepository);
      await Future.delayed(Duration.zero);

      await notifier.setCurrentOrganization(org2);

      expect(notifier.state.currentOrganization?.id, 'org-2');
      verify(() => mockRepository.setCurrentOrganization('org-2')).called(1);
    });
  });
}
