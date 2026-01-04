import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/core/constants/api_constants.dart';
import 'package:gitbook_mobile/data/datasources/remote/gitbook_api_client.dart';
import 'package:gitbook_mobile/data/models/models.dart';

import '../../../mocks/mock_dio_client.dart';

void main() {
  late MockDioClient mockClient;
  late GitBookApiClient apiClient;

  setUp(() {
    mockClient = MockDioClient();
    apiClient = GitBookApiClient(mockClient);
  });

  tearDown(() {
    mockClient.reset();
  });

  group('Authentication', () {
    test('getToken should make POST request to token endpoint', () async {
      mockClient.mockResponse(ApiConstants.token, {
        'accessToken': 'access-123',
        'tokenType': 'Bearer',
        'expiresIn': 3600,
        'refreshToken': 'refresh-456',
      });

      final result = await apiClient.getToken(
        grantType: 'authorization_code',
        clientId: 'client-123',
        code: 'auth-code',
        redirectUri: 'https://app.example.com/callback',
      );

      expect(result.accessToken, 'access-123');
      expect(result.tokenType, 'Bearer');
      expect(result.expiresIn, 3600);
      expect(result.refreshToken, 'refresh-456');

      expect(mockClient.requests.length, 1);
      expect(mockClient.requests[0].method, 'POST');
      expect(mockClient.requests[0].path, ApiConstants.token);
      expect(mockClient.requests[0].data['grant_type'], 'authorization_code');
      expect(mockClient.requests[0].data['client_id'], 'client-123');
    });

    test('getToken should support refresh_token grant', () async {
      mockClient.mockResponse(ApiConstants.token, {
        'accessToken': 'new-access-token',
        'expiresIn': 7200,
      });

      final result = await apiClient.getToken(
        grantType: 'refresh_token',
        refreshToken: 'old-refresh-token',
      );

      expect(result.accessToken, 'new-access-token');
      expect(mockClient.requests[0].data['grant_type'], 'refresh_token');
      expect(mockClient.requests[0].data['refresh_token'], 'old-refresh-token');
    });
  });

  group('User', () {
    test('getCurrentUser should fetch current user', () async {
      mockClient.mockResponse(ApiConstants.user, {
        'id': 'user-123',
        'displayName': 'John Doe',
        'email': 'john@example.com',
      });

      final result = await apiClient.getCurrentUser();

      expect(result.id, 'user-123');
      expect(result.displayName, 'John Doe');
      expect(result.email, 'john@example.com');

      expect(mockClient.requests.length, 1);
      expect(mockClient.requests[0].method, 'GET');
      expect(mockClient.requests[0].path, ApiConstants.user);
    });
  });

  group('Organizations', () {
    test('listOrganizations should fetch organizations list', () async {
      mockClient.mockResponse(ApiConstants.orgs, {
        'items': [
          {'id': 'org-1', 'title': 'Org One'},
          {'id': 'org-2', 'title': 'Org Two'},
        ],
        'next': {'page': 'cursor-abc'},
      });

      final result = await apiClient.listOrganizations(limit: 10);

      expect(result.items.length, 2);
      expect(result.items[0].id, 'org-1');
      expect(result.items[0].title, 'Org One');
      expect(result.next?.page, 'cursor-abc');

      expect(mockClient.requests[0].queryParameters?['limit'], 10);
    });

    test('listOrganizations should support pagination', () async {
      mockClient.mockResponse(ApiConstants.orgs, {
        'items': [
          {'id': 'org-3', 'title': 'Org Three'},
        ],
      });

      await apiClient.listOrganizations(page: 'cursor-abc');

      expect(mockClient.requests[0].queryParameters?['page'], 'cursor-abc');
    });

    test('getOrganization should fetch single organization', () async {
      mockClient.mockResponse(ApiConstants.org('org-123'), {
        'id': 'org-123',
        'title': 'My Organization',
        'createdAt': '2024-01-01T00:00:00.000Z',
      });

      final result = await apiClient.getOrganization('org-123');

      expect(result.id, 'org-123');
      expect(result.title, 'My Organization');
      expect(mockClient.requests[0].path, ApiConstants.org('org-123'));
    });

    test('listOrganizationMembers should fetch members', () async {
      mockClient.mockResponse(ApiConstants.orgMembers('org-123'), {
        'items': [
          {
            'id': 'member-1',
            'role': 'admin',
            'user': {'id': 'user-1', 'displayName': 'Admin User'},
          },
          {'id': 'member-2', 'role': 'member'},
        ],
      });

      final result = await apiClient.listOrganizationMembers('org-123', limit: 20);

      expect(result.items.length, 2);
      expect(result.items[0].role, 'admin');
      expect(result.items[0].user?.displayName, 'Admin User');
    });
  });

  group('Spaces', () {
    test('listSpaces should fetch spaces in organization', () async {
      mockClient.mockResponse(ApiConstants.orgSpaces('org-123'), {
        'items': [
          {'id': 'space-1', 'title': 'Documentation', 'visibility': 'public'},
          {'id': 'space-2', 'title': 'Internal', 'visibility': 'private'},
        ],
      });

      final result = await apiClient.listSpaces('org-123');

      expect(result.items.length, 2);
      expect(result.items[0].title, 'Documentation');
      expect(result.items[0].visibility, SpaceVisibility.public);
      expect(result.items[1].visibility, SpaceVisibility.private);
    });

    test('getSpace should fetch single space', () async {
      mockClient.mockResponse(ApiConstants.space('space-123'), {
        'id': 'space-123',
        'title': 'My Space',
        'description': 'A test space',
        'visibility': 'public',
      });

      final result = await apiClient.getSpace('space-123');

      expect(result.id, 'space-123');
      expect(result.title, 'My Space');
      expect(result.description, 'A test space');
    });

    test('createSpace should create new space', () async {
      mockClient.mockResponse(ApiConstants.orgSpaces('org-123'), {
        'id': 'new-space',
        'title': 'New Space',
        'description': 'Created space',
        'visibility': 'private',
      });

      final result = await apiClient.createSpace(
        'org-123',
        title: 'New Space',
        description: 'Created space',
        visibility: SpaceVisibility.private,
      );

      expect(result.id, 'new-space');
      expect(result.title, 'New Space');

      expect(mockClient.requests[0].method, 'POST');
      expect(mockClient.requests[0].data['title'], 'New Space');
      expect(mockClient.requests[0].data['description'], 'Created space');
      expect(mockClient.requests[0].data['visibility'], 'private');
    });

    test('updateSpace should update existing space', () async {
      mockClient.mockResponse(ApiConstants.space('space-123'), {
        'id': 'space-123',
        'title': 'Updated Title',
      });

      final result = await apiClient.updateSpace(
        'space-123',
        title: 'Updated Title',
      );

      expect(result.title, 'Updated Title');
      expect(mockClient.requests[0].method, 'PATCH');
      expect(mockClient.requests[0].data['title'], 'Updated Title');
    });

    test('deleteSpace should delete space', () async {
      mockClient.mockResponse(ApiConstants.space('space-123'), {});

      await apiClient.deleteSpace('space-123');

      expect(mockClient.requests[0].method, 'DELETE');
      expect(mockClient.requests[0].path, ApiConstants.space('space-123'));
    });
  });

  group('Content / Pages', () {
    test('getSpaceContent should fetch table of contents', () async {
      mockClient.mockResponse(ApiConstants.spaceContent('space-123'), {
        'pages': [
          {'id': 'page-1', 'title': 'Introduction', 'type': 'document'},
          {
            'id': 'group-1',
            'title': 'User Guide',
            'type': 'group',
            'pages': [
              {'id': 'page-2', 'title': 'Installation', 'type': 'document'},
            ],
          },
        ],
      });

      final result = await apiClient.getSpaceContent('space-123');

      expect(result.pages.length, 2);
      expect(result.pages[0].type, ContentType.document);
      expect(result.pages[1].type, ContentType.group);
      expect(result.pages[1].pages?.length, 1);
    });

    test('getPageByPath should fetch page by path', () async {
      mockClient.mockResponse(
        ApiConstants.spaceContentByPath('space-123', 'getting-started'),
        {
          'id': 'page-123',
          'title': 'Getting Started',
          'path': '/getting-started',
          'document': {
            'markdown': '# Getting Started\n\nWelcome!',
          },
        },
      );

      final result = await apiClient.getPageByPath('space-123', 'getting-started');

      expect(result.id, 'page-123');
      expect(result.title, 'Getting Started');
      expect(result.document?.markdown, '# Getting Started\n\nWelcome!');
    });

    test('getPageById should fetch page by ID', () async {
      mockClient.mockResponse(
        ApiConstants.spaceContentById('space-123', 'page-456'),
        {
          'id': 'page-456',
          'title': 'Page Title',
        },
      );

      final result = await apiClient.getPageById('space-123', 'page-456');

      expect(result.id, 'page-456');
      expect(result.title, 'Page Title');
    });

    test('createPage should create new page', () async {
      mockClient.mockResponse(ApiConstants.spaceContent('space-123'), {
        'id': 'new-page',
        'title': 'New Page',
        'type': 'document',
        'slug': 'new-page',
      });

      final result = await apiClient.createPage(
        'space-123',
        title: 'New Page',
        slug: 'new-page',
        type: ContentType.document,
        parentId: 'parent-123',
      );

      expect(result.id, 'new-page');
      expect(mockClient.requests[0].method, 'POST');
      expect(mockClient.requests[0].data['title'], 'New Page');
      expect(mockClient.requests[0].data['slug'], 'new-page');
      expect(mockClient.requests[0].data['parent'], 'parent-123');
    });

    test('updatePage should update page content', () async {
      mockClient.mockResponse(
        ApiConstants.spaceContentById('space-123', 'page-456'),
        {
          'id': 'page-456',
          'title': 'Updated Title',
        },
      );

      final result = await apiClient.updatePage(
        'space-123',
        'page-456',
        title: 'Updated Title',
        document: {'nodes': {'type': 'doc'}},
      );

      expect(result.title, 'Updated Title');
      expect(mockClient.requests[0].method, 'PATCH');
      expect(mockClient.requests[0].data['title'], 'Updated Title');
      expect(mockClient.requests[0].data['document'], isNotNull);
    });

    test('deletePage should delete page', () async {
      mockClient.mockResponse(
        ApiConstants.spaceContentById('space-123', 'page-456'),
        {},
      );

      await apiClient.deletePage('space-123', 'page-456');

      expect(mockClient.requests[0].method, 'DELETE');
    });
  });

  group('Change Requests', () {
    test('listChangeRequests should fetch change requests', () async {
      mockClient.mockResponse(ApiConstants.changeRequests('space-123'), {
        'items': [
          {'id': 'cr-1', 'number': 1, 'status': 'open', 'subject': 'Update docs'},
          {'id': 'cr-2', 'number': 2, 'status': 'merged'},
        ],
      });

      final result = await apiClient.listChangeRequests('space-123');

      expect(result.items.length, 2);
      expect(result.items[0].status, ChangeRequestStatus.open);
      expect(result.items[0].subject, 'Update docs');
      expect(result.items[1].status, ChangeRequestStatus.merged);
    });

    test('listChangeRequests should support status filter', () async {
      mockClient.mockResponse(ApiConstants.changeRequests('space-123'), {
        'items': [
          {'id': 'cr-1', 'number': 1, 'status': 'open'},
        ],
      });

      await apiClient.listChangeRequests(
        'space-123',
        status: ChangeRequestStatus.open,
      );

      expect(mockClient.requests[0].queryParameters?['status'], 'open');
    });

    test('getChangeRequest should fetch single change request', () async {
      mockClient.mockResponse(
        ApiConstants.changeRequest('space-123', 'cr-456'),
        {
          'id': 'cr-456',
          'number': 42,
          'subject': 'Fix typos',
          'status': 'open',
          'createdBy': {'id': 'user-1', 'displayName': 'Author'},
        },
      );

      final result = await apiClient.getChangeRequest('space-123', 'cr-456');

      expect(result.id, 'cr-456');
      expect(result.number, 42);
      expect(result.subject, 'Fix typos');
      expect(result.createdBy?.displayName, 'Author');
    });

    test('createChangeRequest should create new change request', () async {
      mockClient.mockResponse(ApiConstants.changeRequests('space-123'), {
        'id': 'new-cr',
        'number': 99,
        'subject': 'New feature',
        'status': 'draft',
      });

      final result = await apiClient.createChangeRequest(
        'space-123',
        subject: 'New feature',
      );

      expect(result.id, 'new-cr');
      expect(result.subject, 'New feature');
      expect(mockClient.requests[0].method, 'POST');
      expect(mockClient.requests[0].data['subject'], 'New feature');
    });

    test('mergeChangeRequest should merge change request', () async {
      mockClient.mockResponse(
        ApiConstants.mergeChangeRequest('space-123', 'cr-456'),
        {
          'id': 'cr-456',
          'number': 42,
          'status': 'merged',
          'mergedAt': '2024-06-01T00:00:00.000Z',
        },
      );

      final result = await apiClient.mergeChangeRequest('space-123', 'cr-456');

      expect(result.status, ChangeRequestStatus.merged);
      expect(result.mergedAt, isNotNull);
      expect(mockClient.requests[0].method, 'POST');
    });
  });

  group('Search', () {
    test('searchOrganization should search within organization', () async {
      mockClient.mockResponse(ApiConstants.orgSearch('org-123'), {
        'items': [
          {
            'id': 'result-1',
            'title': 'Introduction',
            'type': 'page',
            'highlight': 'Getting <em>started</em> guide',
            'spaceId': 'space-1',
          },
          {
            'id': 'result-2',
            'title': 'API Documentation',
            'type': 'space',
          },
        ],
        'next': {'page': 'cursor-xyz'},
      });

      final result = await apiClient.searchOrganization(
        'org-123',
        query: 'started',
        limit: 10,
      );

      expect(result.items.length, 2);
      expect(result.items[0].type, SearchResultType.page);
      expect(result.items[0].highlight, contains('<em>started</em>'));
      expect(result.items[1].type, SearchResultType.space);
      expect(result.next?.page, 'cursor-xyz');

      expect(mockClient.requests[0].queryParameters?['query'], 'started');
      expect(mockClient.requests[0].queryParameters?['limit'], 10);
    });

    test('searchSpace should search within space', () async {
      mockClient.mockResponse(ApiConstants.spaceSearch('space-123'), {
        'items': [
          {
            'id': 'page-1',
            'title': 'Authentication',
            'type': 'page',
            'path': '/auth',
          },
        ],
      });

      final result = await apiClient.searchSpace(
        'space-123',
        query: 'authentication',
      );

      expect(result.items.length, 1);
      expect(result.items[0].title, 'Authentication');
      expect(result.items[0].path, '/auth');

      expect(mockClient.requests[0].path, ApiConstants.spaceSearch('space-123'));
      expect(mockClient.requests[0].queryParameters?['query'], 'authentication');
    });

    test('searchSpace should support pagination', () async {
      mockClient.mockResponse(ApiConstants.spaceSearch('space-123'), {
        'items': [],
      });

      await apiClient.searchSpace(
        'space-123',
        query: 'test',
        page: 'cursor-123',
        limit: 50,
      );

      expect(mockClient.requests[0].queryParameters?['page'], 'cursor-123');
      expect(mockClient.requests[0].queryParameters?['limit'], 50);
    });
  });

  group('Error handling', () {
    test('should propagate errors from DioClient', () async {
      mockClient.setNextError(Exception('Network error'));

      expect(
        () => apiClient.getCurrentUser(),
        throwsException,
      );
    });
  });
}
