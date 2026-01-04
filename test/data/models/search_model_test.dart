import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/search_model.dart';

void main() {
  group('SearchResultType enum', () {
    test('should serialize result types correctly', () {
      final types = {
        SearchResultType.page: 'page',
        SearchResultType.space: 'space',
      };

      for (final entry in types.entries) {
        final result = SearchResult(
          id: 'result-1',
          title: 'Test',
          type: entry.key,
        );
        final json = result.toJson();
        expect(json['type'], entry.value);
      }
    });

    test('should deserialize result types correctly', () {
      final types = {
        'page': SearchResultType.page,
        'space': SearchResultType.space,
      };

      for (final entry in types.entries) {
        final json = {
          'id': 'result-1',
          'title': 'Test',
          'type': entry.key,
        };
        final result = SearchResult.fromJson(json);
        expect(result.type, entry.value);
      }
    });
  });

  group('SearchResult', () {
    test('should serialize to JSON correctly', () {
      const result = SearchResult(
        id: 'page-123',
        title: 'Getting Started',
        type: SearchResultType.page,
        path: '/getting-started',
        spaceId: 'space-456',
        spaceTitle: 'Documentation',
        highlight: 'This is the <em>getting started</em> guide...',
        urls: SearchResultUrls(
          location: 'https://api.gitbook.com/v1/pages/page-123',
          app: 'https://app.gitbook.com/pages/page-123',
        ),
      );

      final json = result.toJson();

      expect(json['id'], 'page-123');
      expect(json['title'], 'Getting Started');
      expect(json['type'], 'page');
      expect(json['path'], '/getting-started');
      expect(json['spaceId'], 'space-456');
      expect(json['spaceTitle'], 'Documentation');
      expect(json['highlight'], contains('<em>getting started</em>'));
      // After toJson(), nested objects are still model instances
      expect((json['urls'] as dynamic).location, 'https://api.gitbook.com/v1/pages/page-123');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'space-789',
        'title': 'API Reference',
        'type': 'space',
        'highlight': 'Complete <em>API</em> documentation...',
        'urls': {
          'location': 'https://api.gitbook.com/v1/spaces/space-789',
          'app': 'https://app.gitbook.com/spaces/space-789',
        },
      };

      final result = SearchResult.fromJson(json);

      expect(result.id, 'space-789');
      expect(result.title, 'API Reference');
      expect(result.type, SearchResultType.space);
      expect(result.highlight, contains('<em>API</em>'));
      expect(result.urls?.app, 'https://app.gitbook.com/spaces/space-789');
    });

    test('should handle null optional fields', () {
      final json = {
        'id': 'result-minimal',
        'title': 'Minimal Result',
      };

      final result = SearchResult.fromJson(json);

      expect(result.id, 'result-minimal');
      expect(result.title, 'Minimal Result');
      expect(result.type, isNull);
      expect(result.path, isNull);
      expect(result.spaceId, isNull);
      expect(result.highlight, isNull);
      expect(result.urls, isNull);
    });
  });

  group('SearchResultUrls', () {
    test('should serialize and deserialize correctly', () {
      const urls = SearchResultUrls(
        location: 'https://api.gitbook.com/v1/search/result',
        app: 'https://app.gitbook.com/search/result',
      );

      final json = urls.toJson();

      expect(json['location'], 'https://api.gitbook.com/v1/search/result');
      expect(json['app'], 'https://app.gitbook.com/search/result');

      final deserialized = SearchResultUrls.fromJson(json);
      expect(deserialized, urls);
    });

    test('should handle null fields', () {
      final json = <String, dynamic>{};

      final urls = SearchResultUrls.fromJson(json);

      expect(urls.location, isNull);
      expect(urls.app, isNull);
    });
  });

  group('SearchResponse', () {
    test('should deserialize response with results', () {
      final json = {
        'items': [
          {
            'id': 'page-1',
            'title': 'Introduction',
            'type': 'page',
            'highlight': 'Welcome to the <em>introduction</em>',
          },
          {
            'id': 'page-2',
            'title': 'Quick Start',
            'type': 'page',
            'highlight': 'Get started <em>quickly</em>',
          },
          {
            'id': 'space-1',
            'title': 'API Docs',
            'type': 'space',
          },
        ],
        'next': {'page': 'cursor-next'},
      };

      final response = SearchResponse.fromJson(json);

      expect(response.items.length, 3);
      expect(response.items[0].title, 'Introduction');
      expect(response.items[0].type, SearchResultType.page);
      expect(response.items[2].type, SearchResultType.space);
      expect(response.next?.page, 'cursor-next');
    });

    test('should handle empty results', () {
      final json = {
        'items': <Map<String, dynamic>>[],
      };

      final response = SearchResponse.fromJson(json);

      expect(response.items, isEmpty);
      expect(response.next, isNull);
    });

    test('should handle response without pagination', () {
      final json = {
        'items': [
          {'id': 'result-1', 'title': 'Only Result'},
        ],
      };

      final response = SearchResponse.fromJson(json);

      expect(response.items.length, 1);
      expect(response.next, isNull);
    });
  });

  group('SearchRequest', () {
    test('should serialize to JSON correctly', () {
      const request = SearchRequest(
        query: 'authentication',
        limit: 20,
        page: 'cursor-abc',
      );

      final json = request.toJson();

      expect(json['query'], 'authentication');
      expect(json['limit'], 20);
      expect(json['page'], 'cursor-abc');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'query': 'api endpoints',
        'limit': 10,
        'page': 'next-page',
      };

      final request = SearchRequest.fromJson(json);

      expect(request.query, 'api endpoints');
      expect(request.limit, 10);
      expect(request.page, 'next-page');
    });

    test('should handle minimal request', () {
      const request = SearchRequest(query: 'simple search');

      final json = request.toJson();

      expect(json['query'], 'simple search');
      expect(json['limit'], isNull);
      expect(json['page'], isNull);
    });

    test('should support special characters in query', () {
      const request = SearchRequest(query: 'user@example.com "exact phrase"');

      final json = request.toJson();

      expect(json['query'], 'user@example.com "exact phrase"');
    });
  });
}
