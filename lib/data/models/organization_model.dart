import 'package:freezed_annotation/freezed_annotation.dart';

import 'common_model.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

/// Organization model representing a GitBook organization
@freezed
class OrganizationModel with _$OrganizationModel {
  const factory OrganizationModel({
    required String id,
    required String title,
    DateTime? createdAt,
    DateTime? updatedAt,
    OrganizationUrls? urls,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);
}

/// Organization URLs
@freezed
class OrganizationUrls with _$OrganizationUrls {
  const factory OrganizationUrls({
    String? location,
    String? app,
  }) = _OrganizationUrls;

  factory OrganizationUrls.fromJson(Map<String, dynamic> json) =>
      _$OrganizationUrlsFromJson(json);
}

/// Response for listing organizations
@freezed
class OrganizationsListResponse with _$OrganizationsListResponse {
  const factory OrganizationsListResponse({
    required List<OrganizationModel> items,
    PageInfo? next,
  }) = _OrganizationsListResponse;

  factory OrganizationsListResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationsListResponseFromJson(json);
}

/// Organization member
@freezed
class OrganizationMember with _$OrganizationMember {
  const factory OrganizationMember({
    required String id,
    required String role,
    UserInfo? user,
    DateTime? createdAt,
  }) = _OrganizationMember;

  factory OrganizationMember.fromJson(Map<String, dynamic> json) =>
      _$OrganizationMemberFromJson(json);
}

/// Basic user info in member context
@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String id,
    String? displayName,
    String? email,
    String? photoUrl,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

/// Response for listing organization members
@freezed
class OrganizationMembersResponse with _$OrganizationMembersResponse {
  const factory OrganizationMembersResponse({
    required List<OrganizationMember> items,
    PageInfo? next,
  }) = _OrganizationMembersResponse;

  factory OrganizationMembersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrganizationMembersResponseFromJson(json);
}
