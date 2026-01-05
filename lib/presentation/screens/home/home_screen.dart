import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/space_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';
import '../../widgets/space/recent_spaces_section.dart';
import '../../widgets/space/spaces_list.dart';
import '../../widgets/user/organization_switcher.dart';
import '../spaces/create_space_screen.dart';

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
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadData() {
    // Load organizations first, then spaces
    ref.read(organizationsProvider.notifier).loadOrganizations();
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
                    IconButton(
                      icon: Icon(
                        spacesState.viewMode == SpaceViewMode.list
                            ? Icons.view_list
                            : Icons.grid_view,
                      ),
                      onPressed: () {
                        ref.read(spacesProvider.notifier).setViewMode(
                              spacesState.viewMode == SpaceViewMode.list
                                  ? SpaceViewMode.grid
                                  : SpaceViewMode.list,
                            );
                      },
                      tooltip: spacesState.viewMode == SpaceViewMode.list
                          ? 'Grid view'
                          : 'List view',
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Space'),
        content: Text('Are you sure you want to delete "${space.title}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(spacesProvider.notifier).deleteSpace(space.id);
    }
  }
}
