import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/content_entity.dart';
import '../../providers/content_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import 'page_detail_screen.dart';

/// Screen showing table of contents / pages list for a space
class PagesListScreen extends ConsumerStatefulWidget {
  final String spaceId;
  final String spaceTitle;

  const PagesListScreen({
    super.key,
    required this.spaceId,
    required this.spaceTitle,
  });

  @override
  ConsumerState<PagesListScreen> createState() => _PagesListScreenState();
}

class _PagesListScreenState extends ConsumerState<PagesListScreen> {
  final _searchController = TextEditingController();
  bool _showSearch = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
      if (!_showSearch) {
        _searchController.clear();
        ref.read(tableOfContentsProvider(widget.spaceId).notifier).clearSearch();
      }
    });
  }

  void _onSearchChanged(String query) {
    ref.read(tableOfContentsProvider(widget.spaceId).notifier).setSearchQuery(query);
  }

  void _navigateToPage(ContentPage page) {
    if (page.isDocument || page.isLink) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PageDetailScreen(
            spaceId: widget.spaceId,
            pageId: page.id,
            pageTitle: page.title,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tableOfContentsProvider(widget.spaceId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search pages...',
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : Text(widget.spaceTitle),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(tableOfContentsProvider(widget.spaceId).notifier).refresh(),
        child: _buildContent(state, theme),
      ),
    );
  }

  Widget _buildContent(TableOfContentsState state, ThemeData theme) {
    if (state.isLoading && state.pages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.pages.isEmpty) {
      return ErrorState(
        message: state.error!,
        onRetry: () => ref.read(tableOfContentsProvider(widget.spaceId).notifier).refresh(),
      );
    }

    if (state.pages.isEmpty) {
      return EmptyState(
        icon: Icons.article_outlined,
        title: 'No Pages',
        message: 'This space doesn\'t have any pages yet.',
      );
    }

    // Show flat search results or tree view
    if (state.searchQuery.isNotEmpty) {
      final filtered = state.filteredPages;
      if (filtered.isEmpty) {
        return EmptyState(
          icon: Icons.search_off,
          title: 'No Results',
          message: 'No pages match your search.',
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final page = filtered[index];
          return _PageListTile(
            page: page,
            onTap: () => _navigateToPage(page),
          );
        },
      );
    }

    // Tree view
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: state.pages.map((page) {
        return _PageTreeItem(
          page: page,
          depth: 0,
          onTap: _navigateToPage,
        );
      }).toList(),
    );
  }
}

/// Tree item widget for hierarchical display
class _PageTreeItem extends StatefulWidget {
  final ContentPage page;
  final int depth;
  final void Function(ContentPage) onTap;

  const _PageTreeItem({
    required this.page,
    required this.depth,
    required this.onTap,
  });

  @override
  State<_PageTreeItem> createState() => _PageTreeItemState();
}

class _PageTreeItemState extends State<_PageTreeItem> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Expand first level by default
    _isExpanded = widget.depth == 0 && widget.page.hasChildren;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasChildren = widget.page.hasChildren;
    final leftPadding = 16.0 + (widget.depth * 24.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (widget.page.isGroup && hasChildren) {
              setState(() => _isExpanded = !_isExpanded);
            } else {
              widget.onTap(widget.page);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: leftPadding,
              right: 16,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              children: [
                // Expand/collapse icon or page icon
                SizedBox(
                  width: 24,
                  child: hasChildren
                      ? GestureDetector(
                          onTap: () => setState(() => _isExpanded = !_isExpanded),
                          child: Icon(
                            _isExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.chevron_right,
                            size: 20,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        )
                      : Icon(
                          _getPageIcon(widget.page),
                          size: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                ),
                const SizedBox(width: 8),
                // Page icon (if has children, show folder icon)
                if (hasChildren) ...[
                  Icon(
                    _isExpanded ? Icons.folder_open : Icons.folder_outlined,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                ],
                // Title
                Expanded(
                  child: Text(
                    widget.page.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: hasChildren ? FontWeight.w500 : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Arrow for documents
                if (widget.page.isDocument)
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              ],
            ),
          ),
        ),
        // Children
        if (_isExpanded && hasChildren)
          ...widget.page.children.map((child) {
            return _PageTreeItem(
              page: child,
              depth: widget.depth + 1,
              onTap: widget.onTap,
            );
          }),
      ],
    );
  }

  IconData _getPageIcon(ContentPage page) {
    return switch (page.type) {
      PageType.document => Icons.article_outlined,
      PageType.group => Icons.folder_outlined,
      PageType.link => Icons.link,
    };
  }
}

/// Simple list tile for search results
class _PageListTile extends StatelessWidget {
  final ContentPage page;
  final VoidCallback onTap;

  const _PageListTile({
    required this.page,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        _getPageIcon(page),
        color: theme.colorScheme.primary,
      ),
      title: Text(
        page.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: page.path != null
          ? Text(
              page.path!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  IconData _getPageIcon(ContentPage page) {
    return switch (page.type) {
      PageType.document => Icons.article_outlined,
      PageType.group => Icons.folder_outlined,
      PageType.link => Icons.link,
    };
  }
}
