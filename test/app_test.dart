import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/user_entity.dart';

void main() {
  group('ThemeModeSetting to ThemeMode mapping', () {
    // Helper function to test theme mode mapping (same logic as in app.dart)
    ThemeMode mapThemeMode(ThemeModeSetting setting) {
      switch (setting) {
        case ThemeModeSetting.light:
          return ThemeMode.light;
        case ThemeModeSetting.dark:
          return ThemeMode.dark;
        case ThemeModeSetting.system:
          return ThemeMode.system;
      }
    }

    test('should map light setting to ThemeMode.light', () {
      expect(mapThemeMode(ThemeModeSetting.light), ThemeMode.light);
    });

    test('should map dark setting to ThemeMode.dark', () {
      expect(mapThemeMode(ThemeModeSetting.dark), ThemeMode.dark);
    });

    test('should map system setting to ThemeMode.system', () {
      expect(mapThemeMode(ThemeModeSetting.system), ThemeMode.system);
    });

    test('should cover all ThemeModeSetting values', () {
      // Ensure all enum values are handled
      for (final setting in ThemeModeSetting.values) {
        final result = mapThemeMode(setting);
        expect(result, isA<ThemeMode>());
      }
    });
  });

  group('ThemeModeSetting enum', () {
    test('should have 3 values', () {
      expect(ThemeModeSetting.values.length, 3);
    });

    test('should contain light, dark, and system', () {
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.light));
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.dark));
      expect(ThemeModeSetting.values, contains(ThemeModeSetting.system));
    });
  });
}
