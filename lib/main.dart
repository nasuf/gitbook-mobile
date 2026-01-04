import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration
  AppConfig.init(Environment.dev);

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // TODO: Initialize secure storage
  // TODO: Open Hive boxes
  // TODO: Initialize database

  runApp(
    const ProviderScope(
      child: GitBookApp(),
    ),
  );
}
