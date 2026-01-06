import '../../domain/entities/content_entity.dart';
import '../../domain/repositories/content_repository.dart';
import '../datasources/remote/gitbook_api_client.dart';
import '../models/content_model.dart';

/// Implementation of ContentRepository
class ContentRepositoryImpl implements ContentRepository {
  final GitBookApiClient _apiClient;

  ContentRepositoryImpl({
    required GitBookApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<List<ContentPage>> getTableOfContents(String spaceId) async {
    final response = await _apiClient.getSpaceContent(spaceId);
    return response.pages.map(_mapToPage).toList();
  }

  @override
  Future<PageContent> getPageByPath(String spaceId, String path) async {
    final content = await _apiClient.getPageByPath(spaceId, path);
    return _mapToPageContent(content);
  }

  @override
  Future<PageContent> getPageById(String spaceId, String pageId) async {
    final content = await _apiClient.getPageById(spaceId, pageId);
    return _mapToPageContent(content);
  }

  @override
  Future<List<ContentPage>> searchPages(String spaceId, String query) async {
    // Get all pages and filter locally for now
    // TODO: Use search API when available for pages
    final toc = await getTableOfContents(spaceId);
    final results = <ContentPage>[];
    _searchInPages(toc, query.toLowerCase(), results);
    return results;
  }

  void _searchInPages(List<ContentPage> pages, String query, List<ContentPage> results) {
    for (final page in pages) {
      if (page.title.toLowerCase().contains(query) ||
          (page.description?.toLowerCase().contains(query) ?? false)) {
        results.add(page);
      }
      if (page.hasChildren) {
        _searchInPages(page.children, query, results);
      }
    }
  }

  @override
  Future<ContentPage> createPage(
    String spaceId, {
    required String title,
    String? slug,
    String? description,
    PageType? type,
    String? parentId,
  }) async {
    final page = await _apiClient.createPage(
      spaceId,
      title: title,
      slug: slug,
      description: description,
      type: type != null ? _mapToModelType(type) : null,
      parentId: parentId,
    );
    return _mapToPage(page);
  }

  @override
  Future<PageContent> updatePage(
    String spaceId,
    String pageId, {
    String? title,
    String? description,
    Map<String, dynamic>? document,
  }) async {
    final content = await _apiClient.updatePage(
      spaceId,
      pageId,
      title: title,
      description: description,
      document: document,
    );
    return _mapToPageContent(content);
  }

  @override
  Future<void> deletePage(String spaceId, String pageId) async {
    await _apiClient.deletePage(spaceId, pageId);
  }

  @override
  Future<List<BreadcrumbItem>> getBreadcrumb(String spaceId, String pageId) async {
    // Build breadcrumb by traversing the table of contents
    final toc = await getTableOfContents(spaceId);
    final breadcrumb = <BreadcrumbItem>[];
    _findBreadcrumb(toc, pageId, breadcrumb);
    return breadcrumb;
  }

  bool _findBreadcrumb(List<ContentPage> pages, String targetId, List<BreadcrumbItem> breadcrumb) {
    for (final page in pages) {
      if (page.id == targetId) {
        breadcrumb.add(BreadcrumbItem(
          id: page.id,
          title: page.title,
          path: page.path,
        ));
        return true;
      }

      if (page.hasChildren) {
        // Temporarily add this page to breadcrumb
        final item = BreadcrumbItem(
          id: page.id,
          title: page.title,
          path: page.path,
        );
        breadcrumb.add(item);

        if (_findBreadcrumb(page.children, targetId, breadcrumb)) {
          return true;
        }

        // Target not found in this branch, remove from breadcrumb
        breadcrumb.removeLast();
      }
    }
    return false;
  }

  ContentPage _mapToPage(ContentModel model) {
    return ContentPage(
      id: model.id,
      title: model.title,
      type: _mapType(model.type),
      path: model.path,
      slug: model.slug,
      description: model.description,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      appUrl: model.urls?.app,
      children: model.pages?.map(_mapToPage).toList() ?? [],
    );
  }

  PageContent _mapToPageContent(DocumentContent content) {
    return PageContent(
      id: content.id,
      title: content.title,
      type: content.type != null ? _mapType(content.type!) : null,
      path: content.path,
      slug: content.slug,
      description: content.description,
      createdAt: content.createdAt,
      updatedAt: content.updatedAt,
      markdown: content.document?.markdown,
      documentNodes: content.document?.nodes,
    );
  }

  PageType _mapType(ContentType type) {
    return switch (type) {
      ContentType.document => PageType.document,
      ContentType.group => PageType.group,
      ContentType.link => PageType.link,
    };
  }

  ContentType _mapToModelType(PageType type) {
    return switch (type) {
      PageType.document => ContentType.document,
      PageType.group => ContentType.group,
      PageType.link => ContentType.link,
    };
  }
}
