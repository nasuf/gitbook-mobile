import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/datasources/local/content_local_datasource.dart';
import 'package:gitbook_mobile/data/datasources/local/database/app_database.dart';
import 'package:gitbook_mobile/data/models/content_model.dart';
import 'package:gitbook_mobile/data/models/organization_model.dart';
import 'package:gitbook_mobile/data/models/space_model.dart';
import 'package:gitbook_mobile/data/models/user_model.dart';

void main() {
  late AppDatabase database;
  late ContentLocalDataSource dataSource;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
    dataSource = ContentLocalDataSource(database: database);
  });

  tearDown(() async {
    await database.close();
  });

  group('Organization Operations', () {
    test('should cache and retrieve organizations', () async {
      final organizations = [
        const OrganizationModel(
          id: 'org-1',
          title: 'Organization One',
          urls: OrganizationUrls(
            location: 'https://api.gitbook.com/v1/orgs/org-1',
            app: 'https://app.gitbook.com/orgs/org-1',
          ),
        ),
        const OrganizationModel(
          id: 'org-2',
          title: 'Organization Two',
        ),
      ];

      await dataSource.cacheOrganizations(organizations);

      final cached = await dataSource.getOrganizations();

      expect(cached.length, 2);
      expect(cached[0].id, 'org-1');
      expect(cached[0].title, 'Organization One');
      expect(cached[0].urls?.location, 'https://api.gitbook.com/v1/orgs/org-1');
      expect(cached[1].id, 'org-2');
    });

    test('should retrieve single organization by id', () async {
      await dataSource.cacheOrganization(
        const OrganizationModel(
          id: 'org-single',
          title: 'Single Org',
        ),
      );

      final org = await dataSource.getOrganization('org-single');

      expect(org, isNotNull);
      expect(org!.id, 'org-single');
      expect(org.title, 'Single Org');
    });

    test('should return null for non-existent organization', () async {
      final org = await dataSource.getOrganization('non-existent');

      expect(org, isNull);
    });

    test('should cache organization with custom TTL', () async {
      await dataSource.cacheOrganization(
        const OrganizationModel(id: 'org-ttl', title: 'TTL Org'),
        ttl: const Duration(hours: 12),
      );

      final org = await database.getOrganization('org-ttl');

      expect(org, isNotNull);
      expect(org!.expiresAt.difference(org.cachedAt).inHours, 12);
    });
  });

  group('Space Operations', () {
    test('should cache and retrieve spaces by organization', () async {
      final spaces = [
        const SpaceModel(
          id: 'space-1',
          title: 'Space One',
          description: 'First space',
          visibility: SpaceVisibility.public,
          organizationId: 'org-A',
          urls: SpaceUrls(
            location: 'https://api.gitbook.com/v1/spaces/space-1',
            app: 'https://app.gitbook.com/spaces/space-1',
            published: 'https://docs.example.com',
          ),
        ),
        const SpaceModel(
          id: 'space-2',
          title: 'Space Two',
          visibility: SpaceVisibility.private,
          organizationId: 'org-A',
        ),
        const SpaceModel(
          id: 'space-3',
          title: 'Space Three',
          organizationId: 'org-B',
        ),
      ];

      await dataSource.cacheSpaces(spaces);

      final spacesOrgA = await dataSource.getSpacesByOrganization('org-A');
      final spacesOrgB = await dataSource.getSpacesByOrganization('org-B');

      expect(spacesOrgA.length, 2);
      expect(spacesOrgB.length, 1);
      expect(spacesOrgA[0].visibility, SpaceVisibility.public);
      expect(spacesOrgA[0].urls?.published, 'https://docs.example.com');
    });

    test('should retrieve single space by id', () async {
      await dataSource.cacheSpace(
        const SpaceModel(
          id: 'space-single',
          title: 'Single Space',
          visibility: SpaceVisibility.shareLink,
        ),
      );

      final space = await dataSource.getSpace('space-single');

      expect(space, isNotNull);
      expect(space!.id, 'space-single');
      expect(space.visibility, SpaceVisibility.shareLink);
    });

    test('should return null for non-existent space', () async {
      final space = await dataSource.getSpace('non-existent');

      expect(space, isNull);
    });
  });

  group('Content Operations', () {
    test('should cache and retrieve content by space', () async {
      final contents = [
        const ContentModel(
          id: 'page-1',
          title: 'Introduction',
          type: ContentType.document,
          path: '/introduction',
          slug: 'introduction',
        ),
        const ContentModel(
          id: 'page-2',
          title: 'Getting Started',
          type: ContentType.document,
          path: '/getting-started',
          slug: 'getting-started',
        ),
      ];

      await dataSource.cacheContent('space-test', contents);

      final cached = await dataSource.getContentBySpace('space-test');

      expect(cached.length, 2);
      expect(cached[0].id, 'page-1');
      expect(cached[0].title, 'Introduction');
      expect(cached[0].type, ContentType.document);
      expect(cached[0].path, '/introduction');
    });

    test('should retrieve content by id', () async {
      await dataSource.cacheContent('space-test', [
        const ContentModel(
          id: 'page-by-id',
          title: 'Find Me',
          type: ContentType.document,
        ),
      ]);

      final content = await dataSource.getContent('page-by-id');

      expect(content, isNotNull);
      expect(content!.title, 'Find Me');
    });

    test('should retrieve content by path', () async {
      await dataSource.cacheContent('space-test', [
        const ContentModel(
          id: 'page-path',
          title: 'API Reference',
          type: ContentType.document,
          path: '/api/reference',
        ),
      ]);

      final content = await dataSource.getContentByPath('space-test', '/api/reference');

      expect(content, isNotNull);
      expect(content!.title, 'API Reference');
    });

    test('should cache nested content structure', () async {
      final contents = [
        const ContentModel(
          id: 'group-1',
          title: 'Getting Started',
          type: ContentType.group,
          pages: [
            ContentModel(
              id: 'page-1-1',
              title: 'Installation',
              type: ContentType.document,
            ),
            ContentModel(
              id: 'page-1-2',
              title: 'Configuration',
              type: ContentType.document,
            ),
          ],
        ),
        const ContentModel(
          id: 'page-2',
          title: 'API Reference',
          type: ContentType.document,
        ),
      ];

      await dataSource.cacheContent('space-nested', contents);

      // Verify all items are cached
      final group = await dataSource.getContent('group-1');
      final child1 = await dataSource.getContent('page-1-1');
      final child2 = await dataSource.getContent('page-1-2');
      final standalone = await dataSource.getContent('page-2');

      expect(group, isNotNull);
      expect(group!.type, ContentType.group);
      expect(child1, isNotNull);
      expect(child2, isNotNull);
      expect(standalone, isNotNull);
    });

    test('should build content tree correctly', () async {
      // Insert flat structure with parent-child relationships
      final now = DateTime.now();
      final expiresAt = now.add(const Duration(hours: 1));

      await database.upsertContentList([
        CachedContentCompanion.insert(
          id: 'root-1',
          spaceId: 'space-tree',
          title: 'Root 1',
          type: 'group',
          parentId: const Value(null),
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'child-1',
          spaceId: 'space-tree',
          title: 'Child 1',
          type: 'document',
          parentId: const Value('root-1'),
          orderIndex: const Value(0),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'child-2',
          spaceId: 'space-tree',
          title: 'Child 2',
          type: 'document',
          parentId: const Value('root-1'),
          orderIndex: const Value(1),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
        CachedContentCompanion.insert(
          id: 'root-2',
          spaceId: 'space-tree',
          title: 'Root 2',
          type: 'document',
          parentId: const Value(null),
          orderIndex: const Value(1),
          cachedAt: now,
          expiresAt: expiresAt,
        ),
      ]);

      final tree = await dataSource.getContentBySpace('space-tree');

      expect(tree.length, 2); // Two root items
      expect(tree[0].id, 'root-1');
      expect(tree[0].pages, isNotNull);
      expect(tree[0].pages!.length, 2);
      expect(tree[0].pages![0].id, 'child-1');
      expect(tree[0].pages![1].id, 'child-2');
      expect(tree[1].id, 'root-2');
      expect(tree[1].pages, isNull);
    });
  });

  group('Document Operations', () {
    test('should cache and retrieve document content', () async {
      // First cache the content metadata
      await dataSource.cacheContent('space-doc', [
        const ContentModel(
          id: 'doc-page',
          title: 'Document Page',
          type: ContentType.document,
          path: '/doc',
        ),
      ]);

      // Then cache the document body
      await dataSource.cacheDocument(
        'doc-page',
        'space-doc',
        const DocumentBody(
          markdown: '# Hello World\n\nThis is content.',
          nodes: {'type': 'document', 'content': []},
        ),
      );

      final doc = await dataSource.getDocument('doc-page');

      expect(doc, isNotNull);
      expect(doc!.id, 'doc-page');
      expect(doc.title, 'Document Page');
      expect(doc.document?.markdown, '# Hello World\n\nThis is content.');
      expect(doc.document?.nodes, isNotNull);
      expect(doc.document?.nodes!['type'], 'document');
    });

    test('should return null for non-existent document', () async {
      final doc = await dataSource.getDocument('non-existent');

      expect(doc, isNull);
    });
  });

  group('User Operations', () {
    test('should cache and retrieve user', () async {
      await dataSource.cacheUser(
        const UserModel(
          id: 'user-123',
          displayName: 'John Doe',
          email: 'john@example.com',
          photoUrl: 'https://example.com/photo.jpg',
        ),
      );

      final user = await dataSource.getUser('user-123');

      expect(user, isNotNull);
      expect(user!.id, 'user-123');
      expect(user.displayName, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
    });

    test('should return null for non-existent user', () async {
      final user = await dataSource.getUser('non-existent');

      expect(user, isNull);
    });

    test('should cache user with custom TTL', () async {
      await dataSource.cacheUser(
        const UserModel(id: 'user-ttl', displayName: 'TTL User'),
        ttl: const Duration(days: 1),
      );

      final cached = await database.getUser('user-ttl');

      expect(cached, isNotNull);
      expect(cached!.expiresAt.difference(cached.cachedAt).inHours, 24);
    });
  });

  group('Cleanup Operations', () {
    test('should delete space data', () async {
      await dataSource.cacheSpaces([
        const SpaceModel(id: 'space-delete', title: 'Delete Me'),
      ]);
      await dataSource.cacheContent('space-delete', [
        const ContentModel(
          id: 'page-delete',
          title: 'Delete This Page',
          type: ContentType.document,
        ),
      ]);

      await dataSource.deleteSpaceData('space-delete');

      final space = await dataSource.getSpace('space-delete');
      final content = await dataSource.getContentBySpace('space-delete');

      expect(space, isNull);
      expect(content, isEmpty);
    });

    test('should clear all data', () async {
      await dataSource.cacheOrganizations([
        const OrganizationModel(id: 'org-clear', title: 'Clear Me'),
      ]);
      await dataSource.cacheSpaces([
        const SpaceModel(id: 'space-clear', title: 'Clear Me'),
      ]);

      await dataSource.clearAll();

      final orgs = await dataSource.getOrganizations();
      final spaces = await dataSource.getSpacesByOrganization('org-clear');

      expect(orgs, isEmpty);
      expect(spaces, isEmpty);
    });
  });
}
