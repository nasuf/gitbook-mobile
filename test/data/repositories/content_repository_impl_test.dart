import 'package:flutter_test/flutter_test.dart';
import 'package:gitbook_mobile/data/datasources/remote/gitbook_api_client.dart';
import 'package:gitbook_mobile/data/models/content_model.dart';
import 'package:gitbook_mobile/data/repositories/content_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockGitBookApiClient extends Mock implements GitBookApiClient {}

void main() {
  late MockGitBookApiClient mockApiClient;
  late ContentRepositoryImpl repository;

  setUp(() {
    mockApiClient = MockGitBookApiClient();
    repository = ContentRepositoryImpl(apiClient: mockApiClient);
  });

  group('getTableOfContents', () {
    test('should return list of content pages', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Page 1', type: ContentType.document),
            const ContentModel(id: 'page-2', title: 'Page 2', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.getTableOfContents('space-1');

      expect(result.length, 2);
      expect(result[0].id, 'page-1');
      expect(result[1].id, 'page-2');
    });

    test('should handle nested pages', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'group-1',
              title: 'Group 1',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'child-1', title: 'Child 1', type: ContentType.document),
                ContentModel(id: 'child-2', title: 'Child 2', type: ContentType.document),
              ],
            ),
          ],
        ),
      );

      final result = await repository.getTableOfContents('space-1');

      expect(result.length, 1);
      expect(result[0].isGroup, true);
      expect(result[0].children.length, 2);
      expect(result[0].children[0].id, 'child-1');
    });
  });

  group('getChildPages', () {
    test('should return child pages for a valid parent page', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'parent-1',
              title: 'Parent',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'child-1', title: 'Child 1', type: ContentType.document),
                ContentModel(id: 'child-2', title: 'Child 2', type: ContentType.document),
              ],
            ),
          ],
        ),
      );

      final result = await repository.getChildPages('space-1', 'parent-1');

      expect(result.length, 2);
      expect(result[0].id, 'child-1');
      expect(result[0].title, 'Child 1');
      expect(result[1].id, 'child-2');
      expect(result[1].title, 'Child 2');
    });

    test('should return empty list for page without children', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Page 1', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.getChildPages('space-1', 'page-1');

      expect(result, isEmpty);
    });

    test('should return empty list for non-existent page', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Page 1', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.getChildPages('space-1', 'non-existent');

      expect(result, isEmpty);
    });

    test('should find child pages in deeply nested structure', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'level-1',
              title: 'Level 1',
              type: ContentType.group,
              pages: [
                ContentModel(
                  id: 'level-2',
                  title: 'Level 2',
                  type: ContentType.group,
                  pages: [
                    ContentModel(
                      id: 'level-3',
                      title: 'Level 3',
                      type: ContentType.group,
                      pages: [
                        ContentModel(id: 'deep-child', title: 'Deep Child', type: ContentType.document),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      // Get children of level-3 (the deepest group)
      final result = await repository.getChildPages('space-1', 'level-3');

      expect(result.length, 1);
      expect(result[0].id, 'deep-child');
    });

    test('should find page when there are multiple top-level pages', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Page 1', type: ContentType.document),
            const ContentModel(
              id: 'group-1',
              title: 'Group 1',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'child-1', title: 'Child 1', type: ContentType.document),
              ],
            ),
            const ContentModel(id: 'page-2', title: 'Page 2', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.getChildPages('space-1', 'group-1');

      expect(result.length, 1);
      expect(result[0].id, 'child-1');
    });
  });

  group('getBreadcrumb', () {
    test('should build breadcrumb for root level page', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Page 1', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.getBreadcrumb('space-1', 'page-1');

      expect(result.length, 1);
      expect(result[0].id, 'page-1');
      expect(result[0].title, 'Page 1');
    });

    test('should build breadcrumb for nested page', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'group-1',
              title: 'Group',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'child-1', title: 'Child', type: ContentType.document),
              ],
            ),
          ],
        ),
      );

      final result = await repository.getBreadcrumb('space-1', 'child-1');

      expect(result.length, 2);
      expect(result[0].id, 'group-1');
      expect(result[0].title, 'Group');
      expect(result[1].id, 'child-1');
      expect(result[1].title, 'Child');
    });

    test('should build breadcrumb for deeply nested page', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'level-1',
              title: 'Level 1',
              type: ContentType.group,
              pages: [
                ContentModel(
                  id: 'level-2',
                  title: 'Level 2',
                  type: ContentType.group,
                  pages: [
                    ContentModel(
                      id: 'level-3',
                      title: 'Level 3',
                      type: ContentType.document,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      final result = await repository.getBreadcrumb('space-1', 'level-3');

      expect(result.length, 3);
      expect(result[0].id, 'level-1');
      expect(result[1].id, 'level-2');
      expect(result[2].id, 'level-3');
    });

    test('should return empty list for non-existent page', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Page 1', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.getBreadcrumb('space-1', 'non-existent');

      expect(result, isEmpty);
    });

    test('should correctly backtrack when page not in first branch', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'wrong-group',
              title: 'Wrong Group',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'wrong-child', title: 'Wrong Child', type: ContentType.document),
              ],
            ),
            const ContentModel(
              id: 'right-group',
              title: 'Right Group',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'target-child', title: 'Target Child', type: ContentType.document),
              ],
            ),
          ],
        ),
      );

      final result = await repository.getBreadcrumb('space-1', 'target-child');

      expect(result.length, 2);
      expect(result[0].id, 'right-group');
      expect(result[1].id, 'target-child');
    });
  });

  group('searchPages', () {
    test('should find pages matching title', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'Introduction', type: ContentType.document),
            const ContentModel(id: 'page-2', title: 'Getting Started', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.searchPages('space-1', 'intro');

      expect(result.length, 1);
      expect(result[0].id, 'page-1');
    });

    test('should find pages matching description', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'page-1',
              title: 'Title',
              type: ContentType.document,
              description: 'This describes the feature',
            ),
          ],
        ),
      );

      final result = await repository.searchPages('space-1', 'feature');

      expect(result.length, 1);
      expect(result[0].id, 'page-1');
    });

    test('should search case-insensitively', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(id: 'page-1', title: 'UPPERCASE', type: ContentType.document),
          ],
        ),
      );

      final result = await repository.searchPages('space-1', 'upper');

      expect(result.length, 1);
    });

    test('should search in nested pages', () async {
      when(() => mockApiClient.getSpaceContent('space-1')).thenAnswer(
        (_) async => SpaceContentResponse(
          pages: [
            const ContentModel(
              id: 'group-1',
              title: 'Group',
              type: ContentType.group,
              pages: [
                ContentModel(id: 'nested', title: 'Nested Target', type: ContentType.document),
              ],
            ),
          ],
        ),
      );

      final result = await repository.searchPages('space-1', 'target');

      expect(result.length, 1);
      expect(result[0].id, 'nested');
    });
  });
}
