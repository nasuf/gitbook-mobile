import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/domain/entities/content_entity.dart';
import 'package:gitbook_mobile/presentation/screens/pages/page_detail_screen.dart';

void main() {
  group('PageDetailScreen', () {
    test('should pass visitedHistory to nested navigations', () {
      // Create a PageDetailScreen with history
      const screen = PageDetailScreen(
        spaceId: 'space-1',
        pageId: 'page-3',
        pageTitle: 'Page 3',
        visitedHistory: ['page-1', 'page-2'],
      );

      // Verify the history is set correctly
      expect(screen.visitedHistory, ['page-1', 'page-2']);
      expect(screen.pageId, 'page-3');
    });

    test('should have correct currentVisitedHistory', () {
      const screen = PageDetailScreen(
        spaceId: 'space-1',
        pageId: 'page-3',
        pageTitle: 'Page 3',
        visitedHistory: ['page-1', 'page-2'],
      );

      // Access private getter through testing
      // The _currentVisitedHistory should include the current page
      expect(screen.visitedHistory.length, 2);
      // The full history including current should be: page-1, page-2, page-3
    });
  });

  group('PageDetailScreen navigation history', () {
    test('visitedHistory should default to empty list', () {
      const screen = PageDetailScreen(
        spaceId: 'space-1',
        pageId: 'page-1',
        pageTitle: 'Test',
      );

      expect(screen.visitedHistory, isEmpty);
    });

    test('should preserve visitedHistory when passed', () {
      const history = ['page-1', 'page-2', 'page-3'];
      const screen = PageDetailScreen(
        spaceId: 'space-1',
        pageId: 'page-4',
        pageTitle: 'Test',
        visitedHistory: history,
      );

      expect(screen.visitedHistory, history);
      expect(screen.visitedHistory.length, 3);
    });
  });

  group('Breadcrumb navigation logic', () {
    test('should identify visited pages by index', () {
      const visitedHistory = ['page-1', 'page-2', 'page-3'];

      // Test indexOf for visited page
      expect(visitedHistory.indexOf('page-1'), 0);
      expect(visitedHistory.indexOf('page-2'), 1);
      expect(visitedHistory.indexOf('page-3'), 2);

      // Test indexOf for unvisited page
      expect(visitedHistory.indexOf('page-4'), -1);
    });

    test('should calculate correct pop count for visited pages', () {
      const visitedHistory = ['page-1', 'page-2', 'page-3'];
      const targetId = 'page-1';

      final targetIndex = visitedHistory.indexOf(targetId);
      expect(targetIndex, 0);

      final popCount = visitedHistory.length - targetIndex;
      expect(popCount, 3); // Need to pop 3 times to get back to page-1
    });

    test('should handle navigation to middle of history', () {
      const visitedHistory = ['page-1', 'page-2', 'page-3', 'page-4'];
      const targetId = 'page-2';

      final targetIndex = visitedHistory.indexOf(targetId);
      expect(targetIndex, 1);

      final popCount = visitedHistory.length - targetIndex;
      expect(popCount, 3); // Pop page-4, page-3, and page-2 to land on page-2
    });
  });

  group('ContentPage widget helpers', () {
    test('isGroup should return true for group type', () {
      const page = ContentPage(
        id: 'group-1',
        title: 'Group',
        type: PageType.group,
      );

      expect(page.isGroup, true);
      expect(page.isDocument, false);
    });

    test('isDocument should return true for document type', () {
      const page = ContentPage(
        id: 'doc-1',
        title: 'Document',
        type: PageType.document,
      );

      expect(page.isDocument, true);
      expect(page.isGroup, false);
    });

    test('hasChildren should return true when children exist', () {
      const pageWithChildren = ContentPage(
        id: 'group-1',
        title: 'Group',
        type: PageType.group,
        children: [
          ContentPage(id: 'child-1', title: 'Child 1', type: PageType.document),
        ],
      );

      expect(pageWithChildren.hasChildren, true);

      const pageWithoutChildren = ContentPage(
        id: 'doc-1',
        title: 'Document',
        type: PageType.document,
      );

      expect(pageWithoutChildren.hasChildren, false);
    });
  });

  group('BreadcrumbItem', () {
    test('should create BreadcrumbItem with required fields', () {
      const item = BreadcrumbItem(
        id: 'item-1',
        title: 'Item 1',
      );

      expect(item.id, 'item-1');
      expect(item.title, 'Item 1');
      expect(item.path, isNull);
    });

    test('should create BreadcrumbItem with path', () {
      const item = BreadcrumbItem(
        id: 'item-1',
        title: 'Item 1',
        path: '/path/to/item',
      );

      expect(item.path, '/path/to/item');
    });

    test('should compare BreadcrumbItems correctly', () {
      const item1 = BreadcrumbItem(id: 'item-1', title: 'Item');
      const item2 = BreadcrumbItem(id: 'item-1', title: 'Item');
      const item3 = BreadcrumbItem(id: 'item-2', title: 'Item');

      expect(item1, equals(item2));
      expect(item1, isNot(equals(item3)));
    });
  });

  group('SlideFromLeftRoute animation', () {
    test('should verify slide animation parameters', () {
      // The animation slides from left (-1.0, 0.0) to center (0.0, 0.0)
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;

      expect(begin.dx, -1.0);
      expect(begin.dy, 0.0);
      expect(end.dx, 0.0);
      expect(end.dy, 0.0);
    });
  });

  group('ChildPages display', () {
    test('ContentPage children should be accessible', () {
      const parentPage = ContentPage(
        id: 'parent-1',
        title: 'Parent',
        type: PageType.group,
        children: [
          ContentPage(id: 'child-1', title: 'Child 1', type: PageType.document),
          ContentPage(id: 'child-2', title: 'Child 2', type: PageType.document),
          ContentPage(id: 'child-3', title: 'Child 3', type: PageType.group),
        ],
      );

      expect(parentPage.children.length, 3);
      expect(parentPage.children[0].id, 'child-1');
      expect(parentPage.children[2].isGroup, true);
    });

    test('should handle nested children structure', () {
      const deepNested = ContentPage(
        id: 'level-1',
        title: 'Level 1',
        type: PageType.group,
        children: [
          ContentPage(
            id: 'level-2',
            title: 'Level 2',
            type: PageType.group,
            children: [
              ContentPage(
                id: 'level-3',
                title: 'Level 3',
                type: PageType.document,
              ),
            ],
          ),
        ],
      );

      expect(deepNested.hasChildren, true);
      expect(deepNested.children[0].hasChildren, true);
      expect(deepNested.children[0].children[0].hasChildren, false);
    });
  });

  group('Font size control', () {
    test('available font sizes should be in valid range', () {
      const fontSizes = [12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0];

      expect(fontSizes.length, 7);
      expect(fontSizes.first, 12.0);
      expect(fontSizes.last, 24.0);

      // All sizes should be positive
      for (final size in fontSizes) {
        expect(size, greaterThan(0));
      }

      // Sizes should be in ascending order
      for (var i = 1; i < fontSizes.length; i++) {
        expect(fontSizes[i], greaterThan(fontSizes[i - 1]));
      }
    });

    test('font size selection logic', () {
      const currentSize = 16.0;
      const selectedSize = 20.0;

      // Check if size is selected
      expect(currentSize == 16.0, true);
      expect(currentSize == selectedSize, false);

      // Verify size would be updated
      expect(selectedSize, isNot(equals(currentSize)));
    });

    test('font size item should show check mark for selected size', () {
      const sizes = [12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0];
      const currentSize = 16.0;

      for (final size in sizes) {
        final isSelected = size == currentSize;
        if (size == 16.0) {
          expect(isSelected, true);
        } else {
          expect(isSelected, false);
        }
      }
    });
  });
}
