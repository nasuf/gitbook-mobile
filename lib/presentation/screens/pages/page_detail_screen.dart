import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/content_entity.dart';
import '../../providers/content_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/markdown/gitbook_markdown.dart';

/// Custom route that slides from left to right (like going back)
class _SlideFromLeftRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  _SlideFromLeftRoute({required this.page, super.settings})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: Curves.easeInOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
}

/// Screen showing page content with breadcrumb navigation
class PageDetailScreen extends ConsumerWidget {
  final String spaceId;
  final String pageId;
  final String pageTitle;
  /// Navigation history: list of pageIds that were actually visited
  final List<String> visitedHistory;

  const PageDetailScreen({
    super.key,
    required this.spaceId,
    required this.pageId,
    required this.pageTitle,
    this.visitedHistory = const [],
  });

  /// Current visited history including this page
  List<String> get _currentVisitedHistory => [...visitedHistory, pageId];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = PageContentKey(spaceId, pageId);
    final state = ref.watch(pageContentProvider(key));
    final settingsState = ref.watch(userSettingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.content?.title ?? pageTitle),
        actions: [
          // Font size control
          PopupMenuButton<double>(
            icon: const Icon(Icons.text_fields),
            tooltip: 'Font Size',
            onSelected: (size) {
              ref.read(userSettingsProvider.notifier).updateFontSize(size);
            },
            itemBuilder: (context) => [
              _buildFontSizeItem(12.0, settingsState.settings.fontSize),
              _buildFontSizeItem(14.0, settingsState.settings.fontSize),
              _buildFontSizeItem(16.0, settingsState.settings.fontSize),
              _buildFontSizeItem(18.0, settingsState.settings.fontSize),
              _buildFontSizeItem(20.0, settingsState.settings.fontSize),
              _buildFontSizeItem(22.0, settingsState.settings.fontSize),
              _buildFontSizeItem(24.0, settingsState.settings.fontSize),
            ],
          ),
        ],
      ),
      body: _buildBody(context, ref, state, settingsState.settings.fontSize, theme),
    );
  }

  PopupMenuEntry<double> _buildFontSizeItem(double size, double currentSize) {
    final isSelected = size == currentSize;
    return PopupMenuItem<double>(
      value: size,
      child: Row(
        children: [
          if (isSelected)
            const Icon(Icons.check, size: 18)
          else
            const SizedBox(width: 18),
          const SizedBox(width: 8),
          Text('${size.toInt()} pt'),
        ],
      ),
    );
  }

  /// Navigate to a breadcrumb item
  void _navigateToBreadcrumbItem(BuildContext context, BreadcrumbItem item) {
    // Check if target page is in visited history
    final targetIndex = visitedHistory.indexOf(item.id);

    if (targetIndex >= 0) {
      // Page was visited before, pop back to it
      final popCount = visitedHistory.length - targetIndex;
      var count = 0;
      Navigator.of(context).popUntil((route) {
        return count++ >= popCount || route.isFirst;
      });
    } else {
      // Page was not visited, use pushReplacement with reverse animation
      // This replaces current page, so back button goes to previous visited page
      Navigator.of(context).pushReplacement(
        _SlideFromLeftRoute(
          page: PageDetailScreen(
            spaceId: spaceId,
            pageId: item.id,
            pageTitle: item.title,
            visitedHistory: visitedHistory, // Keep same history
          ),
        ),
      );
    }
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    PageContentState state,
    double fontSize,
    ThemeData theme,
  ) {
    final key = PageContentKey(spaceId, pageId);

    if (state.isLoading && state.content == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.content == null) {
      return ErrorState(
        message: state.error!,
        onRetry: () => ref.read(pageContentProvider(key).notifier).refresh(),
      );
    }

    final content = state.content;
    if (content == null) {
      return const Center(child: Text('No content available'));
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(pageContentProvider(key).notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Breadcrumb navigation
          if (state.breadcrumb.isNotEmpty)
            _BreadcrumbNavigation(
              items: state.breadcrumb,
              currentPageId: pageId,
              onItemTap: (item) {
                // Navigate to the selected breadcrumb item
                if (item.id != pageId) {
                  _navigateToBreadcrumbItem(context, item);
                }
              },
            ),
          const SizedBox(height: 16),
          // Page header
          Text(
            content.title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (content.description != null) ...[
            const SizedBox(height: 8),
            Text(
              content.description!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 24),
          // Page content
          if (content.hasMarkdown)
            GitBookMarkdown(
              data: content.markdown!,
              spaceId: spaceId,
              fontSize: fontSize,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              onInternalLinkTap: (targetPageId) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: '/page/$targetPageId'),
                    builder: (context) => PageDetailScreen(
                      spaceId: spaceId,
                      pageId: targetPageId,
                      pageTitle: 'Page',
                      visitedHistory: _currentVisitedHistory,
                    ),
                  ),
                );
              },
            )
          else if (state.hasChildPages)
            // Show child pages list for folder/group pages
            _ChildPagesList(
              childPages: state.childPages,
              spaceId: spaceId,
              visitedHistory: _currentVisitedHistory,
            )
          else
            _EmptyContentPlaceholder(theme: theme),
          const SizedBox(height: 24),
          // Page metadata
          _PageMetadata(content: content),
        ],
      ),
    );
  }
}

/// Breadcrumb navigation widget
class _BreadcrumbNavigation extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final String currentPageId;
  final void Function(BreadcrumbItem item) onItemTap;

  const _BreadcrumbNavigation({
    required this.items,
    required this.currentPageId,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            InkWell(
              onTap: items[i].id != currentPageId
                  ? () => onItemTap(items[i])
                  : null,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  items[i].title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: i == items.length - 1
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: i == items.length - 1 ? FontWeight.w500 : null,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Child pages list for folder/group pages
class _ChildPagesList extends StatelessWidget {
  final List<ContentPage> childPages;
  final String spaceId;
  final List<String> visitedHistory;

  const _ChildPagesList({
    required this.childPages,
    required this.spaceId,
    required this.visitedHistory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pages',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        ...childPages.map((page) => _ChildPageItem(
              page: page,
              spaceId: spaceId,
              visitedHistory: visitedHistory,
            )),
      ],
    );
  }
}

/// Individual child page item
class _ChildPageItem extends StatelessWidget {
  final ContentPage page;
  final String spaceId;
  final List<String> visitedHistory;

  const _ChildPageItem({
    required this.page,
    required this.spaceId,
    required this.visitedHistory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          page.isGroup ? Icons.folder_outlined : Icons.article_outlined,
          color: page.isGroup
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          page.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: page.description != null
            ? Text(
                page.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              settings: RouteSettings(name: '/page/${page.id}'),
              builder: (context) => PageDetailScreen(
                spaceId: spaceId,
                pageId: page.id,
                pageTitle: page.title,
                visitedHistory: visitedHistory,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Empty content placeholder when no markdown available
class _EmptyContentPlaceholder extends StatelessWidget {
  final ThemeData theme;

  const _EmptyContentPlaceholder({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            Icons.article_outlined,
            size: 48,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No Content',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'This page does not have any content yet.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Page metadata display
class _PageMetadata extends StatelessWidget {
  final PageContent content;

  const _PageMetadata({required this.content});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Page Info',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            if (content.path != null)
              _MetadataRow(label: 'Path', value: content.path!),
            if (content.slug != null)
              _MetadataRow(label: 'Slug', value: content.slug!),
            if (content.createdAt != null)
              _MetadataRow(
                label: 'Created',
                value: _formatDate(content.createdAt!),
              ),
            if (content.updatedAt != null)
              _MetadataRow(
                label: 'Updated',
                value: _formatDate(content.updatedAt!),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _MetadataRow extends StatelessWidget {
  final String label;
  final String value;

  const _MetadataRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
