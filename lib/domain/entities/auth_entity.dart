import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_entity.freezed.dart';

/// Authentication status enum
enum AuthStatus {
  /// User is not authenticated
  unauthenticated,

  /// Authentication is in progress
  authenticating,

  /// User is authenticated
  authenticated,

  /// Authentication failed
  error,
}

/// Authentication state entity
@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(AuthStatus.unauthenticated) AuthStatus status,
    String? userId,
    String? error,
    @Default(false) bool isLoading,
  }) = _AuthState;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
}

/// Login method enum
enum LoginMethod {
  /// OAuth 2.0 login
  oauth,

  /// API token login
  apiToken,
}

/// OAuth configuration
@freezed
class OAuthConfig with _$OAuthConfig {
  const factory OAuthConfig({
    required String clientId,
    required String redirectUri,
    required String authorizationEndpoint,
    required String tokenEndpoint,
    @Default(['content:read', 'content:write']) List<String> scopes,
  }) = _OAuthConfig;
}
