import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/space/hierarchical_spaces_list.dart';
import '../../widgets/space/recent_spaces_section.dart';
import '../../widgets/space/spaces_list.dart';
import '../../widgets/user/organization_switcher.dart';
import '../collections/collection_detail_screen.dart';
import '../spaces/create_space_screen.dart';
import '../trash/trash_screen.dart';

/// Home screen showing organizations and spaces
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();
  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    // Delay provider modification until after widget tree is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    // Load organizations first, then load spaces after organizations are ready
    await ref.read(organizationsProvider.notifier).loadOrganizations();
    // Now that organizations are loaded, load spaces
    ref.read(spacesProvider.notifier).loadSpaces();
    ref.read(recentSpacesProvider.notifier).loadRecentSpaces();
  }

  void _onOrganizationChanged() {
    // Reload spaces when organization changes
    ref.read(spacesProvider.notifier).loadSpaces();
    ref.read(recentSpacesProvider.notifier).loadRecentSpaces();
  }

  Future<void> _onRefresh() async {
    await ref.read(organizationsProvider.notifier).refresh();
    await ref.read(spacesProvider.notifier).refresh();
    await ref.read(recentSpacesProvider.notifier).loadRecentSpaces();
  }

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
      if (!_showSearch) {
        _searchController.clear();
        ref.read(spacesProvider.notifier).clearSearch();
      }
    });
  }

  void _onSearchChanged(String query) {
    ref.read(spacesProvider.notifier).setSearchQuery(query);
  }

  void _navigateToCreateSpace() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (context) => const CreateSpaceScreen()),
    );
    if (created == true) {
      ref.read(spacesProvider.notifier).refresh();
    }
  }

  void _navigateToProfile() {
    Navigator.of(context).pushNamed('/profile');
  }

  void _navigateToTrash() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const TrashScreen()),
    );
  }

  void _navigateToCollection(SpaceCollection collection) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CollectionDetailScreen(collection: collection),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orgState = ref.watch(organizationsProvider);
    final spacesState = ref.watch(spacesProvider);
    final recentState = ref.watch(recentSpacesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: _showSearch
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search spaces...',
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : GestureDetector(
                onTap: () {
                  OrganizationSwitcherBottomSheet.show(
                    context,
                    onOrganizationChanged: _onOrganizationChanged,
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      orgState.currentOrganization?.title ?? 'Select Organization',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(_showSearch ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Trash',
            onPressed: _navigateToTrash,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: _navigateToProfile,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _buildContent(orgState, spacesState, recentState, theme),
      ),
      floatingActionButton: orgState.currentOrganization != null
          ? FloatingActionButton(
              onPressed: _navigateToCreateSpace,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildContent(
    OrganizationsState orgState,
    SpacesState spacesState,
    RecentSpacesState recentState,
    ThemeData theme,
  ) {
    if (orgState.isLoading && orgState.organizations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // Show error state if there's an error loading organizations
    if (orgState.error != null && orgState.organizations.isEmpty) {
      return ErrorState(
        message: 'Failed to load organizations: ${orgState.error}',
        onRetry: () => ref.read(organizationsProvider.notifier).refresh(),
      );
    }

    if (orgState.organizations.isEmpty) {
      return EmptyState(
        icon: Icons.business_outlined,
        title: 'No Organizations',
        message: 'You don\'t have access to any organizations yet.',
        actionLabel: 'Refresh',
        onAction: _onRefresh,
      );
    }

    if (orgState.currentOrganization == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'Select an organization',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            FilledButton.tonal(
              onPressed: () {
                OrganizationSwitcherBottomSheet.show(
                  context,
                  onOrganizationChanged: _onOrganizationChanged,
                );
              },
              child: const Text('Choose Organization'),
            ),
          ],
        ),
      );
    }

    if (spacesState.error != null) {
      return ErrorState(
        message: spacesState.error!,
        onRetry: () => ref.read(spacesProvider.notifier).loadSpaces(),
      );
    }

    final filteredSpaces = spacesState.filteredSpaces;

    if (spacesState.isLoading && spacesState.spaces.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (spacesState.spaces.isEmpty) {
      return EmptyState(
        icon: Icons.folder_outlined,
        title: 'No Spaces',
        message: 'Create your first space to get started.',
        actionLabel: 'Create Space',
        onAction: _navigateToCreateSpace,
      );
    }

    return CustomScrollView(
      slivers: [
        // Recent Spaces Section (only show if not searching)
        if (!_showSearch && recentState.items.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Recent',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: RecentSpacesSection(
              items: recentState.items,
              onSpaceTap: (item) {
                Navigator.of(context).pushNamed('/space/${item.id}');
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(height: 32),
          ),
        ],
        // Spaces List Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _showSearch
                      ? 'Results (${filteredSpaces.length})'
                      : 'All Spaces (${spacesState.spaces.length})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    // Display mode toggle (flat/hierarchical)
                    IconButton(
                      icon: Icon(
                        spacesState.displayMode == SpaceDisplayMode.flat
                            ? Icons.view_list
                            : Icons.account_tree,
                      ),
                      onPressed: () {
                        ref.read(spacesProvider.notifier).toggleDisplayMode();
                      },
                      tooltip: spacesState.displayMode == SpaceDisplayMode.flat
                          ? 'Show collections'
                          : 'Flat view',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Spaces List/Grid
        if (filteredSpaces.isEmpty && _showSearch)
          SliverFillRemaining(
            child: EmptyState(
              icon: Icons.search_off,
              title: 'No Results',
              message: 'No spaces match your search.',
            ),
          )
        else if (spacesState.displayMode == SpaceDisplayMode.hierarchical &&
            spacesState.isLoading)
          const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          )
        else if (spacesState.displayMode == SpaceDisplayMode.hierarchical)
          HierarchicalSpacesList(
            items: spacesState.hierarchicalItems,
            onSpaceTap: (space) {
              // Add to recent
              ref.read(recentSpacesProvider.notifier).addRecent(
                    space,
                    organizationTitle:
                        ref.read(organizationsProvider).currentOrganization?.title,
                  );
              Navigator.of(context).pushNamed('/space/${space.id}');
            },
            onCollectionTap: _navigateToCollection,
            onSpaceDelete: (space) => _showDeleteConfirmation(space),
          )
        else
          SpacesList(
            spaces: filteredSpaces,
            viewMode: spacesState.viewMode,
            onSpaceTap: (space) {
              // Add to recent
              ref.read(recentSpacesProvider.notifier).addRecent(
                    space,
                    organizationTitle:
                        ref.read(organizationsProvider).currentOrganization?.title,
                  );
              Navigator.of(context).pushNamed('/space/${space.id}');
            },
            onSpaceDelete: (space) => _showDeleteConfirmation(space),
          ),
      ],
    );
  }

  Future<void> _showDeleteConfirmation(space) async {
    final deleted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _DeleteSpaceDialog(
        spaceTitle: space.title,
        onDelete: () async {
          await ref.read(spacesProvider.notifier).deleteSpace(space.id);
        },
      ),
    );

    if (deleted == true && mounted) {
      // Reload recent spaces to remove deleted space
      ref.read(recentSpacesProvider.notifier).loadRecentSpaces();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Space deleted successfully')),
      );
    }
  }
}

/// Dialog for deleting a space with loading state
class _DeleteSpaceDialog extends StatefulWidget {
  final String spaceTitle;
  final Future<void> Function() onDelete;

  const _DeleteSpaceDialog({
    required this.spaceTitle,
    required this.onDelete,
  });

  @override
  State<_DeleteSpaceDialog> createState() => _DeleteSpaceDialogState();
}

class _DeleteSpaceDialogState extends State<_DeleteSpaceDialog> {
  bool _isDeleting = false;

  Future<void> _handleDelete() async {
    setState(() => _isDeleting = true);
    try {
      await widget.onDelete();
      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDeleting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Space'),
      content: Text('Are you sure you want to delete "${widget.spaceTitle}"? This action cannot be undone.'),
      actions: [
        TextButton(
          onPressed: _isDeleting ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isDeleting ? null : _handleDelete,
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
          child: _isDeleting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Delete'),
        ),
      ],
    );
  }
}
