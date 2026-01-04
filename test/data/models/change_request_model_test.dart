import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/change_request_model.dart';

void main() {
  group('ChangeRequestStatus enum', () {
    test('should serialize status correctly', () {
      final statuses = {
        ChangeRequestStatus.draft: 'draft',
        ChangeRequestStatus.open: 'open',
        ChangeRequestStatus.merged: 'merged',
        ChangeRequestStatus.closed: 'closed',
      };

      for (final entry in statuses.entries) {
        final cr = ChangeRequestModel(
          id: 'cr-1',
          number: 1,
          status: entry.key,
        );
        final json = cr.toJson();
        expect(json['status'], entry.value);
      }
    });

    test('should deserialize status correctly', () {
      final statuses = {
        'draft': ChangeRequestStatus.draft,
        'open': ChangeRequestStatus.open,
        'merged': ChangeRequestStatus.merged,
        'closed': ChangeRequestStatus.closed,
      };

      for (final entry in statuses.entries) {
        final json = {
          'id': 'cr-1',
          'number': 1,
          'status': entry.key,
        };
        final cr = ChangeRequestModel.fromJson(json);
        expect(cr.status, entry.value);
      }
    });
  });

  group('ChangeRequestModel', () {
    test('should serialize to JSON correctly', () {
      final cr = ChangeRequestModel(
        id: 'cr-123',
        number: 42,
        subject: 'Update documentation',
        status: ChangeRequestStatus.open,
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-05T00:00:00.000Z'),
        createdBy: const ChangeRequestAuthor(
          id: 'user-456',
          displayName: 'John Doe',
          email: 'john@example.com',
        ),
        urls: const ChangeRequestUrls(
          location: 'https://api.gitbook.com/v1/change-requests/cr-123',
          app: 'https://app.gitbook.com/change-requests/cr-123',
        ),
      );

      final json = cr.toJson();

      expect(json['id'], 'cr-123');
      expect(json['number'], 42);
      expect(json['subject'], 'Update documentation');
      expect(json['status'], 'open');
      // After toJson(), nested objects are still model instances
      expect((json['createdBy'] as dynamic).displayName, 'John Doe');
      expect((json['urls'] as dynamic).location, 'https://api.gitbook.com/v1/change-requests/cr-123');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'cr-456',
        'number': 15,
        'subject': 'Fix typos',
        'status': 'merged',
        'createdAt': '2024-02-01T00:00:00.000Z',
        'mergedAt': '2024-02-05T00:00:00.000Z',
        'createdBy': {
          'id': 'user-789',
          'displayName': 'Jane Doe',
        },
      };

      final cr = ChangeRequestModel.fromJson(json);

      expect(cr.id, 'cr-456');
      expect(cr.number, 15);
      expect(cr.status, ChangeRequestStatus.merged);
      expect(cr.mergedAt, DateTime.parse('2024-02-05T00:00:00.000Z'));
      expect(cr.createdBy?.displayName, 'Jane Doe');
    });

    test('should handle closed change request', () {
      final json = {
        'id': 'cr-closed',
        'number': 99,
        'status': 'closed',
        'closedAt': '2024-03-01T00:00:00.000Z',
      };

      final cr = ChangeRequestModel.fromJson(json);

      expect(cr.status, ChangeRequestStatus.closed);
      expect(cr.closedAt, DateTime.parse('2024-03-01T00:00:00.000Z'));
    });

    test('should handle null optional fields', () {
      final json = {
        'id': 'cr-minimal',
        'number': 1,
      };

      final cr = ChangeRequestModel.fromJson(json);

      expect(cr.id, 'cr-minimal');
      expect(cr.number, 1);
      expect(cr.subject, isNull);
      expect(cr.status, isNull);
      expect(cr.createdBy, isNull);
      expect(cr.urls, isNull);
    });
  });

  group('ChangeRequestsListResponse', () {
    test('should deserialize list response correctly', () {
      final json = {
        'items': [
          {'id': 'cr-1', 'number': 1, 'status': 'open'},
          {'id': 'cr-2', 'number': 2, 'status': 'merged'},
          {'id': 'cr-3', 'number': 3, 'status': 'closed'},
        ],
        'next': {'page': 'cursor-123'},
      };

      final response = ChangeRequestsListResponse.fromJson(json);

      expect(response.items.length, 3);
      expect(response.items[0].status, ChangeRequestStatus.open);
      expect(response.items[1].status, ChangeRequestStatus.merged);
      expect(response.items[2].status, ChangeRequestStatus.closed);
      expect(response.next?.page, 'cursor-123');
    });

    test('should handle empty list', () {
      final json = {
        'items': <Map<String, dynamic>>[],
      };

      final response = ChangeRequestsListResponse.fromJson(json);

      expect(response.items, isEmpty);
      expect(response.next, isNull);
    });
  });

  group('ChangeRequestAuthor', () {
    test('should serialize and deserialize correctly', () {
      const author = ChangeRequestAuthor(
        id: 'author-123',
        displayName: 'Test Author',
        email: 'author@example.com',
        photoUrl: 'https://example.com/photo.jpg',
      );

      final json = author.toJson();

      expect(json['id'], 'author-123');
      expect(json['displayName'], 'Test Author');
      expect(json['email'], 'author@example.com');
      expect(json['photoUrl'], 'https://example.com/photo.jpg');

      final deserialized = ChangeRequestAuthor.fromJson(json);
      expect(deserialized, author);
    });
  });

  group('CreateChangeRequestRequest', () {
    test('should serialize with subject', () {
      const request = CreateChangeRequestRequest(
        subject: 'New feature documentation',
      );

      final json = request.toJson();

      expect(json['subject'], 'New feature documentation');
    });

    test('should serialize without subject', () {
      const request = CreateChangeRequestRequest();

      final json = request.toJson();

      expect(json['subject'], isNull);
    });
  });

  group('ChangeRequestComment', () {
    test('should deserialize comment correctly', () {
      final json = {
        'id': 'comment-123',
        'body': 'This looks good!',
        'createdAt': '2024-01-15T10:30:00.000Z',
        'updatedAt': '2024-01-15T10:30:00.000Z',
        'author': {
          'id': 'user-456',
          'displayName': 'Reviewer',
        },
      };

      final comment = ChangeRequestComment.fromJson(json);

      expect(comment.id, 'comment-123');
      expect(comment.body, 'This looks good!');
      expect(comment.createdAt, DateTime.parse('2024-01-15T10:30:00.000Z'));
      expect(comment.author?.displayName, 'Reviewer');
    });

    test('should serialize comment correctly', () {
      final comment = ChangeRequestComment(
        id: 'comment-789',
        body: 'Please fix the typo.',
        createdAt: DateTime.parse('2024-02-01T00:00:00.000Z'),
      );

      final json = comment.toJson();

      expect(json['id'], 'comment-789');
      expect(json['body'], 'Please fix the typo.');
      expect(json['author'], isNull);
    });
  });

  group('ChangeRequestUrls', () {
    test('should serialize and deserialize correctly', () {
      const urls = ChangeRequestUrls(
        location: 'https://api.gitbook.com/v1/cr/123',
        app: 'https://app.gitbook.com/cr/123',
      );

      final json = urls.toJson();
      expect(json['location'], 'https://api.gitbook.com/v1/cr/123');
      expect(json['app'], 'https://app.gitbook.com/cr/123');

      final deserialized = ChangeRequestUrls.fromJson(json);
      expect(deserialized, urls);
    });
  });
}
