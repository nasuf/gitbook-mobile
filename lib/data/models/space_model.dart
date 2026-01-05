import 'package:freezed_annotation/freezed_annotation.dart';

import 'common_model.dart';

part 'space_model.freezed.dart';
part 'space_model.g.dart';

/// Visibility enum for spaces
enum SpaceVisibility {
  @JsonValue('public')
  public,
  @JsonValue('unlisted')
  unlisted,
  @JsonValue('share-link')
  shareLink,
  @JsonValue('visitor-auth')
  visitorAuth,
  @JsonValue('in-collection')
  inCollection,
  @JsonValue('private')
  private,
}

/// Space model representing a GitBook space
@freezed
class SpaceModel with _$SpaceModel {
  const factory SpaceModel({
    required String id,
    required String title,
    String? description,
    String? emoji,
    SpaceVisibility? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    SpaceUrls? urls,
    String? organizationId,
    /// ID of the parent collection (if the space belongs to a collection)
    String? parent,
  }) = _SpaceModel;

  factory SpaceModel.fromJson(Map<String, dynamic> json) =>
      _$SpaceModelFromJson(json);
}

/// Space URLs
@freezed
class SpaceUrls with _$SpaceUrls {
  const factory SpaceUrls({
    String? location,
    String? app,
    String? published,
  }) = _SpaceUrls;

  factory SpaceUrls.fromJson(Map<String, dynamic> json) =>
      _$SpaceUrlsFromJson(json);
}

/// Response for listing spaces
@freezed
class SpacesListResponse with _$SpacesListResponse {
  const factory SpacesListResponse({
    required List<SpaceModel> items,
    PageInfo? next,
  }) = _SpacesListResponse;

  factory SpacesListResponse.fromJson(Map<String, dynamic> json) =>
      _$SpacesListResponseFromJson(json);
}

/// Request to create a new space
@freezed
class CreateSpaceRequest with _$CreateSpaceRequest {
  const factory CreateSpaceRequest({
    required String title,
    String? description,
    SpaceVisibility? visibility,
  }) = _CreateSpaceRequest;

  factory CreateSpaceRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSpaceRequestFromJson(json);
}

/// Request to update a space
@freezed
class UpdateSpaceRequest with _$UpdateSpaceRequest {
  const factory UpdateSpaceRequest({
    String? title,
    String? description,
    SpaceVisibility? visibility,
  }) = _UpdateSpaceRequest;

  factory UpdateSpaceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateSpaceRequestFromJson(json);
}
