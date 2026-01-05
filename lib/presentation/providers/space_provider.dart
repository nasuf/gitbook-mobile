import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/space_entity.dart';
import '../../domain/repositories/space_repository.dart';
import 'core_providers.dart';
import 'user_provider.dart';

/// State for spaces list
class SpacesState {
  final List<Space> spaces;
  final bool isLoading;
  final String? error;
  final SpaceViewMode viewMode;
  final String searchQuery;

  const SpacesState({
    this.spaces = const [],
    this.isLoading = false,
    this.error,
    this.viewMode = SpaceViewMode.list,
    this.searchQuery = '',
  });

  SpacesState copyWith({
    List<Space>? spaces,
    bool? isLoading,
    String? error,
    SpaceViewMode? viewMode,
    String? searchQuery,
  }) {
    return SpacesState(
      spaces: spaces ?? this.spaces,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      viewMode: viewMode ?? this.viewMode,
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
}

/// View mode for spaces list
enum SpaceViewMode { list, grid }

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
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refresh spaces
  Future<void> refresh() => loadSpaces(forceRefresh: true);

  /// Set view mode
  void setViewMode(SpaceViewMode mode) {
    state = state.copyWith(viewMode: mode);
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
    try {
      await _repository.deleteSpace(spaceId);
      state = state.copyWith(
        spaces: state.spaces.where((s) => s.id != spaceId).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Create a new space
  Future<Space?> createSpace({
    required String title,
    String? description,
    SpaceVisibility? visibility,
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

  RecentSpacesNotifier(this._repository) : super(const RecentSpacesState()) {
    loadRecentSpaces();
  }

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
