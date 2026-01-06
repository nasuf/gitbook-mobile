import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/content_entity.dart';
import '../../providers/content_provider.dart';
import '../../widgets/common/error_state.dart';

/// Screen showing page content with breadcrumb navigation
class PageDetailScreen extends ConsumerWidget {
  final String spaceId;
  final String pageId;
  final String pageTitle;

  const PageDetailScreen({
    super.key,
    required this.spaceId,
    required this.pageId,
    required this.pageTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = PageContentKey(spaceId, pageId);
    final state = ref.watch(pageContentProvider(key));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.content?.title ?? pageTitle),
      ),
      body: _buildBody(context, ref, state, theme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    PageContentState state,
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
              onItemTap: (item) {
                // Navigate to the selected breadcrumb item
                if (item.id != pageId) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => PageDetailScreen(
                        spaceId: spaceId,
                        pageId: item.id,
                        pageTitle: item.title,
                      ),
                    ),
                  );
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
            _MarkdownContent(markdown: content.markdown!)
          else
            Container(
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
                    'Content Preview',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Full markdown rendering will be available in Phase 3.4',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
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
  final void Function(BreadcrumbItem) onItemTap;

  const _BreadcrumbNavigation({
    required this.items,
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
              onTap: () => onItemTap(items[i]),
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

/// Simple markdown content display (placeholder for Phase 3.4)
class _MarkdownContent extends StatelessWidget {
  final String markdown;

  const _MarkdownContent({required this.markdown});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // For now, display raw markdown with basic formatting
    // Full markdown rendering will be implemented in Phase 3.4
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        markdown,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontFamily: 'monospace',
          height: 1.5,
        ),
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
