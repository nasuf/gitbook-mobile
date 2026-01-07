import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/space_entity.dart';
import '../../domain/repositories/space_repository.dart';
import 'core_providers.dart';
import 'user_provider.dart';

/// State for spaces list
class SpacesState {
  final List<Space> spaces;
  final Map<String, SpaceCollection> collections;
  final List<SpaceCollection> allCollections;
  final bool isLoading;
  final String? error;
  final SpaceViewMode viewMode;
  final SpaceDisplayMode displayMode;
  final String searchQuery;

  const SpacesState({
    this.spaces = const [],
    this.collections = const {},
    this.allCollections = const [],
    this.isLoading = false,
    this.error,
    this.viewMode = SpaceViewMode.list,
    this.displayMode = SpaceDisplayMode.hierarchical,
    this.searchQuery = '',
  });

  SpacesState copyWith({
    List<Space>? spaces,
    Map<String, SpaceCollection>? collections,
    List<SpaceCollection>? allCollections,
    bool? isLoading,
    String? error,
    SpaceViewMode? viewMode,
    SpaceDisplayMode? displayMode,
    String? searchQuery,
  }) {
    return SpacesState(
      spaces: spaces ?? this.spaces,
      collections: collections ?? this.collections,
      allCollections: allCollections ?? this.allCollections,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      viewMode: viewMode ?? this.viewMode,
      displayMode: displayMode ?? this.displayMode,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// Filtered spaces based on search query
  List<Space> get filteredSpaces {
    if (searchQuery.isEmpty) return spaces;
    final query = searchQuery.toLowerCase();
    return spaces.where((space) {
      return space.title.toLowerCase().contains(query) ||
          (space.description?.toLowerCase().contains(query) ?? false);
    }).toList();
  }

  /// Get spaces at root level (not in a collection)
  List<Space> get rootSpaces {
    return filteredSpaces.where((space) => space.parentId == null).toList();
  }

  /// Get spaces in a specific collection
  List<Space> spacesInCollection(String collectionId) {
    return filteredSpaces.where((space) => space.parentId == collectionId).toList();
  }

  /// Get collection IDs that have spaces
  Set<String> get collectionIds {
    return filteredSpaces
        .where((space) => space.parentId != null)
        .map((space) => space.parentId!)
        .toSet();
  }

  /// Get hierarchical view data (collections with their spaces)
  List<HierarchicalSpaceItem> get hierarchicalItems {
    final items = <HierarchicalSpaceItem>[];

    // Add root spaces first (spaces not in any collection)
    for (final space in rootSpaces) {
      items.add(HierarchicalSpaceItem.space(space));
    }

    // Add all collections (including empty ones)
    final addedCollectionIds = <String>{};

    // First add collections from allCollections list
    for (final collection in allCollections) {
      final collectionSpaces = spacesInCollection(collection.id);
      items.add(HierarchicalSpaceItem.collection(
        collection,
        collectionSpaces,
      ));
      addedCollectionIds.add(collection.id);
    }

    // Then add any collections we have in the collections map but not in allCollections
    // (in case allCollections hasn't been loaded yet)
    for (final collectionId in collectionIds) {
      if (!addedCollectionIds.contains(collectionId)) {
        final collection = collections[collectionId];
        if (collection != null) {
          final collectionSpaces = spacesInCollection(collectionId);
          items.add(HierarchicalSpaceItem.collection(
            collection,
            collectionSpaces,
          ));
        }
      }
    }

    return items;
  }
}

/// View mode for spaces list (list vs grid)
enum SpaceViewMode { list, grid }

/// Display mode for spaces (flat vs hierarchical with collections)
enum SpaceDisplayMode { flat, hierarchical }

/// Represents an item in the hierarchical view
class HierarchicalSpaceItem {
  final SpaceCollection? collection;
  final Space? space;
  final List<Space> childSpaces;
  final bool isCollection;

  const HierarchicalSpaceItem._({
    this.collection,
    this.space,
    this.childSpaces = const [],
    required this.isCollection,
  });

  factory HierarchicalSpaceItem.space(Space space) {
    return HierarchicalSpaceItem._(
      space: space,
      isCollection: false,
    );
  }

  factory HierarchicalSpaceItem.collection(
    SpaceCollection collection,
    List<Space> spaces,
  ) {
    return HierarchicalSpaceItem._(
      collection: collection,
      childSpaces: spaces,
      isCollection: true,
    );
  }

  String get title => isCollection ? collection!.title : space!.title;
  String? get emoji => isCollection ? collection!.emoji : space!.emoji;
}

/// Notifier for spaces state
class SpacesNotifier extends StateNotifier<SpacesState> {
  final SpaceRepository _repository;
  final Ref _ref;

  SpacesNotifier(this._repository, this._ref) : super(const SpacesState());

  /// Load spaces for the current organization
  Future<void> loadSpaces({bool forceRefresh = false}) async {
    final orgState = _ref.read(organizationsProvider);
    final currentOrg = orgState.currentOrganization;
    if (currentOrg == null) {
      state = state.copyWith(
        spaces: [],
        isLoading: false,
        error: 'No organization selected',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final spaces = await _repository.getSpaces(
        currentOrg.id,
        forceRefresh: forceRefresh,
      );
      state = state.copyWith(spaces: spaces, isLoading: false);

      // If in hierarchical mode, load collections if needed or forced
      if (state.displayMode == SpaceDisplayMode.hierarchical) {
        final needsLoad = forceRefresh ||
            (state.allCollections.isEmpty && state.collections.isEmpty);
        if (needsLoad) {
          await loadAllCollections();
          await _loadCollections();
        }
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Load collection details for spaces that have a parent
  Future<void> _loadCollections() async {
    final collectionIds = state.collectionIds;
    if (collectionIds.isEmpty) return;

    final collections = Map<String, SpaceCollection>.from(state.collections);

    for (final collectionId in collectionIds) {
      if (!collections.containsKey(collectionId)) {
        try {
          final collection = await _repository.getCollectionById(collectionId);
          collections[collectionId] = collection;
        } catch (e) {
          // Silently ignore collection fetch errors
        }
      }
    }

    state = state.copyWith(collections: collections);
  }

  /// Refresh spaces
  Future<void> refresh() => loadSpaces(forceRefresh: true);

  /// Set view mode (list/grid)
  void setViewMode(SpaceViewMode mode) {
    state = state.copyWith(viewMode: mode);
  }

  /// Set display mode (flat/hierarchical)
  Future<void> setDisplayMode(SpaceDisplayMode mode) async {
    if (mode == SpaceDisplayMode.hierarchical) {
      // Only load collections if not already loaded
      final needsLoad = state.allCollections.isEmpty && state.collections.isEmpty;
      if (needsLoad) {
        state = state.copyWith(displayMode: mode, isLoading: true);
        await loadAllCollections();
        await _loadCollections();
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(displayMode: mode);
      }
    } else {
      state = state.copyWith(displayMode: mode);
    }
  }

  /// Toggle display mode between flat and hierarchical
  Future<void> toggleDisplayMode() async {
    final newMode = state.displayMode == SpaceDisplayMode.flat
        ? SpaceDisplayMode.hierarchical
        : SpaceDisplayMode.flat;
    await setDisplayMode(newMode);
  }

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Clear search
  void clearSearch() {
    state = state.copyWith(searchQuery: '');
  }

  /// Delete a space
  Future<void> deleteSpace(String spaceId) async {
    await _repository.deleteSpace(spaceId);
    state = state.copyWith(
      spaces: state.spaces.where((s) => s.id != spaceId).toList(),
    );
  }

  /// Load all collections for the current organization
  Future<void> loadAllCollections() async {
    final orgState = _ref.read(organizationsProvider);
    final currentOrg = orgState.currentOrganization;
    if (currentOrg == null) return;

    try {
      final collections = await _repository.getCollections(currentOrg.id);
      state = state.copyWith(allCollections: collections);
    } catch (e) {
      // Silently ignore collection fetch errors
    }
  }

  /// Create a new collection
  Future<SpaceCollection?> createCollection({
    required String title,
    String? description,
  }) async {
    final orgState = _ref.read(organizationsProvider);
    final currentOrg = orgState.currentOrganization;
    if (currentOrg == null) {
      state = state.copyWith(error: 'No organization selected');
      return null;
    }

    try {
      final collection = await _repository.createCollection(
        organizationId: currentOrg.id,
        title: title,
        description: description,
      );
      state = state.copyWith(
        allCollections: [...state.allCollections, collection],
      );
      return collection;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  /// Create a new space
  Future<Space?> createSpace({
    required String title,
    String? description,
    SpaceVisibility? visibility,
    String? parentCollectionId,
  }) async {
    final orgState = _ref.read(organizationsProvider);
    final currentOrg = orgState.currentOrganization;
    if (currentOrg == null) {
      state = state.copyWith(error: 'No organization selected');
      return null;
    }

    try {
      final space = await _repository.createSpace(
        organizationId: currentOrg.id,
        title: title,
        description: description,
        visibility: visibility,
        parentCollectionId: parentCollectionId,
      );
      state = state.copyWith(spaces: [...state.spaces, space]);
      return space;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }
}

/// Provider for spaces state
final spacesProvider =
    StateNotifierProvider<SpacesNotifier, SpacesState>((ref) {
  final repository = ref.watch(spaceRepositoryProvider);
  return SpacesNotifier(repository, ref);
});

/// State for a single space detail
class SpaceDetailState {
  final Space? space;
  final bool isLoading;
  final String? error;

  const SpaceDetailState({
    this.space,
    this.isLoading = false,
    this.error,
  });

  SpaceDetailState copyWith({
    Space? space,
    bool? isLoading,
    String? error,
  }) {
    return SpaceDetailState(
      space: space ?? this.space,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for space detail
class SpaceDetailNotifier extends StateNotifier<SpaceDetailState> {
  final SpaceRepository _repository;
  final String _spaceId;

  SpaceDetailNotifier(this._repository, this._spaceId)
      : super(const SpaceDetailState()) {
    _loadSpace();
  }

  Future<void> _loadSpace() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final space = await _repository.getSpaceById(_spaceId);
      state = state.copyWith(space: space, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh space details
  Future<void> refresh() => _loadSpace();

  /// Update space
  Future<bool> updateSpace({
    String? title,
    String? description,
    SpaceVisibility? visibility,
  }) async {
    try {
      final updated = await _repository.updateSpace(
        _spaceId,
        title: title,
        description: description,
        visibility: visibility,
      );
      state = state.copyWith(space: updated);
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }
}

/// Provider for space detail
final spaceDetailProvider = StateNotifierProvider.family<SpaceDetailNotifier,
    SpaceDetailState, String>((ref, spaceId) {
  final repository = ref.watch(spaceRepositoryProvider);
  return SpaceDetailNotifier(repository, spaceId);
});

/// State for recent spaces
class RecentSpacesState {
  final List<RecentSpaceItem> items;
  final bool isLoading;
  final String? error;

  const RecentSpacesState({
    this.items = const [],
    this.isLoading = false,
    this.error,
  });

  RecentSpacesState copyWith({
    List<RecentSpaceItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return RecentSpacesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for recent spaces
class RecentSpacesNotifier extends StateNotifier<RecentSpacesState> {
  final SpaceRepository _repository;

  RecentSpacesNotifier(this._repository) : super(const RecentSpacesState());
  // Note: Don't auto-load in constructor - HomeScreen calls loadRecentSpaces explicitly

  /// Load recent spaces
  Future<void> loadRecentSpaces() async {
    state = state.copyWith(isLoading: true);
    try {
      final items = await _repository.getRecentSpaces();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Add a space to recent items
  Future<void> addRecent(Space space, {String? organizationTitle}) async {
    await _repository.addToRecentSpaces(space, organizationTitle: organizationTitle);
    await loadRecentSpaces();
  }

  /// Clear recent spaces
  Future<void> clearRecent() async {
    await _repository.clearRecentSpaces();
    state = state.copyWith(items: []);
  }
}

/// Provider for recent spaces
final recentSpacesProvider =
    StateNotifierProvider<RecentSpacesNotifier, RecentSpacesState>((ref) {
  final repository = ref.watch(spaceRepositoryProvider);
  return RecentSpacesNotifier(repository);
});
