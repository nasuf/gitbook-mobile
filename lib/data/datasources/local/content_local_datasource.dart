import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/storage/cache_manager.dart';
import '../../models/content_model.dart';
import '../../models/organization_model.dart';
import '../../models/space_model.dart';
import '../../models/user_model.dart';
import 'database/app_database.dart';

/// Local data source for cached content operations
class ContentLocalDataSource {
  final AppDatabase _database;

  ContentLocalDataSource({required AppDatabase database}) : _database = database;

  // ============ Organization Operations ============

  /// Get all cached organizations
  Future<List<OrganizationModel>> getOrganizations() async {
    final cached = await _database.getAllOrganizations();
    return cached.map(_mapOrganization).toList();
  }

  /// Get a cached organization by ID
  Future<OrganizationModel?> getOrganization(String id) async {
    final cached = await _database.getOrganization(id);
    if (cached == null) return null;
    return _mapOrganization(cached);
  }

  /// Cache organizations
  Future<void> cacheOrganizations(
    List<OrganizationModel> organizations, {
    Duration ttl = CacheDuration.organizations,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(ttl);

    final companions = organizations.map((org) {
      return CachedOrganizationsCompanion.insert(
        id: org.id,
        title: org.title,
        urlsLocation: Value(org.urls?.location),
        urlsApp: Value(org.urls?.app),
        createdAt: Value(org.createdAt),
        updatedAt: Value(org.updatedAt),
        cachedAt: now,
        expiresAt: expiresAt,
      );
    }).toList();

    await _database.upsertOrganizations(companions);
  }

  /// Cache a single organization
  Future<void> cacheOrganization(
    OrganizationModel organization, {
    Duration ttl = CacheDuration.organizations,
  }) async {
    await cacheOrganizations([organization], ttl: ttl);
  }

  OrganizationModel _mapOrganization(CachedOrganization cached) {
    return OrganizationModel(
      id: cached.id,
      title: cached.title,
      urls: cached.urlsLocation != null || cached.urlsApp != null
          ? OrganizationUrls(
              location: cached.urlsLocation,
              app: cached.urlsApp,
            )
          : null,
      createdAt: cached.createdAt,
      updatedAt: cached.updatedAt,
    );
  }

  // ============ Space Operations ============

  /// Get all cached spaces for an organization
  Future<List<SpaceModel>> getSpacesByOrganization(String orgId) async {
    final cached = await _database.getSpacesByOrganization(orgId);
    return cached.map(_mapSpace).toList();
  }

  /// Get a cached space by ID
  Future<SpaceModel?> getSpace(String id) async {
    final cached = await _database.getSpace(id);
    if (cached == null) return null;
    return _mapSpace(cached);
  }

  /// Cache spaces
  Future<void> cacheSpaces(
    List<SpaceModel> spaces, {
    Duration ttl = CacheDuration.spaces,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(ttl);

    final companions = spaces.map((space) {
      return CachedSpacesCompanion.insert(
        id: space.id,
        title: space.title,
        description: Value(space.description),
        visibility: Value(space.visibility?.name),
        organizationId: Value(space.organizationId),
        urlsLocation: Value(space.urls?.location),
        urlsApp: Value(space.urls?.app),
        urlsPublished: Value(space.urls?.published),
        createdAt: Value(space.createdAt),
        updatedAt: Value(space.updatedAt),
        deletedAt: Value(space.deletedAt),
        cachedAt: now,
        expiresAt: expiresAt,
      );
    }).toList();

    await _database.upsertSpaces(companions);
  }

  /// Cache a single space
  Future<void> cacheSpace(
    SpaceModel space, {
    Duration ttl = CacheDuration.spaces,
  }) async {
    await cacheSpaces([space], ttl: ttl);
  }

  SpaceModel _mapSpace(CachedSpace cached) {
    return SpaceModel(
      id: cached.id,
      title: cached.title,
      description: cached.description,
      visibility: cached.visibility != null
          ? SpaceVisibility.values.firstWhere(
              (v) => v.name == cached.visibility,
              orElse: () => SpaceVisibility.private,
            )
          : null,
      organizationId: cached.organizationId,
      urls: cached.urlsLocation != null || cached.urlsApp != null
          ? SpaceUrls(
              location: cached.urlsLocation,
              app: cached.urlsApp,
              published: cached.urlsPublished,
            )
          : null,
      createdAt: cached.createdAt,
      updatedAt: cached.updatedAt,
      deletedAt: cached.deletedAt,
    );
  }

  // ============ Content Operations ============

  /// Get all cached content for a space
  Future<List<ContentModel>> getContentBySpace(String spaceId) async {
    final cached = await _database.getContentBySpace(spaceId);
    return _buildContentTree(cached);
  }

  /// Get root content for a space
  Future<List<ContentModel>> getRootContent(String spaceId) async {
    final cached = await _database.getRootContent(spaceId);
    return Future.wait(cached.map((c) async {
      final children = await _database.getChildContent(c.id);
      return _mapContentWithChildren(c, children);
    }));
  }

  /// Get content by ID
  Future<ContentModel?> getContent(String id) async {
    final cached = await _database.getContent(id);
    if (cached == null) return null;
    return _mapContent(cached);
  }

  /// Get content by path
  Future<ContentModel?> getContentByPath(String spaceId, String path) async {
    final cached = await _database.getContentByPath(spaceId, path);
    if (cached == null) return null;
    return _mapContent(cached);
  }

  /// Cache content list
  Future<void> cacheContent(
    String spaceId,
    List<ContentModel> contents, {
    Duration ttl = CacheDuration.content,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(ttl);

    final companions = <CachedContentCompanion>[];
    _flattenContent(contents, spaceId, null, companions, now, expiresAt, 0);

    await _database.upsertContentList(companions);
  }

  void _flattenContent(
    List<ContentModel> contents,
    String spaceId,
    String? parentId,
    List<CachedContentCompanion> companions,
    DateTime cachedAt,
    DateTime expiresAt,
    int startIndex,
  ) {
    for (var i = 0; i < contents.length; i++) {
      final content = contents[i];
      companions.add(CachedContentCompanion.insert(
        id: content.id,
        spaceId: spaceId,
        title: content.title,
        type: content.type.name,
        path: Value(content.path),
        slug: Value(content.slug),
        description: Value(content.description),
        parentId: Value(parentId),
        orderIndex: Value(startIndex + i),
        urlsLocation: Value(content.urls?.location),
        urlsApp: Value(content.urls?.app),
        createdAt: Value(content.createdAt),
        updatedAt: Value(content.updatedAt),
        cachedAt: cachedAt,
        expiresAt: expiresAt,
      ));

      if (content.pages != null && content.pages!.isNotEmpty) {
        _flattenContent(
          content.pages!,
          spaceId,
          content.id,
          companions,
          cachedAt,
          expiresAt,
          0,
        );
      }
    }
  }

  List<ContentModel> _buildContentTree(List<CachedContentData> cached) {
    final Map<String?, List<CachedContentData>> byParent = {};

    for (final item in cached) {
      byParent.putIfAbsent(item.parentId, () => []).add(item);
    }

    List<ContentModel> buildChildren(String? parentId) {
      final children = byParent[parentId] ?? [];
      return children.map((c) {
        final pages = buildChildren(c.id);
        return _mapContent(c).copyWith(pages: pages.isEmpty ? null : pages);
      }).toList();
    }

    return buildChildren(null);
  }

  Future<ContentModel> _mapContentWithChildren(
    CachedContentData cached,
    List<CachedContentData> children,
  ) async {
    final childModels = await Future.wait(children.map((c) async {
      final grandChildren = await _database.getChildContent(c.id);
      return _mapContentWithChildren(c, grandChildren);
    }));

    return _mapContent(cached).copyWith(
      pages: childModels.isEmpty ? null : childModels,
    );
  }

  ContentModel _mapContent(CachedContentData cached) {
    return ContentModel(
      id: cached.id,
      title: cached.title,
      type: ContentType.values.firstWhere(
        (t) => t.name == cached.type,
        orElse: () => ContentType.document,
      ),
      path: cached.path,
      slug: cached.slug,
      description: cached.description,
      urls: cached.urlsLocation != null || cached.urlsApp != null
          ? ContentUrls(
              location: cached.urlsLocation,
              app: cached.urlsApp,
            )
          : null,
      createdAt: cached.createdAt,
      updatedAt: cached.updatedAt,
    );
  }

  // ============ Document Operations ============

  /// Get cached document content
  Future<DocumentContent?> getDocument(String pageId) async {
    final cached = await _database.getDocument(pageId);
    if (cached == null) return null;

    final content = await _database.getContent(pageId);

    return DocumentContent(
      id: pageId,
      title: content?.title ?? '',
      type: content != null
          ? ContentType.values.firstWhere(
              (t) => t.name == content.type,
              orElse: () => ContentType.document,
            )
          : null,
      path: content?.path,
      slug: content?.slug,
      description: content?.description,
      createdAt: content?.createdAt,
      updatedAt: content?.updatedAt,
      document: DocumentBody(
        markdown: cached.markdown,
        nodes: cached.nodesJson != null
            ? json.decode(cached.nodesJson!) as Map<String, dynamic>
            : null,
      ),
    );
  }

  /// Cache document content
  Future<void> cacheDocument(
    String pageId,
    String spaceId,
    DocumentBody document, {
    Duration ttl = CacheDuration.documents,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(ttl);

    await _database.upsertDocument(CachedDocumentsCompanion.insert(
      pageId: pageId,
      spaceId: spaceId,
      markdown: Value(document.markdown),
      nodesJson: Value(document.nodes != null ? json.encode(document.nodes) : null),
      cachedAt: now,
      expiresAt: expiresAt,
    ));
  }

  // ============ User Operations ============

  /// Get cached user
  Future<UserModel?> getUser(String id) async {
    final cached = await _database.getUser(id);
    if (cached == null) return null;

    return UserModel(
      id: cached.id,
      displayName: cached.displayName,
      email: cached.email,
      photoUrl: cached.photoUrl,
    );
  }

  /// Cache user
  Future<void> cacheUser(
    UserModel user, {
    Duration ttl = CacheDuration.users,
  }) async {
    final now = DateTime.now();
    final expiresAt = now.add(ttl);

    await _database.upsertUser(CachedUsersCompanion.insert(
      id: user.id,
      displayName: Value(user.displayName),
      email: Value(user.email),
      photoUrl: Value(user.photoUrl),
      cachedAt: now,
      expiresAt: expiresAt,
    ));
  }

  // ============ Cleanup ============

  /// Delete all cached data for a space
  Future<void> deleteSpaceData(String spaceId) async {
    await _database.deleteSpace(spaceId);
    await _database.deleteContentBySpace(spaceId);
    await _database.deleteDocumentsBySpace(spaceId);
  }

  /// Delete all cached data
  Future<void> clearAll() async {
    await _database.clearAllCache();
  }
}
