import '../../data/models/organization_model.dart';
import '../entities/user_entity.dart';

/// Abstract user repository interface
abstract class UserRepository {
  /// Get the current authenticated user
  Future<User> getCurrentUser();

  /// Get cached user if available
  Future<User?> getCachedUser();

  /// Get user settings
  Future<UserSettings> getUserSettings();

  /// Update user settings
  Future<void> updateUserSettings(UserSettings settings);

  /// Get list of organizations for the current user
  Future<List<OrganizationModel>> getOrganizations({bool forceRefresh = false});

  /// Get the currently selected organization
  Future<OrganizationModel?> getCurrentOrganization();

  /// Set the current organization
  Future<void> setCurrentOrganization(String organizationId);

  /// Clear user cache
  Future<void> clearCache();
}
