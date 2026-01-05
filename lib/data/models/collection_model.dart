import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_model.freezed.dart';
part 'collection_model.g.dart';

/// Collection model representing a GitBook collection
/// A collection is a group that spaces can belong to
@freezed
class CollectionModel with _$CollectionModel {
  const factory CollectionModel({
    required String id,
    required String title,
    String? description,
    String? emoji,
    DateTime? createdAt,
    DateTime? updatedAt,
    CollectionUrls? urls,
    String? organizationId,
  }) = _CollectionModel;

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);
}

/// Collection URLs
@freezed
class CollectionUrls with _$CollectionUrls {
  const factory CollectionUrls({
    String? location,
    String? app,
  }) = _CollectionUrls;

  factory CollectionUrls.fromJson(Map<String, dynamic> json) =>
      _$CollectionUrlsFromJson(json);
}

/// Response for listing collections
@freezed
class CollectionsListResponse with _$CollectionsListResponse {
  const factory CollectionsListResponse({
    required List<CollectionModel> items,
    String? next,
  }) = _CollectionsListResponse;

  factory CollectionsListResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionsListResponseFromJson(json);
}
