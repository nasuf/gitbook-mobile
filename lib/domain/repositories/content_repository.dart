import '../entities/content_entity.dart';

/// Repository interface for content/page operations
abstract class ContentRepository {
  /// Get table of contents for a space
  Future<List<ContentPage>> getTableOfContents(String spaceId);

  /// Get page content by path
  Future<PageContent> getPageByPath(String spaceId, String path);

  /// Get page content by ID
  Future<PageContent> getPageById(String spaceId, String pageId);

  /// Search pages within a space
  Future<List<ContentPage>> searchPages(String spaceId, String query);

  /// Create a new page
  Future<ContentPage> createPage(
    String spaceId, {
    required String title,
    String? slug,
    String? description,
    PageType? type,
    String? parentId,
  });

  /// Update a page
  Future<PageContent> updatePage(
    String spaceId,
    String pageId, {
    String? title,
    String? description,
    Map<String, dynamic>? document,
  });

  /// Delete a page
  Future<void> deletePage(String spaceId, String pageId);

  /// Get breadcrumb trail for a page
  Future<List<BreadcrumbItem>> getBreadcrumb(String spaceId, String pageId);

  /// Get child pages for a specific page (from table of contents)
  Future<List<ContentPage>> getChildPages(String spaceId, String pageId);
}
