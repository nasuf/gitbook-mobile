import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/content_entity.dart';
import '../../domain/repositories/content_repository.dart';
import '../../data/repositories/content_repository_impl.dart';
import 'core_providers.dart';

/// Provider for content repository
final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  final apiClient = ref.watch(gitBookApiClientProvider);
  return ContentRepositoryImpl(apiClient: apiClient);
});

/// State for table of contents
class TableOfContentsState {
  final List<ContentPage> pages;
  final bool isLoading;
  final String? error;
  final String searchQuery;

  const TableOfContentsState({
    this.pages = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
  });

  TableOfContentsState copyWith({
    List<ContentPage>? pages,
    bool? isLoading,
    String? error,
    String? searchQuery,
  }) {
    return TableOfContentsState(
      pages: pages ?? this.pages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// Get filtered pages based on search query
  List<ContentPage> get filteredPages {
    if (searchQuery.isEmpty) return pages;
    final results = <ContentPage>[];
    _filterPages(pages, searchQuery.toLowerCase(), results);
    return results;
  }

  void _filterPages(List<ContentPage> pages, String query, List<ContentPage> results) {
    for (final page in pages) {
      if (page.title.toLowerCase().contains(query) ||
          (page.description?.toLowerCase().contains(query) ?? false)) {
        results.add(page);
      }
      if (page.hasChildren) {
        _filterPages(page.children, query, results);
      }
    }
  }

  /// Flatten all pages (for search results display)
  List<ContentPage> get allPagesFlat {
    final result = <ContentPage>[];
    _flattenPages(pages, result);
    return result;
  }

  void _flattenPages(List<ContentPage> pages, List<ContentPage> result) {
    for (final page in pages) {
      result.add(page);
      if (page.hasChildren) {
        _flattenPages(page.children, result);
      }
    }
  }
}

/// Notifier for table of contents
class TableOfContentsNotifier extends StateNotifier<TableOfContentsState> {
  final ContentRepository _repository;
  final String _spaceId;

  TableOfContentsNotifier(this._repository, this._spaceId)
      : super(const TableOfContentsState()) {
    loadContent();
  }

  /// Load table of contents
  Future<void> loadContent() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final pages = await _repository.getTableOfContents(_spaceId);
      state = state.copyWith(pages: pages, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh content
  Future<void> refresh() => loadContent();

  /// Set search query
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Clear search
  void clearSearch() {
    state = state.copyWith(searchQuery: '');
  }
}

/// Provider for table of contents (per space)
final tableOfContentsProvider = StateNotifierProvider.family<
    TableOfContentsNotifier, TableOfContentsState, String>((ref, spaceId) {
  final repository = ref.watch(contentRepositoryProvider);
  return TableOfContentsNotifier(repository, spaceId);
});

/// State for page content
class PageContentState {
  final PageContent? content;
  final List<BreadcrumbItem> breadcrumb;
  final bool isLoading;
  final String? error;

  const PageContentState({
    this.content,
    this.breadcrumb = const [],
    this.isLoading = false,
    this.error,
  });

  PageContentState copyWith({
    PageContent? content,
    List<BreadcrumbItem>? breadcrumb,
    bool? isLoading,
    String? error,
  }) {
    return PageContentState(
      content: content ?? this.content,
      breadcrumb: breadcrumb ?? this.breadcrumb,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Key for page content provider (spaceId + pageId)
class PageContentKey {
  final String spaceId;
  final String pageId;

  const PageContentKey(this.spaceId, this.pageId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageContentKey &&
          runtimeType == other.runtimeType &&
          spaceId == other.spaceId &&
          pageId == other.pageId;

  @override
  int get hashCode => spaceId.hashCode ^ pageId.hashCode;
}

/// Notifier for page content
class PageContentNotifier extends StateNotifier<PageContentState> {
  final ContentRepository _repository;
  final String _spaceId;
  final String _pageId;

  PageContentNotifier(this._repository, this._spaceId, this._pageId)
      : super(const PageContentState()) {
    loadContent();
  }

  /// Load page content
  Future<void> loadContent() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final content = await _repository.getPageById(_spaceId, _pageId);
      final breadcrumb = await _repository.getBreadcrumb(_spaceId, _pageId);
      state = state.copyWith(
        content: content,
        breadcrumb: breadcrumb,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh content
  Future<void> refresh() => loadContent();
}

/// Provider for page content
final pageContentProvider = StateNotifierProvider.family<PageContentNotifier,
    PageContentState, PageContentKey>((ref, key) {
  final repository = ref.watch(contentRepositoryProvider);
  return PageContentNotifier(repository, key.spaceId, key.pageId);
});
