// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) {
  return _ContentModel.fromJson(json);
}

/// @nodoc
mixin _$ContentModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ContentType get type => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  ContentUrls? get urls => throw _privateConstructorUsedError;
  List<ContentModel>? get pages => throw _privateConstructorUsedError;

  /// Serializes this ContentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentModelCopyWith<ContentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentModelCopyWith<$Res> {
  factory $ContentModelCopyWith(
          ContentModel value, $Res Function(ContentModel) then) =
      _$ContentModelCopyWithImpl<$Res, ContentModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      ContentType type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      ContentUrls? urls,
      List<ContentModel>? pages});

  $ContentUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class _$ContentModelCopyWithImpl<$Res, $Val extends ContentModel>
    implements $ContentModelCopyWith<$Res> {
  _$ContentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? path = freezed,
    Object? slug = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? urls = freezed,
    Object? pages = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
              as ContentUrls?,
      pages: freezed == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<ContentModel>?,
    ) as $Val);
  }

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentUrlsCopyWith<$Res>? get urls {
    if (_value.urls == null) {
      return null;
    }

    return $ContentUrlsCopyWith<$Res>(_value.urls!, (value) {
      return _then(_value.copyWith(urls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ContentModelImplCopyWith<$Res>
    implements $ContentModelCopyWith<$Res> {
  factory _$$ContentModelImplCopyWith(
          _$ContentModelImpl value, $Res Function(_$ContentModelImpl) then) =
      __$$ContentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      ContentType type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      ContentUrls? urls,
      List<ContentModel>? pages});

  @override
  $ContentUrlsCopyWith<$Res>? get urls;
}

/// @nodoc
class __$$ContentModelImplCopyWithImpl<$Res>
    extends _$ContentModelCopyWithImpl<$Res, _$ContentModelImpl>
    implements _$$ContentModelImplCopyWith<$Res> {
  __$$ContentModelImplCopyWithImpl(
      _$ContentModelImpl _value, $Res Function(_$ContentModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = null,
    Object? path = freezed,
    Object? slug = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? urls = freezed,
    Object? pages = freezed,
  }) {
    return _then(_$ContentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
              as ContentUrls?,
      pages: freezed == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<ContentModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentModelImpl implements _ContentModel {
  const _$ContentModelImpl(
      {required this.id,
      required this.title,
      required this.type,
      this.path,
      this.slug,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.urls,
      final List<ContentModel>? pages})
      : _pages = pages;

  factory _$ContentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final ContentType type;
  @override
  final String? path;
  @override
  final String? slug;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final ContentUrls? urls;
  final List<ContentModel>? _pages;
  @override
  List<ContentModel>? get pages {
    final value = _pages;
    if (value == null) return null;
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ContentModel(id: $id, title: $title, type: $type, path: $path, slug: $slug, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, urls: $urls, pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.urls, urls) || other.urls == urls) &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      type,
      path,
      slug,
      description,
      createdAt,
      updatedAt,
      urls,
      const DeepCollectionEquality().hash(_pages));

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentModelImplCopyWith<_$ContentModelImpl> get copyWith =>
      __$$ContentModelImplCopyWithImpl<_$ContentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentModelImplToJson(
      this,
    );
  }
}

abstract class _ContentModel implements ContentModel {
  const factory _ContentModel(
      {required final String id,
      required final String title,
      required final ContentType type,
      final String? path,
      final String? slug,
      final String? description,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final ContentUrls? urls,
      final List<ContentModel>? pages}) = _$ContentModelImpl;

  factory _ContentModel.fromJson(Map<String, dynamic> json) =
      _$ContentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  ContentType get type;
  @override
  String? get path;
  @override
  String? get slug;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  ContentUrls? get urls;
  @override
  List<ContentModel>? get pages;

  /// Create a copy of ContentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentModelImplCopyWith<_$ContentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ContentUrls _$ContentUrlsFromJson(Map<String, dynamic> json) {
  return _ContentUrls.fromJson(json);
}

/// @nodoc
mixin _$ContentUrls {
  String? get location => throw _privateConstructorUsedError;
  String? get app => throw _privateConstructorUsedError;

  /// Serializes this ContentUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentUrlsCopyWith<ContentUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentUrlsCopyWith<$Res> {
  factory $ContentUrlsCopyWith(
          ContentUrls value, $Res Function(ContentUrls) then) =
      _$ContentUrlsCopyWithImpl<$Res, ContentUrls>;
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class _$ContentUrlsCopyWithImpl<$Res, $Val extends ContentUrls>
    implements $ContentUrlsCopyWith<$Res> {
  _$ContentUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentUrls
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
abstract class _$$ContentUrlsImplCopyWith<$Res>
    implements $ContentUrlsCopyWith<$Res> {
  factory _$$ContentUrlsImplCopyWith(
          _$ContentUrlsImpl value, $Res Function(_$ContentUrlsImpl) then) =
      __$$ContentUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? location, String? app});
}

/// @nodoc
class __$$ContentUrlsImplCopyWithImpl<$Res>
    extends _$ContentUrlsCopyWithImpl<$Res, _$ContentUrlsImpl>
    implements _$$ContentUrlsImplCopyWith<$Res> {
  __$$ContentUrlsImplCopyWithImpl(
      _$ContentUrlsImpl _value, $Res Function(_$ContentUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? app = freezed,
  }) {
    return _then(_$ContentUrlsImpl(
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
class _$ContentUrlsImpl implements _ContentUrls {
  const _$ContentUrlsImpl({this.location, this.app});

  factory _$ContentUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentUrlsImplFromJson(json);

  @override
  final String? location;
  @override
  final String? app;

  @override
  String toString() {
    return 'ContentUrls(location: $location, app: $app)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentUrlsImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.app, app) || other.app == app));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, app);

  /// Create a copy of ContentUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentUrlsImplCopyWith<_$ContentUrlsImpl> get copyWith =>
      __$$ContentUrlsImplCopyWithImpl<_$ContentUrlsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentUrlsImplToJson(
      this,
    );
  }
}

abstract class _ContentUrls implements ContentUrls {
  const factory _ContentUrls({final String? location, final String? app}) =
      _$ContentUrlsImpl;

  factory _ContentUrls.fromJson(Map<String, dynamic> json) =
      _$ContentUrlsImpl.fromJson;

  @override
  String? get location;
  @override
  String? get app;

  /// Create a copy of ContentUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentUrlsImplCopyWith<_$ContentUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpaceContentResponse _$SpaceContentResponseFromJson(Map<String, dynamic> json) {
  return _SpaceContentResponse.fromJson(json);
}

/// @nodoc
mixin _$SpaceContentResponse {
  List<ContentModel> get pages => throw _privateConstructorUsedError;

  /// Serializes this SpaceContentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpaceContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceContentResponseCopyWith<SpaceContentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceContentResponseCopyWith<$Res> {
  factory $SpaceContentResponseCopyWith(SpaceContentResponse value,
          $Res Function(SpaceContentResponse) then) =
      _$SpaceContentResponseCopyWithImpl<$Res, SpaceContentResponse>;
  @useResult
  $Res call({List<ContentModel> pages});
}

/// @nodoc
class _$SpaceContentResponseCopyWithImpl<$Res,
        $Val extends SpaceContentResponse>
    implements $SpaceContentResponseCopyWith<$Res> {
  _$SpaceContentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpaceContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
  }) {
    return _then(_value.copyWith(
      pages: null == pages
          ? _value.pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<ContentModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpaceContentResponseImplCopyWith<$Res>
    implements $SpaceContentResponseCopyWith<$Res> {
  factory _$$SpaceContentResponseImplCopyWith(_$SpaceContentResponseImpl value,
          $Res Function(_$SpaceContentResponseImpl) then) =
      __$$SpaceContentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ContentModel> pages});
}

/// @nodoc
class __$$SpaceContentResponseImplCopyWithImpl<$Res>
    extends _$SpaceContentResponseCopyWithImpl<$Res, _$SpaceContentResponseImpl>
    implements _$$SpaceContentResponseImplCopyWith<$Res> {
  __$$SpaceContentResponseImplCopyWithImpl(_$SpaceContentResponseImpl _value,
      $Res Function(_$SpaceContentResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pages = null,
  }) {
    return _then(_$SpaceContentResponseImpl(
      pages: null == pages
          ? _value._pages
          : pages // ignore: cast_nullable_to_non_nullable
              as List<ContentModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpaceContentResponseImpl implements _SpaceContentResponse {
  const _$SpaceContentResponseImpl({required final List<ContentModel> pages})
      : _pages = pages;

  factory _$SpaceContentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpaceContentResponseImplFromJson(json);

  final List<ContentModel> _pages;
  @override
  List<ContentModel> get pages {
    if (_pages is EqualUnmodifiableListView) return _pages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pages);
  }

  @override
  String toString() {
    return 'SpaceContentResponse(pages: $pages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceContentResponseImpl &&
            const DeepCollectionEquality().equals(other._pages, _pages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_pages));

  /// Create a copy of SpaceContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceContentResponseImplCopyWith<_$SpaceContentResponseImpl>
      get copyWith =>
          __$$SpaceContentResponseImplCopyWithImpl<_$SpaceContentResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpaceContentResponseImplToJson(
      this,
    );
  }
}

abstract class _SpaceContentResponse implements SpaceContentResponse {
  const factory _SpaceContentResponse(
      {required final List<ContentModel> pages}) = _$SpaceContentResponseImpl;

  factory _SpaceContentResponse.fromJson(Map<String, dynamic> json) =
      _$SpaceContentResponseImpl.fromJson;

  @override
  List<ContentModel> get pages;

  /// Create a copy of SpaceContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceContentResponseImplCopyWith<_$SpaceContentResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

DocumentContent _$DocumentContentFromJson(Map<String, dynamic> json) {
  return _DocumentContent.fromJson(json);
}

/// @nodoc
mixin _$DocumentContent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ContentType? get type => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DocumentBody? get document => throw _privateConstructorUsedError;

  /// Serializes this DocumentContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentContentCopyWith<DocumentContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentContentCopyWith<$Res> {
  factory $DocumentContentCopyWith(
          DocumentContent value, $Res Function(DocumentContent) then) =
      _$DocumentContentCopyWithImpl<$Res, DocumentContent>;
  @useResult
  $Res call(
      {String id,
      String title,
      ContentType? type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      DocumentBody? document});

  $DocumentBodyCopyWith<$Res>? get document;
}

/// @nodoc
class _$DocumentContentCopyWithImpl<$Res, $Val extends DocumentContent>
    implements $DocumentContentCopyWith<$Res> {
  _$DocumentContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = freezed,
    Object? path = freezed,
    Object? slug = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? document = freezed,
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as DocumentBody?,
    ) as $Val);
  }

  /// Create a copy of DocumentContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentBodyCopyWith<$Res>? get document {
    if (_value.document == null) {
      return null;
    }

    return $DocumentBodyCopyWith<$Res>(_value.document!, (value) {
      return _then(_value.copyWith(document: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DocumentContentImplCopyWith<$Res>
    implements $DocumentContentCopyWith<$Res> {
  factory _$$DocumentContentImplCopyWith(_$DocumentContentImpl value,
          $Res Function(_$DocumentContentImpl) then) =
      __$$DocumentContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      ContentType? type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      DocumentBody? document});

  @override
  $DocumentBodyCopyWith<$Res>? get document;
}

/// @nodoc
class __$$DocumentContentImplCopyWithImpl<$Res>
    extends _$DocumentContentCopyWithImpl<$Res, _$DocumentContentImpl>
    implements _$$DocumentContentImplCopyWith<$Res> {
  __$$DocumentContentImplCopyWithImpl(
      _$DocumentContentImpl _value, $Res Function(_$DocumentContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? type = freezed,
    Object? path = freezed,
    Object? slug = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? document = freezed,
  }) {
    return _then(_$DocumentContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType?,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as DocumentBody?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentContentImpl implements _DocumentContent {
  const _$DocumentContentImpl(
      {required this.id,
      required this.title,
      this.type,
      this.path,
      this.slug,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.document});

  factory _$DocumentContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentContentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final ContentType? type;
  @override
  final String? path;
  @override
  final String? slug;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DocumentBody? document;

  @override
  String toString() {
    return 'DocumentContent(id: $id, title: $title, type: $type, path: $path, slug: $slug, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, document: $document)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.document, document) ||
                other.document == document));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, type, path, slug,
      description, createdAt, updatedAt, document);

  /// Create a copy of DocumentContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentContentImplCopyWith<_$DocumentContentImpl> get copyWith =>
      __$$DocumentContentImplCopyWithImpl<_$DocumentContentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentContentImplToJson(
      this,
    );
  }
}

abstract class _DocumentContent implements DocumentContent {
  const factory _DocumentContent(
      {required final String id,
      required final String title,
      final ContentType? type,
      final String? path,
      final String? slug,
      final String? description,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DocumentBody? document}) = _$DocumentContentImpl;

  factory _DocumentContent.fromJson(Map<String, dynamic> json) =
      _$DocumentContentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  ContentType? get type;
  @override
  String? get path;
  @override
  String? get slug;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DocumentBody? get document;

  /// Create a copy of DocumentContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentContentImplCopyWith<_$DocumentContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DocumentBody _$DocumentBodyFromJson(Map<String, dynamic> json) {
  return _DocumentBody.fromJson(json);
}

/// @nodoc
mixin _$DocumentBody {
  /// The document content in GitBook's JSON format
  Map<String, dynamic>? get nodes => throw _privateConstructorUsedError;

  /// Markdown representation (if available)
  String? get markdown => throw _privateConstructorUsedError;

  /// Serializes this DocumentBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentBodyCopyWith<DocumentBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentBodyCopyWith<$Res> {
  factory $DocumentBodyCopyWith(
          DocumentBody value, $Res Function(DocumentBody) then) =
      _$DocumentBodyCopyWithImpl<$Res, DocumentBody>;
  @useResult
  $Res call({Map<String, dynamic>? nodes, String? markdown});
}

/// @nodoc
class _$DocumentBodyCopyWithImpl<$Res, $Val extends DocumentBody>
    implements $DocumentBodyCopyWith<$Res> {
  _$DocumentBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = freezed,
    Object? markdown = freezed,
  }) {
    return _then(_value.copyWith(
      nodes: freezed == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      markdown: freezed == markdown
          ? _value.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DocumentBodyImplCopyWith<$Res>
    implements $DocumentBodyCopyWith<$Res> {
  factory _$$DocumentBodyImplCopyWith(
          _$DocumentBodyImpl value, $Res Function(_$DocumentBodyImpl) then) =
      __$$DocumentBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic>? nodes, String? markdown});
}

/// @nodoc
class __$$DocumentBodyImplCopyWithImpl<$Res>
    extends _$DocumentBodyCopyWithImpl<$Res, _$DocumentBodyImpl>
    implements _$$DocumentBodyImplCopyWith<$Res> {
  __$$DocumentBodyImplCopyWithImpl(
      _$DocumentBodyImpl _value, $Res Function(_$DocumentBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of DocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = freezed,
    Object? markdown = freezed,
  }) {
    return _then(_$DocumentBodyImpl(
      nodes: freezed == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      markdown: freezed == markdown
          ? _value.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentBodyImpl implements _DocumentBody {
  const _$DocumentBodyImpl({final Map<String, dynamic>? nodes, this.markdown})
      : _nodes = nodes;

  factory _$DocumentBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DocumentBodyImplFromJson(json);

  /// The document content in GitBook's JSON format
  final Map<String, dynamic>? _nodes;

  /// The document content in GitBook's JSON format
  @override
  Map<String, dynamic>? get nodes {
    final value = _nodes;
    if (value == null) return null;
    if (_nodes is EqualUnmodifiableMapView) return _nodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Markdown representation (if available)
  @override
  final String? markdown;

  @override
  String toString() {
    return 'DocumentBody(nodes: $nodes, markdown: $markdown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentBodyImpl &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            (identical(other.markdown, markdown) ||
                other.markdown == markdown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_nodes), markdown);

  /// Create a copy of DocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentBodyImplCopyWith<_$DocumentBodyImpl> get copyWith =>
      __$$DocumentBodyImplCopyWithImpl<_$DocumentBodyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentBodyImplToJson(
      this,
    );
  }
}

abstract class _DocumentBody implements DocumentBody {
  const factory _DocumentBody(
      {final Map<String, dynamic>? nodes,
      final String? markdown}) = _$DocumentBodyImpl;

  factory _DocumentBody.fromJson(Map<String, dynamic> json) =
      _$DocumentBodyImpl.fromJson;

  /// The document content in GitBook's JSON format
  @override
  Map<String, dynamic>? get nodes;

  /// Markdown representation (if available)
  @override
  String? get markdown;

  /// Create a copy of DocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentBodyImplCopyWith<_$DocumentBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreatePageRequest _$CreatePageRequestFromJson(Map<String, dynamic> json) {
  return _CreatePageRequest.fromJson(json);
}

/// @nodoc
mixin _$CreatePageRequest {
  String get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  ContentType? get type => throw _privateConstructorUsedError;

  /// Parent page ID for nested pages
  String? get parent => throw _privateConstructorUsedError;

  /// Serializes this CreatePageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatePageRequestCopyWith<CreatePageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePageRequestCopyWith<$Res> {
  factory $CreatePageRequestCopyWith(
          CreatePageRequest value, $Res Function(CreatePageRequest) then) =
      _$CreatePageRequestCopyWithImpl<$Res, CreatePageRequest>;
  @useResult
  $Res call(
      {String title,
      String? slug,
      String? description,
      ContentType? type,
      String? parent});
}

/// @nodoc
class _$CreatePageRequestCopyWithImpl<$Res, $Val extends CreatePageRequest>
    implements $CreatePageRequestCopyWith<$Res> {
  _$CreatePageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? parent = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType?,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatePageRequestImplCopyWith<$Res>
    implements $CreatePageRequestCopyWith<$Res> {
  factory _$$CreatePageRequestImplCopyWith(_$CreatePageRequestImpl value,
          $Res Function(_$CreatePageRequestImpl) then) =
      __$$CreatePageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? slug,
      String? description,
      ContentType? type,
      String? parent});
}

/// @nodoc
class __$$CreatePageRequestImplCopyWithImpl<$Res>
    extends _$CreatePageRequestCopyWithImpl<$Res, _$CreatePageRequestImpl>
    implements _$$CreatePageRequestImplCopyWith<$Res> {
  __$$CreatePageRequestImplCopyWithImpl(_$CreatePageRequestImpl _value,
      $Res Function(_$CreatePageRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? slug = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? parent = freezed,
  }) {
    return _then(_$CreatePageRequestImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentType?,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreatePageRequestImpl implements _CreatePageRequest {
  const _$CreatePageRequestImpl(
      {required this.title,
      this.slug,
      this.description,
      this.type,
      this.parent});

  factory _$CreatePageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreatePageRequestImplFromJson(json);

  @override
  final String title;
  @override
  final String? slug;
  @override
  final String? description;
  @override
  final ContentType? type;

  /// Parent page ID for nested pages
  @override
  final String? parent;

  @override
  String toString() {
    return 'CreatePageRequest(title: $title, slug: $slug, description: $description, type: $type, parent: $parent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePageRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.parent, parent) || other.parent == parent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, slug, description, type, parent);

  /// Create a copy of CreatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatePageRequestImplCopyWith<_$CreatePageRequestImpl> get copyWith =>
      __$$CreatePageRequestImplCopyWithImpl<_$CreatePageRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatePageRequestImplToJson(
      this,
    );
  }
}

abstract class _CreatePageRequest implements CreatePageRequest {
  const factory _CreatePageRequest(
      {required final String title,
      final String? slug,
      final String? description,
      final ContentType? type,
      final String? parent}) = _$CreatePageRequestImpl;

  factory _CreatePageRequest.fromJson(Map<String, dynamic> json) =
      _$CreatePageRequestImpl.fromJson;

  @override
  String get title;
  @override
  String? get slug;
  @override
  String? get description;
  @override
  ContentType? get type;

  /// Parent page ID for nested pages
  @override
  String? get parent;

  /// Create a copy of CreatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatePageRequestImplCopyWith<_$CreatePageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UpdatePageRequest _$UpdatePageRequestFromJson(Map<String, dynamic> json) {
  return _UpdatePageRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdatePageRequest {
  String? get title => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Document content to update
  Map<String, dynamic>? get document => throw _privateConstructorUsedError;

  /// Serializes this UpdatePageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdatePageRequestCopyWith<UpdatePageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdatePageRequestCopyWith<$Res> {
  factory $UpdatePageRequestCopyWith(
          UpdatePageRequest value, $Res Function(UpdatePageRequest) then) =
      _$UpdatePageRequestCopyWithImpl<$Res, UpdatePageRequest>;
  @useResult
  $Res call(
      {String? title,
      String? slug,
      String? description,
      Map<String, dynamic>? document});
}

/// @nodoc
class _$UpdatePageRequestCopyWithImpl<$Res, $Val extends UpdatePageRequest>
    implements $UpdatePageRequestCopyWith<$Res> {
  _$UpdatePageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? slug = freezed,
    Object? description = freezed,
    Object? document = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      document: freezed == document
          ? _value.document
          : document // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdatePageRequestImplCopyWith<$Res>
    implements $UpdatePageRequestCopyWith<$Res> {
  factory _$$UpdatePageRequestImplCopyWith(_$UpdatePageRequestImpl value,
          $Res Function(_$UpdatePageRequestImpl) then) =
      __$$UpdatePageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? slug,
      String? description,
      Map<String, dynamic>? document});
}

/// @nodoc
class __$$UpdatePageRequestImplCopyWithImpl<$Res>
    extends _$UpdatePageRequestCopyWithImpl<$Res, _$UpdatePageRequestImpl>
    implements _$$UpdatePageRequestImplCopyWith<$Res> {
  __$$UpdatePageRequestImplCopyWithImpl(_$UpdatePageRequestImpl _value,
      $Res Function(_$UpdatePageRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? slug = freezed,
    Object? description = freezed,
    Object? document = freezed,
  }) {
    return _then(_$UpdatePageRequestImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      document: freezed == document
          ? _value._document
          : document // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdatePageRequestImpl implements _UpdatePageRequest {
  const _$UpdatePageRequestImpl(
      {this.title,
      this.slug,
      this.description,
      final Map<String, dynamic>? document})
      : _document = document;

  factory _$UpdatePageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdatePageRequestImplFromJson(json);

  @override
  final String? title;
  @override
  final String? slug;
  @override
  final String? description;

  /// Document content to update
  final Map<String, dynamic>? _document;

  /// Document content to update
  @override
  Map<String, dynamic>? get document {
    final value = _document;
    if (value == null) return null;
    if (_document is EqualUnmodifiableMapView) return _document;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UpdatePageRequest(title: $title, slug: $slug, description: $description, document: $document)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePageRequestImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._document, _document));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, slug, description,
      const DeepCollectionEquality().hash(_document));

  /// Create a copy of UpdatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePageRequestImplCopyWith<_$UpdatePageRequestImpl> get copyWith =>
      __$$UpdatePageRequestImplCopyWithImpl<_$UpdatePageRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdatePageRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdatePageRequest implements UpdatePageRequest {
  const factory _UpdatePageRequest(
      {final String? title,
      final String? slug,
      final String? description,
      final Map<String, dynamic>? document}) = _$UpdatePageRequestImpl;

  factory _UpdatePageRequest.fromJson(Map<String, dynamic> json) =
      _$UpdatePageRequestImpl.fromJson;

  @override
  String? get title;
  @override
  String? get slug;
  @override
  String? get description;

  /// Document content to update
  @override
  Map<String, dynamic>? get document;

  /// Create a copy of UpdatePageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdatePageRequestImplCopyWith<_$UpdatePageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
