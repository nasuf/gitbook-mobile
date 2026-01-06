import '../../../core/constants/api_constants.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/utils/gitbook_document_converter.dart';
import '../../models/models.dart';

/// GitBook API client for making API calls
class GitBookApiClient {
  final DioClient _client;

  GitBookApiClient(this._client);

  // ============ Authentication ============

  /// Exchange authorization code for access token
  Future<TokenResponse> getToken({
    required String grantType,
    String? clientId,
    String? clientSecret,
    String? code,
    String? redirectUri,
    String? refreshToken,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.token,
      data: {
        'grant_type': grantType,
        if (clientId != null) 'client_id': clientId,
        if (clientSecret != null) 'client_secret': clientSecret,
        if (code != null) 'code': code,
        if (redirectUri != null) 'redirect_uri': redirectUri,
        if (refreshToken != null) 'refresh_token': refreshToken,
      },
    );
    return TokenResponse.fromJson(response.data!);
  }

  // ============ User ============

  /// Get current authenticated user
  Future<UserModel> getCurrentUser() async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.user,
    );
    return UserModel.fromJson(response.data!);
  }

  // ============ Organizations ============

  /// List all organizations the user has access to
  Future<OrganizationsListResponse> listOrganizations({
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.orgs,
      queryParameters: {
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return OrganizationsListResponse.fromJson(response.data!);
  }

  /// Get organization by ID
  Future<OrganizationModel> getOrganization(String orgId) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.org(orgId),
    );
    return OrganizationModel.fromJson(response.data!);
  }

  /// List organization members
  Future<OrganizationMembersResponse> listOrganizationMembers(
    String orgId, {
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.orgMembers(orgId),
      queryParameters: {
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return OrganizationMembersResponse.fromJson(response.data!);
  }

  // ============ Collections ============

  /// List collections in an organization
  Future<CollectionsListResponse> listCollections(
    String orgId, {
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.orgCollections(orgId),
      queryParameters: {
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return CollectionsListResponse.fromJson(response.data!);
  }

  /// Get collection by ID
  Future<CollectionModel> getCollection(String collectionId) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.collection(collectionId),
    );
    return CollectionModel.fromJson(response.data!);
  }

  /// Create a new collection
  Future<CollectionModel> createCollection(
    String orgId, {
    required String title,
    String? description,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.orgCollections(orgId),
      data: {
        'title': title,
        if (description != null) 'description': description,
      },
    );
    return CollectionModel.fromJson(response.data!);
  }

  // ============ Spaces ============

  /// List spaces in an organization
  Future<SpacesListResponse> listSpaces(
    String orgId, {
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.orgSpaces(orgId),
      queryParameters: {
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return SpacesListResponse.fromJson(response.data!);
  }

  /// Get space by ID
  Future<SpaceModel> getSpace(String spaceId) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.space(spaceId),
    );
    return SpaceModel.fromJson(response.data!);
  }

  /// Create a new space
  Future<SpaceModel> createSpace(
    String orgId, {
    required String title,
    String? description,
    SpaceVisibility? visibility,
    String? parentCollectionId,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.orgSpaces(orgId),
      data: {
        'title': title,
        if (description != null) 'description': description,
        if (visibility != null) 'visibility': visibility.name,
        if (parentCollectionId != null) 'parent': parentCollectionId,
      },
    );
    return SpaceModel.fromJson(response.data!);
  }

  /// Update a space
  Future<SpaceModel> updateSpace(
    String spaceId, {
    String? title,
    String? description,
    SpaceVisibility? visibility,
  }) async {
    final response = await _client.patch<Map<String, dynamic>>(
      ApiConstants.space(spaceId),
      data: {
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (visibility != null) 'visibility': visibility.name,
      },
    );
    return SpaceModel.fromJson(response.data!);
  }

  /// Delete a space (moves to trash)
  Future<void> deleteSpace(String spaceId) async {
    await _client.delete(ApiConstants.space(spaceId));
  }

  /// Restore a space from trash
  Future<SpaceModel> restoreSpace(String spaceId) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.restoreSpace(spaceId),
    );
    return SpaceModel.fromJson(response.data!);
  }

  // ============ Content / Pages ============

  /// Get space content (table of contents)
  Future<SpaceContentResponse> getSpaceContent(String spaceId) async {
    try {
      // Use dynamic type to avoid Dio's automatic type casting
      final response = await _client.get<dynamic>(
        ApiConstants.spaceContent(spaceId),
      );

      // Manually handle the response data
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return _parseSpaceContentResponse(data);
      } else if (data is Map) {
        return _parseSpaceContentResponse(Map<String, dynamic>.from(data));
      } else {
        throw FormatException('Unexpected response type: ${data.runtimeType}');
      }
    } catch (e, stackTrace) {
      throw Exception('getSpaceContent failed: $e\nStack: $stackTrace');
    }
  }

  /// Parse space content response with safe type handling
  SpaceContentResponse _parseSpaceContentResponse(Map<String, dynamic> json) {
    final pagesJson = json['pages'] as List<dynamic>? ?? [];
    final pages = pagesJson.map((e) {
      if (e is Map<String, dynamic>) {
        return _parseContentModel(e);
      }
      throw FormatException('Invalid page format: ${e.runtimeType}');
    }).toList();

    return SpaceContentResponse(pages: pages);
  }

  /// Parse ContentModel with safe type handling
  ContentModel _parseContentModel(Map<String, dynamic> json) {
    String? safeString(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      return null;
    }

    // Parse type
    ContentType type = ContentType.document;
    final typeValue = json['type'];
    if (typeValue is String) {
      type = ContentType.values.firstWhere(
        (e) => e.name == typeValue,
        orElse: () => ContentType.document,
      );
    }

    // Parse nested pages recursively
    List<ContentModel>? childPages;
    final pagesJson = json['pages'];
    if (pagesJson is List) {
      childPages = pagesJson.whereType<Map<String, dynamic>>().map(_parseContentModel).toList();
    }

    // Parse URLs
    ContentUrls? urls;
    final urlsJson = json['urls'];
    if (urlsJson is Map<String, dynamic>) {
      urls = ContentUrls(
        location: safeString(urlsJson['location']),
        app: safeString(urlsJson['app']),
      );
    }

    return ContentModel(
      id: json['id']?.toString() ?? '',
      title: safeString(json['title']) ?? 'Untitled',
      type: type,
      path: safeString(json['path']),
      slug: safeString(json['slug']),
      description: safeString(json['description']),
      createdAt: json['createdAt'] is String
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] is String
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      urls: urls,
      pages: childPages,
    );
  }

  /// Get page by path
  Future<DocumentContent> getPageByPath(String spaceId, String path) async {
    try {
      // Use dynamic type to avoid Dio's automatic type casting
      final response = await _client.get<dynamic>(
        ApiConstants.spaceContentByPath(spaceId, path),
        queryParameters: {'documentFormat': 'markdown'},
      );

      // Manually handle the response data
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return _parseDocumentContent(data);
      } else if (data is Map) {
        return _parseDocumentContent(Map<String, dynamic>.from(data));
      } else {
        throw FormatException('Unexpected response type: ${data.runtimeType}');
      }
    } catch (e, stackTrace) {
      throw Exception('getPageByPath failed: $e\nStack: $stackTrace');
    }
  }

  /// Get page by ID
  Future<DocumentContent> getPageById(String spaceId, String pageId) async {
    try {
      // Use dynamic type to avoid Dio's automatic type casting
      final response = await _client.get<dynamic>(
        ApiConstants.spaceContentById(spaceId, pageId),
        queryParameters: {'documentFormat': 'markdown'},
      );

      // Manually handle the response data
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return _parseDocumentContent(data);
      } else if (data is Map) {
        // Convert to proper type if needed
        return _parseDocumentContent(Map<String, dynamic>.from(data));
      } else {
        throw FormatException('Unexpected response type: ${data.runtimeType}');
      }
    } catch (e, stackTrace) {
      // Re-throw with more context for debugging
      throw Exception('getPageById failed: $e\nStack: $stackTrace');
    }
  }

  /// Parse document content handling different response formats
  DocumentContent _parseDocumentContent(Map<String, dynamic> json) {
    String? safeString(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      return null;
    }

    // Handle the document field
    final document = json['document'];
    String? markdownContent;

    if (document is String) {
      markdownContent = document;
    } else if (document is Map<String, dynamic>) {
      final markdown = document['markdown'];
      if (markdown is String) {
        markdownContent = markdown;
      } else if (document['nodes'] is List) {
        markdownContent = GitBookDocumentConverter.toMarkdown(document);
      }
    }

    ContentType? contentType;
    final typeValue = json['type'];
    if (typeValue is String) {
      contentType = ContentType.values.cast<ContentType?>().firstWhere(
            (e) => e?.name == typeValue,
            orElse: () => null,
          );
    }

    return DocumentContent(
      id: json['id']?.toString() ?? '',
      title: safeString(json['title']) ?? 'Untitled',
      type: contentType,
      path: safeString(json['path']),
      slug: safeString(json['slug']),
      description: safeString(json['description']),
      createdAt: json['createdAt'] is String
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] is String
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      document: markdownContent != null
          ? DocumentBody(markdown: markdownContent)
          : null,
    );
  }

  /// Create a new page
  Future<ContentModel> createPage(
    String spaceId, {
    required String title,
    String? slug,
    String? description,
    ContentType? type,
    String? parentId,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.spaceContent(spaceId),
      data: {
        'title': title,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (type != null) 'type': type.name,
        if (parentId != null) 'parent': parentId,
      },
    );
    return _parseContentModel(response.data!);
  }

  /// Update a page
  Future<DocumentContent> updatePage(
    String spaceId,
    String pageId, {
    String? title,
    String? slug,
    String? description,
    Map<String, dynamic>? document,
  }) async {
    final response = await _client.patch<Map<String, dynamic>>(
      ApiConstants.spaceContentById(spaceId, pageId),
      data: {
        if (title != null) 'title': title,
        if (slug != null) 'slug': slug,
        if (description != null) 'description': description,
        if (document != null) 'document': document,
      },
    );
    return _parseDocumentContent(response.data!);
  }

  /// Delete a page
  Future<void> deletePage(String spaceId, String pageId) async {
    await _client.delete(ApiConstants.spaceContentById(spaceId, pageId));
  }

  // ============ Change Requests ============

  /// List change requests for a space
  Future<ChangeRequestsListResponse> listChangeRequests(
    String spaceId, {
    ChangeRequestStatus? status,
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.changeRequests(spaceId),
      queryParameters: {
        if (status != null) 'status': status.name,
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return ChangeRequestsListResponse.fromJson(response.data!);
  }

  /// Get change request by ID
  Future<ChangeRequestModel> getChangeRequest(
    String spaceId,
    String changeRequestId,
  ) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.changeRequest(spaceId, changeRequestId),
    );
    return ChangeRequestModel.fromJson(response.data!);
  }

  /// Create a new change request
  Future<ChangeRequestModel> createChangeRequest(
    String spaceId, {
    String? subject,
  }) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.changeRequests(spaceId),
      data: {
        if (subject != null) 'subject': subject,
      },
    );
    return ChangeRequestModel.fromJson(response.data!);
  }

  /// Merge a change request
  Future<ChangeRequestModel> mergeChangeRequest(
    String spaceId,
    String changeRequestId,
  ) async {
    final response = await _client.post<Map<String, dynamic>>(
      ApiConstants.mergeChangeRequest(spaceId, changeRequestId),
    );
    return ChangeRequestModel.fromJson(response.data!);
  }

  // ============ Search ============

  /// Search within an organization
  Future<SearchResponse> searchOrganization(
    String orgId, {
    required String query,
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.orgSearch(orgId),
      queryParameters: {
        'query': query,
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return SearchResponse.fromJson(response.data!);
  }

  /// Search within a space
  Future<SearchResponse> searchSpace(
    String spaceId, {
    required String query,
    int? limit,
    String? page,
  }) async {
    final response = await _client.get<Map<String, dynamic>>(
      ApiConstants.spaceSearch(spaceId),
      queryParameters: {
        'query': query,
        if (limit != null) 'limit': limit,
        if (page != null) 'page': page,
      },
    );
    return SearchResponse.fromJson(response.data!);
  }
}
