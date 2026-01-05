import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_entity.freezed.dart';

/// Space visibility options
enum SpaceVisibility {
  public,
  unlisted,
  shareLink,
  visitorAuth,
  inCollection,
  private,
}

/// Space entity for domain layer
@freezed
class Space with _$Space {
  const factory Space({
    required String id,
    required String title,
    String? description,
    SpaceVisibility? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? organizationId,
    String? appUrl,
    String? publishedUrl,
  }) = _Space;

  const Space._();

  /// Check if space is public
  bool get isPublic => visibility == SpaceVisibility.public;

  /// Check if space is private
  bool get isPrivate => visibility == SpaceVisibility.private;
}

/// Recent space item for quick access
@freezed
class RecentSpaceItem with _$RecentSpaceItem {
  const factory RecentSpaceItem({
    required String id,
    required String title,
    String? organizationId,
    String? organizationTitle,
    required DateTime accessedAt,
  }) = _RecentSpaceItem;
}
