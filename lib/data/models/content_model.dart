import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_model.freezed.dart';
part 'content_model.g.dart';

/// Content type enum
enum ContentType {
  @JsonValue('document')
  document,
  @JsonValue('group')
  group,
  @JsonValue('link')
  link,
}

/// Page/Content model representing content in a space
@freezed
class ContentModel with _$ContentModel {
  const factory ContentModel({
    required String id,
    required String title,
    required ContentType type,
    String? path,
    String? slug,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    ContentUrls? urls,
    List<ContentModel>? pages,
  }) = _ContentModel;

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);
}

/// Content URLs
@freezed
class ContentUrls with _$ContentUrls {
  const factory ContentUrls({
    String? location,
    String? app,
  }) = _ContentUrls;

  factory ContentUrls.fromJson(Map<String, dynamic> json) =>
      _$ContentUrlsFromJson(json);
}

/// Response for space content (table of contents)
@freezed
class SpaceContentResponse with _$SpaceContentResponse {
  const factory SpaceContentResponse({
    required List<ContentModel> pages,
  }) = _SpaceContentResponse;

  factory SpaceContentResponse.fromJson(Map<String, dynamic> json) =>
      _$SpaceContentResponseFromJson(json);
}

/// Document content with markdown
@freezed
class DocumentContent with _$DocumentContent {
  const factory DocumentContent({
    required String id,
    required String title,
    ContentType? type,
    String? path,
    String? slug,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DocumentBody? document,
  }) = _DocumentContent;

  factory DocumentContent.fromJson(Map<String, dynamic> json) =>
      _$DocumentContentFromJson(json);
}

/// Document body containing the actual content
@freezed
class DocumentBody with _$DocumentBody {
  const factory DocumentBody({
    /// The document content in GitBook's JSON format
    Map<String, dynamic>? nodes,
    /// Markdown representation (if available)
    String? markdown,
  }) = _DocumentBody;

  factory DocumentBody.fromJson(Map<String, dynamic> json) =>
      _$DocumentBodyFromJson(json);
}

/// Request to create a new page
@freezed
class CreatePageRequest with _$CreatePageRequest {
  const factory CreatePageRequest({
    required String title,
    String? slug,
    String? description,
    ContentType? type,
    /// Parent page ID for nested pages
    String? parent,
  }) = _CreatePageRequest;

  factory CreatePageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePageRequestFromJson(json);
}

/// Request to update a page
@freezed
class UpdatePageRequest with _$UpdatePageRequest {
  const factory UpdatePageRequest({
    String? title,
    String? slug,
    String? description,
    /// Document content to update
    Map<String, dynamic>? document,
  }) = _UpdatePageRequest;

  factory UpdatePageRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePageRequestFromJson(json);
}
