import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/space_entity.dart';
import 'package:gitbook_mobile/domain/repositories/space_repository.dart';
import 'package:gitbook_mobile/domain/usecases/space_usecases.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceRepository extends Mock implements SpaceRepository {}

void main() {
  late MockSpaceRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(const Space(id: '', title: ''));
    registerFallbackValue(SpaceVisibility.private);
  });

  setUp(() {
    mockRepository = MockSpaceRepository();
  });

  group('GetSpacesUseCase', () {
    late GetSpacesUseCase useCase;

    setUp(() {
      useCase = GetSpacesUseCase(mockRepository);
    });

    test('should return spaces from repository', () async {
      final spaces = [
        const Space(id: 'space-1', title: 'Space One'),
        const Space(id: 'space-2', title: 'Space Two'),
      ];
      when(() => mockRepository.getSpaces('org-123', forceRefresh: false))
          .thenAnswer((_) async => spaces);

      final result = await useCase('org-123');

      expect(result.length, 2);
      expect(result[0].id, 'space-1');
      expect(result[1].id, 'space-2');
      verify(() => mockRepository.getSpaces('org-123', forceRefresh: false))
          .called(1);
    });

    test('should force refresh when requested', () async {
      when(() => mockRepository.getSpaces('org-123', forceRefresh: true))
          .thenAnswer((_) async => []);

      await useCase('org-123', forceRefresh: true);

      verify(() => mockRepository.getSpaces('org-123', forceRefresh: true))
          .called(1);
    });
  });

  group('GetSpaceUseCase', () {
    late GetSpaceUseCase useCase;

    setUp(() {
      useCase = GetSpaceUseCase(mockRepository);
    });

    test('should return space by ID', () async {
      const space = Space(id: 'space-123', title: 'Test Space');
      when(() => mockRepository.getSpaceById('space-123'))
          .thenAnswer((_) async => space);

      final result = await useCase('space-123');

      expect(result.id, 'space-123');
      expect(result.title, 'Test Space');
      verify(() => mockRepository.getSpaceById('space-123')).called(1);
    });
  });

  group('CreateSpaceUseCase', () {
    late CreateSpaceUseCase useCase;

    setUp(() {
      useCase = CreateSpaceUseCase(mockRepository);
    });

    test('should create a new space', () async {
      const newSpace = Space(
        id: 'space-new',
        title: 'New Space',
        description: 'Description',
        visibility: SpaceVisibility.private,
      );
      when(() => mockRepository.createSpace(
            organizationId: 'org-123',
            title: 'New Space',
            description: 'Description',
            visibility: SpaceVisibility.private,
          )).thenAnswer((_) async => newSpace);

      final result = await useCase(
        organizationId: 'org-123',
        title: 'New Space',
        description: 'Description',
        visibility: SpaceVisibility.private,
      );

      expect(result.id, 'space-new');
      expect(result.title, 'New Space');
      verify(() => mockRepository.createSpace(
            organizationId: 'org-123',
            title: 'New Space',
            description: 'Description',
            visibility: SpaceVisibility.private,
          )).called(1);
    });

    test('should create a space with minimal fields', () async {
      const newSpace = Space(id: 'space-new', title: 'Minimal Space');
      when(() => mockRepository.createSpace(
            organizationId: 'org-123',
            title: 'Minimal Space',
            description: null,
            visibility: null,
          )).thenAnswer((_) async => newSpace);

      final result = await useCase(
        organizationId: 'org-123',
        title: 'Minimal Space',
      );

      expect(result.id, 'space-new');
    });
  });

  group('UpdateSpaceUseCase', () {
    late UpdateSpaceUseCase useCase;

    setUp(() {
      useCase = UpdateSpaceUseCase(mockRepository);
    });

    test('should update space title', () async {
      const updatedSpace = Space(id: 'space-123', title: 'Updated Title');
      when(() => mockRepository.updateSpace(
            'space-123',
            title: 'Updated Title',
            description: null,
            visibility: null,
          )).thenAnswer((_) async => updatedSpace);

      final result = await useCase('space-123', title: 'Updated Title');

      expect(result.title, 'Updated Title');
      verify(() => mockRepository.updateSpace(
            'space-123',
            title: 'Updated Title',
            description: null,
            visibility: null,
          )).called(1);
    });

    test('should update space visibility', () async {
      const updatedSpace = Space(
        id: 'space-123',
        title: 'Space',
        visibility: SpaceVisibility.public,
      );
      when(() => mockRepository.updateSpace(
            'space-123',
            title: null,
            description: null,
            visibility: SpaceVisibility.public,
          )).thenAnswer((_) async => updatedSpace);

      final result = await useCase(
        'space-123',
        visibility: SpaceVisibility.public,
      );

      expect(result.visibility, SpaceVisibility.public);
    });
  });

  group('DeleteSpaceUseCase', () {
    late DeleteSpaceUseCase useCase;

    setUp(() {
      useCase = DeleteSpaceUseCase(mockRepository);
    });

    test('should delete space', () async {
      when(() => mockRepository.deleteSpace('space-123'))
          .thenAnswer((_) async {});

      await useCase('space-123');

      verify(() => mockRepository.deleteSpace('space-123')).called(1);
    });
  });

  group('SearchSpacesUseCase', () {
    late SearchSpacesUseCase useCase;

    setUp(() {
      useCase = SearchSpacesUseCase(mockRepository);
    });

    test('should search spaces', () async {
      final results = [
        const Space(id: 'space-1', title: 'Matching Space'),
      ];
      when(() => mockRepository.searchSpaces('org-123', 'match'))
          .thenAnswer((_) async => results);

      final result = await useCase('org-123', 'match');

      expect(result.length, 1);
      expect(result[0].title, 'Matching Space');
      verify(() => mockRepository.searchSpaces('org-123', 'match')).called(1);
    });

    test('should return empty list when no matches', () async {
      when(() => mockRepository.searchSpaces('org-123', 'nonexistent'))
          .thenAnswer((_) async => []);

      final result = await useCase('org-123', 'nonexistent');

      expect(result, isEmpty);
    });
  });

  group('GetRecentSpacesUseCase', () {
    late GetRecentSpacesUseCase useCase;

    setUp(() {
      useCase = GetRecentSpacesUseCase(mockRepository);
    });

    test('should return recent spaces', () async {
      final recentItems = [
        RecentSpaceItem(
          id: 'space-1',
          title: 'Recent 1',
          accessedAt: DateTime(2024, 1, 1),
        ),
        RecentSpaceItem(
          id: 'space-2',
          title: 'Recent 2',
          accessedAt: DateTime(2024, 1, 2),
        ),
      ];
      when(() => mockRepository.getRecentSpaces(limit: 10))
          .thenAnswer((_) async => recentItems);

      final result = await useCase();

      expect(result.length, 2);
      expect(result[0].id, 'space-1');
    });

    test('should respect limit parameter', () async {
      when(() => mockRepository.getRecentSpaces(limit: 5))
          .thenAnswer((_) async => []);

      await useCase(limit: 5);

      verify(() => mockRepository.getRecentSpaces(limit: 5)).called(1);
    });
  });

  group('AddToRecentSpacesUseCase', () {
    late AddToRecentSpacesUseCase useCase;

    setUp(() {
      useCase = AddToRecentSpacesUseCase(mockRepository);
    });

    test('should add space to recent items', () async {
      const space = Space(id: 'space-123', title: 'Test Space');
      when(() => mockRepository.addToRecentSpaces(
            space,
            organizationTitle: 'My Org',
          )).thenAnswer((_) async {});

      await useCase(space, organizationTitle: 'My Org');

      verify(() => mockRepository.addToRecentSpaces(
            space,
            organizationTitle: 'My Org',
          )).called(1);
    });
  });
}
