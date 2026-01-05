import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/organization_model.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import 'core_providers.dart';

/// User settings state
class UserSettingsState {
  final UserSettings settings;
  final bool isLoading;
  final String? error;

  const UserSettingsState({
    this.settings = const UserSettings(),
    this.isLoading = false,
    this.error,
  });

  UserSettingsState copyWith({
    UserSettings? settings,
    bool? isLoading,
    String? error,
  }) {
    return UserSettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// User settings notifier
class UserSettingsNotifier extends StateNotifier<UserSettingsState> {
  final UserRepository _repository;

  UserSettingsNotifier(this._repository) : super(const UserSettingsState()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    state = state.copyWith(isLoading: true);
    try {
      final settings = await _repository.getUserSettings();
      state = UserSettingsState(settings: settings);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateThemeMode(ThemeModeSetting themeMode) async {
    final newSettings = UserSettings(
      themeMode: themeMode,
      defaultOrganizationId: state.settings.defaultOrganizationId,
      offlineModeEnabled: state.settings.offlineModeEnabled,
      defaultEditorMode: state.settings.defaultEditorMode,
      fontSize: state.settings.fontSize,
    );
    await _updateSettings(newSettings);
  }

  Future<void> updateOfflineMode(bool enabled) async {
    final newSettings = UserSettings(
      themeMode: state.settings.themeMode,
      defaultOrganizationId: state.settings.defaultOrganizationId,
      offlineModeEnabled: enabled,
      defaultEditorMode: state.settings.defaultEditorMode,
      fontSize: state.settings.fontSize,
    );
    await _updateSettings(newSettings);
  }

  Future<void> updateEditorMode(EditorMode mode) async {
    final newSettings = UserSettings(
      themeMode: state.settings.themeMode,
      defaultOrganizationId: state.settings.defaultOrganizationId,
      offlineModeEnabled: state.settings.offlineModeEnabled,
      defaultEditorMode: mode,
      fontSize: state.settings.fontSize,
    );
    await _updateSettings(newSettings);
  }

  Future<void> updateFontSize(double size) async {
    final newSettings = UserSettings(
      themeMode: state.settings.themeMode,
      defaultOrganizationId: state.settings.defaultOrganizationId,
      offlineModeEnabled: state.settings.offlineModeEnabled,
      defaultEditorMode: state.settings.defaultEditorMode,
      fontSize: size,
    );
    await _updateSettings(newSettings);
  }

  Future<void> _updateSettings(UserSettings settings) async {
    try {
      await _repository.updateUserSettings(settings);
      state = UserSettingsState(settings: settings);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// Provider for user settings
final userSettingsProvider =
    StateNotifierProvider<UserSettingsNotifier, UserSettingsState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserSettingsNotifier(repository);
});

/// Organizations state
class OrganizationsState {
  final List<OrganizationModel> organizations;
  final OrganizationModel? currentOrganization;
  final bool isLoading;
  final String? error;

  const OrganizationsState({
    this.organizations = const [],
    this.currentOrganization,
    this.isLoading = false,
    this.error,
  });

  OrganizationsState copyWith({
    List<OrganizationModel>? organizations,
    OrganizationModel? currentOrganization,
    bool? isLoading,
    String? error,
  }) {
    return OrganizationsState(
      organizations: organizations ?? this.organizations,
      currentOrganization: currentOrganization ?? this.currentOrganization,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Organizations notifier
class OrganizationsNotifier extends StateNotifier<OrganizationsState> {
  final UserRepository _repository;

  OrganizationsNotifier(this._repository) : super(const OrganizationsState()) {
    _loadOrganizations();
  }

  Future<void> _loadOrganizations() async {
    state = state.copyWith(isLoading: true);
    try {
      final organizations = await _repository.getOrganizations();
      final currentOrg = await _repository.getCurrentOrganization();
      state = OrganizationsState(
        organizations: organizations,
        currentOrganization: currentOrg,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true);
    try {
      final organizations = await _repository.getOrganizations(forceRefresh: true);
      final currentOrg = await _repository.getCurrentOrganization();
      state = OrganizationsState(
        organizations: organizations,
        currentOrganization: currentOrg,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> setCurrentOrganization(OrganizationModel organization) async {
    try {
      await _repository.setCurrentOrganization(organization.id);
      state = state.copyWith(currentOrganization: organization);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// Provider for organizations
final organizationsProvider =
    StateNotifierProvider<OrganizationsNotifier, OrganizationsState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return OrganizationsNotifier(repository);
});

/// Convenience provider for current organization
final currentOrganizationProvider = Provider<OrganizationModel?>((ref) {
  return ref.watch(organizationsProvider).currentOrganization;
});
