import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

/// User entity representing the current authenticated user
@freezed
class User with _$User {
  const User._();

  const factory User({
    required String id,
    String? displayName,
    String? email,
    String? photoUrl,
  }) = _User;

  /// Get display name or fallback to email or id
  String get name => displayName ?? email ?? id;

  /// Get initials for avatar
  String get initials {
    final name = displayName ?? email ?? id;
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length.clamp(0, 2)).toUpperCase();
    }
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
}

/// User settings entity
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(ThemeModeSetting.system) ThemeModeSetting themeMode,
    String? defaultOrganizationId,
    @Default(false) bool offlineModeEnabled,
    @Default(EditorMode.wysiwyg) EditorMode defaultEditorMode,
    @Default(14.0) double fontSize,
  }) = _UserSettings;
}

/// Theme mode setting
enum ThemeModeSetting {
  light,
  dark,
  system,
}

/// Editor mode setting
enum EditorMode {
  wysiwyg,
  markdown,
  split,
}
