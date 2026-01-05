import 'dart:async';

import 'package:drift/drift.dart';

import '../../data/datasources/local/database/app_database.dart';
import 'hive_storage.dart';

/// Cache duration configurations
class CacheDuration {
  /// Default cache duration for frequently accessed data
  static const Duration short = Duration(minutes: 15);

  /// Cache duration for moderately accessed data
  static const Duration medium = Duration(hours: 1);

  /// Cache duration for rarely changed data
  static const Duration long = Duration(hours: 24);

  /// Cache duration for static/rarely changed data
  static const Duration extended = Duration(days: 7);

  /// Specific durations for different entity types
  static const Duration organizations = Duration(hours: 6);
  static const Duration spaces = Duration(hours: 1);
  static const Duration content = Duration(minutes: 30);
  static const Duration documents = Duration(minutes: 30);
  static const Duration users = Duration(hours: 12);
}

/// Cache invalidation strategies
enum CacheStrategy {
  /// Cache first, then network
  cacheFirst,

  /// Network first, fallback to cache
  networkFirst,

  /// Cache only (offline mode)
  cacheOnly,

  /// Network only (always fresh)
  networkOnly,

  /// Stale while revalidate
  staleWhileRevalidate,
}

/// Manages caching operations and invalidation
class CacheManager {
  final AppDatabase _database;
  final HiveStorage _hiveStorage;

  /// Timer for periodic cache cleanup
  Timer? _cleanupTimer;

  /// Whether cache manager is initialized
  bool _initialized = false;

  CacheManager({
    required AppDatabase database,
    required HiveStorage hiveStorage,
  })  : _database = database,
        _hiveStorage = hiveStorage;

  /// Initialize cache manager
  Future<void> initialize() async {
    if (_initialized) return;

    // Run initial cleanup
    await cleanupExpired();

    // Schedule periodic cleanup every hour
    _cleanupTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => cleanupExpired(),
    );

    _initialized = true;
  }

  /// Dispose cache manager
  void dispose() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
    _initialized = false;
  }

  // ============ Cache Invalidation ============

  /// Clean up all expired cache entries
  Future<void> cleanupExpired() async {
    await _database.deleteAllExpired();

    // Clean up expired Hive cache entries
    final metadataBox = _hiveStorage;
    final cacheKeys = metadataBox.getAllDraftIds(); // Reuse to get all cache keys
    for (final key in cacheKeys) {
      if (!metadataBox.isCacheValid(key)) {
        await metadataBox.removeCache(key);
        await metadataBox.removeCacheMetadata(key);
      }
    }
  }

  /// Invalidate cache for a specific organization
  Future<void> invalidateOrganization(String orgId) async {
    await _database.deleteOrganization(orgId);
    await _database.deleteSpacesByOrganization(orgId);
    await _hiveStorage.removeCache('org_$orgId');
    await _hiveStorage.removeCacheMetadata('org_$orgId');
  }

  /// Invalidate cache for a specific space
  Future<void> invalidateSpace(String spaceId) async {
    await _database.deleteSpace(spaceId);
    await _database.deleteContentBySpace(spaceId);
    await _database.deleteDocumentsBySpace(spaceId);
    await _hiveStorage.removeCache('space_$spaceId');
    await _hiveStorage.removeCacheMetadata('space_$spaceId');
  }

  /// Invalidate cache for a specific page/content
  Future<void> invalidateContent(String contentId) async {
    await _database.deleteContent(contentId);
    await _database.deleteDocument(contentId);
    await _hiveStorage.removeCache('content_$contentId');
    await _hiveStorage.removeCacheMetadata('content_$contentId');
  }

  /// Invalidate all organization cache
  Future<void> invalidateAllOrganizations() async {
    await _database.delete(_database.cachedOrganizations).go();
    await _hiveStorage.clearCache();
  }

  /// Invalidate all space cache
  Future<void> invalidateAllSpaces() async {
    await _database.delete(_database.cachedSpaces).go();
    await _database.delete(_database.cachedContent).go();
    await _database.delete(_database.cachedDocuments).go();
  }

  /// Clear all cache
  Future<void> clearAll() async {
    await _database.clearAllCache();
    await _hiveStorage.clearCache();
  }

  // ============ Cache Status ============

  /// Check if organization cache is valid
  Future<bool> isOrganizationCacheValid(String orgId) async {
    final org = await _database.getOrganization(orgId);
    if (org == null) return false;
    return org.expiresAt.isAfter(DateTime.now());
  }

  /// Check if space cache is valid
  Future<bool> isSpaceCacheValid(String spaceId) async {
    final space = await _database.getSpace(spaceId);
    if (space == null) return false;
    return space.expiresAt.isAfter(DateTime.now());
  }

  /// Check if content cache is valid
  Future<bool> isContentCacheValid(String contentId) async {
    final content = await _database.getContent(contentId);
    if (content == null) return false;
    return content.expiresAt.isAfter(DateTime.now());
  }

  /// Check if space content list cache is valid
  Future<bool> isSpaceContentCacheValid(String spaceId) async {
    final contents = await _database.getContentBySpace(spaceId);
    if (contents.isEmpty) return false;
    return contents.every((c) => c.expiresAt.isAfter(DateTime.now()));
  }

  // ============ Cache Statistics ============

  /// Get cache statistics
  Future<CacheStats> getStats() async {
    final orgs = await _database.getAllOrganizations();
    final spaces = await _database.getAllSpaces();
    final recentItems = await _database.getRecentItems();
    final pendingSync = await _database.getPendingSyncItems();

    return CacheStats(
      organizationCount: orgs.length,
      spaceCount: spaces.length,
      contentCount: 0, // Would need a count query
      recentItemCount: recentItems.length,
      pendingSyncCount: pendingSync.length,
      lastSyncTime: _hiveStorage.getLastSyncTime(),
    );
  }

  // ============ Sync Queue Operations ============

  /// Add an operation to the sync queue
  Future<int> queueOperation({
    required String operationType,
    required String entityType,
    required String entityId,
    String? spaceId,
    required String payload,
  }) async {
    return _database.addToSyncQueue(
      SyncQueueCompanion.insert(
        operationType: operationType,
        entityType: entityType,
        entityId: entityId,
        spaceId: Value(spaceId),
        payload: payload,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Get pending sync operations
  Future<List<SyncQueueData>> getPendingOperations() {
    return _database.getPendingSyncItems();
  }

  /// Mark sync operation as completed
  Future<void> markSyncCompleted(int id) async {
    await _database.updateSyncItem(
      id,
      const SyncQueueCompanion(
        status: Value('completed'),
      ),
    );
  }

  /// Mark sync operation as failed
  Future<void> markSyncFailed(int id, String errorMessage) async {
    await _database.updateSyncItem(
      id,
      SyncQueueCompanion(
        status: const Value('failed'),
        errorMessage: Value(errorMessage),
        retryCount: const Value(1), // Increment would need current value
        lastAttemptAt: Value(DateTime.now()),
      ),
    );
  }

  /// Clear completed sync operations
  Future<void> clearCompletedSyncs() {
    return _database.deleteCompletedSyncItems();
  }

  // ============ Recent Items ============

  /// Add a recent item
  Future<void> addRecentItem({
    required String itemType,
    required String itemId,
    required String title,
    String? spaceId,
    String? path,
  }) async {
    await _database.addRecentItem(
      RecentItemsCompanion.insert(
        itemType: itemType,
        itemId: itemId,
        title: title,
        spaceId: Value(spaceId),
        path: Value(path),
        accessedAt: DateTime.now(),
      ),
    );
  }

  /// Get recent items
  Future<List<RecentItem>> getRecentItems({int limit = 20}) {
    return _database.getRecentItems(limit: limit);
  }

  /// Clear recent items
  Future<void> clearRecentItems() {
    return _database.clearRecentItems();
  }
}

/// Cache statistics
class CacheStats {
  final int organizationCount;
  final int spaceCount;
  final int contentCount;
  final int recentItemCount;
  final int pendingSyncCount;
  final DateTime? lastSyncTime;

  CacheStats({
    required this.organizationCount,
    required this.spaceCount,
    required this.contentCount,
    required this.recentItemCount,
    required this.pendingSyncCount,
    this.lastSyncTime,
  });

  /// Check if cache is empty
  bool get isEmpty =>
      organizationCount == 0 && spaceCount == 0 && contentCount == 0;

  /// Check if there are pending sync operations
  bool get hasPendingSync => pendingSyncCount > 0;
}
