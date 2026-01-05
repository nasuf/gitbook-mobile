// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) {
  return _CollectionModel.fromJson(json);
}

/// @nodoc
mixin _$CollectionModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get emoji => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  CollectionUrls? get urls => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;

  /// Serializes this CollectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionModelCopyWith<CollectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionModelCopyWith<$Res> {
  factory $CollectionModelCopyWith(
          CollectionModel value, $Res Function(CollectionModel) then) =
      _$CollectionModelCopyWithImpl<$Res, CollectionModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? emoji,
      DateTime? createdAt,
      DateTime? updatedAt,
      CollectionUrls? urls,
      String? organizationId});

  $CollectionUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class _$CollectionModelCopyWithImpl<$Res, $Val extends CollectionModel>
    implements $CollectionModelCopyWith<$Res> {
  _$CollectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? emoji = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? urls = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      urls: freezed == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as CollectionUrls?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CollectionUrlsCopyWith<$Res>? get urls {
    if (_value.urls == null) {
      return null;
    }

    return $CollectionUrlsCopyWith<$Res>(_value.urls!, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CollectionModelImplCopyWith<$Res>
    implements $CollectionModelCopyWith<$Res> {
  factory _$$CollectionModelImplCopyWith(_$CollectionModelImpl value,
          $Res Function(_$CollectionModelImpl) then) =
      __$$CollectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? emoji,
      DateTime? createdAt,
      DateTime? updatedAt,
      CollectionUrls? urls,
      String? organizationId});

  @override
  $CollectionUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class __$$CollectionModelImplCopyWithImpl<$Res>
    extends _$CollectionModelCopyWithImpl<$Res, _$CollectionModelImpl>
    implements _$$CollectionModelImplCopyWith<$Res> {
  __$$CollectionModelImplCopyWithImpl(
      _$CollectionModelImpl _value, $Res Function(_$CollectionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? emoji = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? urls = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_$CollectionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      urls: freezed == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as CollectionUrls?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionModelImpl implements _CollectionModel {
  const _$CollectionModelImpl(
      {required this.id,
      required this.title,
      this.description,
      this.emoji,
      this.createdAt,
      this.updatedAt,
      this.urls,
      this.organizationId});

  factory _$CollectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? emoji;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final CollectionUrls? urls;
  @override
  final String? organizationId;

  @override
  String toString() {
    return 'CollectionModel(id: $id, title: $title, description: $description, emoji: $emoji, createdAt: $createdAt, updatedAt: $updatedAt, urls: $urls, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.urls, urls) || other.urls == urls) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, emoji,
      createdAt, updatedAt, urls, organizationId);

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionModelImplCopyWith<_$CollectionModelImpl> get copyWith =>
      __$$CollectionModelImplCopyWithImpl<_$CollectionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionModelImplToJson(
      this,
    );
  }
}

abstract class _CollectionModel implements CollectionModel {
  const factory _CollectionModel(
      {required final String id,
      required final String title,
      final String? description,
      final String? emoji,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final CollectionUrls? urls,
      final String? organizationId}) = _$CollectionModelImpl;

  factory _CollectionModel.fromJson(Map<String, dynamic> json) =
      _$CollectionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get emoji;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  CollectionUrls? get urls;
  @override
  String? get organizationId;

  /// Create a copy of CollectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionModelImplCopyWith<_$CollectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CollectionUrls _$CollectionUrlsFromJson(Map<String, dynamic> json) {
  return _CollectionUrls.fromJson(json);
}

/// @nodoc
mixin _$CollectionUrls {
  String? get location => throw _privateConstructorUsedError;
  String? get app => throw _privateConstructorUsedError;

  /// Serializes this CollectionUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CollectionUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionUrlsCopyWith<CollectionUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionUrlsCopyWith<$Res> {
  factory $CollectionUrlsCopyWith(
          CollectionUrls value, $Res Function(CollectionUrls) then) =
      _$CollectionUrlsCopyWithImpl<$Res, CollectionUrls>;
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class _$CollectionUrlsCopyWithImpl<$Res, $Val extends CollectionUrls>
    implements $CollectionUrlsCopyWith<$Res> {
  _$CollectionUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionUrls
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
abstract class _$$CollectionUrlsImplCopyWith<$Res>
    implements $CollectionUrlsCopyWith<$Res> {
  factory _$$CollectionUrlsImplCopyWith(_$CollectionUrlsImpl value,
          $Res Function(_$CollectionUrlsImpl) then) =
      __$$CollectionUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class __$$CollectionUrlsImplCopyWithImpl<$Res>
    extends _$CollectionUrlsCopyWithImpl<$Res, _$CollectionUrlsImpl>
    implements _$$CollectionUrlsImplCopyWith<$Res> {
  __$$CollectionUrlsImplCopyWithImpl(
      _$CollectionUrlsImpl _value, $Res Function(_$CollectionUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
  }) {
    return _then(_$CollectionUrlsImpl(
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
class _$CollectionUrlsImpl implements _CollectionUrls {
  const _$CollectionUrlsImpl({this.location, this.app});

  factory _$CollectionUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionUrlsImplFromJson(json);

  @override
  final String? location;
  @override
  final String? app;

  @override
  String toString() {
    return 'CollectionUrls(location: $location, app: $app)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionUrlsImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.app, app) || other.app == app));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, app);

  /// Create a copy of CollectionUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionUrlsImplCopyWith<_$CollectionUrlsImpl> get copyWith =>
      __$$CollectionUrlsImplCopyWithImpl<_$CollectionUrlsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionUrlsImplToJson(
      this,
    );
  }
}

abstract class _CollectionUrls implements CollectionUrls {
  const factory _CollectionUrls({final String? location, final String? app}) =
      _$CollectionUrlsImpl;

  factory _CollectionUrls.fromJson(Map<String, dynamic> json) =
      _$CollectionUrlsImpl.fromJson;

  @override
  String? get location;
  @override
  String? get app;

  /// Create a copy of CollectionUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionUrlsImplCopyWith<_$CollectionUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
