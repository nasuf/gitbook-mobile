// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Space {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get emoji => throw _privateConstructorUsedError;
  SpaceVisibility? get visibility => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// When the space was moved to trash (null if not deleted)
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;
  String? get appUrl => throw _privateConstructorUsedError;
  String? get publishedUrl => throw _privateConstructorUsedError;

  /// ID of the parent collection (if the space belongs to a collection)
  String? get parentId => throw _privateConstructorUsedError;

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceCopyWith<Space> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceCopyWith<$Res> {
  factory $SpaceCopyWith(Space value, $Res Function(Space) then) =
      _$SpaceCopyWithImpl<$Res, Space>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? emoji,
      SpaceVisibility? visibility,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      String? organizationId,
      String? appUrl,
      String? publishedUrl,
      String? parentId});
}

/// @nodoc
class _$SpaceCopyWithImpl<$Res, $Val extends Space>
    implements $SpaceCopyWith<$Res> {
  _$SpaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? emoji = freezed,
    Object? visibility = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? organizationId = freezed,
    Object? appUrl = freezed,
    Object? publishedUrl = freezed,
    Object? parentId = freezed,
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
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      appUrl: freezed == appUrl
          ? _value.appUrl
          : appUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedUrl: freezed == publishedUrl
          ? _value.publishedUrl
          : publishedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpaceImplCopyWith<$Res> implements $SpaceCopyWith<$Res> {
  factory _$$SpaceImplCopyWith(
          _$SpaceImpl value, $Res Function(_$SpaceImpl) then) =
      __$$SpaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? emoji,
      SpaceVisibility? visibility,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      String? organizationId,
      String? appUrl,
      String? publishedUrl,
      String? parentId});
}

/// @nodoc
class __$$SpaceImplCopyWithImpl<$Res>
    extends _$SpaceCopyWithImpl<$Res, _$SpaceImpl>
    implements _$$SpaceImplCopyWith<$Res> {
  __$$SpaceImplCopyWithImpl(
      _$SpaceImpl _value, $Res Function(_$SpaceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? emoji = freezed,
    Object? visibility = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? organizationId = freezed,
    Object? appUrl = freezed,
    Object? publishedUrl = freezed,
    Object? parentId = freezed,
  }) {
    return _then(_$SpaceImpl(
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
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      appUrl: freezed == appUrl
          ? _value.appUrl
          : appUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedUrl: freezed == publishedUrl
          ? _value.publishedUrl
          : publishedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SpaceImpl extends _Space {
  const _$SpaceImpl(
      {required this.id,
      required this.title,
      this.description,
      this.emoji,
      this.visibility,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.organizationId,
      this.appUrl,
      this.publishedUrl,
      this.parentId})
      : super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? emoji;
  @override
  final SpaceVisibility? visibility;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// When the space was moved to trash (null if not deleted)
  @override
  final DateTime? deletedAt;
  @override
  final String? organizationId;
  @override
  final String? appUrl;
  @override
  final String? publishedUrl;

  /// ID of the parent collection (if the space belongs to a collection)
  @override
  final String? parentId;

  @override
  String toString() {
    return 'Space(id: $id, title: $title, description: $description, emoji: $emoji, visibility: $visibility, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, organizationId: $organizationId, appUrl: $appUrl, publishedUrl: $publishedUrl, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.appUrl, appUrl) || other.appUrl == appUrl) &&
            (identical(other.publishedUrl, publishedUrl) ||
                other.publishedUrl == publishedUrl) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      emoji,
      visibility,
      createdAt,
      updatedAt,
      deletedAt,
      organizationId,
      appUrl,
      publishedUrl,
      parentId);

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceImplCopyWith<_$SpaceImpl> get copyWith =>
      __$$SpaceImplCopyWithImpl<_$SpaceImpl>(this, _$identity);
}

abstract class _Space extends Space {
  const factory _Space(
      {required final String id,
      required final String title,
      final String? description,
      final String? emoji,
      final SpaceVisibility? visibility,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? deletedAt,
      final String? organizationId,
      final String? appUrl,
      final String? publishedUrl,
      final String? parentId}) = _$SpaceImpl;
  const _Space._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get emoji;
  @override
  SpaceVisibility? get visibility;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// When the space was moved to trash (null if not deleted)
  @override
  DateTime? get deletedAt;
  @override
  String? get organizationId;
  @override
  String? get appUrl;
  @override
  String? get publishedUrl;

  /// ID of the parent collection (if the space belongs to a collection)
  @override
  String? get parentId;

  /// Create a copy of Space
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceImplCopyWith<_$SpaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SpaceCollection {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get emoji => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;

  /// Create a copy of SpaceCollection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpaceCollectionCopyWith<SpaceCollection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpaceCollectionCopyWith<$Res> {
  factory $SpaceCollectionCopyWith(
          SpaceCollection value, $Res Function(SpaceCollection) then) =
      _$SpaceCollectionCopyWithImpl<$Res, SpaceCollection>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? emoji,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? organizationId});
}

/// @nodoc
class _$SpaceCollectionCopyWithImpl<$Res, $Val extends SpaceCollection>
    implements $SpaceCollectionCopyWith<$Res> {
  _$SpaceCollectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpaceCollection
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
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpaceCollectionImplCopyWith<$Res>
    implements $SpaceCollectionCopyWith<$Res> {
  factory _$$SpaceCollectionImplCopyWith(_$SpaceCollectionImpl value,
          $Res Function(_$SpaceCollectionImpl) then) =
      __$$SpaceCollectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      String? emoji,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? organizationId});
}

/// @nodoc
class __$$SpaceCollectionImplCopyWithImpl<$Res>
    extends _$SpaceCollectionCopyWithImpl<$Res, _$SpaceCollectionImpl>
    implements _$$SpaceCollectionImplCopyWith<$Res> {
  __$$SpaceCollectionImplCopyWithImpl(
      _$SpaceCollectionImpl _value, $Res Function(_$SpaceCollectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpaceCollection
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
    Object? organizationId = freezed,
  }) {
    return _then(_$SpaceCollectionImpl(
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
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SpaceCollectionImpl extends _SpaceCollection {
  const _$SpaceCollectionImpl(
      {required this.id,
      required this.title,
      this.description,
      this.emoji,
      this.createdAt,
      this.updatedAt,
      this.organizationId})
      : super._();

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
  final String? organizationId;

  @override
  String toString() {
    return 'SpaceCollection(id: $id, title: $title, description: $description, emoji: $emoji, createdAt: $createdAt, updatedAt: $updatedAt, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpaceCollectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, emoji,
      createdAt, updatedAt, organizationId);

  /// Create a copy of SpaceCollection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpaceCollectionImplCopyWith<_$SpaceCollectionImpl> get copyWith =>
      __$$SpaceCollectionImplCopyWithImpl<_$SpaceCollectionImpl>(
          this, _$identity);
}

abstract class _SpaceCollection extends SpaceCollection {
  const factory _SpaceCollection(
      {required final String id,
      required final String title,
      final String? description,
      final String? emoji,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? organizationId}) = _$SpaceCollectionImpl;
  const _SpaceCollection._() : super._();

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
  String? get organizationId;

  /// Create a copy of SpaceCollection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpaceCollectionImplCopyWith<_$SpaceCollectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CollectionWithSpaces {
  SpaceCollection get collection => throw _privateConstructorUsedError;
  List<Space> get spaces => throw _privateConstructorUsedError;

  /// Create a copy of CollectionWithSpaces
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CollectionWithSpacesCopyWith<CollectionWithSpaces> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionWithSpacesCopyWith<$Res> {
  factory $CollectionWithSpacesCopyWith(CollectionWithSpaces value,
          $Res Function(CollectionWithSpaces) then) =
      _$CollectionWithSpacesCopyWithImpl<$Res, CollectionWithSpaces>;
  @useResult
  $Res call({SpaceCollection collection, List<Space> spaces});

  $SpaceCollectionCopyWith<$Res> get collection;
}

/// @nodoc
class _$CollectionWithSpacesCopyWithImpl<$Res,
        $Val extends CollectionWithSpaces>
    implements $CollectionWithSpacesCopyWith<$Res> {
  _$CollectionWithSpacesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CollectionWithSpaces
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
    Object? spaces = null,
  }) {
    return _then(_value.copyWith(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as SpaceCollection,
      spaces: null == spaces
          ? _value.spaces
          : spaces // ignore: cast_nullable_to_non_nullable
              as List<Space>,
    ) as $Val);
  }

  /// Create a copy of CollectionWithSpaces
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SpaceCollectionCopyWith<$Res> get collection {
    return $SpaceCollectionCopyWith<$Res>(_value.collection, (value) {
      return _then(_value.copyWith(collection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CollectionWithSpacesImplCopyWith<$Res>
    implements $CollectionWithSpacesCopyWith<$Res> {
  factory _$$CollectionWithSpacesImplCopyWith(_$CollectionWithSpacesImpl value,
          $Res Function(_$CollectionWithSpacesImpl) then) =
      __$$CollectionWithSpacesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SpaceCollection collection, List<Space> spaces});

  @override
  $SpaceCollectionCopyWith<$Res> get collection;
}

/// @nodoc
class __$$CollectionWithSpacesImplCopyWithImpl<$Res>
    extends _$CollectionWithSpacesCopyWithImpl<$Res, _$CollectionWithSpacesImpl>
    implements _$$CollectionWithSpacesImplCopyWith<$Res> {
  __$$CollectionWithSpacesImplCopyWithImpl(_$CollectionWithSpacesImpl _value,
      $Res Function(_$CollectionWithSpacesImpl) _then)
      : super(_value, _then);

  /// Create a copy of CollectionWithSpaces
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = null,
    Object? spaces = null,
  }) {
    return _then(_$CollectionWithSpacesImpl(
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as SpaceCollection,
      spaces: null == spaces
          ? _value._spaces
          : spaces // ignore: cast_nullable_to_non_nullable
              as List<Space>,
    ));
  }
}

/// @nodoc

class _$CollectionWithSpacesImpl extends _CollectionWithSpaces {
  const _$CollectionWithSpacesImpl(
      {required this.collection, required final List<Space> spaces})
      : _spaces = spaces,
        super._();

  @override
  final SpaceCollection collection;
  final List<Space> _spaces;
  @override
  List<Space> get spaces {
    if (_spaces is EqualUnmodifiableListView) return _spaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spaces);
  }

  @override
  String toString() {
    return 'CollectionWithSpaces(collection: $collection, spaces: $spaces)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionWithSpacesImpl &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            const DeepCollectionEquality().equals(other._spaces, _spaces));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, collection, const DeepCollectionEquality().hash(_spaces));

  /// Create a copy of CollectionWithSpaces
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionWithSpacesImplCopyWith<_$CollectionWithSpacesImpl>
      get copyWith =>
          __$$CollectionWithSpacesImplCopyWithImpl<_$CollectionWithSpacesImpl>(
              this, _$identity);
}

abstract class _CollectionWithSpaces extends CollectionWithSpaces {
  const factory _CollectionWithSpaces(
      {required final SpaceCollection collection,
      required final List<Space> spaces}) = _$CollectionWithSpacesImpl;
  const _CollectionWithSpaces._() : super._();

  @override
  SpaceCollection get collection;
  @override
  List<Space> get spaces;

  /// Create a copy of CollectionWithSpaces
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CollectionWithSpacesImplCopyWith<_$CollectionWithSpacesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecentSpaceItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get organizationId => throw _privateConstructorUsedError;
  String? get organizationTitle => throw _privateConstructorUsedError;
  DateTime get accessedAt => throw _privateConstructorUsedError;

  /// Create a copy of RecentSpaceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecentSpaceItemCopyWith<RecentSpaceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentSpaceItemCopyWith<$Res> {
  factory $RecentSpaceItemCopyWith(
          RecentSpaceItem value, $Res Function(RecentSpaceItem) then) =
      _$RecentSpaceItemCopyWithImpl<$Res, RecentSpaceItem>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? organizationId,
      String? organizationTitle,
      DateTime accessedAt});
}

/// @nodoc
class _$RecentSpaceItemCopyWithImpl<$Res, $Val extends RecentSpaceItem>
    implements $RecentSpaceItemCopyWith<$Res> {
  _$RecentSpaceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecentSpaceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? organizationId = freezed,
    Object? organizationTitle = freezed,
    Object? accessedAt = null,
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
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationTitle: freezed == organizationTitle
          ? _value.organizationTitle
          : organizationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      accessedAt: null == accessedAt
          ? _value.accessedAt
          : accessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentSpaceItemImplCopyWith<$Res>
    implements $RecentSpaceItemCopyWith<$Res> {
  factory _$$RecentSpaceItemImplCopyWith(_$RecentSpaceItemImpl value,
          $Res Function(_$RecentSpaceItemImpl) then) =
      __$$RecentSpaceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? organizationId,
      String? organizationTitle,
      DateTime accessedAt});
}

/// @nodoc
class __$$RecentSpaceItemImplCopyWithImpl<$Res>
    extends _$RecentSpaceItemCopyWithImpl<$Res, _$RecentSpaceItemImpl>
    implements _$$RecentSpaceItemImplCopyWith<$Res> {
  __$$RecentSpaceItemImplCopyWithImpl(
      _$RecentSpaceItemImpl _value, $Res Function(_$RecentSpaceItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecentSpaceItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? organizationId = freezed,
    Object? organizationTitle = freezed,
    Object? accessedAt = null,
  }) {
    return _then(_$RecentSpaceItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      organizationId: freezed == organizationId
          ? _value.organizationId
          : organizationId // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationTitle: freezed == organizationTitle
          ? _value.organizationTitle
          : organizationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      accessedAt: null == accessedAt
          ? _value.accessedAt
          : accessedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$RecentSpaceItemImpl implements _RecentSpaceItem {
  const _$RecentSpaceItemImpl(
      {required this.id,
      required this.title,
      this.organizationId,
      this.organizationTitle,
      required this.accessedAt});

  @override
  final String id;
  @override
  final String title;
  @override
  final String? organizationId;
  @override
  final String? organizationTitle;
  @override
  final DateTime accessedAt;

  @override
  String toString() {
    return 'RecentSpaceItem(id: $id, title: $title, organizationId: $organizationId, organizationTitle: $organizationTitle, accessedAt: $accessedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentSpaceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.organizationId, organizationId) ||
                other.organizationId == organizationId) &&
            (identical(other.organizationTitle, organizationTitle) ||
                other.organizationTitle == organizationTitle) &&
            (identical(other.accessedAt, accessedAt) ||
                other.accessedAt == accessedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, organizationId, organizationTitle, accessedAt);

  /// Create a copy of RecentSpaceItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentSpaceItemImplCopyWith<_$RecentSpaceItemImpl> get copyWith =>
      __$$RecentSpaceItemImplCopyWithImpl<_$RecentSpaceItemImpl>(
          this, _$identity);
}

abstract class _RecentSpaceItem implements RecentSpaceItem {
  const factory _RecentSpaceItem(
      {required final String id,
      required final String title,
      final String? organizationId,
      final String? organizationTitle,
      required final DateTime accessedAt}) = _$RecentSpaceItemImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get organizationId;
  @override
  String? get organizationTitle;
  @override
  DateTime get accessedAt;

  /// Create a copy of RecentSpaceItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecentSpaceItemImplCopyWith<_$RecentSpaceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
