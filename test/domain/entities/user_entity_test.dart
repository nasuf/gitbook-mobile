import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';

void main() {
  group('User', () {
    test('should create user with required fields', () {
      const user = User(id: 'user-123');

      expect(user.id, 'user-123');
      expect(user.displayName, isNull);
      expect(user.email, isNull);
      expect(user.photoUrl, isNull);
    });

    test('should create user with all fields', () {
      const user = User(
        id: 'user-123',
        displayName: 'John Doe',
        email: 'john@example.com',
        photoUrl: 'https://example.com/photo.jpg',
      );

      expect(user.id, 'user-123');
      expect(user.displayName, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
    });

    group('name getter', () {
      test('should return displayName if available', () {
        const user = User(
          id: 'user-123',
          displayName: 'John Doe',
          email: 'john@example.com',
        );

        expect(user.name, 'John Doe');
      });

      test('should return email if displayName is null', () {
        const user = User(
          id: 'user-123',
          email: 'john@example.com',
        );

        expect(user.name, 'john@example.com');
      });

      test('should return id if displayName and email are null', () {
        const user = User(id: 'user-123');

        expect(user.name, 'user-123');
      });
    });

    group('initials getter', () {
      test('should return initials from display name with two words', () {
        const user = User(id: 'user-123', displayName: 'John Doe');

        expect(user.initials, 'JD');
      });

      test('should return initials from display name with one word', () {
        const user = User(id: 'user-123', displayName: 'John');

        expect(user.initials, 'JO');
      });

      test('should return initials from email if no display name', () {
        const user = User(id: 'user-123', email: 'john@example.com');

        expect(user.initials, 'JO');
      });

      test('should return initials from id if no display name or email', () {
        const user = User(id: 'ab');

        expect(user.initials, 'AB');
      });

      test('should handle three word names', () {
        const user = User(id: 'user-123', displayName: 'John Middle Doe');

        expect(user.initials, 'JM');
      });

      test('should handle empty string fallback', () {
        const user = User(id: 'x');

        expect(user.initials, 'X');
      });
    });
  });

  group('UserSettings', () {
    test('should have default values', () {
      const settings = UserSettings();

      expect(settings.themeMode, ThemeModeSetting.system);
      expect(settings.defaultOrganizationId, isNull);
      expect(settings.offlineModeEnabled, isFalse);
      expect(settings.defaultEditorMode, EditorMode.wysiwyg);
      expect(settings.fontSize, 14.0);
    });

    test('should create with custom values', () {
      const settings = UserSettings(
        themeMode: ThemeModeSetting.dark,
        defaultOrganizationId: 'org-123',
        offlineModeEnabled: true,
        defaultEditorMode: EditorMode.markdown,
        fontSize: 18.0,
      );

      expect(settings.themeMode, ThemeModeSetting.dark);
      expect(settings.defaultOrganizationId, 'org-123');
      expect(settings.offlineModeEnabled, isTrue);
      expect(settings.defaultEditorMode, EditorMode.markdown);
      expect(settings.fontSize, 18.0);
    });
  });

  group('ThemeModeSetting', () {
    test('should have all expected values', () {
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.light));
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.dark));
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.system));
    });

    test('should have 3 modes', () {
      expect(ThemeModeSetting.values.length, 3);
    });
  });

  group('EditorMode', () {
    test('should have all expected values', () {
      expect(EditorMode.values, contains(EditorMode.wysiwyg));
      expect(EditorMode.values, contains(EditorMode.markdown));
      expect(EditorMode.values, contains(EditorMode.split));
    });

    test('should have 3 modes', () {
      expect(EditorMode.values.length, 3);
    });
  });
}
