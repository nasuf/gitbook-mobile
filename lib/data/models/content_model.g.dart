// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentModelImpl _$$ContentModelImplFromJson(Map<String, dynamic> json) =>
    _$ContentModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: $enumDecode(_$ContentTypeEnumMap, json['type']),
      path: json['path'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      urls: json['urls'] == null
          ? null
          : ContentUrls.fromJson(json['urls'] as Map<String, dynamic>),
      pages: (json['pages'] as List<dynamic>?)
          ?.map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ContentModelImplToJson(_$ContentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$ContentTypeEnumMap[instance.type]!,
      'path': instance.path,
      'slug': instance.slug,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'urls': instance.urls,
      'pages': instance.pages,
    };

const _$ContentTypeEnumMap = {
  ContentType.document: 'document',
  ContentType.group: 'group',
  ContentType.link: 'link',
};

_$ContentUrlsImpl _$$ContentUrlsImplFromJson(Map<String, dynamic> json) =>
    _$ContentUrlsImpl(
      location: json['location'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$$ContentUrlsImplToJson(_$ContentUrlsImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'app': instance.app,
    };

_$SpaceContentResponseImpl _$$SpaceContentResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SpaceContentResponseImpl(
      pages: (json['pages'] as List<dynamic>)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SpaceContentResponseImplToJson(
        _$SpaceContentResponseImpl instance) =>
    <String, dynamic>{
      'pages': instance.pages,
    };

_$DocumentContentImpl _$$DocumentContentImplFromJson(
        Map<String, dynamic> json) =>
    _$DocumentContentImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: $enumDecodeNullable(_$ContentTypeEnumMap, json['type']),
      path: json['path'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      document: json['document'] == null
          ? null
          : DocumentBody.fromJson(json['document'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DocumentContentImplToJson(
        _$DocumentContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$ContentTypeEnumMap[instance.type],
      'path': instance.path,
      'slug': instance.slug,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'document': instance.document,
    };

_$DocumentBodyImpl _$$DocumentBodyImplFromJson(Map<String, dynamic> json) =>
    _$DocumentBodyImpl(
      nodes: json['nodes'] as Map<String, dynamic>?,
      markdown: json['markdown'] as String?,
    );

Map<String, dynamic> _$$DocumentBodyImplToJson(_$DocumentBodyImpl instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
      'markdown': instance.markdown,
    };

_$CreatePageRequestImpl _$$CreatePageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePageRequestImpl(
      title: json['title'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      type: $enumDecodeNullable(_$ContentTypeEnumMap, json['type']),
      parent: json['parent'] as String?,
    );

Map<String, dynamic> _$$CreatePageRequestImplToJson(
        _$CreatePageRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'type': _$ContentTypeEnumMap[instance.type],
      'parent': instance.parent,
    };

_$UpdatePageRequestImpl _$$UpdatePageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdatePageRequestImpl(
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      document: json['document'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UpdatePageRequestImplToJson(
        _$UpdatePageRequestImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'document': instance.document,
    };
