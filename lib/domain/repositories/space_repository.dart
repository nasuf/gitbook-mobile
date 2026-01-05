import '../entities/space_entity.dart';

/// Repository interface for space operations
abstract class SpaceRepository {
  /// Get all spaces for an organization
  Future<List<Space>> getSpaces(
    String organizationId, {
    bool forceRefresh = false,
  });

  /// Get a single space by ID
  Future<Space> getSpaceById(String spaceId);

  /// Get a collection by ID
  Future<SpaceCollection> getCollectionById(String collectionId);

  /// Get all collections for an organization
  Future<List<SpaceCollection>> getCollections(String organizationId);

  /// Create a new collection
  Future<SpaceCollection> createCollection({
    required String organizationId,
    required String title,
    String? description,
  });

  /// Create a new space
  Future<Space> createSpace({
    required String organizationId,
    required String title,
    String? description,
    SpaceVisibility? visibility,
    String? parentCollectionId,
  });

  /// Update a space
  Future<Space> updateSpace(
    String spaceId, {
    String? title,
    String? description,
    SpaceVisibility? visibility,
  });

  /// Delete a space
  Future<void> deleteSpace(String spaceId);

  /// Search spaces within an organization
  Future<List<Space>> searchSpaces(
    String organizationId,
    String query,
  );

  /// Get recent spaces
  Future<List<RecentSpaceItem>> getRecentSpaces({int limit = 10});

  /// Add a space to recent items
  Future<void> addToRecentSpaces(Space space, {String? organizationTitle});

  /// Clear recent spaces
  Future<void> clearRecentSpaces();
}
