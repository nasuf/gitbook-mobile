import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/space_entity.dart';

void main() {
  group('Space', () {
    test('should create a Space with required fields', () {
      const space = Space(
        id: 'space-123',
        title: 'Test Space',
      );

      expect(space.id, 'space-123');
      expect(space.title, 'Test Space');
      expect(space.description, isNull);
      expect(space.visibility, isNull);
    });

    test('should create a Space with all fields', () {
      final space = Space(
        id: 'space-123',
        title: 'Test Space',
        description: 'A test space',
        visibility: SpaceVisibility.public,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: DateTime(2024, 1, 2),
        organizationId: 'org-123',
        appUrl: 'https://app.gitbook.com/s/space-123',
        publishedUrl: 'https://docs.example.com',
      );

      expect(space.id, 'space-123');
      expect(space.title, 'Test Space');
      expect(space.description, 'A test space');
      expect(space.visibility, SpaceVisibility.public);
      expect(space.createdAt, DateTime(2024, 1, 1));
      expect(space.updatedAt, DateTime(2024, 1, 2));
      expect(space.organizationId, 'org-123');
      expect(space.appUrl, 'https://app.gitbook.com/s/space-123');
      expect(space.publishedUrl, 'https://docs.example.com');
    });

    test('should check if space is public', () {
      const publicSpace = Space(
        id: 'space-1',
        title: 'Public',
        visibility: SpaceVisibility.public,
      );

      const privateSpace = Space(
        id: 'space-2',
        title: 'Private',
        visibility: SpaceVisibility.private,
      );

      expect(publicSpace.isPublic, isTrue);
      expect(publicSpace.isPrivate, isFalse);
      expect(privateSpace.isPublic, isFalse);
      expect(privateSpace.isPrivate, isTrue);
    });

    test('should copy with new values', () {
      const original = Space(
        id: 'space-123',
        title: 'Original',
      );

      final copied = original.copyWith(
        title: 'Updated',
        description: 'New description',
      );

      expect(copied.id, 'space-123');
      expect(copied.title, 'Updated');
      expect(copied.description, 'New description');
    });

    test('should have equality', () {
      const space1 = Space(
        id: 'space-123',
        title: 'Test',
        visibility: SpaceVisibility.public,
      );

      const space2 = Space(
        id: 'space-123',
        title: 'Test',
        visibility: SpaceVisibility.public,
      );

      const space3 = Space(
        id: 'space-456',
        title: 'Test',
        visibility: SpaceVisibility.public,
      );

      expect(space1, equals(space2));
      expect(space1, isNot(equals(space3)));
    });
  });

  group('SpaceVisibility', () {
    test('should have all visibility types', () {
      expect(SpaceVisibility.values, hasLength(6));
      expect(SpaceVisibility.values, contains(SpaceVisibility.public));
      expect(SpaceVisibility.values, contains(SpaceVisibility.private));
      expect(SpaceVisibility.values, contains(SpaceVisibility.unlisted));
      expect(SpaceVisibility.values, contains(SpaceVisibility.shareLink));
      expect(SpaceVisibility.values, contains(SpaceVisibility.visitorAuth));
      expect(SpaceVisibility.values, contains(SpaceVisibility.inCollection));
    });
  });

  group('RecentSpaceItem', () {
    test('should create a RecentSpaceItem', () {
      final item = RecentSpaceItem(
        id: 'space-123',
        title: 'Recent Space',
        organizationId: 'org-123',
        organizationTitle: 'My Org',
        accessedAt: DateTime(2024, 1, 1),
      );

      expect(item.id, 'space-123');
      expect(item.title, 'Recent Space');
      expect(item.organizationId, 'org-123');
      expect(item.organizationTitle, 'My Org');
      expect(item.accessedAt, DateTime(2024, 1, 1));
    });

    test('should create a RecentSpaceItem without optional fields', () {
      final item = RecentSpaceItem(
        id: 'space-123',
        title: 'Recent Space',
        accessedAt: DateTime(2024, 1, 1),
      );

      expect(item.id, 'space-123');
      expect(item.organizationId, isNull);
      expect(item.organizationTitle, isNull);
    });

    test('should have equality', () {
      final item1 = RecentSpaceItem(
        id: 'space-123',
        title: 'Test',
        accessedAt: DateTime(2024, 1, 1),
      );

      final item2 = RecentSpaceItem(
        id: 'space-123',
        title: 'Test',
        accessedAt: DateTime(2024, 1, 1),
      );

      expect(item1, equals(item2));
    });
  });
}
