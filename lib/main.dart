import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/storage/hive_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration
  AppConfig.init(Environment.dev);

  // Initialize Hive storage (opens all required boxes)
  await HiveStorage.initialize();

  runApp(
    const ProviderScope(
      child: GitBookApp(),
    ),
  );
}
