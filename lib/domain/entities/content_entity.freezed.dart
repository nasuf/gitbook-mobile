// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ContentPage {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  PageType get type => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get appUrl => throw _privateConstructorUsedError;

  /// Child pages for groups/nested structure
  List<ContentPage> get children => throw _privateConstructorUsedError;

  /// Create a copy of ContentPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentPageCopyWith<ContentPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentPageCopyWith<$Res> {
  factory $ContentPageCopyWith(
          ContentPage value, $Res Function(ContentPage) then) =
      _$ContentPageCopyWithImpl<$Res, ContentPage>;
  @useResult
  $Res call(
      {String id,
      String title,
      PageType type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? appUrl,
      List<ContentPage> children});
}

/// @nodoc
class _$ContentPageCopyWithImpl<$Res, $Val extends ContentPage>
    implements $ContentPageCopyWith<$Res> {
  _$ContentPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentPage
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
    Object? appUrl = freezed,
    Object? children = null,
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
              as PageType,
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
      appUrl: freezed == appUrl
          ? _value.appUrl
          : appUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ContentPage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentPageImplCopyWith<$Res>
    implements $ContentPageCopyWith<$Res> {
  factory _$$ContentPageImplCopyWith(
          _$ContentPageImpl value, $Res Function(_$ContentPageImpl) then) =
      __$$ContentPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      PageType type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? appUrl,
      List<ContentPage> children});
}

/// @nodoc
class __$$ContentPageImplCopyWithImpl<$Res>
    extends _$ContentPageCopyWithImpl<$Res, _$ContentPageImpl>
    implements _$$ContentPageImplCopyWith<$Res> {
  __$$ContentPageImplCopyWithImpl(
      _$ContentPageImpl _value, $Res Function(_$ContentPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentPage
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
    Object? appUrl = freezed,
    Object? children = null,
  }) {
    return _then(_$ContentPageImpl(
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
              as PageType,
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
      appUrl: freezed == appUrl
          ? _value.appUrl
          : appUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ContentPage>,
    ));
  }
}

/// @nodoc

class _$ContentPageImpl extends _ContentPage {
  const _$ContentPageImpl(
      {required this.id,
      required this.title,
      required this.type,
      this.path,
      this.slug,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.appUrl,
      final List<ContentPage> children = const []})
      : _children = children,
        super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final PageType type;
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
  final String? appUrl;

  /// Child pages for groups/nested structure
  final List<ContentPage> _children;

  /// Child pages for groups/nested structure
  @override
  @JsonKey()
  List<ContentPage> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  String toString() {
    return 'ContentPage(id: $id, title: $title, type: $type, path: $path, slug: $slug, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, appUrl: $appUrl, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentPageImpl &&
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
            (identical(other.appUrl, appUrl) || other.appUrl == appUrl) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

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
      appUrl,
      const DeepCollectionEquality().hash(_children));

  /// Create a copy of ContentPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentPageImplCopyWith<_$ContentPageImpl> get copyWith =>
      __$$ContentPageImplCopyWithImpl<_$ContentPageImpl>(this, _$identity);
}

abstract class _ContentPage extends ContentPage {
  const factory _ContentPage(
      {required final String id,
      required final String title,
      required final PageType type,
      final String? path,
      final String? slug,
      final String? description,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? appUrl,
      final List<ContentPage> children}) = _$ContentPageImpl;
  const _ContentPage._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  PageType get type;
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
  String? get appUrl;

  /// Child pages for groups/nested structure
  @override
  List<ContentPage> get children;

  /// Create a copy of ContentPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentPageImplCopyWith<_$ContentPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PageContent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  PageType? get type => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Markdown content
  String? get markdown => throw _privateConstructorUsedError;

  /// Raw document nodes (GitBook format)
  Map<String, dynamic>? get documentNodes => throw _privateConstructorUsedError;

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageContentCopyWith<PageContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageContentCopyWith<$Res> {
  factory $PageContentCopyWith(
          PageContent value, $Res Function(PageContent) then) =
      _$PageContentCopyWithImpl<$Res, PageContent>;
  @useResult
  $Res call(
      {String id,
      String title,
      PageType? type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? markdown,
      Map<String, dynamic>? documentNodes});
}

/// @nodoc
class _$PageContentCopyWithImpl<$Res, $Val extends PageContent>
    implements $PageContentCopyWith<$Res> {
  _$PageContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageContent
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
    Object? markdown = freezed,
    Object? documentNodes = freezed,
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
              as PageType?,
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
      markdown: freezed == markdown
          ? _value.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String?,
      documentNodes: freezed == documentNodes
          ? _value.documentNodes
          : documentNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PageContentImplCopyWith<$Res>
    implements $PageContentCopyWith<$Res> {
  factory _$$PageContentImplCopyWith(
          _$PageContentImpl value, $Res Function(_$PageContentImpl) then) =
      __$$PageContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      PageType? type,
      String? path,
      String? slug,
      String? description,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? markdown,
      Map<String, dynamic>? documentNodes});
}

/// @nodoc
class __$$PageContentImplCopyWithImpl<$Res>
    extends _$PageContentCopyWithImpl<$Res, _$PageContentImpl>
    implements _$$PageContentImplCopyWith<$Res> {
  __$$PageContentImplCopyWithImpl(
      _$PageContentImpl _value, $Res Function(_$PageContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of PageContent
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
    Object? markdown = freezed,
    Object? documentNodes = freezed,
  }) {
    return _then(_$PageContentImpl(
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
              as PageType?,
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
      markdown: freezed == markdown
          ? _value.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String?,
      documentNodes: freezed == documentNodes
          ? _value._documentNodes
          : documentNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$PageContentImpl extends _PageContent {
  const _$PageContentImpl(
      {required this.id,
      required this.title,
      this.type,
      this.path,
      this.slug,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.markdown,
      final Map<String, dynamic>? documentNodes})
      : _documentNodes = documentNodes,
        super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final PageType? type;
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

  /// Markdown content
  @override
  final String? markdown;

  /// Raw document nodes (GitBook format)
  final Map<String, dynamic>? _documentNodes;

  /// Raw document nodes (GitBook format)
  @override
  Map<String, dynamic>? get documentNodes {
    final value = _documentNodes;
    if (value == null) return null;
    if (_documentNodes is EqualUnmodifiableMapView) return _documentNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PageContent(id: $id, title: $title, type: $type, path: $path, slug: $slug, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, markdown: $markdown, documentNodes: $documentNodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageContentImpl &&
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
            (identical(other.markdown, markdown) ||
                other.markdown == markdown) &&
            const DeepCollectionEquality()
                .equals(other._documentNodes, _documentNodes));
  }

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
      markdown,
      const DeepCollectionEquality().hash(_documentNodes));

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageContentImplCopyWith<_$PageContentImpl> get copyWith =>
      __$$PageContentImplCopyWithImpl<_$PageContentImpl>(this, _$identity);
}

abstract class _PageContent extends PageContent {
  const factory _PageContent(
      {required final String id,
      required final String title,
      final PageType? type,
      final String? path,
      final String? slug,
      final String? description,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final String? markdown,
      final Map<String, dynamic>? documentNodes}) = _$PageContentImpl;
  const _PageContent._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  PageType? get type;
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

  /// Markdown content
  @override
  String? get markdown;

  /// Raw document nodes (GitBook format)
  @override
  Map<String, dynamic>? get documentNodes;

  /// Create a copy of PageContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageContentImplCopyWith<_$PageContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BreadcrumbItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get path => throw _privateConstructorUsedError;

  /// Create a copy of BreadcrumbItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BreadcrumbItemCopyWith<BreadcrumbItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BreadcrumbItemCopyWith<$Res> {
  factory $BreadcrumbItemCopyWith(
          BreadcrumbItem value, $Res Function(BreadcrumbItem) then) =
      _$BreadcrumbItemCopyWithImpl<$Res, BreadcrumbItem>;
  @useResult
  $Res call({String id, String title, String? path});
}

/// @nodoc
class _$BreadcrumbItemCopyWithImpl<$Res, $Val extends BreadcrumbItem>
    implements $BreadcrumbItemCopyWith<$Res> {
  _$BreadcrumbItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BreadcrumbItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? path = freezed,
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
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BreadcrumbItemImplCopyWith<$Res>
    implements $BreadcrumbItemCopyWith<$Res> {
  factory _$$BreadcrumbItemImplCopyWith(_$BreadcrumbItemImpl value,
          $Res Function(_$BreadcrumbItemImpl) then) =
      __$$BreadcrumbItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String? path});
}

/// @nodoc
class __$$BreadcrumbItemImplCopyWithImpl<$Res>
    extends _$BreadcrumbItemCopyWithImpl<$Res, _$BreadcrumbItemImpl>
    implements _$$BreadcrumbItemImplCopyWith<$Res> {
  __$$BreadcrumbItemImplCopyWithImpl(
      _$BreadcrumbItemImpl _value, $Res Function(_$BreadcrumbItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of BreadcrumbItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? path = freezed,
  }) {
    return _then(_$BreadcrumbItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      path: freezed == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$BreadcrumbItemImpl implements _BreadcrumbItem {
  const _$BreadcrumbItemImpl(
      {required this.id, required this.title, this.path});

  @override
  final String id;
  @override
  final String title;
  @override
  final String? path;

  @override
  String toString() {
    return 'BreadcrumbItem(id: $id, title: $title, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BreadcrumbItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.path, path) || other.path == path));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, path);

  /// Create a copy of BreadcrumbItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BreadcrumbItemImplCopyWith<_$BreadcrumbItemImpl> get copyWith =>
      __$$BreadcrumbItemImplCopyWithImpl<_$BreadcrumbItemImpl>(
          this, _$identity);
}

abstract class _BreadcrumbItem implements BreadcrumbItem {
  const factory _BreadcrumbItem(
      {required final String id,
      required final String title,
      final String? path}) = _$BreadcrumbItemImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get path;

  /// Create a copy of BreadcrumbItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BreadcrumbItemImplCopyWith<_$BreadcrumbItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
