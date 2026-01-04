// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangeRequestModelImpl _$$ChangeRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeRequestModelImpl(
      id: json['id'] as String,
      number: (json['number'] as num).toInt(),
      subject: json['subject'] as String?,
      status: $enumDecodeNullable(_$ChangeRequestStatusEnumMap, json['status']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      mergedAt: json['mergedAt'] == null
          ? null
          : DateTime.parse(json['mergedAt'] as String),
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
      createdBy: json['createdBy'] == null
          ? null
          : ChangeRequestAuthor.fromJson(
              json['createdBy'] as Map<String, dynamic>),
      urls: json['urls'] == null
          ? null
          : ChangeRequestUrls.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChangeRequestModelImplToJson(
        _$ChangeRequestModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'subject': instance.subject,
      'status': _$ChangeRequestStatusEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'mergedAt': instance.mergedAt?.toIso8601String(),
      'closedAt': instance.closedAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'urls': instance.urls,
    };

const _$ChangeRequestStatusEnumMap = {
  ChangeRequestStatus.draft: 'draft',
  ChangeRequestStatus.open: 'open',
  ChangeRequestStatus.merged: 'merged',
  ChangeRequestStatus.closed: 'closed',
};

_$ChangeRequestAuthorImpl _$$ChangeRequestAuthorImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeRequestAuthorImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$$ChangeRequestAuthorImplToJson(
        _$ChangeRequestAuthorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
    };

_$ChangeRequestUrlsImpl _$$ChangeRequestUrlsImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeRequestUrlsImpl(
      location: json['location'] as String?,
      app: json['app'] as String?,
    );

Map<String, dynamic> _$$ChangeRequestUrlsImplToJson(
        _$ChangeRequestUrlsImpl instance) =>
    <String, dynamic>{
      'location': instance.location,
      'app': instance.app,
    };

_$ChangeRequestsListResponseImpl _$$ChangeRequestsListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeRequestsListResponseImpl(
      items: (json['items'] as List<dynamic>)
          .map((e) => ChangeRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      next: json['next'] == null
          ? null
          : PageInfo.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChangeRequestsListResponseImplToJson(
        _$ChangeRequestsListResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };

_$CreateChangeRequestRequestImpl _$$CreateChangeRequestRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateChangeRequestRequestImpl(
      subject: json['subject'] as String?,
    );

Map<String, dynamic> _$$CreateChangeRequestRequestImplToJson(
        _$CreateChangeRequestRequestImpl instance) =>
    <String, dynamic>{
      'subject': instance.subject,
    };

_$ChangeRequestCommentImpl _$$ChangeRequestCommentImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangeRequestCommentImpl(
      id: json['id'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      author: json['author'] == null
          ? null
          : ChangeRequestAuthor.fromJson(
              json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ChangeRequestCommentImplToJson(
        _$ChangeRequestCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'body': instance.body,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'author': instance.author,
    };
