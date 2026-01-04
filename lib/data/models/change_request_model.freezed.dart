// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangeRequestModel _$ChangeRequestModelFromJson(Map<String, dynamic> json) {
  return _ChangeRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ChangeRequestModel {
  String get id => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  ChangeRequestStatus? get status => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get mergedAt => throw _privateConstructorUsedError;
  DateTime? get closedAt => throw _privateConstructorUsedError;
  ChangeRequestAuthor? get createdBy => throw _privateConstructorUsedError;
  ChangeRequestUrls? get urls => throw _privateConstructorUsedError;

  /// Serializes this ChangeRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeRequestModelCopyWith<ChangeRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeRequestModelCopyWith<$Res> {
  factory $ChangeRequestModelCopyWith(
          ChangeRequestModel value, $Res Function(ChangeRequestModel) then) =
      _$ChangeRequestModelCopyWithImpl<$Res, ChangeRequestModel>;
  @useResult
  $Res call(
      {String id,
      int number,
      String? subject,
      ChangeRequestStatus? status,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? mergedAt,
      DateTime? closedAt,
      ChangeRequestAuthor? createdBy,
      ChangeRequestUrls? urls});

  $ChangeRequestAuthorCopyWith<$Res>? get createdBy;
  $ChangeRequestUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class _$ChangeRequestModelCopyWithImpl<$Res, $Val extends ChangeRequestModel>
    implements $ChangeRequestModelCopyWith<$Res> {
  _$ChangeRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? subject = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? mergedAt = freezed,
    Object? closedAt = freezed,
    Object? createdBy = freezed,
    Object? urls = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChangeRequestStatus?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mergedAt: freezed == mergedAt
          ? _value.mergedAt
          : mergedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as ChangeRequestAuthor?,
      urls: freezed == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as ChangeRequestUrls?,
    ) as $Val);
  }

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChangeRequestAuthorCopyWith<$Res>? get createdBy {
    if (_value.createdBy == null) {
      return null;
    }

    return $ChangeRequestAuthorCopyWith<$Res>(_value.createdBy!, (value) {
      return _then(_value.copyWith(createdBy: value) as $Val);
    });
  }

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChangeRequestUrlsCopyWith<$Res>? get urls {
    if (_value.urls == null) {
      return null;
    }

    return $ChangeRequestUrlsCopyWith<$Res>(_value.urls!, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChangeRequestModelImplCopyWith<$Res>
    implements $ChangeRequestModelCopyWith<$Res> {
  factory _$$ChangeRequestModelImplCopyWith(_$ChangeRequestModelImpl value,
          $Res Function(_$ChangeRequestModelImpl) then) =
      __$$ChangeRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int number,
      String? subject,
      ChangeRequestStatus? status,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? mergedAt,
      DateTime? closedAt,
      ChangeRequestAuthor? createdBy,
      ChangeRequestUrls? urls});

  @override
  $ChangeRequestAuthorCopyWith<$Res>? get createdBy;
  @override
  $ChangeRequestUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class __$$ChangeRequestModelImplCopyWithImpl<$Res>
    extends _$ChangeRequestModelCopyWithImpl<$Res, _$ChangeRequestModelImpl>
    implements _$$ChangeRequestModelImplCopyWith<$Res> {
  __$$ChangeRequestModelImplCopyWithImpl(_$ChangeRequestModelImpl _value,
      $Res Function(_$ChangeRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? subject = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? mergedAt = freezed,
    Object? closedAt = freezed,
    Object? createdBy = freezed,
    Object? urls = freezed,
  }) {
    return _then(_$ChangeRequestModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ChangeRequestStatus?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      mergedAt: freezed == mergedAt
          ? _value.mergedAt
          : mergedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      closedAt: freezed == closedAt
          ? _value.closedAt
          : closedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as ChangeRequestAuthor?,
      urls: freezed == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as ChangeRequestUrls?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeRequestModelImpl implements _ChangeRequestModel {
  const _$ChangeRequestModelImpl(
      {required this.id,
      required this.number,
      this.subject,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.mergedAt,
      this.closedAt,
      this.createdBy,
      this.urls});

  factory _$ChangeRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeRequestModelImplFromJson(json);

  @override
  final String id;
  @override
  final int number;
  @override
  final String? subject;
  @override
  final ChangeRequestStatus? status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? mergedAt;
  @override
  final DateTime? closedAt;
  @override
  final ChangeRequestAuthor? createdBy;
  @override
  final ChangeRequestUrls? urls;

  @override
  String toString() {
    return 'ChangeRequestModel(id: $id, number: $number, subject: $subject, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, mergedAt: $mergedAt, closedAt: $closedAt, createdBy: $createdBy, urls: $urls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.mergedAt, mergedAt) ||
                other.mergedAt == mergedAt) &&
            (identical(other.closedAt, closedAt) ||
                other.closedAt == closedAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.urls, urls) || other.urls == urls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, number, subject, status,
      createdAt, updatedAt, mergedAt, closedAt, createdBy, urls);

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeRequestModelImplCopyWith<_$ChangeRequestModelImpl> get copyWith =>
      __$$ChangeRequestModelImplCopyWithImpl<_$ChangeRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeRequestModelImplToJson(
      this,
    );
  }
}

abstract class _ChangeRequestModel implements ChangeRequestModel {
  const factory _ChangeRequestModel(
      {required final String id,
      required final int number,
      final String? subject,
      final ChangeRequestStatus? status,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? mergedAt,
      final DateTime? closedAt,
      final ChangeRequestAuthor? createdBy,
      final ChangeRequestUrls? urls}) = _$ChangeRequestModelImpl;

  factory _ChangeRequestModel.fromJson(Map<String, dynamic> json) =
      _$ChangeRequestModelImpl.fromJson;

  @override
  String get id;
  @override
  int get number;
  @override
  String? get subject;
  @override
  ChangeRequestStatus? get status;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get mergedAt;
  @override
  DateTime? get closedAt;
  @override
  ChangeRequestAuthor? get createdBy;
  @override
  ChangeRequestUrls? get urls;

  /// Create a copy of ChangeRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeRequestModelImplCopyWith<_$ChangeRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChangeRequestAuthor _$ChangeRequestAuthorFromJson(Map<String, dynamic> json) {
  return _ChangeRequestAuthor.fromJson(json);
}

/// @nodoc
mixin _$ChangeRequestAuthor {
  String get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this ChangeRequestAuthor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeRequestAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeRequestAuthorCopyWith<ChangeRequestAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeRequestAuthorCopyWith<$Res> {
  factory $ChangeRequestAuthorCopyWith(
          ChangeRequestAuthor value, $Res Function(ChangeRequestAuthor) then) =
      _$ChangeRequestAuthorCopyWithImpl<$Res, ChangeRequestAuthor>;
  @useResult
  $Res call({String id, String? displayName, String? email, String? photoUrl});
}

/// @nodoc
class _$ChangeRequestAuthorCopyWithImpl<$Res, $Val extends ChangeRequestAuthor>
    implements $ChangeRequestAuthorCopyWith<$Res> {
  _$ChangeRequestAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeRequestAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeRequestAuthorImplCopyWith<$Res>
    implements $ChangeRequestAuthorCopyWith<$Res> {
  factory _$$ChangeRequestAuthorImplCopyWith(_$ChangeRequestAuthorImpl value,
          $Res Function(_$ChangeRequestAuthorImpl) then) =
      __$$ChangeRequestAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? displayName, String? email, String? photoUrl});
}

/// @nodoc
class __$$ChangeRequestAuthorImplCopyWithImpl<$Res>
    extends _$ChangeRequestAuthorCopyWithImpl<$Res, _$ChangeRequestAuthorImpl>
    implements _$$ChangeRequestAuthorImplCopyWith<$Res> {
  __$$ChangeRequestAuthorImplCopyWithImpl(_$ChangeRequestAuthorImpl _value,
      $Res Function(_$ChangeRequestAuthorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeRequestAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$ChangeRequestAuthorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeRequestAuthorImpl implements _ChangeRequestAuthor {
  const _$ChangeRequestAuthorImpl(
      {required this.id, this.displayName, this.email, this.photoUrl});

  factory _$ChangeRequestAuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeRequestAuthorImplFromJson(json);

  @override
  final String id;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'ChangeRequestAuthor(id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeRequestAuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, displayName, email, photoUrl);

  /// Create a copy of ChangeRequestAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeRequestAuthorImplCopyWith<_$ChangeRequestAuthorImpl> get copyWith =>
      __$$ChangeRequestAuthorImplCopyWithImpl<_$ChangeRequestAuthorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeRequestAuthorImplToJson(
      this,
    );
  }
}

abstract class _ChangeRequestAuthor implements ChangeRequestAuthor {
  const factory _ChangeRequestAuthor(
      {required final String id,
      final String? displayName,
      final String? email,
      final String? photoUrl}) = _$ChangeRequestAuthorImpl;

  factory _ChangeRequestAuthor.fromJson(Map<String, dynamic> json) =
      _$ChangeRequestAuthorImpl.fromJson;

  @override
  String get id;
  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get photoUrl;

  /// Create a copy of ChangeRequestAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeRequestAuthorImplCopyWith<_$ChangeRequestAuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChangeRequestUrls _$ChangeRequestUrlsFromJson(Map<String, dynamic> json) {
  return _ChangeRequestUrls.fromJson(json);
}

/// @nodoc
mixin _$ChangeRequestUrls {
  String? get location => throw _privateConstructorUsedError;
  String? get app => throw _privateConstructorUsedError;

  /// Serializes this ChangeRequestUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeRequestUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeRequestUrlsCopyWith<ChangeRequestUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeRequestUrlsCopyWith<$Res> {
  factory $ChangeRequestUrlsCopyWith(
          ChangeRequestUrls value, $Res Function(ChangeRequestUrls) then) =
      _$ChangeRequestUrlsCopyWithImpl<$Res, ChangeRequestUrls>;
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class _$ChangeRequestUrlsCopyWithImpl<$Res, $Val extends ChangeRequestUrls>
    implements $ChangeRequestUrlsCopyWith<$Res> {
  _$ChangeRequestUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeRequestUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
  }) {
    return _then(_value.copyWith(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangeRequestUrlsImplCopyWith<$Res>
    implements $ChangeRequestUrlsCopyWith<$Res> {
  factory _$$ChangeRequestUrlsImplCopyWith(_$ChangeRequestUrlsImpl value,
          $Res Function(_$ChangeRequestUrlsImpl) then) =
      __$$ChangeRequestUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class __$$ChangeRequestUrlsImplCopyWithImpl<$Res>
    extends _$ChangeRequestUrlsCopyWithImpl<$Res, _$ChangeRequestUrlsImpl>
    implements _$$ChangeRequestUrlsImplCopyWith<$Res> {
  __$$ChangeRequestUrlsImplCopyWithImpl(_$ChangeRequestUrlsImpl _value,
      $Res Function(_$ChangeRequestUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeRequestUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
  }) {
    return _then(_$ChangeRequestUrlsImpl(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeRequestUrlsImpl implements _ChangeRequestUrls {
  const _$ChangeRequestUrlsImpl({this.location, this.app});

  factory _$ChangeRequestUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeRequestUrlsImplFromJson(json);

  @override
  final String? location;
  @override
  final String? app;

  @override
  String toString() {
    return 'ChangeRequestUrls(location: $location, app: $app)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeRequestUrlsImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.app, app) || other.app == app));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, app);

  /// Create a copy of ChangeRequestUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeRequestUrlsImplCopyWith<_$ChangeRequestUrlsImpl> get copyWith =>
      __$$ChangeRequestUrlsImplCopyWithImpl<_$ChangeRequestUrlsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeRequestUrlsImplToJson(
      this,
    );
  }
}

abstract class _ChangeRequestUrls implements ChangeRequestUrls {
  const factory _ChangeRequestUrls(
      {final String? location, final String? app}) = _$ChangeRequestUrlsImpl;

  factory _ChangeRequestUrls.fromJson(Map<String, dynamic> json) =
      _$ChangeRequestUrlsImpl.fromJson;

  @override
  String? get location;
  @override
  String? get app;

  /// Create a copy of ChangeRequestUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeRequestUrlsImplCopyWith<_$ChangeRequestUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChangeRequestsListResponse _$ChangeRequestsListResponseFromJson(
    Map<String, dynamic> json) {
  return _ChangeRequestsListResponse.fromJson(json);
}

/// @nodoc
mixin _$ChangeRequestsListResponse {
  List<ChangeRequestModel> get items => throw _privateConstructorUsedError;
  PageInfo? get next => throw _privateConstructorUsedError;

  /// Serializes this ChangeRequestsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeRequestsListResponseCopyWith<ChangeRequestsListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeRequestsListResponseCopyWith<$Res> {
  factory $ChangeRequestsListResponseCopyWith(ChangeRequestsListResponse value,
          $Res Function(ChangeRequestsListResponse) then) =
      _$ChangeRequestsListResponseCopyWithImpl<$Res,
          ChangeRequestsListResponse>;
  @useResult
  $Res call({List<ChangeRequestModel> items, PageInfo? next});

  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class _$ChangeRequestsListResponseCopyWithImpl<$Res,
        $Val extends ChangeRequestsListResponse>
    implements $ChangeRequestsListResponseCopyWith<$Res> {
  _$ChangeRequestsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? next = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChangeRequestModel>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ) as $Val);
  }

  /// Create a copy of ChangeRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PageInfoCopyWith<$Res>? get next {
    if (_value.next == null) {
      return null;
    }

    return $PageInfoCopyWith<$Res>(_value.next!, (value) {
      return _then(_value.copyWith(next: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChangeRequestsListResponseImplCopyWith<$Res>
    implements $ChangeRequestsListResponseCopyWith<$Res> {
  factory _$$ChangeRequestsListResponseImplCopyWith(
          _$ChangeRequestsListResponseImpl value,
          $Res Function(_$ChangeRequestsListResponseImpl) then) =
      __$$ChangeRequestsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ChangeRequestModel> items, PageInfo? next});

  @override
  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class __$$ChangeRequestsListResponseImplCopyWithImpl<$Res>
    extends _$ChangeRequestsListResponseCopyWithImpl<$Res,
        _$ChangeRequestsListResponseImpl>
    implements _$$ChangeRequestsListResponseImplCopyWith<$Res> {
  __$$ChangeRequestsListResponseImplCopyWithImpl(
      _$ChangeRequestsListResponseImpl _value,
      $Res Function(_$ChangeRequestsListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? next = freezed,
  }) {
    return _then(_$ChangeRequestsListResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ChangeRequestModel>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeRequestsListResponseImpl implements _ChangeRequestsListResponse {
  const _$ChangeRequestsListResponseImpl(
      {required final List<ChangeRequestModel> items, this.next})
      : _items = items;

  factory _$ChangeRequestsListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChangeRequestsListResponseImplFromJson(json);

  final List<ChangeRequestModel> _items;
  @override
  List<ChangeRequestModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final PageInfo? next;

  @override
  String toString() {
    return 'ChangeRequestsListResponse(items: $items, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeRequestsListResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.next, next) || other.next == next));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), next);

  /// Create a copy of ChangeRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeRequestsListResponseImplCopyWith<_$ChangeRequestsListResponseImpl>
      get copyWith => __$$ChangeRequestsListResponseImplCopyWithImpl<
          _$ChangeRequestsListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeRequestsListResponseImplToJson(
      this,
    );
  }
}

abstract class _ChangeRequestsListResponse
    implements ChangeRequestsListResponse {
  const factory _ChangeRequestsListResponse(
      {required final List<ChangeRequestModel> items,
      final PageInfo? next}) = _$ChangeRequestsListResponseImpl;

  factory _ChangeRequestsListResponse.fromJson(Map<String, dynamic> json) =
      _$ChangeRequestsListResponseImpl.fromJson;

  @override
  List<ChangeRequestModel> get items;
  @override
  PageInfo? get next;

  /// Create a copy of ChangeRequestsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeRequestsListResponseImplCopyWith<_$ChangeRequestsListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

CreateChangeRequestRequest _$CreateChangeRequestRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateChangeRequestRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateChangeRequestRequest {
  String? get subject => throw _privateConstructorUsedError;

  /// Serializes this CreateChangeRequestRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateChangeRequestRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateChangeRequestRequestCopyWith<CreateChangeRequestRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChangeRequestRequestCopyWith<$Res> {
  factory $CreateChangeRequestRequestCopyWith(CreateChangeRequestRequest value,
          $Res Function(CreateChangeRequestRequest) then) =
      _$CreateChangeRequestRequestCopyWithImpl<$Res,
          CreateChangeRequestRequest>;
  @useResult
  $Res call({String? subject});
}

/// @nodoc
class _$CreateChangeRequestRequestCopyWithImpl<$Res,
        $Val extends CreateChangeRequestRequest>
    implements $CreateChangeRequestRequestCopyWith<$Res> {
  _$CreateChangeRequestRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateChangeRequestRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = freezed,
  }) {
    return _then(_value.copyWith(
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateChangeRequestRequestImplCopyWith<$Res>
    implements $CreateChangeRequestRequestCopyWith<$Res> {
  factory _$$CreateChangeRequestRequestImplCopyWith(
          _$CreateChangeRequestRequestImpl value,
          $Res Function(_$CreateChangeRequestRequestImpl) then) =
      __$$CreateChangeRequestRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? subject});
}

/// @nodoc
class __$$CreateChangeRequestRequestImplCopyWithImpl<$Res>
    extends _$CreateChangeRequestRequestCopyWithImpl<$Res,
        _$CreateChangeRequestRequestImpl>
    implements _$$CreateChangeRequestRequestImplCopyWith<$Res> {
  __$$CreateChangeRequestRequestImplCopyWithImpl(
      _$CreateChangeRequestRequestImpl _value,
      $Res Function(_$CreateChangeRequestRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateChangeRequestRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subject = freezed,
  }) {
    return _then(_$CreateChangeRequestRequestImpl(
      subject: freezed == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateChangeRequestRequestImpl implements _CreateChangeRequestRequest {
  const _$CreateChangeRequestRequestImpl({this.subject});

  factory _$CreateChangeRequestRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CreateChangeRequestRequestImplFromJson(json);

  @override
  final String? subject;

  @override
  String toString() {
    return 'CreateChangeRequestRequest(subject: $subject)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateChangeRequestRequestImpl &&
            (identical(other.subject, subject) || other.subject == subject));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, subject);

  /// Create a copy of CreateChangeRequestRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateChangeRequestRequestImplCopyWith<_$CreateChangeRequestRequestImpl>
      get copyWith => __$$CreateChangeRequestRequestImplCopyWithImpl<
          _$CreateChangeRequestRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateChangeRequestRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateChangeRequestRequest
    implements CreateChangeRequestRequest {
  const factory _CreateChangeRequestRequest({final String? subject}) =
      _$CreateChangeRequestRequestImpl;

  factory _CreateChangeRequestRequest.fromJson(Map<String, dynamic> json) =
      _$CreateChangeRequestRequestImpl.fromJson;

  @override
  String? get subject;

  /// Create a copy of CreateChangeRequestRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateChangeRequestRequestImplCopyWith<_$CreateChangeRequestRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ChangeRequestComment _$ChangeRequestCommentFromJson(Map<String, dynamic> json) {
  return _ChangeRequestComment.fromJson(json);
}

/// @nodoc
mixin _$ChangeRequestComment {
  String get id => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  ChangeRequestAuthor? get author => throw _privateConstructorUsedError;

  /// Serializes this ChangeRequestComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangeRequestComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangeRequestCommentCopyWith<ChangeRequestComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeRequestCommentCopyWith<$Res> {
  factory $ChangeRequestCommentCopyWith(ChangeRequestComment value,
          $Res Function(ChangeRequestComment) then) =
      _$ChangeRequestCommentCopyWithImpl<$Res, ChangeRequestComment>;
  @useResult
  $Res call(
      {String id,
      String body,
      DateTime? createdAt,
      DateTime? updatedAt,
      ChangeRequestAuthor? author});

  $ChangeRequestAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class _$ChangeRequestCommentCopyWithImpl<$Res,
        $Val extends ChangeRequestComment>
    implements $ChangeRequestCommentCopyWith<$Res> {
  _$ChangeRequestCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangeRequestComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? body = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ChangeRequestAuthor?,
    ) as $Val);
  }

  /// Create a copy of ChangeRequestComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChangeRequestAuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $ChangeRequestAuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChangeRequestCommentImplCopyWith<$Res>
    implements $ChangeRequestCommentCopyWith<$Res> {
  factory _$$ChangeRequestCommentImplCopyWith(_$ChangeRequestCommentImpl value,
          $Res Function(_$ChangeRequestCommentImpl) then) =
      __$$ChangeRequestCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String body,
      DateTime? createdAt,
      DateTime? updatedAt,
      ChangeRequestAuthor? author});

  @override
  $ChangeRequestAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class __$$ChangeRequestCommentImplCopyWithImpl<$Res>
    extends _$ChangeRequestCommentCopyWithImpl<$Res, _$ChangeRequestCommentImpl>
    implements _$$ChangeRequestCommentImplCopyWith<$Res> {
  __$$ChangeRequestCommentImplCopyWithImpl(_$ChangeRequestCommentImpl _value,
      $Res Function(_$ChangeRequestCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangeRequestComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? body = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? author = freezed,
  }) {
    return _then(_$ChangeRequestCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ChangeRequestAuthor?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangeRequestCommentImpl implements _ChangeRequestComment {
  const _$ChangeRequestCommentImpl(
      {required this.id,
      required this.body,
      this.createdAt,
      this.updatedAt,
      this.author});

  factory _$ChangeRequestCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangeRequestCommentImplFromJson(json);

  @override
  final String id;
  @override
  final String body;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final ChangeRequestAuthor? author;

  @override
  String toString() {
    return 'ChangeRequestComment(id: $id, body: $body, createdAt: $createdAt, updatedAt: $updatedAt, author: $author)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeRequestCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.author, author) || other.author == author));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, body, createdAt, updatedAt, author);

  /// Create a copy of ChangeRequestComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeRequestCommentImplCopyWith<_$ChangeRequestCommentImpl>
      get copyWith =>
          __$$ChangeRequestCommentImplCopyWithImpl<_$ChangeRequestCommentImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangeRequestCommentImplToJson(
      this,
    );
  }
}

abstract class _ChangeRequestComment implements ChangeRequestComment {
  const factory _ChangeRequestComment(
      {required final String id,
      required final String body,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final ChangeRequestAuthor? author}) = _$ChangeRequestCommentImpl;

  factory _ChangeRequestComment.fromJson(Map<String, dynamic> json) =
      _$ChangeRequestCommentImpl.fromJson;

  @override
  String get id;
  @override
  String get body;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  ChangeRequestAuthor? get author;

  /// Create a copy of ChangeRequestComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeRequestCommentImplCopyWith<_$ChangeRequestCommentImpl>
      get copyWith => throw _privateConstructorUsedError;
}
