// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrganizationModelImpl _$$OrganizationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      urls: json['urls'] == null
          ? null
          : OrganizationUrls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrganizationModelImplToJson(
        _$OrganizationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'urls': instance.urls,
    };

_$OrganizationUrlsImpl _$$OrganizationUrlsImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationUrlsImpl(
      location: json['location'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$$OrganizationUrlsImplToJson(
        _$OrganizationUrlsImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'app': instance.app,
    };

_$OrganizationsListResponseImpl _$$OrganizationsListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationsListResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => OrganizationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] == null
          ? null
          : PageInfo.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrganizationsListResponseImplToJson(
        _$OrganizationsListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };

_$OrganizationMemberImpl _$$OrganizationMemberImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationMemberImpl(
      id: json['id'] as String,
      role: json['role'] as String,
      user: json['user'] == null
          ? null
          : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$OrganizationMemberImplToJson(
        _$OrganizationMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'user': instance.user,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$UserInfoImpl _$$UserInfoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$$UserInfoImplToJson(_$UserInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
    };

_$OrganizationMembersResponseImpl _$$OrganizationMembersResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$OrganizationMembersResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => OrganizationMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] == null
          ? null
          : PageInfo.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrganizationMembersResponseImplToJson(
        _$OrganizationMembersResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };
