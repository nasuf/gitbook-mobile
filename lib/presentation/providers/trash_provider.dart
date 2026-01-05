import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/space_entity.dart';
import '../../domain/repositories/space_repository.dart';
import 'core_providers.dart';
import 'user_provider.dart';

/// State for trash
class TrashState {
  final List<Space> trashedSpaces;
  final bool isLoading;
  final String? error;

  const TrashState({
    this.trashedSpaces = const [],
    this.isLoading = false,
    this.error,
  });

  TrashState copyWith({
    List<Space>? trashedSpaces,
    bool? isLoading,
    String? error,
  }) {
    return TrashState(
      trashedSpaces: trashedSpaces ?? this.trashedSpaces,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for trash state
class TrashNotifier extends StateNotifier<TrashState> {
  final SpaceRepository _repository;
  final Ref _ref;

  TrashNotifier(this._repository, this._ref) : super(const TrashState());

  /// Load trashed spaces for the current organization
  Future<void> loadTrashedSpaces() async {
    final orgState = _ref.read(organizationsProvider);
    final currentOrg = orgState.currentOrganization;
    if (currentOrg == null) {
      state = state.copyWith(
        trashedSpaces: [],
        isLoading: false,
        error: 'No organization selected',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final spaces = await _repository.getTrashedSpaces(currentOrg.id);
      state = state.copyWith(trashedSpaces: spaces, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Restore a space from trash
  Future<bool> restoreSpace(String spaceId) async {
    try {
      await _repository.restoreSpace(spaceId);
      // Remove from trashed list
      state = state.copyWith(
        trashedSpaces: state.trashedSpaces.where((s) => s.id != spaceId).toList(),
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    }
  }

  /// Refresh trashed spaces
  Future<void> refresh() => loadTrashedSpaces();
}

/// Provider for trash state
final trashProvider = StateNotifierProvider<TrashNotifier, TrashState>((ref) {
  final repository = ref.watch(spaceRepositoryProvider);
  return TrashNotifier(repository, ref);
});
