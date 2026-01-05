import 'package:flutter/material.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';

/// Convert emoji code point string to actual emoji character
String? _convertEmojiCode(String? emojiCode) {
  if (emojiCode == null || emojiCode.isEmpty) return null;
  try {
    // Handle emoji code like "1f4d9" -> actual emoji
    final codePoint = int.parse(emojiCode, radix: 16);
    return String.fromCharCode(codePoint);
  } catch (e) {
    // If it's already an emoji or invalid, return as-is
    return emojiCode;
  }
}

/// Hierarchical list of spaces with collections
class HierarchicalSpacesList extends StatefulWidget {
  final List<HierarchicalSpaceItem> items;
  final void Function(Space) onSpaceTap;
  final void Function(Space)? onSpaceDelete;

  const HierarchicalSpacesList({
    super.key,
    required this.items,
    required this.onSpaceTap,
    this.onSpaceDelete,
  });

  @override
  State<HierarchicalSpacesList> createState() => _HierarchicalSpacesListState();
}

class _HierarchicalSpacesListState extends State<HierarchicalSpacesList> {
  final Set<String> _expandedCollections = {};

  @override
  void initState() {
    super.initState();
    // Expand all collections by default
    for (final item in widget.items) {
      if (item.isCollection) {
        _expandedCollections.add(item.collection!.id);
      }
    }
  }

  void _toggleCollection(String collectionId) {
    setState(() {
      if (_expandedCollections.contains(collectionId)) {
        _expandedCollections.remove(collectionId);
      } else {
        _expandedCollections.add(collectionId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final item = widget.items[index];
          if (item.isCollection) {
            return _CollectionTile(
              collection: item.collection!,
              spaces: item.childSpaces,
              isExpanded: _expandedCollections.contains(item.collection!.id),
              onToggle: () => _toggleCollection(item.collection!.id),
              onSpaceTap: widget.onSpaceTap,
              onSpaceDelete: widget.onSpaceDelete,
            );
          } else {
            return _SpaceListTile(
              space: item.space!,
              onTap: () => widget.onSpaceTap(item.space!),
              onDelete: widget.onSpaceDelete != null
                  ? () => widget.onSpaceDelete!(item.space!)
                  : null,
            );
          }
        },
        childCount: widget.items.length,
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  final SpaceCollection collection;
  final List<Space> spaces;
  final bool isExpanded;
  final VoidCallback onToggle;
  final void Function(Space) onSpaceTap;
  final void Function(Space)? onSpaceDelete;

  const _CollectionTile({
    required this.collection,
    required this.spaces,
    required this.isExpanded,
    required this.onToggle,
    required this.onSpaceTap,
    this.onSpaceDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Collection header
        InkWell(
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: _convertEmojiCode(collection.emoji) != null
                        ? Text(
                            _convertEmojiCode(collection.emoji)!,
                            style: const TextStyle(fontSize: 20),
                          )
                        : Icon(
                            Icons.folder_outlined,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        collection.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${spaces.length} space${spaces.length == 1 ? '' : 's'}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        // Expanded spaces
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              children: spaces.map((space) {
                return _SpaceListTile(
                  space: space,
                  onTap: () => onSpaceTap(space),
                  onDelete: onSpaceDelete != null
                      ? () => onSpaceDelete!(space)
                      : null,
                  isNested: true,
                );
              }).toList(),
            ),
          ),
        const Divider(height: 1),
      ],
    );
  }
}

class _SpaceListTile extends StatelessWidget {
  final Space space;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isNested;

  const _SpaceListTile({
    required this.space,
    required this.onTap,
    this.onDelete,
    this.isNested = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: isNested ? 8 : 16,
        vertical: 0,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: _convertEmojiCode(space.emoji) != null
              ? Text(
                  _convertEmojiCode(space.emoji)!,
                  style: const TextStyle(fontSize: 18),
                )
              : Icon(
                  Icons.description_outlined,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 20,
                ),
        ),
      ),
      title: Text(
        space.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
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
