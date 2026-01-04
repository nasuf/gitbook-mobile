// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'organization_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) {
  return _OrganizationModel.fromJson(json);
}

/// @nodoc
mixin _$OrganizationModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  OrganizationUrls? get urls => throw _privateConstructorUsedError;

  /// Serializes this OrganizationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationModelCopyWith<OrganizationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationModelCopyWith<$Res> {
  factory $OrganizationModelCopyWith(
          OrganizationModel value, $Res Function(OrganizationModel) then) =
      _$OrganizationModelCopyWithImpl<$Res, OrganizationModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime? createdAt,
      DateTime? updatedAt,
      OrganizationUrls? urls});

  $OrganizationUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class _$OrganizationModelCopyWithImpl<$Res, $Val extends OrganizationModel>
    implements $OrganizationModelCopyWith<$Res> {
  _$OrganizationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? urls = freezed,
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
              as OrganizationUrls?,
    ) as $Val);
  }

  /// Create a copy of OrganizationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OrganizationUrlsCopyWith<$Res>? get urls {
    if (_value.urls == null) {
      return null;
    }

    return $OrganizationUrlsCopyWith<$Res>(_value.urls!, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationModelImplCopyWith<$Res>
    implements $OrganizationModelCopyWith<$Res> {
  factory _$$OrganizationModelImplCopyWith(_$OrganizationModelImpl value,
          $Res Function(_$OrganizationModelImpl) then) =
      __$$OrganizationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime? createdAt,
      DateTime? updatedAt,
      OrganizationUrls? urls});

  @override
  $OrganizationUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class __$$OrganizationModelImplCopyWithImpl<$Res>
    extends _$OrganizationModelCopyWithImpl<$Res, _$OrganizationModelImpl>
    implements _$$OrganizationModelImplCopyWith<$Res> {
  __$$OrganizationModelImplCopyWithImpl(_$OrganizationModelImpl _value,
      $Res Function(_$OrganizationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? urls = freezed,
  }) {
    return _then(_$OrganizationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
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
              as OrganizationUrls?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationModelImpl implements _OrganizationModel {
  const _$OrganizationModelImpl(
      {required this.id,
      required this.title,
      this.createdAt,
      this.updatedAt,
      this.urls});

  factory _$OrganizationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final OrganizationUrls? urls;

  @override
  String toString() {
    return 'OrganizationModel(id: $id, title: $title, createdAt: $createdAt, updatedAt: $updatedAt, urls: $urls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.urls, urls) || other.urls == urls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, createdAt, updatedAt, urls);

  /// Create a copy of OrganizationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationModelImplCopyWith<_$OrganizationModelImpl> get copyWith =>
      __$$OrganizationModelImplCopyWithImpl<_$OrganizationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationModelImplToJson(
      this,
    );
  }
}

abstract class _OrganizationModel implements OrganizationModel {
  const factory _OrganizationModel(
      {required final String id,
      required final String title,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final OrganizationUrls? urls}) = _$OrganizationModelImpl;

  factory _OrganizationModel.fromJson(Map<String, dynamic> json) =
      _$OrganizationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  OrganizationUrls? get urls;

  /// Create a copy of OrganizationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationModelImplCopyWith<_$OrganizationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationUrls _$OrganizationUrlsFromJson(Map<String, dynamic> json) {
  return _OrganizationUrls.fromJson(json);
}

/// @nodoc
mixin _$OrganizationUrls {
  String? get location => throw _privateConstructorUsedError;
  String? get app => throw _privateConstructorUsedError;

  /// Serializes this OrganizationUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationUrlsCopyWith<OrganizationUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationUrlsCopyWith<$Res> {
  factory $OrganizationUrlsCopyWith(
          OrganizationUrls value, $Res Function(OrganizationUrls) then) =
      _$OrganizationUrlsCopyWithImpl<$Res, OrganizationUrls>;
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class _$OrganizationUrlsCopyWithImpl<$Res, $Val extends OrganizationUrls>
    implements $OrganizationUrlsCopyWith<$Res> {
  _$OrganizationUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationUrls
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
abstract class _$$OrganizationUrlsImplCopyWith<$Res>
    implements $OrganizationUrlsCopyWith<$Res> {
  factory _$$OrganizationUrlsImplCopyWith(_$OrganizationUrlsImpl value,
          $Res Function(_$OrganizationUrlsImpl) then) =
      __$$OrganizationUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class __$$OrganizationUrlsImplCopyWithImpl<$Res>
    extends _$OrganizationUrlsCopyWithImpl<$Res, _$OrganizationUrlsImpl>
    implements _$$OrganizationUrlsImplCopyWith<$Res> {
  __$$OrganizationUrlsImplCopyWithImpl(_$OrganizationUrlsImpl _value,
      $Res Function(_$OrganizationUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
  }) {
    return _then(_$OrganizationUrlsImpl(
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
class _$OrganizationUrlsImpl implements _OrganizationUrls {
  const _$OrganizationUrlsImpl({this.location, this.app});

  factory _$OrganizationUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationUrlsImplFromJson(json);

  @override
  final String? location;
  @override
  final String? app;

  @override
  String toString() {
    return 'OrganizationUrls(location: $location, app: $app)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationUrlsImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.app, app) || other.app == app));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, app);

  /// Create a copy of OrganizationUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationUrlsImplCopyWith<_$OrganizationUrlsImpl> get copyWith =>
      __$$OrganizationUrlsImplCopyWithImpl<_$OrganizationUrlsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationUrlsImplToJson(
      this,
    );
  }
}

abstract class _OrganizationUrls implements OrganizationUrls {
  const factory _OrganizationUrls({final String? location, final String? app}) =
      _$OrganizationUrlsImpl;

  factory _OrganizationUrls.fromJson(Map<String, dynamic> json) =
      _$OrganizationUrlsImpl.fromJson;

  @override
  String? get location;
  @override
  String? get app;

  /// Create a copy of OrganizationUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationUrlsImplCopyWith<_$OrganizationUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationsListResponse _$OrganizationsListResponseFromJson(
    Map<String, dynamic> json) {
  return _OrganizationsListResponse.fromJson(json);
}

/// @nodoc
mixin _$OrganizationsListResponse {
  List<OrganizationModel> get items => throw _privateConstructorUsedError;
  PageInfo? get next => throw _privateConstructorUsedError;

  /// Serializes this OrganizationsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationsListResponseCopyWith<OrganizationsListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationsListResponseCopyWith<$Res> {
  factory $OrganizationsListResponseCopyWith(OrganizationsListResponse value,
          $Res Function(OrganizationsListResponse) then) =
      _$OrganizationsListResponseCopyWithImpl<$Res, OrganizationsListResponse>;
  @useResult
  $Res call({List<OrganizationModel> items, PageInfo? next});

  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class _$OrganizationsListResponseCopyWithImpl<$Res,
        $Val extends OrganizationsListResponse>
    implements $OrganizationsListResponseCopyWith<$Res> {
  _$OrganizationsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationsListResponse
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
              as List<OrganizationModel>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ) as $Val);
  }

  /// Create a copy of OrganizationsListResponse
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
abstract class _$$OrganizationsListResponseImplCopyWith<$Res>
    implements $OrganizationsListResponseCopyWith<$Res> {
  factory _$$OrganizationsListResponseImplCopyWith(
          _$OrganizationsListResponseImpl value,
          $Res Function(_$OrganizationsListResponseImpl) then) =
      __$$OrganizationsListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrganizationModel> items, PageInfo? next});

  @override
  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class __$$OrganizationsListResponseImplCopyWithImpl<$Res>
    extends _$OrganizationsListResponseCopyWithImpl<$Res,
        _$OrganizationsListResponseImpl>
    implements _$$OrganizationsListResponseImplCopyWith<$Res> {
  __$$OrganizationsListResponseImplCopyWithImpl(
      _$OrganizationsListResponseImpl _value,
      $Res Function(_$OrganizationsListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? next = freezed,
  }) {
    return _then(_$OrganizationsListResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrganizationModel>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationsListResponseImpl implements _OrganizationsListResponse {
  const _$OrganizationsListResponseImpl(
      {required final List<OrganizationModel> items, this.next})
      : _items = items;

  factory _$OrganizationsListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationsListResponseImplFromJson(json);

  final List<OrganizationModel> _items;
  @override
  List<OrganizationModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final PageInfo? next;

  @override
  String toString() {
    return 'OrganizationsListResponse(items: $items, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationsListResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.next, next) || other.next == next));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), next);

  /// Create a copy of OrganizationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationsListResponseImplCopyWith<_$OrganizationsListResponseImpl>
      get copyWith => __$$OrganizationsListResponseImplCopyWithImpl<
          _$OrganizationsListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationsListResponseImplToJson(
      this,
    );
  }
}

abstract class _OrganizationsListResponse implements OrganizationsListResponse {
  const factory _OrganizationsListResponse(
      {required final List<OrganizationModel> items,
      final PageInfo? next}) = _$OrganizationsListResponseImpl;

  factory _OrganizationsListResponse.fromJson(Map<String, dynamic> json) =
      _$OrganizationsListResponseImpl.fromJson;

  @override
  List<OrganizationModel> get items;
  @override
  PageInfo? get next;

  /// Create a copy of OrganizationsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationsListResponseImplCopyWith<_$OrganizationsListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

OrganizationMember _$OrganizationMemberFromJson(Map<String, dynamic> json) {
  return _OrganizationMember.fromJson(json);
}

/// @nodoc
mixin _$OrganizationMember {
  String get id => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  UserInfo? get user => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this OrganizationMember to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationMemberCopyWith<OrganizationMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationMemberCopyWith<$Res> {
  factory $OrganizationMemberCopyWith(
          OrganizationMember value, $Res Function(OrganizationMember) then) =
      _$OrganizationMemberCopyWithImpl<$Res, OrganizationMember>;
  @useResult
  $Res call({String id, String role, UserInfo? user, DateTime? createdAt});

  $UserInfoCopyWith<$Res>? get user;
}

/// @nodoc
class _$OrganizationMemberCopyWithImpl<$Res, $Val extends OrganizationMember>
    implements $OrganizationMemberCopyWith<$Res> {
  _$OrganizationMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? user = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserInfoCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrganizationMemberImplCopyWith<$Res>
    implements $OrganizationMemberCopyWith<$Res> {
  factory _$$OrganizationMemberImplCopyWith(_$OrganizationMemberImpl value,
          $Res Function(_$OrganizationMemberImpl) then) =
      __$$OrganizationMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String role, UserInfo? user, DateTime? createdAt});

  @override
  $UserInfoCopyWith<$Res>? get user;
}

/// @nodoc
class __$$OrganizationMemberImplCopyWithImpl<$Res>
    extends _$OrganizationMemberCopyWithImpl<$Res, _$OrganizationMemberImpl>
    implements _$$OrganizationMemberImplCopyWith<$Res> {
  __$$OrganizationMemberImplCopyWithImpl(_$OrganizationMemberImpl _value,
      $Res Function(_$OrganizationMemberImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? user = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$OrganizationMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfo?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationMemberImpl implements _OrganizationMember {
  const _$OrganizationMemberImpl(
      {required this.id, required this.role, this.user, this.createdAt});

  factory _$OrganizationMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrganizationMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String role;
  @override
  final UserInfo? user;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'OrganizationMember(id: $id, role: $role, user: $user, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, role, user, createdAt);

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationMemberImplCopyWith<_$OrganizationMemberImpl> get copyWith =>
      __$$OrganizationMemberImplCopyWithImpl<_$OrganizationMemberImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationMemberImplToJson(
      this,
    );
  }
}

abstract class _OrganizationMember implements OrganizationMember {
  const factory _OrganizationMember(
      {required final String id,
      required final String role,
      final UserInfo? user,
      final DateTime? createdAt}) = _$OrganizationMemberImpl;

  factory _OrganizationMember.fromJson(Map<String, dynamic> json) =
      _$OrganizationMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get role;
  @override
  UserInfo? get user;
  @override
  DateTime? get createdAt;

  /// Create a copy of OrganizationMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationMemberImplCopyWith<_$OrganizationMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
mixin _$UserInfo {
  String get id => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  /// Serializes this UserInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res, UserInfo>;
  @useResult
  $Res call({String id, String? displayName, String? email, String? photoUrl});
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res, $Val extends UserInfo>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfo
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
abstract class _$$UserInfoImplCopyWith<$Res>
    implements $UserInfoCopyWith<$Res> {
  factory _$$UserInfoImplCopyWith(
          _$UserInfoImpl value, $Res Function(_$UserInfoImpl) then) =
      __$$UserInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? displayName, String? email, String? photoUrl});
}

/// @nodoc
class __$$UserInfoImplCopyWithImpl<$Res>
    extends _$UserInfoCopyWithImpl<$Res, _$UserInfoImpl>
    implements _$$UserInfoImplCopyWith<$Res> {
  __$$UserInfoImplCopyWithImpl(
      _$UserInfoImpl _value, $Res Function(_$UserInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_$UserInfoImpl(
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
class _$UserInfoImpl implements _UserInfo {
  const _$UserInfoImpl(
      {required this.id, this.displayName, this.email, this.photoUrl});

  factory _$UserInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoImplFromJson(json);

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
    return 'UserInfo(id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoImpl &&
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

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoImplCopyWith<_$UserInfoImpl> get copyWith =>
      __$$UserInfoImplCopyWithImpl<_$UserInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoImplToJson(
      this,
    );
  }
}

abstract class _UserInfo implements UserInfo {
  const factory _UserInfo(
      {required final String id,
      final String? displayName,
      final String? email,
      final String? photoUrl}) = _$UserInfoImpl;

  factory _UserInfo.fromJson(Map<String, dynamic> json) =
      _$UserInfoImpl.fromJson;

  @override
  String get id;
  @override
  String? get displayName;
  @override
  String? get email;
  @override
  String? get photoUrl;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoImplCopyWith<_$UserInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrganizationMembersResponse _$OrganizationMembersResponseFromJson(
    Map<String, dynamic> json) {
  return _OrganizationMembersResponse.fromJson(json);
}

/// @nodoc
mixin _$OrganizationMembersResponse {
  List<OrganizationMember> get items => throw _privateConstructorUsedError;
  PageInfo? get next => throw _privateConstructorUsedError;

  /// Serializes this OrganizationMembersResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrganizationMembersResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrganizationMembersResponseCopyWith<OrganizationMembersResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrganizationMembersResponseCopyWith<$Res> {
  factory $OrganizationMembersResponseCopyWith(
          OrganizationMembersResponse value,
          $Res Function(OrganizationMembersResponse) then) =
      _$OrganizationMembersResponseCopyWithImpl<$Res,
          OrganizationMembersResponse>;
  @useResult
  $Res call({List<OrganizationMember> items, PageInfo? next});

  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class _$OrganizationMembersResponseCopyWithImpl<$Res,
        $Val extends OrganizationMembersResponse>
    implements $OrganizationMembersResponseCopyWith<$Res> {
  _$OrganizationMembersResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrganizationMembersResponse
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
              as List<OrganizationMember>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ) as $Val);
  }

  /// Create a copy of OrganizationMembersResponse
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
abstract class _$$OrganizationMembersResponseImplCopyWith<$Res>
    implements $OrganizationMembersResponseCopyWith<$Res> {
  factory _$$OrganizationMembersResponseImplCopyWith(
          _$OrganizationMembersResponseImpl value,
          $Res Function(_$OrganizationMembersResponseImpl) then) =
      __$$OrganizationMembersResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OrganizationMember> items, PageInfo? next});

  @override
  $PageInfoCopyWith<$Res>? get next;
}

/// @nodoc
class __$$OrganizationMembersResponseImplCopyWithImpl<$Res>
    extends _$OrganizationMembersResponseCopyWithImpl<$Res,
        _$OrganizationMembersResponseImpl>
    implements _$$OrganizationMembersResponseImplCopyWith<$Res> {
  __$$OrganizationMembersResponseImplCopyWithImpl(
      _$OrganizationMembersResponseImpl _value,
      $Res Function(_$OrganizationMembersResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrganizationMembersResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? next = freezed,
  }) {
    return _then(_$OrganizationMembersResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrganizationMember>,
      next: freezed == next
          ? _value.next
          : next // ignore: cast_nullable_to_non_nullable
              as PageInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrganizationMembersResponseImpl
    implements _OrganizationMembersResponse {
  const _$OrganizationMembersResponseImpl(
      {required final List<OrganizationMember> items, this.next})
      : _items = items;

  factory _$OrganizationMembersResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OrganizationMembersResponseImplFromJson(json);

  final List<OrganizationMember> _items;
  @override
  List<OrganizationMember> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final PageInfo? next;

  @override
  String toString() {
    return 'OrganizationMembersResponse(items: $items, next: $next)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrganizationMembersResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.next, next) || other.next == next));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), next);

  /// Create a copy of OrganizationMembersResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrganizationMembersResponseImplCopyWith<_$OrganizationMembersResponseImpl>
      get copyWith => __$$OrganizationMembersResponseImplCopyWithImpl<
          _$OrganizationMembersResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrganizationMembersResponseImplToJson(
      this,
    );
  }
}

abstract class _OrganizationMembersResponse
    implements OrganizationMembersResponse {
  const factory _OrganizationMembersResponse(
      {required final List<OrganizationMember> items,
      final PageInfo? next}) = _$OrganizationMembersResponseImpl;

  factory _OrganizationMembersResponse.fromJson(Map<String, dynamic> json) =
      _$OrganizationMembersResponseImpl.fromJson;

  @override
  List<OrganizationMember> get items;
  @override
  PageInfo? get next;

  /// Create a copy of OrganizationMembersResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrganizationMembersResponseImplCopyWith<_$OrganizationMembersResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
