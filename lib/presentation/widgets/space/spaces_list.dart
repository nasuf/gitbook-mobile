import 'package:flutter/material.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';

/// List or grid of spaces
class SpacesList extends StatelessWidget {
  final List<Space> spaces;
  final SpaceViewMode viewMode;
  final void Function(Space) onSpaceTap;
  final void Function(Space)? onSpaceDelete;

  const SpacesList({
    super.key,
    required this.spaces,
    required this.viewMode,
    required this.onSpaceTap,
    this.onSpaceDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (viewMode == SpaceViewMode.grid) {
      return SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _SpaceGridTile(
              space: spaces[index],
              onTap: () => onSpaceTap(spaces[index]),
              onDelete: onSpaceDelete != null
                  ? () => onSpaceDelete!(spaces[index])
                  : null,
            ),
            childCount: spaces.length,
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _SpaceListTile(
          space: spaces[index],
          onTap: () => onSpaceTap(spaces[index]),
          onDelete: onSpaceDelete != null
              ? () => onSpaceDelete!(spaces[index])
              : null,
        ),
        childCount: spaces.length,
      ),
    );
  }
}

class _SpaceListTile extends StatelessWidget {
  final Space space;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _SpaceListTile({
    required this.space,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.folder,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
      title: Text(
        space.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: space.description != null
          ? Text(
              space.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (space.visibility != null)
            Icon(
              _getVisibilityIcon(space.visibility!),
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          if (onDelete != null)
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () => _showOptionsMenu(context),
            ),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('Open'),
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
            ),
            if (onDelete != null)
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onDelete!();
                },
              ),
          ],
        ),
      ),
    );
  }

  IconData _getVisibilityIcon(SpaceVisibility visibility) {
    return switch (visibility) {
      SpaceVisibility.public => Icons.public,
      SpaceVisibility.private => Icons.lock,
      SpaceVisibility.unlisted => Icons.link_off,
      _ => Icons.shield,
    };
  }
}

class _SpaceGridTile extends StatelessWidget {
  final Space space;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const _SpaceGridTile({
    required this.space,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        onLongPress: onDelete != null ? () => _showOptionsMenu(context) : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.folder,
                      color: theme.colorScheme.onPrimaryContainer,
                      size: 20,
                    ),
                  ),
                  if (space.visibility != null)
                    Icon(
                      _getVisibilityIcon(space.visibility!),
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
              const Spacer(),
              Text(
                space.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (space.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  space.description!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.open_in_new),
              title: const Text('Open'),
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
            ),
            if (onDelete != null)
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onDelete!();
                },
              ),
          ],
        ),
      ),
    );
  }

  IconData _getVisibilityIcon(SpaceVisibility visibility) {
    return switch (visibility) {
      SpaceVisibility.public => Icons.public,
      SpaceVisibility.private => Icons.lock,
      SpaceVisibility.unlisted => Icons.link_off,
      _ => Icons.shield,
    };
  }
}
