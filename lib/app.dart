import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/entities/user_entity.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/profile/profile_screen.dart';
import 'presentation/screens/spaces/space_detail_screen.dart';
import 'presentation/screens/spaces/space_settings_screen.dart';
import 'presentation/theme/app_theme.dart';

/// Main application widget
class GitBookApp extends ConsumerWidget {
  const GitBookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final settingsState = ref.watch(userSettingsProvider);

    return MaterialApp(
      title: 'GitBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _mapThemeMode(settingsState.settings.themeMode),
      home: _buildHome(authState),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  ThemeMode _mapThemeMode(ThemeModeSetting setting) {
    switch (setting) {
      case ThemeModeSetting.light:
        return ThemeMode.light;
      case ThemeModeSetting.dark:
        return ThemeMode.dark;
      case ThemeModeSetting.system:
        return ThemeMode.system;
    }
  }

  Widget _buildHome(AuthUiState authState) {
    // Show loading indicator while checking auth
    if (authState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Show home screen if authenticated
    if (authState.isAuthenticated) {
      return const HomeScreen();
    }

    // Show login screen if not authenticated
    return const LoginScreen();
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // Handle named routes
    if (settings.name?.startsWith('/space/') ?? false) {
      final spaceId = settings.name!.replaceFirst('/space/', '');
      return MaterialPageRoute(
        builder: (context) => SpaceDetailScreen(spaceId: spaceId),
        settings: settings,
      );
    }

    if (settings.name?.startsWith('/space-settings/') ?? false) {
      final spaceId = settings.name!.replaceFirst('/space-settings/', '');
      return MaterialPageRoute(
        builder: (context) => SpaceSettingsScreen(spaceId: spaceId),
        settings: settings,
      );
    }

    if (settings.name == '/profile') {
      return MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
        settings: settings,
      );
    }

    return null;
  }
}
