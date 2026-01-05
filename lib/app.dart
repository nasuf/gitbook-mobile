import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/providers/auth_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/spaces/space_detail_screen.dart';
import 'presentation/screens/spaces/space_settings_screen.dart';
import 'presentation/theme/app_theme.dart';

/// Main application widget
class GitBookApp extends ConsumerWidget {
  const GitBookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'GitBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: _buildHome(authState),
      onGenerateRoute: _onGenerateRoute,
    );
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
      // TODO: Implement profile screen
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          appBar: null,
          body: Center(child: Text('Profile Screen - Coming Soon')),
        ),
        settings: settings,
      );
    }

    return null;
  }
}
