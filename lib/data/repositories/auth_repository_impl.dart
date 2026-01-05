import 'dart:async';

import '../../core/storage/secure_token_storage.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/gitbook_api_client.dart';
import '../models/user_model.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final GitBookApiClient _apiClient;
  final SecureTokenStorage _tokenStorage;

  final _authStateController = StreamController<AuthState>.broadcast();

  AuthRepositoryImpl({
    required GitBookApiClient apiClient,
    required SecureTokenStorage tokenStorage,
  })  : _apiClient = apiClient,
        _tokenStorage = tokenStorage;

  @override
  Stream<AuthState> get authStateChanges => _authStateController.stream;

  void _updateState(AuthState state) {
    _authStateController.add(state);
  }

  @override
  Future<User> loginWithOAuth({
    required String authorizationCode,
    required String redirectUri,
  }) async {
    _updateState(const AuthState(
      status: AuthStatus.authenticating,
      isLoading: true,
    ));

    try {
      // Exchange authorization code for access token
      final tokenResponse = await _apiClient.getToken(
        grantType: 'authorization_code',
        code: authorizationCode,
        redirectUri: redirectUri,
      );

      // Save tokens
      await _tokenStorage.saveAuthData(
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken,
        expiresIn: tokenResponse.expiresIn,
      );

      // Get current user
      final userModel = await _apiClient.getCurrentUser();
      final user = _mapToUser(userModel);

      _updateState(AuthState(
        status: AuthStatus.authenticated,
        userId: user.id,
      ));

      return user;
    } catch (e) {
      _updateState(AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  @override
  Future<User> loginWithApiToken(String token) async {
    _updateState(const AuthState(
      status: AuthStatus.authenticating,
      isLoading: true,
    ));

    try {
      // Save the API token as access token
      await _tokenStorage.saveTokens(accessToken: token);

      // Validate token by fetching current user
      final userModel = await _apiClient.getCurrentUser();
      final user = _mapToUser(userModel);

      _updateState(AuthState(
        status: AuthStatus.authenticated,
        userId: user.id,
      ));

      return user;
    } catch (e) {
      // Clear invalid token
      await _tokenStorage.clearTokens();
      _updateState(AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      ));
      rethrow;
    }
  }

  @override
  Future<void> refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    try {
      final tokenResponse = await _apiClient.getToken(
        grantType: 'refresh_token',
        refreshToken: refreshToken,
      );

      await _tokenStorage.saveAuthData(
        accessToken: tokenResponse.accessToken,
        refreshToken: tokenResponse.refreshToken ?? refreshToken,
        expiresIn: tokenResponse.expiresIn,
      );
    } catch (e) {
      // Refresh failed, user needs to re-authenticate
      await logout();
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.clearTokens();
    _updateState(const AuthState(status: AuthStatus.unauthenticated));
  }

  @override
  Future<bool> isAuthenticated() async {
    return _tokenStorage.hasValidToken();
  }

  @override
  Future<AuthState> getAuthState() async {
    final hasToken = await isAuthenticated();
    if (hasToken) {
      try {
        final userModel = await _apiClient.getCurrentUser();
        return AuthState(
          status: AuthStatus.authenticated,
          userId: userModel.id,
        );
      } catch (_) {
        return const AuthState(status: AuthStatus.unauthenticated);
      }
    }
    return const AuthState(status: AuthStatus.unauthenticated);
  }

  @override
  Future<String?> getAccessToken() async {
    return _tokenStorage.getAccessToken();
  }

  User _mapToUser(UserModel model) {
    return User(
      id: model.id,
      displayName: model.displayName,
      email: model.email,
      photoUrl: model.photoUrl,
    );
  }

  /// Dispose resources
  void dispose() {
    _authStateController.close();
  }
}
