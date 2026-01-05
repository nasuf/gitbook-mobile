// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionModelImpl _$$CollectionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CollectionModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      urls: json['urls'] == null
          ? null
          : CollectionUrls.fromJson(json['urls'] as Map<String, dynamic>),
      organizationId: json['organizationId'] as String?,
    );

Map<String, dynamic> _$$CollectionModelImplToJson(
        _$CollectionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'emoji': instance.emoji,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'urls': instance.urls,
      'organizationId': instance.organizationId,
    };

_$CollectionUrlsImpl _$$CollectionUrlsImplFromJson(Map<String, dynamic> json) =>
    _$CollectionUrlsImpl(
      location: json['location'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$$CollectionUrlsImplToJson(
        _$CollectionUrlsImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'app': instance.app,
    };

_$CollectionsListResponseImpl _$$CollectionsListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CollectionsListResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] as String?,
    );

Map<String, dynamic> _$$CollectionsListResponseImplToJson(
        _$CollectionsListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };
