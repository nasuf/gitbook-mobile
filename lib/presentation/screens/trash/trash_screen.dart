import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../providers/trash_provider.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/error_state.dart';

/// Screen showing trashed spaces
class TrashScreen extends ConsumerStatefulWidget {
  const TrashScreen({super.key});

  @override
  ConsumerState<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends ConsumerState<TrashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trashProvider.notifier).loadTrashedSpaces();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(trashProvider.notifier).refresh();
  }

  Future<void> _restoreSpace(Space space) async {
    final restored = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _RestoreSpaceDialog(
        spaceTitle: space.title,
        onRestore: () async {
          return await ref.read(trashProvider.notifier).restoreSpace(space.id);
        },
      ),
    );

    if (restored == true && mounted) {
      // Refresh spaces list to show restored space
      ref.read(spacesProvider.notifier).refresh();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${space.title}" restored successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final trashState = ref.watch(trashProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _buildContent(trashState, theme),
      ),
    );
  }

  Widget _buildContent(TrashState trashState, ThemeData theme) {
    if (trashState.isLoading && trashState.trashedSpaces.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (trashState.error != null && trashState.trashedSpaces.isEmpty) {
      return ErrorState(
        message: trashState.error!,
        onRetry: _onRefresh,
      );
    }

    if (trashState.trashedSpaces.isEmpty) {
      return EmptyState(
        icon: Icons.delete_outline,
        title: 'Trash is Empty',
        message: 'Deleted spaces will appear here for 7 days before being permanently removed.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: trashState.trashedSpaces.length,
      itemBuilder: (context, index) {
        final space = trashState.trashedSpaces[index];
        return _TrashItem(
          space: space,
          onRestore: () => _restoreSpace(space),
        );
      },
    );
  }
}

/// Dialog for restoring a space with loading state
class _RestoreSpaceDialog extends StatefulWidget {
  final String spaceTitle;
  final Future<bool> Function() onRestore;

  const _RestoreSpaceDialog({
    required this.spaceTitle,
    required this.onRestore,
  });

  @override
  State<_RestoreSpaceDialog> createState() => _RestoreSpaceDialogState();
}

class _RestoreSpaceDialogState extends State<_RestoreSpaceDialog> {
  bool _isRestoring = false;

  Future<void> _handleRestore() async {
    setState(() => _isRestoring = true);
    try {
      final success = await widget.onRestore();
      if (mounted) {
        Navigator.pop(context, success);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isRestoring = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to restore: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Restore Space'),
      content: Text('Restore "${widget.spaceTitle}" from trash?'),
      actions: [
        TextButton(
          onPressed: _isRestoring ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _isRestoring ? null : _handleRestore,
          child: _isRestoring
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Restore'),
        ),
      ],
    );
  }
}

class _TrashItem extends StatelessWidget {
  final Space space;
  final VoidCallback onRestore;

  const _TrashItem({
    required this.space,
    required this.onRestore,
  });

  String? _convertEmojiCode(String? emojiCode) {
    if (emojiCode == null || emojiCode.isEmpty) return null;
    try {
      final codePoint = int.parse(emojiCode, radix: 16);
      return String.fromCharCode(codePoint);
    } catch (e) {
      return emojiCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysRemaining = space.daysUntilPermanentDeletion;
    final emoji = _convertEmojiCode(space.emoji);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: emoji != null
                ? Text(emoji, style: const TextStyle(fontSize: 20))
                : Icon(
                    Icons.description_outlined,
                    color: theme.colorScheme.onErrorContainer,
                  ),
          ),
        ),
        title: Text(
          space.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          daysRemaining != null && daysRemaining > 0
              ? 'Permanently deleted in $daysRemaining day${daysRemaining == 1 ? '' : 's'}'
              : 'Will be permanently deleted soon',
          style: TextStyle(
            color: theme.colorScheme.error,
            fontSize: 12,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.restore),
          tooltip: 'Restore',
          onPressed: onRestore,
        ),
      ),
    );
  }
}
