import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/space_model.dart';

void main() {
  group('SpaceVisibility enum', () {
    test('should serialize public visibility', () {
      const space = SpaceModel(
        id: 'space-1',
        title: 'Public Space',
        visibility: SpaceVisibility.public,
      );

      final json = space.toJson();
      expect(json['visibility'], 'public');
    });

    test('should serialize private visibility', () {
      const space = SpaceModel(
        id: 'space-1',
        title: 'Private Space',
        visibility: SpaceVisibility.private,
      );

      final json = space.toJson();
      expect(json['visibility'], 'private');
    });

    test('should serialize share-link visibility', () {
      const space = SpaceModel(
        id: 'space-1',
        title: 'Share Link Space',
        visibility: SpaceVisibility.shareLink,
      );

      final json = space.toJson();
      expect(json['visibility'], 'share-link');
    });

    test('should deserialize all visibility types', () {
      final visibilities = {
        'public': SpaceVisibility.public,
        'unlisted': SpaceVisibility.unlisted,
        'share-link': SpaceVisibility.shareLink,
        'visitor-auth': SpaceVisibility.visitorAuth,
        'in-collection': SpaceVisibility.inCollection,
        'private': SpaceVisibility.private,
      };

      for (final entry in visibilities.entries) {
        final json = {
          'id': 'space-1',
          'title': 'Test',
          'visibility': entry.key,
        };

        final space = SpaceModel.fromJson(json);
        expect(space.visibility, entry.value);
      }
    });
  });

  group('SpaceModel', () {
    test('should serialize to JSON correctly', () {
      final space = SpaceModel(
        id: 'space-123',
        title: 'Test Space',
        description: 'A test space',
        visibility: SpaceVisibility.public,
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2024-06-01T00:00:00.000Z'),
        organizationId: 'org-456',
        urls: const SpaceUrls(
          location: 'https://api.gitbook.com/v1/spaces/space-123',
          app: 'https://app.gitbook.com/spaces/space-123',
          published: 'https://docs.example.com',
        ),
      );

      final json = space.toJson();

      expect(json['id'], 'space-123');
      expect(json['title'], 'Test Space');
      expect(json['description'], 'A test space');
      expect(json['visibility'], 'public');
      expect(json['organizationId'], 'org-456');
      // After toJson(), nested objects are still model instances
      expect((json['urls'] as dynamic).published, 'https://docs.example.com');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'space-456',
        'title': 'Deserialized Space',
        'description': 'Description here',
        'visibility': 'private',
        'createdAt': '2024-02-15T10:30:00.000Z',
        'organizationId': 'org-789',
        'urls': {
          'location': 'https://api.gitbook.com/v1/spaces/space-456',
          'app': 'https://app.gitbook.com/spaces/space-456',
        },
      };

      final space = SpaceModel.fromJson(json);

      expect(space.id, 'space-456');
      expect(space.title, 'Deserialized Space');
      expect(space.visibility, SpaceVisibility.private);
      expect(space.organizationId, 'org-789');
      expect(space.urls?.location, 'https://api.gitbook.com/v1/spaces/space-456');
    });

    test('should handle deletedAt field', () {
      final json = {
        'id': 'space-deleted',
        'title': 'Deleted Space',
        'deletedAt': '2024-06-15T00:00:00.000Z',
      };

      final space = SpaceModel.fromJson(json);

      expect(space.deletedAt, DateTime.parse('2024-06-15T00:00:00.000Z'));
    });

    test('should handle null optional fields', () {
      final json = {
        'id': 'space-minimal',
        'title': 'Minimal Space',
      };

      final space = SpaceModel.fromJson(json);

      expect(space.id, 'space-minimal');
      expect(space.title, 'Minimal Space');
      expect(space.description, isNull);
      expect(space.visibility, isNull);
      expect(space.urls, isNull);
    });
  });

  group('SpacesListResponse', () {
    test('should deserialize list response correctly', () {
      final json = {
        'items': [
          {'id': 'space-1', 'title': 'Space One', 'visibility': 'public'},
          {'id': 'space-2', 'title': 'Space Two', 'visibility': 'private'},
        ],
        'next': {'page': 'next-page-cursor'},
      };

      final response = SpacesListResponse.fromJson(json);

      expect(response.items.length, 2);
      expect(response.items[0].id, 'space-1');
      expect(response.items[0].visibility, SpaceVisibility.public);
      expect(response.items[1].visibility, SpaceVisibility.private);
      expect(response.next?.page, 'next-page-cursor');
    });

    test('should handle empty list', () {
      final json = {
        'items': <Map<String, dynamic>>[],
      };

      final response = SpacesListResponse.fromJson(json);

      expect(response.items, isEmpty);
      expect(response.next, isNull);
    });
  });

  group('CreateSpaceRequest', () {
    test('should serialize to JSON correctly', () {
      const request = CreateSpaceRequest(
        title: 'New Space',
        description: 'A new space description',
        visibility: SpaceVisibility.public,
      );

      final json = request.toJson();

      expect(json['title'], 'New Space');
      expect(json['description'], 'A new space description');
      expect(json['visibility'], 'public');
    });

    test('should handle minimal request', () {
      const request = CreateSpaceRequest(title: 'Minimal Space');

      final json = request.toJson();

      expect(json['title'], 'Minimal Space');
      expect(json['description'], isNull);
      expect(json['visibility'], isNull);
    });
  });

  group('UpdateSpaceRequest', () {
    test('should serialize to JSON correctly', () {
      const request = UpdateSpaceRequest(
        title: 'Updated Title',
        description: 'Updated description',
        visibility: SpaceVisibility.private,
      );

      final json = request.toJson();

      expect(json['title'], 'Updated Title');
      expect(json['description'], 'Updated description');
      expect(json['visibility'], 'private');
    });

    test('should handle partial update', () {
      const request = UpdateSpaceRequest(title: 'Only Title');

      final json = request.toJson();

      expect(json['title'], 'Only Title');
      expect(json['description'], isNull);
    });
  });

  group('SpaceUrls', () {
    test('should deserialize all URL fields', () {
      final json = {
        'location': 'https://api.gitbook.com/v1/spaces/123',
        'app': 'https://app.gitbook.com/spaces/123',
        'published': 'https://docs.example.com',
      };

      final urls = SpaceUrls.fromJson(json);

      expect(urls.location, 'https://api.gitbook.com/v1/spaces/123');
      expect(urls.app, 'https://app.gitbook.com/spaces/123');
      expect(urls.published, 'https://docs.example.com');
    });
  });
}
