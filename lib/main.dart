import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/storage/hive_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    AppConfig.init(Environment.dev);
    await HiveStorage.initialize();

    runApp(
      const ProviderScope(
        child: GitBookApp(),
      ),
    );
  } catch (e) {
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Init Error: $e', style: const TextStyle(color: Colors.red)),
          ),
        ),
      ),
    ));
  }
}
