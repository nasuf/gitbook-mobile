// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpaceModelImpl _$$SpaceModelImplFromJson(Map<String, dynamic> json) =>
    _$SpaceModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      visibility:
          $enumDecodeNullable(_$SpaceVisibilityEnumMap, json['visibility']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      urls: json['urls'] == null
          ? null
          : SpaceUrls.fromJson(json['urls'] as Map<String, dynamic>),
      organizationId: json['organizationId'] as String?,
    );

Map<String, dynamic> _$$SpaceModelImplToJson(_$SpaceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'visibility': _$SpaceVisibilityEnumMap[instance.visibility],
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'urls': instance.urls,
      'organizationId': instance.organizationId,
    };

const _$SpaceVisibilityEnumMap = {
  SpaceVisibility.public: 'public',
  SpaceVisibility.unlisted: 'unlisted',
  SpaceVisibility.shareLink: 'share-link',
  SpaceVisibility.visitorAuth: 'visitor-auth',
  SpaceVisibility.inCollection: 'in-collection',
  SpaceVisibility.private: 'private',
};

_$SpaceUrlsImpl _$$SpaceUrlsImplFromJson(Map<String, dynamic> json) =>
    _$SpaceUrlsImpl(
      location: json['location'] as String?,
      app: json['app'] as String?,
      published: json['published'] as String?,
    );

Map<String, dynamic> _$$SpaceUrlsImplToJson(_$SpaceUrlsImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'app': instance.app,
      'published': instance.published,
    };

_$SpacesListResponseImpl _$$SpacesListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SpacesListResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => SpaceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] == null
          ? null
          : PageInfo.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SpacesListResponseImplToJson(
        _$SpacesListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };

_$CreateSpaceRequestImpl _$$CreateSpaceRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateSpaceRequestImpl(
      title: json['title'] as String,
      description: json['description'] as String?,
      visibility:
          $enumDecodeNullable(_$SpaceVisibilityEnumMap, json['visibility']),
    );

Map<String, dynamic> _$$CreateSpaceRequestImplToJson(
        _$CreateSpaceRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'visibility': _$SpaceVisibilityEnumMap[instance.visibility],
    };

_$UpdateSpaceRequestImpl _$$UpdateSpaceRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateSpaceRequestImpl(
      title: json['title'] as String?,
      description: json['description'] as String?,
      visibility:
          $enumDecodeNullable(_$SpaceVisibilityEnumMap, json['visibility']),
    );

Map<String, dynamic> _$$UpdateSpaceRequestImplToJson(
        _$UpdateSpaceRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'visibility': _$SpaceVisibilityEnumMap[instance.visibility],
    };
