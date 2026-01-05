import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/storage/cache_manager.dart';
import 'package:gitbook_mobile/data/datasources/local/content_local_datasource.dart';
import 'package:gitbook_mobile/data/datasources/remote/gitbook_api_client.dart';
import 'package:gitbook_mobile/data/models/space_model.dart' as model;
import 'package:gitbook_mobile/data/repositories/space_repository_impl.dart';
import 'package:gitbook_mobile/domain/entities/space_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockGitBookApiClient extends Mock implements GitBookApiClient {}

class MockContentLocalDataSource extends Mock
    implements ContentLocalDataSource {}

class MockCacheManager extends Mock implements CacheManager {}

void main() {
  late MockGitBookApiClient mockApiClient;
  late MockContentLocalDataSource mockLocalDataSource;
  late MockCacheManager mockCacheManager;
  late SpaceRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
        const model.SpaceModel(id: '', title: ''));
    registerFallbackValue(model.SpaceVisibility.private);
  });

  setUp(() {
    mockApiClient = MockGitBookApiClient();
    mockLocalDataSource = MockContentLocalDataSource();
    mockCacheManager = MockCacheManager();
    repository = SpaceRepositoryImpl(
      apiClient: mockApiClient,
      localDataSource: mockLocalDataSource,
      cacheManager: mockCacheManager,
    );
  });

  group('getSpaces', () {
    test('should return cached spaces when available', () async {
      final cachedSpaces = [
        const model.SpaceModel(id: 'space-1', title: 'Space 1'),
        const model.SpaceModel(id: 'space-2', title: 'Space 2'),
      ];
      when(() => mockLocalDataSource.getSpacesByOrganization('org-123'))
          .thenAnswer((_) async => cachedSpaces);

      final result = await repository.getSpaces('org-123');

      expect(result.length, 2);
      expect(result[0].id, 'space-1');
      expect(result[1].id, 'space-2');
      verifyNever(() => mockApiClient.listSpaces('org-123'));
    });

    test('should fetch from API when cache is empty', () async {
      when(() => mockLocalDataSource.getSpacesByOrganization('org-123'))
          .thenAnswer((_) async => []);
      when(() => mockApiClient.listSpaces('org-123')).thenAnswer(
        (_) async => const model.SpacesListResponse(items: [
          model.SpaceModel(id: 'space-1', title: 'Space 1'),
        ]),
      );
      when(() => mockLocalDataSource.cacheSpaces(any()))
          .thenAnswer((_) async {});

      final result = await repository.getSpaces('org-123');

      expect(result.length, 1);
      verify(() => mockApiClient.listSpaces('org-123')).called(1);
    });

    test('should force refresh when requested', () async {
      when(() => mockApiClient.listSpaces('org-123')).thenAnswer(
        (_) async => const model.SpacesListResponse(items: [
          model.SpaceModel(id: 'space-1', title: 'Fresh Space'),
        ]),
      );
      when(() => mockLocalDataSource.cacheSpaces(any()))
          .thenAnswer((_) async {});

      final result = await repository.getSpaces('org-123', forceRefresh: true);

      expect(result.length, 1);
      expect(result[0].title, 'Fresh Space');
      verify(() => mockApiClient.listSpaces('org-123')).called(1);
      verifyNever(() => mockLocalDataSource.getSpacesByOrganization('org-123'));
    });
  });

  group('getSpaceById', () {
    test('should return cached space when available', () async {
      const cachedSpace = model.SpaceModel(id: 'space-123', title: 'Cached Space');
      when(() => mockLocalDataSource.getSpace('space-123'))
          .thenAnswer((_) async => cachedSpace);

      final result = await repository.getSpaceById('space-123');

      expect(result.id, 'space-123');
      expect(result.title, 'Cached Space');
      verifyNever(() => mockApiClient.getSpace('space-123'));
    });

    test('should fetch from API when not cached', () async {
      const apiSpace = model.SpaceModel(id: 'space-123', title: 'API Space');
      when(() => mockLocalDataSource.getSpace('space-123'))
          .thenAnswer((_) async => null);
      when(() => mockApiClient.getSpace('space-123'))
          .thenAnswer((_) async => apiSpace);
      when(() => mockLocalDataSource.cacheSpace(any()))
          .thenAnswer((_) async {});

      final result = await repository.getSpaceById('space-123');

      expect(result.id, 'space-123');
      expect(result.title, 'API Space');
      verify(() => mockApiClient.getSpace('space-123')).called(1);
    });
  });

  group('createSpace', () {
    test('should create space and cache it', () async {
      const newSpace = model.SpaceModel(
        id: 'space-new',
        title: 'New Space',
        description: 'Description',
        visibility: model.SpaceVisibility.private,
      );
      when(() => mockApiClient.createSpace(
            'org-123',
            title: 'New Space',
            description: 'Description',
            visibility: model.SpaceVisibility.private,
          )).thenAnswer((_) async => newSpace);
      when(() => mockLocalDataSource.cacheSpace(any()))
          .thenAnswer((_) async {});
      when(() => mockCacheManager.invalidateSpace('space-new'))
          .thenAnswer((_) async {});

      final result = await repository.createSpace(
        organizationId: 'org-123',
        title: 'New Space',
        description: 'Description',
        visibility: SpaceVisibility.private,
      );

      expect(result.id, 'space-new');
      expect(result.title, 'New Space');
      verify(() => mockLocalDataSource.cacheSpace(any())).called(1);
    });
  });

  group('updateSpace', () {
    test('should update space and cache it', () async {
      const updatedSpace = model.SpaceModel(
        id: 'space-123',
        title: 'Updated Title',
      );
      when(() => mockApiClient.updateSpace(
            'space-123',
            title: 'Updated Title',
            description: null,
            visibility: null,
          )).thenAnswer((_) async => updatedSpace);
      when(() => mockLocalDataSource.cacheSpace(any()))
          .thenAnswer((_) async {});

      final result = await repository.updateSpace(
        'space-123',
        title: 'Updated Title',
      );

      expect(result.title, 'Updated Title');
      verify(() => mockLocalDataSource.cacheSpace(any())).called(1);
    });
  });

  group('deleteSpace', () {
    test('should delete space and invalidate cache', () async {
      when(() => mockApiClient.deleteSpace('space-123'))
          .thenAnswer((_) async {});
      when(() => mockCacheManager.invalidateSpace('space-123'))
          .thenAnswer((_) async {});

      await repository.deleteSpace('space-123');

      verify(() => mockApiClient.deleteSpace('space-123')).called(1);
      verify(() => mockCacheManager.invalidateSpace('space-123')).called(1);
    });
  });

  group('searchSpaces', () {
    test('should filter spaces by title', () async {
      final spaces = [
        const model.SpaceModel(id: 'space-1', title: 'Matching Space'),
        const model.SpaceModel(id: 'space-2', title: 'Other Space'),
        const model.SpaceModel(id: 'space-3', title: 'Another Matching'),
      ];
      when(() => mockLocalDataSource.getSpacesByOrganization('org-123'))
          .thenAnswer((_) async => spaces);

      final result = await repository.searchSpaces('org-123', 'match');

      expect(result.length, 2);
      expect(result.every((s) => s.title.toLowerCase().contains('match')),
          isTrue);
    });

    test('should filter spaces by description', () async {
      final spaces = [
        const model.SpaceModel(
          id: 'space-1',
          title: 'Space',
          description: 'Contains keyword',
        ),
        const model.SpaceModel(id: 'space-2', title: 'Other'),
      ];
      when(() => mockLocalDataSource.getSpacesByOrganization('org-123'))
          .thenAnswer((_) async => spaces);

      final result = await repository.searchSpaces('org-123', 'keyword');

      expect(result.length, 1);
      expect(result[0].id, 'space-1');
    });

    test('should be case insensitive', () async {
      final spaces = [
        const model.SpaceModel(id: 'space-1', title: 'UPPERCASE'),
        const model.SpaceModel(id: 'space-2', title: 'lowercase'),
      ];
      when(() => mockLocalDataSource.getSpacesByOrganization('org-123'))
          .thenAnswer((_) async => spaces);

      final result = await repository.searchSpaces('org-123', 'LOWER');

      expect(result.length, 1);
      expect(result[0].id, 'space-2');
    });
  });

  group('recent spaces', () {
    test('should get recent spaces from cache manager', () async {
      when(() => mockCacheManager.getRecentItems(limit: 10)).thenAnswer(
        (_) async => [],
      );

      final result = await repository.getRecentSpaces();

      expect(result, isEmpty);
      verify(() => mockCacheManager.getRecentItems(limit: 10)).called(1);
    });

    test('should add to recent spaces', () async {
      const space = Space(id: 'space-123', title: 'Test', organizationId: 'org-123');
      when(() => mockCacheManager.addRecentItem(
            itemType: 'space',
            itemId: 'space-123',
            title: 'Test',
            spaceId: 'org-123',
          )).thenAnswer((_) async {});

      await repository.addToRecentSpaces(space);

      verify(() => mockCacheManager.addRecentItem(
            itemType: 'space',
            itemId: 'space-123',
            title: 'Test',
            spaceId: 'org-123',
          )).called(1);
    });

    test('should clear recent spaces', () async {
      when(() => mockCacheManager.clearRecentItems()).thenAnswer((_) async {});

      await repository.clearRecentSpaces();

      verify(() => mockCacheManager.clearRecentItems()).called(1);
    });
  });
}
