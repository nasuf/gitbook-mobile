import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_entity.freezed.dart';

/// Content/Page type
enum PageType {
  document,
  group,
  link,
}

/// Content page entity for domain layer
@freezed
class ContentPage with _$ContentPage {
  const factory ContentPage({
    required String id,
    required String title,
    required PageType type,
    String? path,
    String? slug,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? appUrl,
    /// Child pages for groups/nested structure
    @Default([]) List<ContentPage> children,
  }) = _ContentPage;

  const ContentPage._();

  /// Check if this is a document page
  bool get isDocument => type == PageType.document;

  /// Check if this is a group (folder)
  bool get isGroup => type == PageType.group;

  /// Check if this is a link
  bool get isLink => type == PageType.link;

  /// Check if page has children
  bool get hasChildren => children.isNotEmpty;
}

/// Document content with body
@freezed
class PageContent with _$PageContent {
  const factory PageContent({
    required String id,
    required String title,
    PageType? type,
    String? path,
    String? slug,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    /// Markdown content
    String? markdown,
    /// Raw document nodes (GitBook format)
    Map<String, dynamic>? documentNodes,
  }) = _PageContent;

  const PageContent._();

  /// Check if content has markdown
  bool get hasMarkdown => markdown != null && markdown!.isNotEmpty;
}

/// Breadcrumb item for navigation
@freezed
class BreadcrumbItem with _$BreadcrumbItem {
  const factory BreadcrumbItem({
    required String id,
    required String title,
    String? path,
  }) = _BreadcrumbItem;
}
