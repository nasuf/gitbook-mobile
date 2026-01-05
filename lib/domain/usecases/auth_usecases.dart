import '../entities/auth_entity.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for logging in with OAuth
class LoginWithOAuthUseCase {
  final AuthRepository _repository;

  LoginWithOAuthUseCase(this._repository);

  Future<User> call({
    required String authorizationCode,
    required String redirectUri,
  }) {
    return _repository.loginWithOAuth(
      authorizationCode: authorizationCode,
      redirectUri: redirectUri,
    );
  }
}

/// Use case for logging in with API token
class LoginWithApiTokenUseCase {
  final AuthRepository _repository;

  LoginWithApiTokenUseCase(this._repository);

  Future<User> call(String token) {
    return _repository.loginWithApiToken(token);
  }
}

/// Use case for logging out
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> call() {
    return _repository.logout();
  }
}

/// Use case for checking authentication status
class CheckAuthStatusUseCase {
  final AuthRepository _repository;

  CheckAuthStatusUseCase(this._repository);

  Future<bool> call() {
    return _repository.isAuthenticated();
  }
}

/// Use case for getting authentication state
class GetAuthStateUseCase {
  final AuthRepository _repository;

  GetAuthStateUseCase(this._repository);

  Future<AuthState> call() {
    return _repository.getAuthState();
  }
}

/// Use case for refreshing access token
class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<void> call() {
    return _repository.refreshToken();
  }
}

/// Use case for observing auth state changes
class ObserveAuthStateUseCase {
  final AuthRepository _repository;

  ObserveAuthStateUseCase(this._repository);

  Stream<AuthState> call() {
    return _repository.authStateChanges;
  }
}
