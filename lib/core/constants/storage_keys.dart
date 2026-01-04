/// Storage keys for local persistence
class StorageKeys {
  StorageKeys._();

  // Secure storage keys
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiry = 'token_expiry';

  // Hive box names
  static const String settingsBox = 'settings';
  static const String cacheBox = 'cache';
  static const String draftsBox = 'drafts';

  // Settings keys
  static const String themeMode = 'theme_mode';
  static const String currentOrgId = 'current_org_id';
  static const String editorMode = 'editor_mode';
  static const String autoSaveInterval = 'auto_save_interval';
  static const String fontSize = 'font_size';
}
