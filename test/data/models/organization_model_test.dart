import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/models/organization_model.dart';
import 'package:gitbook_mobile/data/models/common_model.dart';

void main() {
  group('OrganizationModel', () {
    test('should serialize to JSON correctly', () {
      final org = OrganizationModel(
        id: 'org-123',
        title: 'Test Organization',
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
        updatedAt: DateTime.parse('2024-06-01T00:00:00.000Z'),
        urls: const OrganizationUrls(
          location: 'https://api.gitbook.com/v1/orgs/org-123',
          app: 'https://app.gitbook.com/orgs/org-123',
        ),
      );

      final json = org.toJson();

      expect(json['id'], 'org-123');
      expect(json['title'], 'Test Organization');
      // After toJson(), nested objects are still model instances
      expect((json['urls'] as dynamic).location, 'https://api.gitbook.com/v1/orgs/org-123');
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'org-456',
        'title': 'Another Org',
        'createdAt': '2024-01-15T10:30:00.000Z',
        'urls': {
          'location': 'https://api.gitbook.com/v1/orgs/org-456',
          'app': 'https://app.gitbook.com/orgs/org-456',
        },
      };

      final org = OrganizationModel.fromJson(json);

      expect(org.id, 'org-456');
      expect(org.title, 'Another Org');
      expect(org.createdAt, DateTime.parse('2024-01-15T10:30:00.000Z'));
      expect(org.urls?.location, 'https://api.gitbook.com/v1/orgs/org-456');
    });

    test('should handle null optional fields', () {
      final json = {
        'id': 'org-789',
        'title': 'Minimal Org',
      };

      final org = OrganizationModel.fromJson(json);

      expect(org.id, 'org-789');
      expect(org.title, 'Minimal Org');
      expect(org.createdAt, isNull);
      expect(org.updatedAt, isNull);
      expect(org.urls, isNull);
    });
  });

  group('OrganizationsListResponse', () {
    test('should deserialize list response correctly', () {
      final json = {
        'items': [
          {'id': 'org-1', 'title': 'Org One'},
          {'id': 'org-2', 'title': 'Org Two'},
        ],
        'next': {'page': 'cursor-abc'},
      };

      final response = OrganizationsListResponse.fromJson(json);

      expect(response.items.length, 2);
      expect(response.items[0].id, 'org-1');
      expect(response.items[1].title, 'Org Two');
      expect(response.next?.page, 'cursor-abc');
    });

    test('should handle empty list', () {
      final json = {
        'items': <Map<String, dynamic>>[],
      };

      final response = OrganizationsListResponse.fromJson(json);

      expect(response.items, isEmpty);
      expect(response.next, isNull);
    });
  });

  group('OrganizationMember', () {
    test('should deserialize member with user info', () {
      final json = {
        'id': 'member-123',
        'role': 'admin',
        'user': {
          'id': 'user-456',
          'displayName': 'Admin User',
          'email': 'admin@example.com',
        },
        'createdAt': '2024-03-01T00:00:00.000Z',
      };

      final member = OrganizationMember.fromJson(json);

      expect(member.id, 'member-123');
      expect(member.role, 'admin');
      expect(member.user?.id, 'user-456');
      expect(member.user?.displayName, 'Admin User');
      expect(member.createdAt, DateTime.parse('2024-03-01T00:00:00.000Z'));
    });
  });

  group('OrganizationMembersResponse', () {
    test('should deserialize members list response', () {
      final json = {
        'items': [
          {'id': 'member-1', 'role': 'admin'},
          {'id': 'member-2', 'role': 'member'},
        ],
        'next': {'page': 'page-2'},
      };

      final response = OrganizationMembersResponse.fromJson(json);

      expect(response.items.length, 2);
      expect(response.items[0].role, 'admin');
      expect(response.items[1].role, 'member');
    });
  });

  group('UserInfo', () {
    test('should serialize and deserialize correctly', () {
      final json = {
        'id': 'user-info-123',
        'displayName': 'Test User',
        'email': 'test@example.com',
        'photoUrl': 'https://example.com/photo.jpg',
      };

      final userInfo = UserInfo.fromJson(json);

      expect(userInfo.id, 'user-info-123');
      expect(userInfo.displayName, 'Test User');

      final serialized = userInfo.toJson();
      expect(serialized['id'], 'user-info-123');
    });
  });

  group('PageInfo', () {
    test('should deserialize correctly', () {
      final json = {'page': 'cursor-xyz'};
      final pageInfo = PageInfo.fromJson(json);
      expect(pageInfo.page, 'cursor-xyz');
    });

    test('should handle null page', () {
      final json = <String, dynamic>{};
      final pageInfo = PageInfo.fromJson(json);
      expect(pageInfo.page, isNull);
    });
  });
}
