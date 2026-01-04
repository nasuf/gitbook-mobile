import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/content_model.dart';

void main() {
  group('ContentType enum', () {
    test('should serialize content types correctly', () {
      final types = {
        ContentType.document: 'document',
        ContentType.group: 'group',
        ContentType.link: 'link',
      };

      for (final entry in types.entries) {
        final content = ContentModel(
          id: 'content-1',
          title: 'Test',
          type: entry.key,
        );
        final json = content.toJson();
        expect(json['type'], entry.value);
      }
    });

    test('should deserialize content types correctly', () {
      final types = {
        'document': ContentType.document,
        'group': ContentType.group,
        'link': ContentType.link,
      };

      for (final entry in types.entries) {
        final json = {
          'id': 'content-1',
          'title': 'Test',
          'type': entry.key,
        };
        final content = ContentModel.fromJson(json);
        expect(content.type, entry.value);
      }
    });
  });

  group('ContentModel', () {
    test('should serialize to JSON correctly', () {
      const content = ContentModel(
        id: 'page-123',
        title: 'Introduction',
        type: ContentType.document,
        path: '/introduction',
        slug: 'introduction',
        description: 'Introduction page',
        urls: ContentUrls(
          location: 'https://api.gitbook.com/v1/pages/page-123',
          app: 'https://app.gitbook.com/pages/page-123',
        ),
      );

      final json = content.toJson();

      expect(json['id'], 'page-123');
      expect(json['title'], 'Introduction');
      expect(json['type'], 'document');
      expect(json['path'], '/introduction');
      expect(json['slug'], 'introduction');
      // After toJson(), nested objects are still model instances
      expect((json['urls'] as dynamic).location, 'https://api.gitbook.com/v1/pages/page-123');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'page-456',
        'title': 'Getting Started',
        'type': 'document',
        'path': '/getting-started',
        'slug': 'getting-started',
        'createdAt': '2024-01-01T00:00:00.000Z',
        'updatedAt': '2024-06-01T00:00:00.000Z',
      };

      final content = ContentModel.fromJson(json);

      expect(content.id, 'page-456');
      expect(content.title, 'Getting Started');
      expect(content.type, ContentType.document);
      expect(content.path, '/getting-started');
      expect(content.createdAt, DateTime.parse('2024-01-01T00:00:00.000Z'));
    });

    test('should handle nested pages', () {
      final json = {
        'id': 'group-1',
        'title': 'User Guide',
        'type': 'group',
        'pages': [
          {
            'id': 'page-1',
            'title': 'Installation',
            'type': 'document',
          },
          {
            'id': 'page-2',
            'title': 'Configuration',
            'type': 'document',
          },
        ],
      };

      final content = ContentModel.fromJson(json);

      expect(content.type, ContentType.group);
      expect(content.pages?.length, 2);
      expect(content.pages?[0].title, 'Installation');
      expect(content.pages?[1].title, 'Configuration');
    });

    test('should handle deeply nested pages', () {
      final json = {
        'id': 'root-group',
        'title': 'Documentation',
        'type': 'group',
        'pages': [
          {
            'id': 'sub-group',
            'title': 'API Reference',
            'type': 'group',
            'pages': [
              {
                'id': 'nested-page',
                'title': 'Authentication',
                'type': 'document',
              },
            ],
          },
        ],
      };

      final content = ContentModel.fromJson(json);

      expect(content.pages?.length, 1);
      expect(content.pages?[0].pages?.length, 1);
      expect(content.pages?[0].pages?[0].title, 'Authentication');
    });
  });

  group('SpaceContentResponse', () {
    test('should deserialize pages list', () {
      final json = {
        'pages': [
          {'id': 'page-1', 'title': 'Page One', 'type': 'document'},
          {'id': 'page-2', 'title': 'Page Two', 'type': 'document'},
          {'id': 'group-1', 'title': 'Group One', 'type': 'group'},
        ],
      };

      final response = SpaceContentResponse.fromJson(json);

      expect(response.pages.length, 3);
      expect(response.pages[0].type, ContentType.document);
      expect(response.pages[2].type, ContentType.group);
    });

    test('should handle empty pages list', () {
      final json = {
        'pages': <Map<String, dynamic>>[],
      };

      final response = SpaceContentResponse.fromJson(json);

      expect(response.pages, isEmpty);
    });
  });

  group('DocumentContent', () {
    test('should deserialize document with body', () {
      final json = {
        'id': 'doc-123',
        'title': 'Test Document',
        'type': 'document',
        'path': '/test',
        'document': {
          'nodes': {'type': 'doc', 'content': []},
          'markdown': '# Test\n\nThis is a test.',
        },
      };

      final doc = DocumentContent.fromJson(json);

      expect(doc.id, 'doc-123');
      expect(doc.title, 'Test Document');
      expect(doc.document?.markdown, '# Test\n\nThis is a test.');
      expect(doc.document?.nodes, isNotNull);
    });

    test('should handle document without body', () {
      final json = {
        'id': 'doc-456',
        'title': 'Empty Document',
        'type': 'document',
      };

      final doc = DocumentContent.fromJson(json);

      expect(doc.id, 'doc-456');
      expect(doc.document, isNull);
    });
  });

  group('DocumentBody', () {
    test('should serialize and deserialize nodes', () {
      final json = {
        'nodes': {
          'type': 'doc',
          'content': [
            {'type': 'paragraph', 'content': [{'type': 'text', 'text': 'Hello'}]},
          ],
        },
        'markdown': '# Hello',
      };

      final body = DocumentBody.fromJson(json);

      expect(body.nodes?['type'], 'doc');
      expect(body.markdown, '# Hello');

      final serialized = body.toJson();
      expect(serialized['nodes']['type'], 'doc');
    });
  });

  group('CreatePageRequest', () {
    test('should serialize to JSON correctly', () {
      const request = CreatePageRequest(
        title: 'New Page',
        slug: 'new-page',
        description: 'A new page',
        type: ContentType.document,
        parent: 'parent-123',
      );

      final json = request.toJson();

      expect(json['title'], 'New Page');
      expect(json['slug'], 'new-page');
      expect(json['description'], 'A new page');
      expect(json['type'], 'document');
      expect(json['parent'], 'parent-123');
    });

    test('should handle minimal request', () {
      const request = CreatePageRequest(title: 'Minimal Page');

      final json = request.toJson();

      expect(json['title'], 'Minimal Page');
      expect(json['slug'], isNull);
      expect(json['parent'], isNull);
    });
  });

  group('UpdatePageRequest', () {
    test('should serialize to JSON correctly', () {
      const request = UpdatePageRequest(
        title: 'Updated Title',
        slug: 'updated-slug',
        description: 'Updated description',
        document: {'nodes': {'type': 'doc'}},
      );

      final json = request.toJson();

      expect(json['title'], 'Updated Title');
      expect(json['slug'], 'updated-slug');
      expect(json['document']['nodes']['type'], 'doc');
    });

    test('should handle partial update', () {
      const request = UpdatePageRequest(title: 'Only Title Update');

      final json = request.toJson();

      expect(json['title'], 'Only Title Update');
      expect(json['document'], isNull);
    });
  });

  group('ContentUrls', () {
    test('should serialize and deserialize correctly', () {
      const urls = ContentUrls(
        location: 'https://api.gitbook.com/v1/content/123',
        app: 'https://app.gitbook.com/content/123',
      );

      final json = urls.toJson();
      expect(json['location'], 'https://api.gitbook.com/v1/content/123');

      final deserialized = ContentUrls.fromJson(json);
      expect(deserialized.location, urls.location);
      expect(deserialized.app, urls.app);
    });
  });
}
