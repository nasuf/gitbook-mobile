import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ============ Table Definitions ============

/// Cached organizations table
class CachedOrganizations extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get urlsLocation => text().nullable()();
  TextColumn get urlsApp => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get cachedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached spaces table
class CachedSpaces extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get visibility => text().nullable()();
  TextColumn get organizationId => text().nullable()();
  TextColumn get urlsLocation => text().nullable()();
  TextColumn get urlsApp => text().nullable()();
  TextColumn get urlsPublished => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  DateTimeColumn get cachedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached content/pages table
class CachedContent extends Table {
  TextColumn get id => text()();
  TextColumn get spaceId => text()();
  TextColumn get title => text()();
  TextColumn get type => text()();
  TextColumn get path => text().nullable()();
  TextColumn get slug => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get parentId => text().nullable()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
  TextColumn get urlsLocation => text().nullable()();
  TextColumn get urlsApp => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get cachedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Cached document content (markdown/nodes)
class CachedDocuments extends Table {
  TextColumn get pageId => text()();
  TextColumn get spaceId => text()();
  TextColumn get markdown => text().nullable()();
  TextColumn get nodesJson => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {pageId};
}

/// Cached users table
class CachedUsers extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get photoUrl => text().nullable()();
  DateTimeColumn get cachedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Sync queue for offline operations
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operationType => text()(); // create, update, delete
  TextColumn get entityType => text()(); // space, page, etc.
  TextColumn get entityId => text()();
  TextColumn get spaceId => text().nullable()();
  TextColumn get payload => text()(); // JSON payload
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, syncing, failed, completed
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
}

/// Recent items for quick access
class RecentItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemType => text()(); // space, page
  TextColumn get itemId => text()();
  TextColumn get title => text()();
  TextColumn get spaceId => text().nullable()();
  TextColumn get path => text().nullable()();
  DateTimeColumn get accessedAt => dateTime()();
}

// ============ Database Class ============

@DriftDatabase(tables: [
  CachedOrganizations,
  CachedSpaces,
  CachedContent,
  CachedDocuments,
  CachedUsers,
  SyncQueue,
  RecentItems,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Constructor for testing with custom executor
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle future migrations here
        },
      );

  // ============ Organization Operations ============

  Future<List<CachedOrganization>> getAllOrganizations() {
    return select(cachedOrganizations).get();
  }

  Future<CachedOrganization?> getOrganization(String id) {
    return (select(cachedOrganizations)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertOrganization(CachedOrganizationsCompanion org) {
    return into(cachedOrganizations).insertOnConflictUpdate(org);
  }

  Future<void> upsertOrganizations(List<CachedOrganizationsCompanion> orgs) {
    return batch((b) {
      b.insertAllOnConflictUpdate(cachedOrganizations, orgs);
    });
  }

  Future<int> deleteOrganization(String id) {
    return (delete(cachedOrganizations)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteExpiredOrganizations() {
    return (delete(cachedOrganizations)
          ..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now())))
        .go();
  }

  // ============ Space Operations ============

  Future<List<CachedSpace>> getAllSpaces() {
    return select(cachedSpaces).get();
  }

  Future<List<CachedSpace>> getSpacesByOrganization(String orgId) {
    return (select(cachedSpaces)..where((t) => t.organizationId.equals(orgId)))
        .get();
  }

  Future<CachedSpace?> getSpace(String id) {
    return (select(cachedSpaces)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertSpace(CachedSpacesCompanion space) {
    return into(cachedSpaces).insertOnConflictUpdate(space);
  }

  Future<void> upsertSpaces(List<CachedSpacesCompanion> spaces) {
    return batch((b) {
      b.insertAllOnConflictUpdate(cachedSpaces, spaces);
    });
  }

  Future<int> deleteSpace(String id) {
    return (delete(cachedSpaces)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteSpacesByOrganization(String orgId) {
    return (delete(cachedSpaces)..where((t) => t.organizationId.equals(orgId)))
        .go();
  }

  Future<int> deleteExpiredSpaces() {
    return (delete(cachedSpaces)
          ..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now())))
        .go();
  }

  // ============ Content Operations ============

  Future<List<CachedContentData>> getContentBySpace(String spaceId) {
    return (select(cachedContent)
          ..where((t) => t.spaceId.equals(spaceId))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();
  }

  Future<List<CachedContentData>> getRootContent(String spaceId) {
    return (select(cachedContent)
          ..where((t) => t.spaceId.equals(spaceId) & t.parentId.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();
  }

  Future<List<CachedContentData>> getChildContent(String parentId) {
    return (select(cachedContent)
          ..where((t) => t.parentId.equals(parentId))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();
  }

  Future<CachedContentData?> getContent(String id) {
    return (select(cachedContent)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<CachedContentData?> getContentByPath(String spaceId, String path) {
    return (select(cachedContent)
          ..where((t) => t.spaceId.equals(spaceId) & t.path.equals(path)))
        .getSingleOrNull();
  }

  Future<void> upsertContent(CachedContentCompanion content) {
    return into(cachedContent).insertOnConflictUpdate(content);
  }

  Future<void> upsertContentList(List<CachedContentCompanion> contents) {
    return batch((b) {
      b.insertAllOnConflictUpdate(cachedContent, contents);
    });
  }

  Future<int> deleteContent(String id) {
    return (delete(cachedContent)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteContentBySpace(String spaceId) {
    return (delete(cachedContent)..where((t) => t.spaceId.equals(spaceId))).go();
  }

  Future<int> deleteExpiredContent() {
    return (delete(cachedContent)
          ..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now())))
        .go();
  }

  // ============ Document Operations ============

  Future<CachedDocument?> getDocument(String pageId) {
    return (select(cachedDocuments)..where((t) => t.pageId.equals(pageId)))
        .getSingleOrNull();
  }

  Future<void> upsertDocument(CachedDocumentsCompanion doc) {
    return into(cachedDocuments).insertOnConflictUpdate(doc);
  }

  Future<int> deleteDocument(String pageId) {
    return (delete(cachedDocuments)..where((t) => t.pageId.equals(pageId))).go();
  }

  Future<int> deleteDocumentsBySpace(String spaceId) {
    return (delete(cachedDocuments)..where((t) => t.spaceId.equals(spaceId)))
        .go();
  }

  Future<int> deleteExpiredDocuments() {
    return (delete(cachedDocuments)
          ..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now())))
        .go();
  }

  // ============ User Operations ============

  Future<CachedUser?> getUser(String id) {
    return (select(cachedUsers)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsertUser(CachedUsersCompanion user) {
    return into(cachedUsers).insertOnConflictUpdate(user);
  }

  Future<int> deleteUser(String id) {
    return (delete(cachedUsers)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteExpiredUsers() {
    return (delete(cachedUsers)
          ..where((t) => t.expiresAt.isSmallerThanValue(DateTime.now())))
        .go();
  }

  // ============ Sync Queue Operations ============

  Future<List<SyncQueueData>> getPendingSyncItems() {
    return (select(syncQueue)
          ..where((t) => t.status.equals('pending') | t.status.equals('failed'))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  Future<List<SyncQueueData>> getSyncItemsByEntity(
      String entityType, String entityId) {
    return (select(syncQueue)
          ..where(
              (t) => t.entityType.equals(entityType) & t.entityId.equals(entityId)))
        .get();
  }

  Future<int> addToSyncQueue(SyncQueueCompanion item) {
    return into(syncQueue).insert(item);
  }

  Future<bool> updateSyncItem(int id, SyncQueueCompanion item) {
    return (update(syncQueue)..where((t) => t.id.equals(id))).write(item).then(
          (rows) => rows > 0,
        );
  }

  Future<int> deleteSyncItem(int id) {
    return (delete(syncQueue)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteCompletedSyncItems() {
    return (delete(syncQueue)..where((t) => t.status.equals('completed'))).go();
  }

  Future<int> clearSyncQueue() {
    return delete(syncQueue).go();
  }

  // ============ Recent Items Operations ============

  Future<List<RecentItem>> getRecentItems({int limit = 20}) {
    return (select(recentItems)
          ..orderBy([(t) => OrderingTerm.desc(t.accessedAt)])
          ..limit(limit))
        .get();
  }

  Future<List<RecentItem>> getRecentItemsByType(String itemType, {int limit = 10}) {
    return (select(recentItems)
          ..where((t) => t.itemType.equals(itemType))
          ..orderBy([(t) => OrderingTerm.desc(t.accessedAt)])
          ..limit(limit))
        .get();
  }

  Future<void> addRecentItem(RecentItemsCompanion item) async {
    // Remove existing entry for same item if exists
    await (delete(recentItems)
          ..where((t) =>
              t.itemType.equals(item.itemType.value) &
              t.itemId.equals(item.itemId.value)))
        .go();

    // Insert new entry
    await into(recentItems).insert(item);

    // Keep only latest 50 items
    final count = await (selectOnly(recentItems)..addColumns([recentItems.id.count()])).getSingle();
    final itemCount = count.read(recentItems.id.count()) ?? 0;
    if (itemCount > 50) {
      final oldItems = await (select(recentItems)
            ..orderBy([(t) => OrderingTerm.desc(t.accessedAt)])
            ..limit(100, offset: 50))
          .get();
      for (final item in oldItems) {
        await (delete(recentItems)..where((t) => t.id.equals(item.id))).go();
      }
    }
  }

  Future<int> deleteRecentItem(String itemType, String itemId) {
    return (delete(recentItems)
          ..where((t) => t.itemType.equals(itemType) & t.itemId.equals(itemId)))
        .go();
  }

  Future<int> clearRecentItems() {
    return delete(recentItems).go();
  }

  // ============ Cleanup Operations ============

  /// Delete all expired cache entries
  Future<void> deleteAllExpired() async {
    await deleteExpiredOrganizations();
    await deleteExpiredSpaces();
    await deleteExpiredContent();
    await deleteExpiredDocuments();
    await deleteExpiredUsers();
  }

  /// Clear all cached data
  Future<void> clearAllCache() async {
    await delete(cachedOrganizations).go();
    await delete(cachedSpaces).go();
    await delete(cachedContent).go();
    await delete(cachedDocuments).go();
    await delete(cachedUsers).go();
    await delete(recentItems).go();
  }

  /// Clear everything including sync queue
  Future<void> clearAll() async {
    await clearAllCache();
    await clearSyncQueue();
  }
}

/// Open database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'gitbook_cache.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
