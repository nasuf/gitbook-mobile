import 'package:freezed_annotation/freezed_annotation.dart';

import 'common_model.dart';

part 'change_request_model.freezed.dart';
part 'change_request_model.g.dart';

/// Change request status
enum ChangeRequestStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('open')
  open,
  @JsonValue('merged')
  merged,
  @JsonValue('closed')
  closed,
}

/// Change request model
@freezed
class ChangeRequestModel with _$ChangeRequestModel {
  const factory ChangeRequestModel({
    required String id,
    required int number,
    String? subject,
    ChangeRequestStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? mergedAt,
    DateTime? closedAt,
    ChangeRequestAuthor? createdBy,
    ChangeRequestUrls? urls,
  }) = _ChangeRequestModel;

  factory ChangeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestModelFromJson(json);
}

/// Change request author
@freezed
class ChangeRequestAuthor with _$ChangeRequestAuthor {
  const factory ChangeRequestAuthor({
    required String id,
    String? displayName,
    String? email,
    String? photoUrl,
  }) = _ChangeRequestAuthor;

  factory ChangeRequestAuthor.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestAuthorFromJson(json);
}

/// Change request URLs
@freezed
class ChangeRequestUrls with _$ChangeRequestUrls {
  const factory ChangeRequestUrls({
    String? location,
    String? app,
  }) = _ChangeRequestUrls;

  factory ChangeRequestUrls.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestUrlsFromJson(json);
}

/// Response for listing change requests
@freezed
class ChangeRequestsListResponse with _$ChangeRequestsListResponse {
  const factory ChangeRequestsListResponse({
    required List<ChangeRequestModel> items,
    PageInfo? next,
  }) = _ChangeRequestsListResponse;

  factory ChangeRequestsListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestsListResponseFromJson(json);
}

/// Request to create a change request
@freezed
class CreateChangeRequestRequest with _$CreateChangeRequestRequest {
  const factory CreateChangeRequestRequest({
    String? subject,
  }) = _CreateChangeRequestRequest;

  factory CreateChangeRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChangeRequestRequestFromJson(json);
}

/// Change request comment
@freezed
class ChangeRequestComment with _$ChangeRequestComment {
  const factory ChangeRequestComment({
    required String id,
    required String body,
    DateTime? createdAt,
    DateTime? updatedAt,
    ChangeRequestAuthor? author,
  }) = _ChangeRequestComment;

  factory ChangeRequestComment.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestCommentFromJson(json);
}
