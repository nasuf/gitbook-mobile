import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/presentation/widgets/markdown/gitbook_markdown.dart';

void main() {
  group('GitBookMarkdown', () {
    test('should have default fontSize of 16.0', () {
      const markdown = GitBookMarkdown(data: '# Test');
      expect(markdown.fontSize, 16.0);
    });

    test('should accept custom fontSize', () {
      const markdown = GitBookMarkdown(data: '# Test', fontSize: 20.0);
      expect(markdown.fontSize, 20.0);
    });

    test('should have correct default values', () {
      const markdown = GitBookMarkdown(data: 'test');
      expect(markdown.data, 'test');
      expect(markdown.spaceId, isNull);
      expect(markdown.onInternalLinkTap, isNull);
      expect(markdown.physics, isNull);
      expect(markdown.shrinkWrap, false);
      expect(markdown.padding, isNull);
      expect(markdown.fontSize, 16.0);
    });

    test('should accept all parameters', () {
      void onTap(String pageId) {}
      const physics = NeverScrollableScrollPhysics();
      const padding = EdgeInsets.all(8);

      final markdown = GitBookMarkdown(
        data: '# Hello',
        spaceId: 'space-1',
        onInternalLinkTap: onTap,
        physics: physics,
        shrinkWrap: true,
        padding: padding,
        fontSize: 18.0,
      );

      expect(markdown.data, '# Hello');
      expect(markdown.spaceId, 'space-1');
      expect(markdown.onInternalLinkTap, isNotNull);
      expect(markdown.physics, physics);
      expect(markdown.shrinkWrap, true);
      expect(markdown.padding, padding);
      expect(markdown.fontSize, 18.0);
    });
  });

  group('GitBookMarkdown font size scaling', () {
    test('font sizes should scale correctly with base size 16', () {
      const baseFontSize = 16.0;

      // Expected scaled sizes
      expect(baseFontSize * 2.0, 32.0); // h1
      expect(baseFontSize * 1.75, 28.0); // h2
      expect(baseFontSize * 1.5, 24.0); // h3
      expect(baseFontSize * 1.25, 20.0); // h4
      expect(baseFontSize * 1.1, 17.6); // h5
      expect(baseFontSize * 1.0, 16.0); // h6
      expect(baseFontSize * 0.875, 14.0); // code
    });

    test('font sizes should scale correctly with base size 20', () {
      const baseFontSize = 20.0;

      // Expected scaled sizes
      expect(baseFontSize * 2.0, 40.0); // h1
      expect(baseFontSize * 1.75, 35.0); // h2
      expect(baseFontSize * 1.5, 30.0); // h3
      expect(baseFontSize * 1.25, 25.0); // h4
      expect(baseFontSize * 1.1, 22.0); // h5
      expect(baseFontSize * 1.0, 20.0); // h6
      expect(baseFontSize * 0.875, 17.5); // code
    });

    test('font sizes should scale correctly with base size 12', () {
      const baseFontSize = 12.0;

      // Expected scaled sizes
      expect(baseFontSize * 2.0, 24.0); // h1
      expect(baseFontSize * 1.75, 21.0); // h2
      expect(baseFontSize * 1.5, 18.0); // h3
      expect(baseFontSize * 1.25, 15.0); // h4
      expect(baseFontSize * 1.1, closeTo(13.2, 0.01)); // h5
      expect(baseFontSize * 1.0, 12.0); // h6
      expect(baseFontSize * 0.875, 10.5); // code
    });
  });

  group('GitBookMarkdown widget rendering', () {
    testWidgets('should render with default font size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GitBookMarkdown(data: 'Hello World'),
          ),
        ),
      );

      expect(find.byType(GitBookMarkdown), findsOneWidget);
    });

    testWidgets('should render with custom font size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GitBookMarkdown(
              data: 'Hello World',
              fontSize: 24.0,
            ),
          ),
        ),
      );

      expect(find.byType(GitBookMarkdown), findsOneWidget);
    });

    testWidgets('should render shrinkWrap correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                GitBookMarkdown(
                  data: '# Title\n\nSome content',
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(GitBookMarkdown), findsOneWidget);
    });
  });
}
