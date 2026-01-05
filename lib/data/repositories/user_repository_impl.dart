import '../../core/storage/hive_storage.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/content_local_datasource.dart';
import '../datasources/remote/gitbook_api_client.dart';
import '../models/organization_model.dart';
import '../models/user_model.dart';

/// Implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final GitBookApiClient _apiClient;
  final ContentLocalDataSource _localDataSource;
  final HiveStorage _hiveStorage;

  static const String _currentOrgKey = 'current_organization_id';
  static const String _userSettingsKey = 'user_settings';
  static const String _cachedUserKey = 'cached_user';

  UserRepositoryImpl({
    required GitBookApiClient apiClient,
    required ContentLocalDataSource localDataSource,
    required HiveStorage hiveStorage,
  })  : _apiClient = apiClient,
        _localDataSource = localDataSource,
        _hiveStorage = hiveStorage;

  @override
  Future<User> getCurrentUser() async {
    final userModel = await _apiClient.getCurrentUser();
    final user = _mapToUser(userModel);

    // Cache user data
    await _localDataSource.cacheUser(userModel);
    await _hiveStorage.cacheJson(_cachedUserKey, {
      'id': user.id,
      'displayName': user.displayName,
      'email': user.email,
      'photoUrl': user.photoUrl,
    });

    return user;
  }

  @override
  Future<User?> getCachedUser() async {
    final cached = await _hiveStorage.getCachedJson(_cachedUserKey);
    if (cached == null) return null;

    return User(
      id: cached['id'] as String,
      displayName: cached['displayName'] as String?,
      email: cached['email'] as String?,
      photoUrl: cached['photoUrl'] as String?,
    );
  }

  @override
  Future<UserSettings> getUserSettings() async {
    final cached = await _hiveStorage.getCachedJson(_userSettingsKey);
    if (cached == null) return const UserSettings();

    return UserSettings(
      themeMode: ThemeModeSetting.values.firstWhere(
        (e) => e.name == cached['themeMode'],
        orElse: () => ThemeModeSetting.system,
      ),
      defaultOrganizationId: cached['defaultOrganizationId'] as String?,
      offlineModeEnabled: cached['offlineModeEnabled'] as bool? ?? false,
      defaultEditorMode: EditorMode.values.firstWhere(
        (e) => e.name == cached['defaultEditorMode'],
        orElse: () => EditorMode.wysiwyg,
      ),
      fontSize: (cached['fontSize'] as num?)?.toDouble() ?? 14.0,
    );
  }

  @override
  Future<void> updateUserSettings(UserSettings settings) async {
    await _hiveStorage.cacheJson(_userSettingsKey, {
      'themeMode': settings.themeMode.name,
      'defaultOrganizationId': settings.defaultOrganizationId,
      'offlineModeEnabled': settings.offlineModeEnabled,
      'defaultEditorMode': settings.defaultEditorMode.name,
      'fontSize': settings.fontSize,
    });
  }

  @override
  Future<List<OrganizationModel>> getOrganizations({
    bool forceRefresh = false,
  }) async {
    // Try to get from cache first unless force refresh
    if (!forceRefresh) {
      final cached = await _localDataSource.getOrganizations();
      if (cached.isNotEmpty) {
        return cached;
      }
    }

    // Fetch from API
    final response = await _apiClient.listOrganizations();

    // Cache the results
    await _localDataSource.cacheOrganizations(response.items);

    return response.items;
  }

  @override
  Future<OrganizationModel?> getCurrentOrganization() async {
    final orgId = _hiveStorage.getSetting<String>(_currentOrgKey);
    if (orgId == null) {
      // Return first organization if no selection
      final orgs = await getOrganizations();
      if (orgs.isNotEmpty) {
        await setCurrentOrganization(orgs.first.id);
        return orgs.first;
      }
      return null;
    }

    // Try to get from cache
    final cached = await _localDataSource.getOrganization(orgId);
    if (cached != null) return cached;

    // Fetch from API
    try {
      final org = await _apiClient.getOrganization(orgId);
      await _localDataSource.cacheOrganization(org);
      return org;
    } catch (_) {
      // Organization might not exist anymore, clear selection
      await _hiveStorage.removeSetting(_currentOrgKey);
      return null;
    }
  }

  @override
  Future<void> setCurrentOrganization(String organizationId) async {
    await _hiveStorage.setSetting(_currentOrgKey, organizationId);
  }

  @override
  Future<void> clearCache() async {
    await _hiveStorage.clearCache();
  }

  User _mapToUser(UserModel model) {
    return User(
      id: model.id,
      displayName: model.displayName,
      email: model.email,
      photoUrl: model.photoUrl,
    );
  }
}
