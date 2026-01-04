// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpaceModel _$SpaceModelFromJson(Map<String, dynamic> json) {
  return _SpaceModel.fromJson(json);
}

/// @nodoc
mixin _$SpaceModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  SpaceVisibility? get visibility => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  SpaceUrls? get urls => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;

  /// Serializes this SpaceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceModelCopyWith<SpaceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceModelCopyWith<$Res> {
  factory $SpaceModelCopyWith(
          SpaceModel value, $Res Function(SpaceModel) then) =
      _$SpaceModelCopyWithImpl<$Res, SpaceModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      SpaceVisibility? visibility,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      SpaceUrls? urls,
      String? organizationId});

  $SpaceUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class _$SpaceModelCopyWithImpl<$Res, $Val extends SpaceModel>
    implements $SpaceModelCopyWith<$Res> {
  _$SpaceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? visibility = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
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
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as SpaceVisibility?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      urls: freezed == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as SpaceUrls?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpaceUrlsCopyWith<$Res>? get urls {
    if (_value.urls == null) {
      return null;
    }

    return $SpaceUrlsCopyWith<$Res>(_value.urls!, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SpaceModelImplCopyWith<$Res>
    implements $SpaceModelCopyWith<$Res> {
  factory _$$SpaceModelImplCopyWith(
          _$SpaceModelImpl value, $Res Function(_$SpaceModelImpl) then) =
      __$$SpaceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      SpaceVisibility? visibility,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      SpaceUrls? urls,
      String? organizationId});

  @override
  $SpaceUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class __$$SpaceModelImplCopyWithImpl<$Res>
    extends _$SpaceModelCopyWithImpl<$Res, _$SpaceModelImpl>
    implements _$$SpaceModelImplCopyWith<$Res> {
  __$$SpaceModelImplCopyWithImpl(
      _$SpaceModelImpl _value, $Res Function(_$SpaceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? visibility = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? urls = freezed,
    Object? organizationId = freezed,
  }) {
    return _then(_$SpaceModelImpl(
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
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as SpaceVisibility?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      urls: freezed == urls
          ? _value.urls
          : urls // ignore: cast_nullable_to_non_nullable
              as SpaceUrls?,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpaceModelImpl implements _SpaceModel {
  const _$SpaceModelImpl(
      {required this.id,
      required this.title,
      this.description,
      this.visibility,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.urls,
      this.organizationId});

  factory _$SpaceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpaceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final SpaceVisibility? visibility;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final SpaceUrls? urls;
  @override
  final String? organizationId;

  @override
  String toString() {
    return 'SpaceModel(id: $id, title: $title, description: $description, visibility: $visibility, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, urls: $urls, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.urls, urls) || other.urls == urls) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description,
      visibility, createdAt, updatedAt, deletedAt, urls, organizationId);

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceModelImplCopyWith<_$SpaceModelImpl> get copyWith =>
      __$$SpaceModelImplCopyWithImpl<_$SpaceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpaceModelImplToJson(
      this,
    );
  }
}

abstract class _SpaceModel implements SpaceModel {
  const factory _SpaceModel(
      {required final String id,
      required final String title,
      final String? description,
      final SpaceVisibility? visibility,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? deletedAt,
      final SpaceUrls? urls,
      final String? organizationId}) = _$SpaceModelImpl;

  factory _SpaceModel.fromJson(Map<String, dynamic> json) =
      _$SpaceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  SpaceVisibility? get visibility;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  SpaceUrls? get urls;
  @override
  String? get organizationId;

  /// Create a copy of SpaceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceModelImplCopyWith<_$SpaceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpaceUrls _$SpaceUrlsFromJson(Map<String, dynamic> json) {
  return _SpaceUrls.fromJson(json);
}

/// @nodoc
mixin _$SpaceUrls {
  String? get location => throw _privateConstructorUsedError;
  String? get app => throw _privateConstructorUsedError;
  String? get published => throw _privateConstructorUsedError;

  /// Serializes this SpaceUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpaceUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceUrlsCopyWith<SpaceUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceUrlsCopyWith<$Res> {
  factory $SpaceUrlsCopyWith(SpaceUrls value, $Res Function(SpaceUrls) then) =
      _$SpaceUrlsCopyWithImpl<$Res, SpaceUrls>;
  @useResult
  $Res call({String? location, String? app, String? published});
}

/// @nodoc
class _$SpaceUrlsCopyWithImpl<$Res, $Val extends SpaceUrls>
    implements $SpaceUrlsCopyWith<$Res> {
  _$SpaceUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpaceUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
    Object? published = freezed,
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
      published: freezed == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpaceUrlsImplCopyWith<$Res>
    implements $SpaceUrlsCopyWith<$Res> {
  factory _$$SpaceUrlsImplCopyWith(
          _$SpaceUrlsImpl value, $Res Function(_$SpaceUrlsImpl) then) =
      __$$SpaceUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? location, String? app, String? published});
}

/// @nodoc
class __$$SpaceUrlsImplCopyWithImpl<$Res>
    extends _$SpaceUrlsCopyWithImpl<$Res, _$SpaceUrlsImpl>
    implements _$$SpaceUrlsImplCopyWith<$Res> {
  __$$SpaceUrlsImplCopyWithImpl(
      _$SpaceUrlsImpl _value, $Res Function(_$SpaceUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
    Object? published = freezed,
  }) {
    return _then(_$SpaceUrlsImpl(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as String?,
      published: freezed == published
          ? _value.published
          : published // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpaceUrlsImpl implements _SpaceUrls {
  const _$SpaceUrlsImpl({this.location, this.app, this.published});

  factory _$SpaceUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpaceUrlsImplFromJson(json);

  @override
  final String? location;
  @override
  final String? app;
  @override
  final String? published;

  @override
  String toString() {
    return 'SpaceUrls(location: $location, app: $app, published: $published)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceUrlsImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.app, app) || other.app == app) &&
            (identical(other.published, published) ||
                other.published == published));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, app, published);

  /// Create a copy of SpaceUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceUrlsImplCopyWith<_$SpaceUrlsImpl> get copyWith =>
      __$$SpaceUrlsImplCopyWithImpl<_$SpaceUrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpaceUrlsImplToJson(
      this,
    );
  }
}

abstract class _SpaceUrls implements SpaceUrls {
  const factory _SpaceUrls(
      {final String? location,
      final String? app,
      final String? published}) = _$SpaceUrlsImpl;

  factory _SpaceUrls.fromJson(Map<String, dynamic> json) =
      _$SpaceUrlsImpl.fromJson;

  @override
  String? get location;
  @override
  String? get app;
  @override
  String? get published;

  /// Create a copy of SpaceUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceUrlsImplCopyWith<_$SpaceUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpacesListResponse _$SpacesListResponseFromJson(Map<String, dynamic> json) {
  return _SpacesListResponse.fromJson(json);
}

/// @nodoc
mixin _$SpacesListResponse {
  List<SpaceModel> get items => throw _privateConstructorUsedError;
  PageInfo? get next => throw _privateConstructorUsedError;

  /// Serializes this SpacesListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpacesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpacesListResponseCopyWith<SpacesListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpacesListResponseCopyWith<$Res> {
  factory $SpacesListResponseCopyWith(
          SpacesListResponse value, $Res Function(SpacesListResponse) then) =
      _$SpacesListResponseCopyWithImpl<$Res, SpacesListResponse>;
  @useResult
  $Res call({List<SpaceModel> items, PageInfo? next});

  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class _$SpacesListResponseCopyWithImpl<$Res, $Val extends SpacesListResponse>
    implements $SpacesListResponseCopyWith<$Res> {
  _$SpacesListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpacesListResponse
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
              as List<SpaceModel>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ) as $Val);
  }

  /// Create a copy of SpacesListResponse
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
abstract class _$$SpacesListResponseImplCopyWith<$Res>
    implements $SpacesListResponseCopyWith<$Res> {
  factory _$$SpacesListResponseImplCopyWith(_$SpacesListResponseImpl value,
          $Res Function(_$SpacesListResponseImpl) then) =
      __$$SpacesListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SpaceModel> items, PageInfo? next});

  @override
  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class __$$SpacesListResponseImplCopyWithImpl<$Res>
    extends _$SpacesListResponseCopyWithImpl<$Res, _$SpacesListResponseImpl>
    implements _$$SpacesListResponseImplCopyWith<$Res> {
  __$$SpacesListResponseImplCopyWithImpl(_$SpacesListResponseImpl _value,
      $Res Function(_$SpacesListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpacesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? next = freezed,
  }) {
    return _then(_$SpacesListResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SpaceModel>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpacesListResponseImpl implements _SpacesListResponse {
  const _$SpacesListResponseImpl(
      {required final List<SpaceModel> items, this.next})
      : _items = items;

  factory _$SpacesListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpacesListResponseImplFromJson(json);

  final List<SpaceModel> _items;
  @override
  List<SpaceModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final PageInfo? next;

  @override
  String toString() {
    return 'SpacesListResponse(items: $items, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpacesListResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.next, next) || other.next == next));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), next);

  /// Create a copy of SpacesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpacesListResponseImplCopyWith<_$SpacesListResponseImpl> get copyWith =>
      __$$SpacesListResponseImplCopyWithImpl<_$SpacesListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpacesListResponseImplToJson(
      this,
    );
  }
}

abstract class _SpacesListResponse implements SpacesListResponse {
  const factory _SpacesListResponse(
      {required final List<SpaceModel> items,
      final PageInfo? next}) = _$SpacesListResponseImpl;

  factory _SpacesListResponse.fromJson(Map<String, dynamic> json) =
      _$SpacesListResponseImpl.fromJson;

  @override
  List<SpaceModel> get items;
  @override
  PageInfo? get next;

  /// Create a copy of SpacesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpacesListResponseImplCopyWith<_$SpacesListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateSpaceRequest _$CreateSpaceRequestFromJson(Map<String, dynamic> json) {
  return _CreateSpaceRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateSpaceRequest {
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  SpaceVisibility? get visibility => throw _privateConstructorUsedError;

  /// Serializes this CreateSpaceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSpaceRequestCopyWith<CreateSpaceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSpaceRequestCopyWith<$Res> {
  factory $CreateSpaceRequestCopyWith(
          CreateSpaceRequest value, $Res Function(CreateSpaceRequest) then) =
      _$CreateSpaceRequestCopyWithImpl<$Res, CreateSpaceRequest>;
  @useResult
  $Res call({String title, String? description, SpaceVisibility? visibility});
}

/// @nodoc
class _$CreateSpaceRequestCopyWithImpl<$Res, $Val extends CreateSpaceRequest>
    implements $CreateSpaceRequestCopyWith<$Res> {
  _$CreateSpaceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? visibility = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as SpaceVisibility?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSpaceRequestImplCopyWith<$Res>
    implements $CreateSpaceRequestCopyWith<$Res> {
  factory _$$CreateSpaceRequestImplCopyWith(_$CreateSpaceRequestImpl value,
          $Res Function(_$CreateSpaceRequestImpl) then) =
      __$$CreateSpaceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? description, SpaceVisibility? visibility});
}

/// @nodoc
class __$$CreateSpaceRequestImplCopyWithImpl<$Res>
    extends _$CreateSpaceRequestCopyWithImpl<$Res, _$CreateSpaceRequestImpl>
    implements _$$CreateSpaceRequestImplCopyWith<$Res> {
  __$$CreateSpaceRequestImplCopyWithImpl(_$CreateSpaceRequestImpl _value,
      $Res Function(_$CreateSpaceRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = freezed,
    Object? visibility = freezed,
  }) {
    return _then(_$CreateSpaceRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as SpaceVisibility?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateSpaceRequestImpl implements _CreateSpaceRequest {
  const _$CreateSpaceRequestImpl(
      {required this.title, this.description, this.visibility});

  factory _$CreateSpaceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateSpaceRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String? description;
  @override
  final SpaceVisibility? visibility;

  @override
  String toString() {
    return 'CreateSpaceRequest(title: $title, description: $description, visibility: $visibility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSpaceRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, visibility);

  /// Create a copy of CreateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSpaceRequestImplCopyWith<_$CreateSpaceRequestImpl> get copyWith =>
      __$$CreateSpaceRequestImplCopyWithImpl<_$CreateSpaceRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateSpaceRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateSpaceRequest implements CreateSpaceRequest {
  const factory _CreateSpaceRequest(
      {required final String title,
      final String? description,
      final SpaceVisibility? visibility}) = _$CreateSpaceRequestImpl;

  factory _CreateSpaceRequest.fromJson(Map<String, dynamic> json) =
      _$CreateSpaceRequestImpl.fromJson;

  @override
  String get title;
  @override
  String? get description;
  @override
  SpaceVisibility? get visibility;

  /// Create a copy of CreateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSpaceRequestImplCopyWith<_$CreateSpaceRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdateSpaceRequest _$UpdateSpaceRequestFromJson(Map<String, dynamic> json) {
  return _UpdateSpaceRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateSpaceRequest {
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  SpaceVisibility? get visibility => throw _privateConstructorUsedError;

  /// Serializes this UpdateSpaceRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateSpaceRequestCopyWith<UpdateSpaceRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateSpaceRequestCopyWith<$Res> {
  factory $UpdateSpaceRequestCopyWith(
          UpdateSpaceRequest value, $Res Function(UpdateSpaceRequest) then) =
      _$UpdateSpaceRequestCopyWithImpl<$Res, UpdateSpaceRequest>;
  @useResult
  $Res call({String? title, String? description, SpaceVisibility? visibility});
}

/// @nodoc
class _$UpdateSpaceRequestCopyWithImpl<$Res, $Val extends UpdateSpaceRequest>
    implements $UpdateSpaceRequestCopyWith<$Res> {
  _$UpdateSpaceRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? visibility = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as SpaceVisibility?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateSpaceRequestImplCopyWith<$Res>
    implements $UpdateSpaceRequestCopyWith<$Res> {
  factory _$$UpdateSpaceRequestImplCopyWith(_$UpdateSpaceRequestImpl value,
          $Res Function(_$UpdateSpaceRequestImpl) then) =
      __$$UpdateSpaceRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, String? description, SpaceVisibility? visibility});
}

/// @nodoc
class __$$UpdateSpaceRequestImplCopyWithImpl<$Res>
    extends _$UpdateSpaceRequestCopyWithImpl<$Res, _$UpdateSpaceRequestImpl>
    implements _$$UpdateSpaceRequestImplCopyWith<$Res> {
  __$$UpdateSpaceRequestImplCopyWithImpl(_$UpdateSpaceRequestImpl _value,
      $Res Function(_$UpdateSpaceRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? description = freezed,
    Object? visibility = freezed,
  }) {
    return _then(_$UpdateSpaceRequestImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as SpaceVisibility?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateSpaceRequestImpl implements _UpdateSpaceRequest {
  const _$UpdateSpaceRequestImpl(
      {this.title, this.description, this.visibility});

  factory _$UpdateSpaceRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateSpaceRequestImplFromJson(json);

  @override
  final String? title;
  @override
  final String? description;
  @override
  final SpaceVisibility? visibility;

  @override
  String toString() {
    return 'UpdateSpaceRequest(title: $title, description: $description, visibility: $visibility)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSpaceRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, visibility);

  /// Create a copy of UpdateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSpaceRequestImplCopyWith<_$UpdateSpaceRequestImpl> get copyWith =>
      __$$UpdateSpaceRequestImplCopyWithImpl<_$UpdateSpaceRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateSpaceRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateSpaceRequest implements UpdateSpaceRequest {
  const factory _UpdateSpaceRequest(
      {final String? title,
      final String? description,
      final SpaceVisibility? visibility}) = _$UpdateSpaceRequestImpl;

  factory _UpdateSpaceRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateSpaceRequestImpl.fromJson;

  @override
  String? get title;
  @override
  String? get description;
  @override
  SpaceVisibility? get visibility;

  /// Create a copy of UpdateSpaceRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSpaceRequestImplCopyWith<_$UpdateSpaceRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
