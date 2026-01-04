import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/datasources/local/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('CachedOrganizations', () {
    test('should insert and retrieve organization', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-123',
        title: 'Test Organization',
        urlsLocation: const Value('https://api.gitbook.com/v1/orgs/org-123'),
        urlsApp: const Value('https://app.gitbook.com/orgs/org-123'),
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final org = await database.getOrganization('org-123');

      expect(org, isNotNull);
      expect(org!.id, 'org-123');
      expect(org.title, 'Test Organization');
      expect(org.urlsLocation, 'https://api.gitbook.com/v1/orgs/org-123');
    });

    test('should update existing organization on conflict', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-123',
        title: 'Original Title',
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-123',
        title: 'Updated Title',
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final orgs = await database.getAllOrganizations();

      expect(orgs.length, 1);
      expect(orgs.first.title, 'Updated Title');
    });

    test('should batch insert multiple organizations', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertOrganizations([
        CachedOrganizationsCompanion.insert(
          id: 'org-1',
          title: 'Org One',
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedOrganizationsCompanion.insert(
          id: 'org-2',
          title: 'Org Two',
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedOrganizationsCompanion.insert(
          id: 'org-3',
          title: 'Org Three',
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      final orgs = await database.getAllOrganizations();

      expect(orgs.length, 3);
    });

    test('should delete organization by id', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-to-delete',
        title: 'Delete Me',
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      await database.deleteOrganization('org-to-delete');

      final org = await database.getOrganization('org-to-delete');
      expect(org, isNull);
    });

    test('should delete expired organizations', () async {
      final now = DateTime.now();

      await database.upsertOrganizations([
        CachedOrganizationsCompanion.insert(
          id: 'org-expired',
          title: 'Expired',
          cachedAt: now.subtract(const Duration(hours: 2)),
          expiresAt: now.subtract(const Duration(hours: 1)),
        ),
        CachedOrganizationsCompanion.insert(
          id: 'org-valid',
          title: 'Valid',
          cachedAt: now,
          expiresAt: now.add(const Duration(hours: 1)),
        ),
      ]);

      await database.deleteExpiredOrganizations();

      final orgs = await database.getAllOrganizations();
      expect(orgs.length, 1);
      expect(orgs.first.id, 'org-valid');
    });
  });

  group('CachedSpaces', () {
    test('should insert and retrieve space', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertSpace(CachedSpacesCompanion.insert(
        id: 'space-123',
        title: 'Test Space',
        description: const Value('A test space'),
        visibility: const Value('public'),
        organizationId: const Value('org-456'),
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final space = await database.getSpace('space-123');

      expect(space, isNotNull);
      expect(space!.id, 'space-123');
      expect(space.title, 'Test Space');
      expect(space.description, 'A test space');
      expect(space.visibility, 'public');
      expect(space.organizationId, 'org-456');
    });

    test('should get spaces by organization', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertSpaces([
        CachedSpacesCompanion.insert(
          id: 'space-1',
          title: 'Space 1',
          organizationId: const Value('org-A'),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedSpacesCompanion.insert(
          id: 'space-2',
          title: 'Space 2',
          organizationId: const Value('org-A'),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedSpacesCompanion.insert(
          id: 'space-3',
          title: 'Space 3',
          organizationId: const Value('org-B'),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      final spacesOrgA = await database.getSpacesByOrganization('org-A');
      final spacesOrgB = await database.getSpacesByOrganization('org-B');

      expect(spacesOrgA.length, 2);
      expect(spacesOrgB.length, 1);
    });

    test('should delete spaces by organization', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertSpaces([
        CachedSpacesCompanion.insert(
          id: 'space-1',
          title: 'Space 1',
          organizationId: const Value('org-to-delete'),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedSpacesCompanion.insert(
          id: 'space-2',
          title: 'Space 2',
          organizationId: const Value('org-to-keep'),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      await database.deleteSpacesByOrganization('org-to-delete');

      final allSpaces = await database.getAllSpaces();
      expect(allSpaces.length, 1);
      expect(allSpaces.first.id, 'space-2');
    });
  });

  group('CachedContent', () {
    test('should insert and retrieve content', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertContent(CachedContentCompanion.insert(
        id: 'page-123',
        spaceId: 'space-456',
        title: 'Getting Started',
        type: 'document',
        path: const Value('/getting-started'),
        slug: const Value('getting-started'),
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final content = await database.getContent('page-123');

      expect(content, isNotNull);
      expect(content!.id, 'page-123');
      expect(content.title, 'Getting Started');
      expect(content.type, 'document');
      expect(content.path, '/getting-started');
    });

    test('should get content by space', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertContentList([
        CachedContentCompanion.insert(
          id: 'page-1',
          spaceId: 'space-A',
          title: 'Page 1',
          type: 'document',
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'page-2',
          spaceId: 'space-A',
          title: 'Page 2',
          type: 'document',
          orderIndex: const Value(1),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'page-3',
          spaceId: 'space-B',
          title: 'Page 3',
          type: 'document',
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      final contentA = await database.getContentBySpace('space-A');
      final contentB = await database.getContentBySpace('space-B');

      expect(contentA.length, 2);
      expect(contentB.length, 1);
      // Verify ordering
      expect(contentA[0].title, 'Page 1');
      expect(contentA[1].title, 'Page 2');
    });

    test('should get content by path', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertContent(CachedContentCompanion.insert(
        id: 'page-by-path',
        spaceId: 'space-test',
        title: 'API Reference',
        type: 'document',
        path: const Value('/api/reference'),
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final content = await database.getContentByPath('space-test', '/api/reference');

      expect(content, isNotNull);
      expect(content!.title, 'API Reference');
    });

    test('should get root content', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertContentList([
        CachedContentCompanion.insert(
          id: 'root-1',
          spaceId: 'space-test',
          title: 'Root 1',
          type: 'document',
          parentId: const Value(null),
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'child-1',
          spaceId: 'space-test',
          title: 'Child 1',
          type: 'document',
          parentId: const Value('root-1'),
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'root-2',
          spaceId: 'space-test',
          title: 'Root 2',
          type: 'document',
          parentId: const Value(null),
          orderIndex: const Value(1),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      final rootContent = await database.getRootContent('space-test');

      expect(rootContent.length, 2);
      expect(rootContent[0].id, 'root-1');
      expect(rootContent[1].id, 'root-2');
    });

    test('should get child content', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertContentList([
        CachedContentCompanion.insert(
          id: 'parent',
          spaceId: 'space-test',
          title: 'Parent',
          type: 'group',
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'child-1',
          spaceId: 'space-test',
          title: 'Child 1',
          type: 'document',
          parentId: const Value('parent'),
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'child-2',
          spaceId: 'space-test',
          title: 'Child 2',
          type: 'document',
          parentId: const Value('parent'),
          orderIndex: const Value(1),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      final children = await database.getChildContent('parent');

      expect(children.length, 2);
      expect(children[0].id, 'child-1');
      expect(children[1].id, 'child-2');
    });
  });

  group('CachedDocuments', () {
    test('should insert and retrieve document', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertDocument(CachedDocumentsCompanion.insert(
        pageId: 'page-123',
        spaceId: 'space-456',
        markdown: const Value('# Hello World\n\nThis is a test.'),
        nodesJson: const Value('{"type":"document"}'),
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final doc = await database.getDocument('page-123');

      expect(doc, isNotNull);
      expect(doc!.pageId, 'page-123');
      expect(doc.markdown, '# Hello World\n\nThis is a test.');
      expect(doc.nodesJson, '{"type":"document"}');
    });

    test('should delete documents by space', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertDocument(CachedDocumentsCompanion.insert(
        pageId: 'page-1',
        spaceId: 'space-to-delete',
        cachedAt: now,
        expiresAt: expiresAt,
      ));
      await database.upsertDocument(CachedDocumentsCompanion.insert(
        pageId: 'page-2',
        spaceId: 'space-to-keep',
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      await database.deleteDocumentsBySpace('space-to-delete');

      final deleted = await database.getDocument('page-1');
      final kept = await database.getDocument('page-2');

      expect(deleted, isNull);
      expect(kept, isNotNull);
    });
  });

  group('CachedUsers', () {
    test('should insert and retrieve user', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertUser(CachedUsersCompanion.insert(
        id: 'user-123',
        displayName: const Value('John Doe'),
        email: const Value('john@example.com'),
        photoUrl: const Value('https://example.com/photo.jpg'),
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      final user = await database.getUser('user-123');

      expect(user, isNotNull);
      expect(user!.id, 'user-123');
      expect(user.displayName, 'John Doe');
      expect(user.email, 'john@example.com');
    });
  });

  group('SyncQueue', () {
    test('should add and retrieve sync items', () async {
      await database.addToSyncQueue(SyncQueueCompanion.insert(
        operationType: 'update',
        entityType: 'page',
        entityId: 'page-123',
        spaceId: const Value('space-456'),
        payload: '{"title":"Updated Title"}',
        createdAt: DateTime.now(),
      ));

      final pending = await database.getPendingSyncItems();

      expect(pending.length, 1);
      expect(pending.first.operationType, 'update');
      expect(pending.first.entityType, 'page');
      expect(pending.first.entityId, 'page-123');
      expect(pending.first.status, 'pending');
    });

    test('should update sync item status', () async {
      final id = await database.addToSyncQueue(SyncQueueCompanion.insert(
        operationType: 'create',
        entityType: 'page',
        entityId: 'page-new',
        payload: '{}',
        createdAt: DateTime.now(),
      ));

      await database.updateSyncItem(
        id,
        const SyncQueueCompanion(
          status: Value('completed'),
        ),
      );

      final pending = await database.getPendingSyncItems();
      expect(pending, isEmpty);
    });

    test('should delete completed sync items', () async {
      final id1 = await database.addToSyncQueue(SyncQueueCompanion.insert(
        operationType: 'create',
        entityType: 'page',
        entityId: 'page-1',
        payload: '{}',
        createdAt: DateTime.now(),
      ));
      await database.addToSyncQueue(SyncQueueCompanion.insert(
        operationType: 'create',
        entityType: 'page',
        entityId: 'page-2',
        payload: '{}',
        createdAt: DateTime.now(),
      ));

      await database.updateSyncItem(
        id1,
        const SyncQueueCompanion(status: Value('completed')),
      );

      await database.deleteCompletedSyncItems();

      final pending = await database.getPendingSyncItems();
      expect(pending.length, 1);
      expect(pending.first.entityId, 'page-2');
    });
  });

  group('RecentItems', () {
    test('should add and retrieve recent items', () async {
      await database.addRecentItem(RecentItemsCompanion.insert(
        itemType: 'space',
        itemId: 'space-123',
        title: 'My Space',
        accessedAt: DateTime.now(),
      ));

      final recent = await database.getRecentItems();

      expect(recent.length, 1);
      expect(recent.first.itemType, 'space');
      expect(recent.first.title, 'My Space');
    });

    test('should order recent items by access time', () async {
      final now = DateTime.now();

      await database.addRecentItem(RecentItemsCompanion.insert(
        itemType: 'page',
        itemId: 'page-1',
        title: 'First Page',
        accessedAt: now.subtract(const Duration(hours: 2)),
      ));
      await database.addRecentItem(RecentItemsCompanion.insert(
        itemType: 'page',
        itemId: 'page-2',
        title: 'Second Page',
        accessedAt: now.subtract(const Duration(hours: 1)),
      ));
      await database.addRecentItem(RecentItemsCompanion.insert(
        itemType: 'page',
        itemId: 'page-3',
        title: 'Third Page',
        accessedAt: now,
      ));

      final recent = await database.getRecentItems();

      expect(recent.length, 3);
      expect(recent[0].title, 'Third Page');
      expect(recent[1].title, 'Second Page');
      expect(recent[2].title, 'First Page');
    });

    test('should filter recent items by type', () async {
      await database.addRecentItem(RecentItemsCompanion.insert(
        itemType: 'space',
        itemId: 'space-1',
        title: 'Space 1',
        accessedAt: DateTime.now(),
      ));
      await database.addRecentItem(RecentItemsCompanion.insert(
        itemType: 'page',
        itemId: 'page-1',
        title: 'Page 1',
        accessedAt: DateTime.now(),
      ));

      final spaces = await database.getRecentItemsByType('space');
      final pages = await database.getRecentItemsByType('page');

      expect(spaces.length, 1);
      expect(pages.length, 1);
      expect(spaces.first.title, 'Space 1');
      expect(pages.first.title, 'Page 1');
    });

    test('should limit recent items', () async {
      for (var i = 0; i < 30; i++) {
        await database.addRecentItem(RecentItemsCompanion.insert(
          itemType: 'page',
          itemId: 'page-$i',
          title: 'Page $i',
          accessedAt: DateTime.now().add(Duration(seconds: i)),
        ));
      }

      final recent = await database.getRecentItems(limit: 10);

      expect(recent.length, 10);
    });
  });

  group('Cleanup Operations', () {
    test('should delete all expired entries', () async {
      final now = DateTime.now();
      final expired = now.subtract(const Duration(hours: 1));
      final valid = now.add(const Duration(hours: 1));

      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-expired',
        title: 'Expired',
        cachedAt: now.subtract(const Duration(hours: 2)),
        expiresAt: expired,
      ));
      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-valid',
        title: 'Valid',
        cachedAt: now,
        expiresAt: valid,
      ));

      await database.upsertSpace(CachedSpacesCompanion.insert(
        id: 'space-expired',
        title: 'Expired',
        cachedAt: now.subtract(const Duration(hours: 2)),
        expiresAt: expired,
      ));

      await database.deleteAllExpired();

      final orgs = await database.getAllOrganizations();
      final spaces = await database.getAllSpaces();

      expect(orgs.length, 1);
      expect(orgs.first.id, 'org-valid');
      expect(spaces, isEmpty);
    });

    test('should clear all cache', () async {
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertOrganization(CachedOrganizationsCompanion.insert(
        id: 'org-1',
        title: 'Org',
        cachedAt: now,
        expiresAt: expiresAt,
      ));
      await database.upsertSpace(CachedSpacesCompanion.insert(
        id: 'space-1',
        title: 'Space',
        cachedAt: now,
        expiresAt: expiresAt,
      ));

      await database.clearAllCache();

      final orgs = await database.getAllOrganizations();
      final spaces = await database.getAllSpaces();

      expect(orgs, isEmpty);
      expect(spaces, isEmpty);
    });
  });
}
