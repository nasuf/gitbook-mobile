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
  static const String cacheMetadataBox = 'cache_metadata';

  // Settings keys
  static const String themeMode = 'theme_mode';
  static const String currentOrgId = 'current_org_id';
  static const String currentUserId = 'current_user_id';
  static const String editorMode = 'editor_mode';
  static const String autoSaveInterval = 'auto_save_interval';
  static const String fontSize = 'font_size';
  static const String offlineModeEnabled = 'offline_mode_enabled';
  static const String lastSyncTime = 'last_sync_time';

  // Cache keys prefixes
  static const String orgCachePrefix = 'org_';
  static const String spaceCachePrefix = 'space_';
  static const String contentCachePrefix = 'content_';
  static const String userCachePrefix = 'user_';

  // Cache metadata keys
  static const String cacheVersion = 'cache_version';
  static const String cacheCreatedAt = 'cache_created_at';
  static const String cacheExpiresAt = 'cache_expires_at';
}
