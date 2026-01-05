import '../../data/models/organization_model.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for getting current user
class GetCurrentUserUseCase {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<User> call() {
    return _repository.getCurrentUser();
  }
}

/// Use case for getting cached user
class GetCachedUserUseCase {
  final UserRepository _repository;

  GetCachedUserUseCase(this._repository);

  Future<User?> call() {
    return _repository.getCachedUser();
  }
}

/// Use case for getting user settings
class GetUserSettingsUseCase {
  final UserRepository _repository;

  GetUserSettingsUseCase(this._repository);

  Future<UserSettings> call() {
    return _repository.getUserSettings();
  }
}

/// Use case for updating user settings
class UpdateUserSettingsUseCase {
  final UserRepository _repository;

  UpdateUserSettingsUseCase(this._repository);

  Future<void> call(UserSettings settings) {
    return _repository.updateUserSettings(settings);
  }
}

/// Use case for getting user organizations
class GetOrganizationsUseCase {
  final UserRepository _repository;

  GetOrganizationsUseCase(this._repository);

  Future<List<OrganizationModel>> call({bool forceRefresh = false}) {
    return _repository.getOrganizations(forceRefresh: forceRefresh);
  }
}

/// Use case for getting current organization
class GetCurrentOrganizationUseCase {
  final UserRepository _repository;

  GetCurrentOrganizationUseCase(this._repository);

  Future<OrganizationModel?> call() {
    return _repository.getCurrentOrganization();
  }
}

/// Use case for setting current organization
class SetCurrentOrganizationUseCase {
  final UserRepository _repository;

  SetCurrentOrganizationUseCase(this._repository);

  Future<void> call(String organizationId) {
    return _repository.setCurrentOrganization(organizationId);
  }
}
