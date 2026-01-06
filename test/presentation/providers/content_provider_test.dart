import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/content_entity.dart';
import 'package:gitbook_mobile/presentation/providers/content_provider.dart';

void main() {
  group('PageContentState', () {
    test('should initialize with default values', () {
      const state = PageContentState();

      expect(state.content, isNull);
      expect(state.breadcrumb, isEmpty);
      expect(state.childPages, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.hasChildPages, false);
    });

    test('should copy with new content', () {
      const state = PageContentState();
      const content = PageContent(id: 'page-1', title: 'Page 1');

      final newState = state.copyWith(content: content);

      expect(newState.content?.id, 'page-1');
      expect(newState.content?.title, 'Page 1');
      expect(newState.breadcrumb, isEmpty);
      expect(newState.childPages, isEmpty);
    });

    test('should copy with breadcrumb', () {
      const state = PageContentState();
      final breadcrumb = [
        const BreadcrumbItem(id: 'item-1', title: 'Item 1'),
        const BreadcrumbItem(id: 'item-2', title: 'Item 2'),
      ];

      final newState = state.copyWith(breadcrumb: breadcrumb);

      expect(newState.breadcrumb.length, 2);
      expect(newState.breadcrumb[0].id, 'item-1');
      expect(newState.breadcrumb[1].id, 'item-2');
    });

    test('should copy with child pages', () {
      const state = PageContentState();
      final childPages = [
        const ContentPage(id: 'child-1', title: 'Child 1', type: PageType.document),
        const ContentPage(id: 'child-2', title: 'Child 2', type: PageType.document),
      ];

      final newState = state.copyWith(childPages: childPages);

      expect(newState.childPages.length, 2);
      expect(newState.childPages[0].id, 'child-1');
      expect(newState.childPages[1].id, 'child-2');
      expect(newState.hasChildPages, true);
    });

    test('should copy with loading state', () {
      const state = PageContentState();

      final loadingState = state.copyWith(isLoading: true);

      expect(loadingState.isLoading, true);

      final doneState = loadingState.copyWith(isLoading: false);

      expect(doneState.isLoading, false);
    });

    test('should copy with error', () {
      const state = PageContentState();

      final errorState = state.copyWith(error: 'Something went wrong');

      expect(errorState.error, 'Something went wrong');

      // Error should be cleared when null is passed explicitly
      final clearedState = errorState.copyWith(error: null);

      expect(clearedState.error, isNull);
    });

    test('hasChildPages should return true when childPages is not empty', () {
      const emptyState = PageContentState();
      expect(emptyState.hasChildPages, false);

      final stateWithChildren = emptyState.copyWith(childPages: [
        const ContentPage(id: 'child-1', title: 'Child 1', type: PageType.document),
      ]);
      expect(stateWithChildren.hasChildPages, true);
    });

    test('should preserve existing values when copying', () {
      const content = PageContent(id: 'page-1', title: 'Page 1');
      final breadcrumb = [const BreadcrumbItem(id: 'item-1', title: 'Item 1')];
      final childPages = [
        const ContentPage(id: 'child-1', title: 'Child 1', type: PageType.document),
      ];

      final state = PageContentState(
        content: content,
        breadcrumb: breadcrumb,
        childPages: childPages,
        isLoading: false,
        error: null,
      );

      // Copying with just isLoading should preserve other values
      final newState = state.copyWith(isLoading: true);

      expect(newState.content?.id, 'page-1');
      expect(newState.breadcrumb.length, 1);
      expect(newState.childPages.length, 1);
      expect(newState.isLoading, true);
    });
  });

  group('PageContentKey', () {
    test('should create key with spaceId and pageId', () {
      const key = PageContentKey('space-1', 'page-1');

      expect(key.spaceId, 'space-1');
      expect(key.pageId, 'page-1');
    });

    test('should be equal for same spaceId and pageId', () {
      const key1 = PageContentKey('space-1', 'page-1');
      const key2 = PageContentKey('space-1', 'page-1');

      expect(key1, equals(key2));
      expect(key1.hashCode, equals(key2.hashCode));
    });

    test('should not be equal for different spaceId', () {
      const key1 = PageContentKey('space-1', 'page-1');
      const key2 = PageContentKey('space-2', 'page-1');

      expect(key1, isNot(equals(key2)));
    });

    test('should not be equal for different pageId', () {
      const key1 = PageContentKey('space-1', 'page-1');
      const key2 = PageContentKey('space-1', 'page-2');

      expect(key1, isNot(equals(key2)));
    });
  });
}
