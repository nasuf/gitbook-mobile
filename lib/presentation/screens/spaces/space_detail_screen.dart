import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../widgets/common/error_state.dart';
import 'space_settings_screen.dart';

/// Screen for viewing space details
class SpaceDetailScreen extends ConsumerWidget {
  final String spaceId;

  const SpaceDetailScreen({
    super.key,
    required this.spaceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(spaceDetailProvider(spaceId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.space?.title ?? 'Space'),
        actions: [
          if (state.space != null)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SpaceSettingsScreen(
                      spaceId: spaceId,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: _buildBody(context, ref, state, theme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    SpaceDetailState state,
    ThemeData theme,
  ) {
    if (state.isLoading && state.space == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.space == null) {
      return ErrorState(
        message: state.error!,
        onRetry: () => ref.read(spaceDetailProvider(spaceId).notifier).refresh(),
      );
    }

    final space = state.space!;

    return RefreshIndicator(
      onRefresh: () => ref.read(spaceDetailProvider(spaceId).notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Space Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.folder,
                          size: 32,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              space.title,
                              style: theme.textTheme.titleLarge,
                            ),
                            if (space.visibility != null) ...[
                              const SizedBox(height: 4),
                              _VisibilityBadge(visibility: space.visibility!),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (space.description != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      space.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Quick Actions
          Text(
            'Quick Actions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.article_outlined,
            title: 'Browse Content',
            subtitle: 'View pages and documents',
            onTap: () {
              // Navigate to content browser
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Content browser coming soon')),
              );
            },
          ),
          _ActionCard(
            icon: Icons.merge_outlined,
            title: 'Change Requests',
            subtitle: 'View and manage change requests',
            onTap: () {
              // Navigate to change requests
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change requests coming soon')),
              );
            },
          ),
          _ActionCard(
            icon: Icons.search,
            title: 'Search',
            subtitle: 'Search content in this space',
            onTap: () {
              // Navigate to search
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon')),
              );
            },
          ),
          const SizedBox(height: 16),
          // Space Info
          Text(
            'Information',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                _InfoRow(
                  label: 'Created',
                  value: space.createdAt != null
                      ? _formatDate(space.createdAt!)
                      : 'Unknown',
                ),
                const Divider(height: 1),
                _InfoRow(
                  label: 'Last Updated',
                  value: space.updatedAt != null
                      ? _formatDate(space.updatedAt!)
                      : 'Unknown',
                ),
                if (space.appUrl != null) ...[
                  const Divider(height: 1),
                  _InfoRow(
                    label: 'App URL',
                    value: space.appUrl!,
                    isUrl: true,
                  ),
                ],
                if (space.publishedUrl != null) ...[
                  const Divider(height: 1),
                  _InfoRow(
                    label: 'Published URL',
                    value: space.publishedUrl!,
                    isUrl: true,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class _VisibilityBadge extends StatelessWidget {
  final SpaceVisibility visibility;

  const _VisibilityBadge({required this.visibility});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (icon, label, color) = _getVisibilityInfo(visibility);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  (IconData, String, Color) _getVisibilityInfo(SpaceVisibility visibility) {
    return switch (visibility) {
      SpaceVisibility.public => (Icons.public, 'Public', Colors.green),
      SpaceVisibility.private => (Icons.lock, 'Private', Colors.orange),
      SpaceVisibility.unlisted => (Icons.link, 'Unlisted', Colors.blue),
      SpaceVisibility.shareLink => (Icons.share, 'Share Link', Colors.purple),
      SpaceVisibility.visitorAuth => (Icons.shield, 'Visitor Auth', Colors.teal),
      SpaceVisibility.inCollection => (Icons.folder_copy, 'In Collection', Colors.indigo),
    };
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isUrl;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isUrl = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isUrl ? theme.colorScheme.primary : null,
              ),
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
