// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResultImpl _$$SearchResultImplFromJson(Map<String, dynamic> json) =>
    _$SearchResultImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: $enumDecodeNullable(_$SearchResultTypeEnumMap, json['type']),
      path: json['path'] as String?,
      spaceId: json['spaceId'] as String?,
      spaceTitle: json['spaceTitle'] as String?,
      highlight: json['highlight'] as String?,
      urls: json['urls'] == null
          ? null
          : SearchResultUrls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SearchResultImplToJson(_$SearchResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$SearchResultTypeEnumMap[instance.type],
      'path': instance.path,
      'spaceId': instance.spaceId,
      'spaceTitle': instance.spaceTitle,
      'highlight': instance.highlight,
      'urls': instance.urls,
    };

const _$SearchResultTypeEnumMap = {
  SearchResultType.page: 'page',
  SearchResultType.space: 'space',
};

_$SearchResultUrlsImpl _$$SearchResultUrlsImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchResultUrlsImpl(
      location: json['location'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$$SearchResultUrlsImplToJson(
        _$SearchResultUrlsImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'app': instance.app,
    };

_$SearchResponseImpl _$$SearchResponseImplFromJson(Map<String, dynamic> json) =>
    _$SearchResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] == null
          ? null
          : PageInfo.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SearchResponseImplToJson(
        _$SearchResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };

_$SearchRequestImpl _$$SearchRequestImplFromJson(Map<String, dynamic> json) =>
    _$SearchRequestImpl(
      query: json['query'] as String,
      limit: (json['limit'] as num?)?.toInt(),
      page: json['page'] as String?,
    );

Map<String, dynamic> _$$SearchRequestImplToJson(_$SearchRequestImpl instance) =>
    <String, dynamic>{
      'query': instance.query,
      'limit': instance.limit,
      'page': instance.page,
    };
