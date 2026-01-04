import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/theme/app_theme.dart';

/// Main application widget
class GitBookApp extends ConsumerWidget {
  const GitBookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Watch theme mode from settings provider

    return MaterialApp(
      title: 'GitBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // TODO: Add go_router configuration
      home: const Scaffold(
        body: Center(
          child: Text('GitBook Mobile'),
        ),
      ),
    );
  }
}
