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
    // Try cache first unless force refresh
    if (!forceRefresh) {
      final cached = await _localDataSource.getSpacesByOrganization(organizationId);
      if (cached.isNotEmpty) {
        return cached.map(_mapToSpace).toList();
      }
    }

    // Fetch from API
    final response = await _apiClient.listSpaces(organizationId);

    // Cache the results
    await _localDataSource.cacheSpaces(response.items);

    return response.items.map(_mapToSpace).toList();
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
  Future<Space> createSpace({
    required String organizationId,
    required String title,
    String? description,
    SpaceVisibility? visibility,
  }) async {
    final space = await _apiClient.createSpace(
      organizationId,
      title: title,
      description: description,
      visibility: _mapToModelVisibility(visibility),
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

  Space _mapToSpace(model.SpaceModel space) {
    return Space(
      id: space.id,
      title: space.title,
      description: space.description,
      emoji: space.emoji,
      visibility: _mapVisibility(space.visibility),
      createdAt: space.createdAt,
      updatedAt: space.updatedAt,
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
