import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gitbook_mobile/app.dart';

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: GitBookApp(),
      ),
    );

    expect(find.text('GitBook Mobile'), findsOneWidget);
  });
}
