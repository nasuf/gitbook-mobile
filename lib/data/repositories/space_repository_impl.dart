import '../../core/storage/cache_manager.dart';
import '../../domain/entities/space_entity.dart';
import '../../domain/repositories/space_repository.dart';
import '../datasources/local/content_local_datasource.dart';
import '../datasources/remote/gitbook_api_client.dart';
import '../models/collection_model.dart' as collection_model;
import '../models/space_model.dart' as model;

/// Implementation of SpaceRepository
class SpaceRepositoryImpl implements SpaceRepository {
  final GitBookApiClient _apiClient;
  final ContentLocalDataSource _localDataSource;
  final CacheManager _cacheManager;

  SpaceRepositoryImpl({
    required GitBookApiClient apiClient,
    required ContentLocalDataSource localDataSource,
    required CacheManager cacheManager,
  })  : _apiClient = apiClient,
        _localDataSource = localDataSource,
        _cacheManager = cacheManager;

  @override
  Future<List<Space>> getSpaces(
    String organizationId, {
    bool forceRefresh = false,
  }) async {
    // Always fetch from API to get fresh data
    // This ensures deleted spaces don't appear from stale cache
    try {
      final response = await _apiClient.listSpaces(organizationId);

      // Filter out trashed spaces (those with deletedAt set)
      final activeSpaces = response.items
          .where((space) => space.deletedAt == null)
          .toList();

      // Clear old cached spaces for this organization and cache new ones
      await _localDataSource.clearSpacesByOrganization(organizationId);
      await _localDataSource.cacheSpaces(activeSpaces);

      return activeSpaces.map(_mapToSpace).toList();
    } catch (e) {
      // On network error, fall back to cache if available
      if (!forceRefresh) {
        final cached = await _localDataSource.getSpacesByOrganization(organizationId);
        if (cached.isNotEmpty) {
          return cached.map(_mapToSpace).toList();
        }
      }
      rethrow;
    }
  }

  @override
  Future<Space> getSpaceById(String spaceId) async {
    // Try cache first
    final cached = await _localDataSource.getSpace(spaceId);
    if (cached != null) {
      return _mapToSpace(cached);
    }

    // Fetch from API
    final space = await _apiClient.getSpace(spaceId);
    await _localDataSource.cacheSpace(space);

    return _mapToSpace(space);
  }

  @override
  Future<SpaceCollection> getCollectionById(String collectionId) async {
    final collection = await _apiClient.getCollection(collectionId);
    return _mapToCollection(collection);
  }

  @override
  Future<List<SpaceCollection>> getCollections(String organizationId) async {
    final response = await _apiClient.listCollections(organizationId);
    return response.items.map(_mapToCollection).toList();
  }

  @override
  Future<SpaceCollection> createCollection({
    required String organizationId,
    required String title,
    String? description,
  }) async {
    final collection = await _apiClient.createCollection(
      organizationId,
      title: title,
      description: description,
    );
    return _mapToCollection(collection);
  }

  @override
  Future<Space> createSpace({
    required String organizationId,
    required String title,
    String? description,
    SpaceVisibility? visibility,
    String? parentCollectionId,
  }) async {
    final space = await _apiClient.createSpace(
      organizationId,
      title: title,
      description: description,
      visibility: _mapToModelVisibility(visibility),
      parentCollectionId: parentCollectionId,
    );

    // Cache the new space
    await _localDataSource.cacheSpace(space);

    // Invalidate organization spaces cache
    await _cacheManager.invalidateSpace(space.id);

    return _mapToSpace(space);
  }

  @override
  Future<Space> updateSpace(
    String spaceId, {
    String? title,
    String? description,
    SpaceVisibility? visibility,
  }) async {
    final space = await _apiClient.updateSpace(
      spaceId,
      title: title,
      description: description,
      visibility: _mapToModelVisibility(visibility),
    );

    // Update cache
    await _localDataSource.cacheSpace(space);

    return _mapToSpace(space);
  }

  @override
  Future<void> deleteSpace(String spaceId) async {
    await _apiClient.deleteSpace(spaceId);

    // Remove from cache
    await _cacheManager.invalidateSpace(spaceId);

    // Also remove from recent items
    await _cacheManager.removeRecentItem('space', spaceId);
  }

  @override
  Future<List<Space>> getTrashedSpaces(String organizationId) async {
    // Fetch all spaces from API (including trashed ones)
    final response = await _apiClient.listSpaces(organizationId);

    // Filter to only trashed spaces (those with deletedAt set)
    final trashedSpaces = response.items
        .where((space) => space.deletedAt != null)
        .toList();

    return trashedSpaces.map(_mapToSpace).toList();
  }

  @override
  Future<Space> restoreSpace(String spaceId) async {
    final space = await _apiClient.restoreSpace(spaceId);

    // Cache the restored space
    await _localDataSource.cacheSpace(space);

    return _mapToSpace(space);
  }

  @override
  Future<List<Space>> searchSpaces(
    String organizationId,
    String query,
  ) async {
    // Get all spaces and filter locally for now
    // API doesn't have a direct space search endpoint
    final spaces = await getSpaces(organizationId);
    final lowercaseQuery = query.toLowerCase();

    return spaces.where((space) {
      return space.title.toLowerCase().contains(lowercaseQuery) ||
          (space.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  @override
  Future<List<RecentSpaceItem>> getRecentSpaces({int limit = 10}) async {
    final recentItems = await _cacheManager.getRecentItems(limit: limit);

    return recentItems
        .where((item) => item.itemType == 'space')
        .map((item) => RecentSpaceItem(
              id: item.itemId,
              title: item.title,
              organizationId: item.spaceId, // We reuse spaceId for org ID
              accessedAt: item.accessedAt,
            ))
        .toList();
  }

  @override
  Future<void> addToRecentSpaces(Space space, {String? organizationTitle}) async {
    await _cacheManager.addRecentItem(
      itemType: 'space',
      itemId: space.id,
      title: space.title,
      spaceId: space.organizationId, // Store org ID in spaceId field
    );
  }

  @override
  Future<void> clearRecentSpaces() async {
    await _cacheManager.clearRecentItems();
  }

  @override
  Future<void> removeFromRecentSpaces(String spaceId) async {
    await _cacheManager.removeRecentItem('space', spaceId);
  }

  Space _mapToSpace(model.SpaceModel space) {
    return Space(
      id: space.id,
      title: space.title,
      description: space.description,
      emoji: space.emoji,
      visibility: _mapVisibility(space.visibility),
      createdAt: space.createdAt,
      updatedAt: space.updatedAt,
      deletedAt: space.deletedAt,
      organizationId: space.organizationId,
      appUrl: space.urls?.app,
      publishedUrl: space.urls?.published,
      parentId: space.parent,
    );
  }

  SpaceCollection _mapToCollection(collection_model.CollectionModel collection) {
    return SpaceCollection(
      id: collection.id,
      title: collection.title,
      description: collection.description,
      emoji: collection.emoji,
      createdAt: collection.createdAt,
      updatedAt: collection.updatedAt,
      organizationId: collection.organizationId,
    );
  }

  SpaceVisibility? _mapVisibility(model.SpaceVisibility? visibility) {
    if (visibility == null) return null;
    return switch (visibility) {
      model.SpaceVisibility.public => SpaceVisibility.public,
      model.SpaceVisibility.unlisted => SpaceVisibility.unlisted,
      model.SpaceVisibility.shareLink => SpaceVisibility.shareLink,
      model.SpaceVisibility.visitorAuth => SpaceVisibility.visitorAuth,
      model.SpaceVisibility.inCollection => SpaceVisibility.inCollection,
      model.SpaceVisibility.private => SpaceVisibility.private,
    };
  }

  model.SpaceVisibility? _mapToModelVisibility(SpaceVisibility? visibility) {
    if (visibility == null) return null;
    return switch (visibility) {
      SpaceVisibility.public => model.SpaceVisibility.public,
      SpaceVisibility.unlisted => model.SpaceVisibility.unlisted,
      SpaceVisibility.shareLink => model.SpaceVisibility.shareLink,
      SpaceVisibility.visitorAuth => model.SpaceVisibility.visitorAuth,
      SpaceVisibility.inCollection => model.SpaceVisibility.inCollection,
      SpaceVisibility.private => model.SpaceVisibility.private,
    };
  }
}
