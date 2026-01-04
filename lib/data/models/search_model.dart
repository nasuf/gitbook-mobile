import 'package:freezed_annotation/freezed_annotation.dart';

import 'common_model.dart';

part 'search_model.freezed.dart';
part 'search_model.g.dart';

/// Search result type
enum SearchResultType {
  @JsonValue('page')
  page,
  @JsonValue('space')
  space,
}

/// Search result item
@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String id,
    required String title,
    SearchResultType? type,
    String? path,
    String? spaceId,
    String? spaceTitle,
    /// Highlighted snippet from the content
    String? highlight,
    SearchResultUrls? urls,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

/// Search result URLs
@freezed
class SearchResultUrls with _$SearchResultUrls {
  const factory SearchResultUrls({
    String? location,
    String? app,
  }) = _SearchResultUrls;

  factory SearchResultUrls.fromJson(Map<String, dynamic> json) =>
      _$SearchResultUrlsFromJson(json);
}

/// Search response
@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required List<SearchResult> items,
    PageInfo? next,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

/// Search request parameters
@freezed
class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    required String query,
    int? limit,
    String? page,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);
}
