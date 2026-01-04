// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenResponseImpl _$$TokenResponseImplFromJson(Map<String, dynamic> json) =>
    _$TokenResponseImpl(
      accessToken: json['accessToken'] as String,
      tokenType: json['tokenType'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
      refreshToken: json['refreshToken'] as String?,
      scope: json['scope'] as String?,
    );

Map<String, dynamic> _$$TokenResponseImplToJson(_$TokenResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'tokenType': instance.tokenType,
      'expiresIn': instance.expiresIn,
      'refreshToken': instance.refreshToken,
      'scope': instance.scope,
    };

_$TokenRequestImpl _$$TokenRequestImplFromJson(Map<String, dynamic> json) =>
    _$TokenRequestImpl(
      grantType: json['grantType'] as String,
      clientId: json['clientId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      code: json['code'] as String?,
      redirectUri: json['redirectUri'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );

Map<String, dynamic> _$$TokenRequestImplToJson(_$TokenRequestImpl instance) =>
    <String, dynamic>{
      'grantType': instance.grantType,
      'clientId': instance.clientId,
      'clientSecret': instance.clientSecret,
      'code': instance.code,
      'redirectUri': instance.redirectUri,
      'refreshToken': instance.refreshToken,
    };

_$AuthDataImpl _$$AuthDataImplFromJson(Map<String, dynamic> json) =>
    _$AuthDataImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$AuthDataImplToJson(_$AuthDataImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };
