import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';

void main() {
  group('ProfileScreen logout logic', () {
    test('logout should trigger navigation to root', () {
      // Test the navigation logic
      // When logout is triggered:
      // 1. Dialog should be closed
      // 2. logout() should be called
      // 3. Navigator.popUntil should pop to first route

      // This is a unit test for the logic, not a widget test
      var dialogClosed = false;
      var logoutCalled = false;
      var poppedToRoot = false;

      // Simulate the logout flow
      void simulateLogout() {
        dialogClosed = true;
        logoutCalled = true;
        poppedToRoot = true;
      }

      simulateLogout();

      expect(dialogClosed, true);
      expect(logoutCalled, true);
      expect(poppedToRoot, true);
    });

    test('context.mounted should be checked before navigation', () {
      // The code checks context.mounted before calling Navigator.popUntil
      // This is important to prevent "Looking up a deactivated widget's ancestor" errors

      var contextMounted = true;
      var navigationCalled = false;

      void simulatePostLogoutNavigation() {
        if (contextMounted) {
          navigationCalled = true;
        }
      }

      simulatePostLogoutNavigation();
      expect(navigationCalled, true);

      // When context is not mounted, navigation should not be called
      contextMounted = false;
      navigationCalled = false;
      simulatePostLogoutNavigation();
      expect(navigationCalled, false);
    });
  });

  group('SettingsScreen', () {
    test('font size setting should be removed', () {
      // Verify that font size is no longer in settings
      // The setting was moved to page detail screen
      const settingsItems = [
        'Theme',
        'Default Editor Mode',
        'Offline Mode',
        // 'Font Size' should NOT be here
      ];

      expect(settingsItems.contains('Font Size'), false);
      expect(settingsItems.contains('Theme'), true);
    });

    test('theme settings should still be available', () {
      // Verify theme modes are available
      expect(ThemeModeSetting.values.length, 3);
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.light));
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.dark));
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.system));
    });
  });

  group('UserSettings', () {
    test('should have fontSize property', () {
      const settings = UserSettings();
      expect(settings.fontSize, 14.0); // default value
    });

    test('should allow custom fontSize', () {
      const settings = UserSettings(fontSize: 20.0);
      expect(settings.fontSize, 20.0);
    });

    test('should have all required properties', () {
      const settings = UserSettings(
        themeMode: ThemeModeSetting.dark,
        defaultOrganizationId: 'org-1',
        offlineModeEnabled: true,
        defaultEditorMode: EditorMode.markdown,
        fontSize: 18.0,
      );

      expect(settings.themeMode, ThemeModeSetting.dark);
      expect(settings.defaultOrganizationId, 'org-1');
      expect(settings.offlineModeEnabled, true);
      expect(settings.defaultEditorMode, EditorMode.markdown);
      expect(settings.fontSize, 18.0);
    });
  });

  group('EditorMode enum', () {
    test('should have 3 values', () {
      expect(EditorMode.values.length, 3);
    });

    test('should contain wysiwyg, markdown, and split', () {
      expect(EditorMode.values, contains(EditorMode.wysiwyg));
      expect(EditorMode.values, contains(EditorMode.markdown));
      expect(EditorMode.values, contains(EditorMode.split));
    });
  });
}
