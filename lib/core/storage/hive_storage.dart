import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../constants/storage_keys.dart';

/// Hive-based storage for lightweight key-value persistence
/// Used for settings, preferences, and simple caching
class HiveStorage {
  static bool _initialized = false;

  /// Initialize Hive storage
  static Future<void> initialize() async {
    if (_initialized) return;

    await Hive.initFlutter();
    await _openBoxes();
    _initialized = true;
  }

  /// Open all required Hive boxes
  static Future<void> _openBoxes() async {
    await Future.wait([
      Hive.openBox<dynamic>(StorageKeys.settingsBox),
      Hive.openBox<String>(StorageKeys.cacheBox),
      Hive.openBox<String>(StorageKeys.draftsBox),
      Hive.openBox<dynamic>(StorageKeys.cacheMetadataBox),
    ]);
  }

  /// Close all Hive boxes
  static Future<void> close() async {
    await Hive.close();
    _initialized = false;
  }

  /// Clear all Hive data
  static Future<void> clearAll() async {
    await Hive.box(StorageKeys.settingsBox).clear();
    await Hive.box<String>(StorageKeys.cacheBox).clear();
    await Hive.box<String>(StorageKeys.draftsBox).clear();
    await Hive.box(StorageKeys.cacheMetadataBox).clear();
  }

  // ============ Settings Box ============

  Box<dynamic> get _settingsBox => Hive.box(StorageKeys.settingsBox);

  /// Get a setting value
  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  /// Set a setting value
  Future<void> setSetting<T>(String key, T value) async {
    await _settingsBox.put(key, value);
  }

  /// Remove a setting
  Future<void> removeSetting(String key) async {
    await _settingsBox.delete(key);
  }

  /// Get theme mode (0: system, 1: light, 2: dark)
  int getThemeMode() {
    return getSetting<int>(StorageKeys.themeMode, defaultValue: 0) ?? 0;
  }

  /// Set theme mode
  Future<void> setThemeMode(int mode) async {
    await setSetting(StorageKeys.themeMode, mode);
  }

  /// Get current organization ID
  String? getCurrentOrgId() {
    return getSetting<String>(StorageKeys.currentOrgId);
  }

  /// Set current organization ID
  Future<void> setCurrentOrgId(String? orgId) async {
    if (orgId == null) {
      await removeSetting(StorageKeys.currentOrgId);
    } else {
      await setSetting(StorageKeys.currentOrgId, orgId);
    }
  }

  /// Get current user ID
  String? getCurrentUserId() {
    return getSetting<String>(StorageKeys.currentUserId);
  }

  /// Set current user ID
  Future<void> setCurrentUserId(String? userId) async {
    if (userId == null) {
      await removeSetting(StorageKeys.currentUserId);
    } else {
      await setSetting(StorageKeys.currentUserId, userId);
    }
  }

  /// Check if offline mode is enabled
  bool isOfflineModeEnabled() {
    return getSetting<bool>(StorageKeys.offlineModeEnabled, defaultValue: false) ?? false;
  }

  /// Set offline mode
  Future<void> setOfflineModeEnabled(bool enabled) async {
    await setSetting(StorageKeys.offlineModeEnabled, enabled);
  }

  /// Get last sync time
  DateTime? getLastSyncTime() {
    final timestamp = getSetting<int>(StorageKeys.lastSyncTime);
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Set last sync time
  Future<void> setLastSyncTime(DateTime time) async {
    await setSetting(StorageKeys.lastSyncTime, time.millisecondsSinceEpoch);
  }

  /// Get editor font size
  double getFontSize() {
    return getSetting<double>(StorageKeys.fontSize, defaultValue: 16.0) ?? 16.0;
  }

  /// Set editor font size
  Future<void> setFontSize(double size) async {
    await setSetting(StorageKeys.fontSize, size);
  }

  /// Get auto save interval in seconds
  int getAutoSaveInterval() {
    return getSetting<int>(StorageKeys.autoSaveInterval, defaultValue: 30) ?? 30;
  }

  /// Set auto save interval
  Future<void> setAutoSaveInterval(int seconds) async {
    await setSetting(StorageKeys.autoSaveInterval, seconds);
  }

  // ============ Cache Box ============

  Box<String> get _cacheBox => Hive.box<String>(StorageKeys.cacheBox);

  /// Get cached JSON data
  Map<String, dynamic>? getCachedJson(String key) {
    final data = _cacheBox.get(key);
    if (data == null) return null;
    try {
      return json.decode(data) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Cache JSON data
  Future<void> cacheJson(String key, Map<String, dynamic> data) async {
    await _cacheBox.put(key, json.encode(data));
  }

  /// Get cached list data
  List<Map<String, dynamic>>? getCachedList(String key) {
    final data = _cacheBox.get(key);
    if (data == null) return null;
    try {
      final list = json.decode(data) as List<dynamic>;
      return list.cast<Map<String, dynamic>>();
    } catch (_) {
      return null;
    }
  }

  /// Cache list data
  Future<void> cacheList(String key, List<Map<String, dynamic>> data) async {
    await _cacheBox.put(key, json.encode(data));
  }

  /// Remove cached data
  Future<void> removeCache(String key) async {
    await _cacheBox.delete(key);
  }

  /// Clear all cache
  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  /// Check if cache exists
  bool hasCache(String key) {
    return _cacheBox.containsKey(key);
  }

  // ============ Drafts Box ============

  Box<String> get _draftsBox => Hive.box<String>(StorageKeys.draftsBox);

  /// Get draft content
  String? getDraft(String pageId) {
    return _draftsBox.get(pageId);
  }

  /// Save draft content
  Future<void> saveDraft(String pageId, String content) async {
    await _draftsBox.put(pageId, content);
  }

  /// Delete draft
  Future<void> deleteDraft(String pageId) async {
    await _draftsBox.delete(pageId);
  }

  /// Get all draft page IDs
  List<String> getAllDraftIds() {
    return _draftsBox.keys.cast<String>().toList();
  }

  /// Check if draft exists
  bool hasDraft(String pageId) {
    return _draftsBox.containsKey(pageId);
  }

  /// Clear all drafts
  Future<void> clearDrafts() async {
    await _draftsBox.clear();
  }

  // ============ Cache Metadata ============

  Box<dynamic> get _metadataBox => Hive.box(StorageKeys.cacheMetadataBox);

  /// Get cache metadata
  CacheMetadata? getCacheMetadata(String key) {
    final data = _metadataBox.get(key);
    if (data == null) return null;
    try {
      if (data is Map) {
        return CacheMetadata.fromMap(Map<String, dynamic>.from(data));
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Set cache metadata
  Future<void> setCacheMetadata(String key, CacheMetadata metadata) async {
    await _metadataBox.put(key, metadata.toMap());
  }

  /// Remove cache metadata
  Future<void> removeCacheMetadata(String key) async {
    await _metadataBox.delete(key);
  }

  /// Check if cache is valid (not expired)
  bool isCacheValid(String key) {
    final metadata = getCacheMetadata(key);
    if (metadata == null) return false;
    return !metadata.isExpired;
  }
}

/// Metadata for cached items
class CacheMetadata {
  final DateTime createdAt;
  final DateTime expiresAt;
  final String? etag;
  final int version;

  CacheMetadata({
    required this.createdAt,
    required this.expiresAt,
    this.etag,
    this.version = 1,
  });

  /// Create metadata with default TTL
  factory CacheMetadata.withTtl(Duration ttl, {String? etag, int version = 1}) {
    final now = DateTime.now();
    return CacheMetadata(
      createdAt: now,
      expiresAt: now.add(ttl),
      etag: etag,
      version: version,
    );
  }

  /// Check if cache has expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Time until expiration
  Duration get timeUntilExpiry => expiresAt.difference(DateTime.now());

  Map<String, dynamic> toMap() => {
        'createdAt': createdAt.millisecondsSinceEpoch,
        'expiresAt': expiresAt.millisecondsSinceEpoch,
        'etag': etag,
        'version': version,
      };

  factory CacheMetadata.fromMap(Map<String, dynamic> map) {
    return CacheMetadata(
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      expiresAt: DateTime.fromMillisecondsSinceEpoch(map['expiresAt'] as int),
      etag: map['etag'] as String?,
      version: map['version'] as int? ?? 1,
    );
  }
}
