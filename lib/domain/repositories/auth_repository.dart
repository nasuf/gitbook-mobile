import '../entities/auth_entity.dart';
import '../entities/user_entity.dart';

/// Abstract authentication repository interface
abstract class AuthRepository {
  /// Login with OAuth 2.0
  /// Returns the authenticated user
  Future<User> loginWithOAuth({
    required String authorizationCode,
    required String redirectUri,
  });

  /// Login with API token
  /// Returns the authenticated user
  Future<User> loginWithApiToken(String token);

  /// Refresh the access token
  Future<void> refreshToken();

  /// Logout and clear all auth data
  Future<void> logout();

  /// Check if user is currently authenticated
  Future<bool> isAuthenticated();

  /// Get the current authentication state
  Future<AuthState> getAuthState();

  /// Get the current access token
  Future<String?> getAccessToken();

  /// Stream of authentication state changes
  Stream<AuthState> get authStateChanges;
}
