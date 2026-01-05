import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import 'core_providers.dart';

/// Auth state for the UI
class AuthUiState {
  final AuthStatus status;
  final User? user;
  final String? error;
  final bool isLoading;

  const AuthUiState({
    this.status = AuthStatus.unauthenticated,
    this.user,
    this.error,
    this.isLoading = false,
  });

  AuthUiState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
    bool? isLoading,
  }) {
    return AuthUiState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
}

/// Auth notifier for managing authentication state
class AuthNotifier extends StateNotifier<AuthUiState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthState>? _authSubscription;

  AuthNotifier({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthUiState()) {
    _init();
  }

  Future<void> _init() async {
    // Listen to auth state changes
    _authSubscription = _authRepository.authStateChanges.listen((authState) {
      state = state.copyWith(
        status: authState.status,
        isLoading: authState.isLoading,
        error: authState.error,
      );
    });

    // Check initial auth state
    await checkAuthStatus();
  }

  /// Check current authentication status
  Future<void> checkAuthStatus() async {
    state = state.copyWith(isLoading: true);

    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        // Try to get cached user first
        var user = await _userRepository.getCachedUser();

        // If no cached user, fetch from API
        user ??= await _userRepository.getCurrentUser();

        state = AuthUiState(
          status: AuthStatus.authenticated,
          user: user,
          isLoading: false,
        );
      } else {
        state = const AuthUiState(
          status: AuthStatus.unauthenticated,
          isLoading: false,
        );
      }
    } catch (e) {
      state = AuthUiState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Login with OAuth
  Future<void> loginWithOAuth({
    required String authorizationCode,
    required String redirectUri,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authRepository.loginWithOAuth(
        authorizationCode: authorizationCode,
        redirectUri: redirectUri,
      );

      state = AuthUiState(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Login with API token
  Future<void> loginWithApiToken(String token) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authRepository.loginWithApiToken(token);

      state = AuthUiState(
        status: AuthStatus.authenticated,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Logout
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authRepository.logout();
      await _userRepository.clearCache();

      state = const AuthUiState(
        status: AuthStatus.unauthenticated,
        isLoading: false,
      );
    } catch (e) {
      // Force logout even on error
      state = AuthUiState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Refresh access token
  Future<void> refreshToken() async {
    try {
      await _authRepository.refreshToken();
    } catch (e) {
      // Token refresh failed, logout
      await logout();
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

/// Provider for AuthNotifier
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthUiState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthNotifier(
    authRepository: authRepository,
    userRepository: userRepository,
  );
});

/// Convenience provider for checking if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
});

/// Convenience provider for current user
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authNotifierProvider).user;
});
