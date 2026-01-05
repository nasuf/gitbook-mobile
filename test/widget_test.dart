import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:gitbook_mobile/app.dart';
import 'package:gitbook_mobile/core/config/app_config.dart';

void main() {
  setUpAll(() {
    // Initialize AppConfig before tests
    AppConfig.init(Environment.dev);
  });

  testWidgets('App starts correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: GitBookApp(),
      ),
    );

    // Wait for widget to build
    await tester.pump();

    // The app should render a MaterialApp
    expect(find.byType(MaterialApp), findsOneWidget);

    // Should have a Scaffold
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
