import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/space_entity.dart';
import 'package:gitbook_mobile/domain/repositories/space_repository.dart';
import 'package:gitbook_mobile/presentation/providers/space_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceRepository extends Mock implements SpaceRepository {}

void main() {
  group('SpacesState', () {
    test('should have default values', () {
      const state = SpacesState();

      expect(state.spaces, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
      expect(state.viewMode, SpaceViewMode.list);
      expect(state.searchQuery, isEmpty);
    });

    test('should copy with new values', () {
      final spaces = [const Space(id: 'space-1', title: 'Test')];
      const state = SpacesState();

      final copied = state.copyWith(
        spaces: spaces,
        isLoading: true,
        viewMode: SpaceViewMode.grid,
      );

      expect(copied.spaces, spaces);
      expect(copied.isLoading, isTrue);
      expect(copied.viewMode, SpaceViewMode.grid);
    });

    test('should clear error when copying with null', () {
      const state = SpacesState(error: 'Some error');

      final copied = state.copyWith(error: null);

      expect(copied.error, isNull);
    });

    test('should filter spaces by search query', () {
      final state = SpacesState(
        spaces: [
          const Space(id: 'space-1', title: 'Matching'),
          const Space(id: 'space-2', title: 'Other'),
        ],
        searchQuery: 'match',
      );

      expect(state.filteredSpaces.length, 1);
      expect(state.filteredSpaces[0].id, 'space-1');
    });

    test('should return all spaces when search query is empty', () {
      final state = SpacesState(
        spaces: [
          const Space(id: 'space-1', title: 'Space One'),
          const Space(id: 'space-2', title: 'Space Two'),
        ],
        searchQuery: '',
      );

      expect(state.filteredSpaces.length, 2);
    });

    test('should filter by description', () {
      final state = SpacesState(
        spaces: [
          const Space(
            id: 'space-1',
            title: 'Space',
            description: 'Has keyword',
          ),
          const Space(id: 'space-2', title: 'Other'),
        ],
        searchQuery: 'keyword',
      );

      expect(state.filteredSpaces.length, 1);
      expect(state.filteredSpaces[0].id, 'space-1');
    });

    test('should be case insensitive when filtering', () {
      final state = SpacesState(
        spaces: [
          const Space(id: 'space-1', title: 'UPPERCASE'),
          const Space(id: 'space-2', title: 'lowercase'),
        ],
        searchQuery: 'LOWER',
      );

      expect(state.filteredSpaces.length, 1);
      expect(state.filteredSpaces[0].id, 'space-2');
    });
  });

  group('SpaceDetailState', () {
    test('should have default values', () {
      const state = SpaceDetailState();

      expect(state.space, isNull);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('should copy with new values', () {
      const space = Space(id: 'space-123', title: 'Test');
      const state = SpaceDetailState();

      final copied = state.copyWith(
        space: space,
        isLoading: true,
      );

      expect(copied.space, space);
      expect(copied.isLoading, isTrue);
    });

    test('should preserve space when copying with other values', () {
      const state = SpaceDetailState(
        space: Space(id: 'space-123', title: 'Test'),
      );

      final copied = state.copyWith(isLoading: true);

      expect(copied.space?.id, 'space-123');
      expect(copied.isLoading, isTrue);
    });
  });

  group('RecentSpacesState', () {
    test('should have default values', () {
      const state = RecentSpacesState();

      expect(state.items, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('should copy with new values', () {
      final items = [
        RecentSpaceItem(
          id: 'space-1',
          title: 'Recent',
          accessedAt: DateTime.now(),
        ),
      ];
      const state = RecentSpacesState();

      final copied = state.copyWith(items: items, isLoading: true);

      expect(copied.items, items);
      expect(copied.isLoading, isTrue);
    });

    test('should clear items when copying with empty list', () {
      final state = RecentSpacesState(
        items: [
          RecentSpaceItem(
            id: 'space-1',
            title: 'Recent',
            accessedAt: DateTime.now(),
          ),
        ],
      );

      final copied = state.copyWith(items: []);

      expect(copied.items, isEmpty);
    });
  });

  group('SpaceViewMode', () {
    test('should have list and grid modes', () {
      expect(SpaceViewMode.values, hasLength(2));
      expect(SpaceViewMode.values, contains(SpaceViewMode.list));
      expect(SpaceViewMode.values, contains(SpaceViewMode.grid));
    });
  });

  group('SpaceDisplayMode', () {
    test('should have flat and hierarchical modes', () {
      expect(SpaceDisplayMode.values, hasLength(2));
      expect(SpaceDisplayMode.values, contains(SpaceDisplayMode.flat));
      expect(SpaceDisplayMode.values, contains(SpaceDisplayMode.hierarchical));
    });

    test('default display mode should be hierarchical', () {
      const state = SpacesState();
      expect(state.displayMode, SpaceDisplayMode.hierarchical);
    });

    test('should switch display mode without loading when collections exist', () {
      // When collections are already loaded, switching should not trigger loading
      final state = SpacesState(
        displayMode: SpaceDisplayMode.flat,
        allCollections: [
          const SpaceCollection(id: 'col-1', title: 'Collection 1'),
        ],
      );

      // Collections exist, so needsLoad should be false
      final needsLoad = state.allCollections.isEmpty && state.collections.isEmpty;
      expect(needsLoad, false);
    });

    test('should need loading when collections are empty', () {
      const state = SpacesState(
        displayMode: SpaceDisplayMode.flat,
        allCollections: [],
        collections: {},
      );

      // Collections are empty, so needsLoad should be true
      final needsLoad = state.allCollections.isEmpty && state.collections.isEmpty;
      expect(needsLoad, true);
    });
  });
}
