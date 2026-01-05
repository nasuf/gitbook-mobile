import '../entities/space_entity.dart';
import '../repositories/space_repository.dart';

/// Use case for getting spaces in an organization
class GetSpacesUseCase {
  final SpaceRepository _repository;

  GetSpacesUseCase(this._repository);

  Future<List<Space>> call(
    String organizationId, {
    bool forceRefresh = false,
  }) {
    return _repository.getSpaces(organizationId, forceRefresh: forceRefresh);
  }
}

/// Use case for getting a single space
class GetSpaceUseCase {
  final SpaceRepository _repository;

  GetSpaceUseCase(this._repository);

  Future<Space> call(String spaceId) {
    return _repository.getSpaceById(spaceId);
  }
}

/// Use case for creating a new space
class CreateSpaceUseCase {
  final SpaceRepository _repository;

  CreateSpaceUseCase(this._repository);

  Future<Space> call({
    required String organizationId,
    required String title,
    String? description,
    SpaceVisibility? visibility,
  }) {
    return _repository.createSpace(
      organizationId: organizationId,
      title: title,
      description: description,
      visibility: visibility,
    );
  }
}

/// Use case for updating a space
class UpdateSpaceUseCase {
  final SpaceRepository _repository;

  UpdateSpaceUseCase(this._repository);

  Future<Space> call(
    String spaceId, {
    String? title,
    String? description,
    SpaceVisibility? visibility,
  }) {
    return _repository.updateSpace(
      spaceId,
      title: title,
      description: description,
      visibility: visibility,
    );
  }
}

/// Use case for deleting a space
class DeleteSpaceUseCase {
  final SpaceRepository _repository;

  DeleteSpaceUseCase(this._repository);

  Future<void> call(String spaceId) {
    return _repository.deleteSpace(spaceId);
  }
}

/// Use case for searching spaces
class SearchSpacesUseCase {
  final SpaceRepository _repository;

  SearchSpacesUseCase(this._repository);

  Future<List<Space>> call(String organizationId, String query) {
    return _repository.searchSpaces(organizationId, query);
  }
}

/// Use case for getting recent spaces
class GetRecentSpacesUseCase {
  final SpaceRepository _repository;

  GetRecentSpacesUseCase(this._repository);

  Future<List<RecentSpaceItem>> call({int limit = 10}) {
    return _repository.getRecentSpaces(limit: limit);
  }
}

/// Use case for adding a space to recent items
class AddToRecentSpacesUseCase {
  final SpaceRepository _repository;

  AddToRecentSpacesUseCase(this._repository);

  Future<void> call(Space space, {String? organizationTitle}) {
    return _repository.addToRecentSpaces(space, organizationTitle: organizationTitle);
  }
}
