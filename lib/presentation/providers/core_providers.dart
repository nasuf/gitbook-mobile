import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_client.dart';
import '../../core/storage/cache_manager.dart';
import '../../core/storage/hive_storage.dart';
import '../../core/storage/secure_token_storage.dart';
import '../../data/datasources/local/content_local_datasource.dart';
import '../../data/datasources/local/database/app_database.dart';
import '../../data/datasources/remote/gitbook_api_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/space_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/space_repository.dart';
import '../../domain/repositories/user_repository.dart';

/// Provider for SecureTokenStorage
final secureTokenStorageProvider = Provider<SecureTokenStorage>((ref) {
  return SecureTokenStorage();
});

/// Provider for HiveStorage
final hiveStorageProvider = Provider<HiveStorage>((ref) {
  return HiveStorage();
});

/// Provider for AppDatabase
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// Provider for ContentLocalDataSource
final contentLocalDataSourceProvider = Provider<ContentLocalDataSource>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return ContentLocalDataSource(database: database);
});

/// Provider for DioClient
final dioClientProvider = Provider<DioClient>((ref) {
  final tokenStorage = ref.watch(secureTokenStorageProvider);
  return DioClient(
    tokenStorage: tokenStorage,
    onAuthFailure: () async {
      // Will be handled by auth notifier
    },
  );
});

/// Provider for GitBookApiClient
final gitBookApiClientProvider = Provider<GitBookApiClient>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GitBookApiClient(dioClient);
});

/// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(gitBookApiClientProvider);
  final tokenStorage = ref.watch(secureTokenStorageProvider);
  return AuthRepositoryImpl(
    apiClient: apiClient,
    tokenStorage: tokenStorage,
  );
});

/// Provider for UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiClient = ref.watch(gitBookApiClientProvider);
  final localDataSource = ref.watch(contentLocalDataSourceProvider);
  final hiveStorage = ref.watch(hiveStorageProvider);
  return UserRepositoryImpl(
    apiClient: apiClient,
    localDataSource: localDataSource,
    hiveStorage: hiveStorage,
  );
});

/// Provider for CacheManager
final cacheManagerProvider = Provider<CacheManager>((ref) {
  final database = ref.watch(appDatabaseProvider);
  final hiveStorage = ref.watch(hiveStorageProvider);
  return CacheManager(
    database: database,
    hiveStorage: hiveStorage,
  );
});

/// Provider for SpaceRepository
final spaceRepositoryProvider = Provider<SpaceRepository>((ref) {
  final apiClient = ref.watch(gitBookApiClientProvider);
  final localDataSource = ref.watch(contentLocalDataSourceProvider);
  final cacheManager = ref.watch(cacheManagerProvider);
  return SpaceRepositoryImpl(
    apiClient: apiClient,
    localDataSource: localDataSource,
    cacheManager: cacheManager,
  );
});
