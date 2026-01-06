import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../widgets/common/error_state.dart';

/// Convert emoji code point string to actual emoji character
String? _convertEmojiCode(String? emojiCode) {
  if (emojiCode == null || emojiCode.isEmpty) return null;
  try {
    final codePoint = int.parse(emojiCode, radix: 16);
    return String.fromCharCode(codePoint);
  } catch (e) {
    return emojiCode;
  }
}

/// Screen for viewing space details
class SpaceDetailScreen extends ConsumerStatefulWidget {
  final String spaceId;

  const SpaceDetailScreen({
    super.key,
    required this.spaceId,
  });

  @override
  ConsumerState<SpaceDetailScreen> createState() => _SpaceDetailScreenState();
}

class _SpaceDetailScreenState extends ConsumerState<SpaceDetailScreen> {
  Future<void> _showRenameDialog(Space space) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _RenameSpaceDialog(
        spaceId: widget.spaceId,
        currentTitle: space.title,
      ),
    );

    if (result == true) {
      ref.read(spaceDetailProvider(widget.spaceId).notifier).refresh();
      ref.read(spacesProvider.notifier).refresh();
    }
  }

  Future<void> _showMoveDialog(Space space) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => _MoveSpaceDialog(
        spaceId: widget.spaceId,
        currentParentId: space.parentId,
      ),
    );

    if (result == true) {
      ref.read(spaceDetailProvider(widget.spaceId).notifier).refresh();
      ref.read(spacesProvider.notifier).refresh();
    }
  }

  Future<void> _showDeleteDialog(Space space) async {
    final deleted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _DeleteSpaceDialog(
        spaceTitle: space.title,
        onDelete: () async {
          await ref.read(spacesProvider.notifier).deleteSpace(widget.spaceId);
        },
      ),
    );

    if (deleted == true && mounted) {
      Navigator.of(context).pop(); // Go back to home screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${space.title}" moved to trash')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(spaceDetailProvider(widget.spaceId));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.space?.title ?? 'Space'),
      ),
      body: _buildBody(context, state, theme),
    );
  }

  Widget _buildBody(
    BuildContext context,
    SpaceDetailState state,
    ThemeData theme,
  ) {
    if (state.isLoading && state.space == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.space == null) {
      return ErrorState(
        message: state.error!,
        onRetry: () => ref.read(spaceDetailProvider(widget.spaceId).notifier).refresh(),
      );
    }

    final space = state.space!;

    return RefreshIndicator(
      onRefresh: () => ref.read(spaceDetailProvider(widget.spaceId).notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Space Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon and title row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _convertEmojiCode(space.emoji) != null
                              ? Text(
                                  _convertEmojiCode(space.emoji)!,
                                  style: const TextStyle(fontSize: 28),
                                )
                              : Icon(
                                  Icons.description_outlined,
                                  size: 28,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              space.title,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (space.description != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                space.description!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Metadata row
                  Row(
                    children: [
                      if (space.visibility != null) ...[
                        _VisibilityBadge(visibility: space.visibility!),
                        const SizedBox(width: 12),
                      ],
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Updated ${_formatRelativeDate(space.updatedAt)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search coming soon')),
              );
            },
          ),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.edit_outlined,
            title: 'Rename',
            subtitle: 'Change the space title',
            onTap: () => _showRenameDialog(space),
          ),
          _ActionCard(
            icon: Icons.drive_file_move_outlined,
            title: 'Move to',
            subtitle: 'Move space to a collection',
            onTap: () => _showMoveDialog(space),
          ),
          const SizedBox(height: 24),
          // Danger Zone
          Text(
            'Danger Zone',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.delete_outline,
            title: 'Delete Space',
            subtitle: 'Move this space to trash',
            isDanger: true,
            onTap: () => _showDeleteDialog(space),
          ),
        ],
      ),
    );
  }

  String _formatRelativeDate(DateTime? date) {
    if (date == null) return 'Unknown';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} min ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }
  }
}

// ============ Dialogs ============

/// Dialog for renaming a space
class _RenameSpaceDialog extends ConsumerStatefulWidget {
  final String spaceId;
  final String currentTitle;

  const _RenameSpaceDialog({
    required this.spaceId,
    required this.currentTitle,
  });

  @override
  ConsumerState<_RenameSpaceDialog> createState() => _RenameSpaceDialogState();
}

class _RenameSpaceDialogState extends ConsumerState<_RenameSpaceDialog> {
  late TextEditingController _titleController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.currentTitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await ref.read(spaceDetailProvider(widget.spaceId).notifier).updateSpace(
        title: title,
      );

      if (mounted) {
        if (success) {
          Navigator.pop(context, true);
        } else {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to rename space')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rename Space'),
      content: TextField(
        controller: _titleController,
        decoration: const InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
        ),
        textCapitalization: TextCapitalization.sentences,
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _handleSave,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}

/// Dialog for moving a space to a collection
class _MoveSpaceDialog extends ConsumerStatefulWidget {
  final String spaceId;
  final String? currentParentId;

  const _MoveSpaceDialog({
    required this.spaceId,
    this.currentParentId,
  });

  @override
  ConsumerState<_MoveSpaceDialog> createState() => _MoveSpaceDialogState();
}

class _MoveSpaceDialogState extends ConsumerState<_MoveSpaceDialog> {
  String? _selectedCollectionId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedCollectionId = widget.currentParentId;
    // Load collections if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(spacesProvider.notifier).loadAllCollections();
    });
  }

  Future<void> _handleMove() async {
    setState(() => _isLoading = true);

    // TODO: Implement move space API when available
    // For now, show a placeholder message
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pop(context, false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Move space feature coming soon')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacesState = ref.watch(spacesProvider);
    final collections = spacesState.allCollections;
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Move to Collection'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a collection to move this space to:',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (collections.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text('No collections available')),
              )
            else
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 300),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Option for no collection (root level)
                    RadioListTile<String?>(
                      title: const Text('No Collection'),
                      subtitle: const Text('Keep at root level'),
                      value: null,
                      groupValue: _selectedCollectionId,
                      onChanged: (value) {
                        setState(() => _selectedCollectionId = value);
                      },
                    ),
                    ...collections.map((collection) => RadioListTile<String?>(
                      title: Text(collection.title),
                      subtitle: collection.description != null
                          ? Text(
                              collection.description!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      value: collection.id,
                      groupValue: _selectedCollectionId,
                      onChanged: (value) {
                        setState(() => _selectedCollectionId = value);
                      },
                    )),
                  ],
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _handleMove,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Move'),
        ),
      ],
    );
  }
}

/// Dialog for deleting a space
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
      content: Text(
        'Are you sure you want to delete "${widget.spaceTitle}"?\n\n'
        'The space will be moved to trash and can be restored within 7 days.',
      ),
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
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Text('Delete'),
        ),
      ],
    );
  }
}

// ============ Widgets ============

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
  final bool isDanger;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDanger ? theme.colorScheme.error : theme.colorScheme.primary;
    final containerColor = isDanger
        ? theme.colorScheme.errorContainer
        : theme.colorScheme.primaryContainer;
    final onContainerColor = isDanger
        ? theme.colorScheme.onErrorContainer
        : theme.colorScheme.onPrimaryContainer;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: onContainerColor,
          ),
        ),
        title: Text(
          title,
          style: isDanger ? TextStyle(color: color) : null,
        ),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.chevron_right,
          color: isDanger ? color : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
