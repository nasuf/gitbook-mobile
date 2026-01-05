/// GitBook API constants
class ApiConstants {
  ApiConstants._();

  /// Base URL for GitBook API
  static const String baseUrl = 'https://api.gitbook.com/v1';

  /// Connection timeout in milliseconds
  static const int connectTimeout = 30000;

  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;

  /// Send timeout in milliseconds
  static const int sendTimeout = 30000;

  // Authentication endpoints
  static const String oauth = '/oauth';
  static const String token = '/oauth/token';

  // Organizations endpoints
  static const String orgs = '/orgs';
  static String org(String orgId) => '/orgs/$orgId';
  static String orgMembers(String orgId) => '/orgs/$orgId/members';
  static String orgSpaces(String orgId) => '/orgs/$orgId/spaces';

  // Collections endpoints
  static String orgCollections(String orgId) => '/orgs/$orgId/collections';
  static String collection(String collectionId) => '/collections/$collectionId';
  static String collectionSpaces(String collectionId) =>
      '/collections/$collectionId/spaces';

  // Spaces endpoints
  static const String spaces = '/spaces';
  static String space(String spaceId) => '/spaces/$spaceId';
  static String restoreSpace(String spaceId) => '/spaces/$spaceId/restore';
  static String spaceContent(String spaceId) => '/spaces/$spaceId/content';
  static String spaceContentByPath(String spaceId, String path) =>
      '/spaces/$spaceId/content/path/$path';
  static String spaceContentById(String spaceId, String pageId) =>
      '/spaces/$spaceId/content/$pageId';

  // Change Requests endpoints
  static String changeRequests(String spaceId) =>
      '/spaces/$spaceId/change-requests';
  static String changeRequest(String spaceId, String crId) =>
      '/spaces/$spaceId/change-requests/$crId';
  static String mergeChangeRequest(String spaceId, String crId) =>
      '/spaces/$spaceId/change-requests/$crId/merge';

  // Search endpoints
  static String orgSearch(String orgId) => '/orgs/$orgId/search';
  static String spaceSearch(String spaceId) => '/spaces/$spaceId/search';

  // User endpoints
  static const String user = '/user';
}
