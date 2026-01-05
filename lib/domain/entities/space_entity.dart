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
    String? emoji,
    SpaceVisibility? visibility,
    DateTime? createdAt,
    DateTime? updatedAt,
    /// When the space was moved to trash (null if not deleted)
    DateTime? deletedAt,
    String? organizationId,
    String? appUrl,
    String? publishedUrl,
    /// ID of the parent collection (if the space belongs to a collection)
    String? parentId,
  }) = _Space;

  const Space._();

  /// Check if space is public
  bool get isPublic => visibility == SpaceVisibility.public;

  /// Check if space is private
  bool get isPrivate => visibility == SpaceVisibility.private;

  /// Check if space belongs to a collection
  bool get isInCollection => parentId != null;

  /// Check if space is in trash
  bool get isDeleted => deletedAt != null;

  /// Days remaining until permanent deletion (7 days from deletedAt)
  int? get daysUntilPermanentDeletion {
    if (deletedAt == null) return null;
    final permanentDeletionDate = deletedAt!.add(const Duration(days: 7));
    final remaining = permanentDeletionDate.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }
}

/// Collection entity for domain layer
@freezed
class SpaceCollection with _$SpaceCollection {
  const factory SpaceCollection({
    required String id,
    required String title,
    String? description,
    String? emoji,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? organizationId,
  }) = _SpaceCollection;

  const SpaceCollection._();
}

/// A collection with its spaces
@freezed
class CollectionWithSpaces with _$CollectionWithSpaces {
  const factory CollectionWithSpaces({
    required SpaceCollection collection,
    required List<Space> spaces,
  }) = _CollectionWithSpaces;

  const CollectionWithSpaces._();
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
