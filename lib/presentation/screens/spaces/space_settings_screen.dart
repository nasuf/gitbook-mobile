import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';

/// Screen for editing space settings
class SpaceSettingsScreen extends ConsumerStatefulWidget {
  final String spaceId;

  const SpaceSettingsScreen({
    super.key,
    required this.spaceId,
  });

  @override
  ConsumerState<SpaceSettingsScreen> createState() => _SpaceSettingsScreenState();
}

class _SpaceSettingsScreenState extends ConsumerState<SpaceSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  SpaceVisibility? _visibility;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    // Initialize with current values after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(spaceDetailProvider(widget.spaceId));
      if (state.space != null) {
        _titleController.text = state.space!.title;
        _descriptionController.text = state.space!.description ?? '';
        setState(() {
          _visibility = state.space!.visibility;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _markAsChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final success = await ref.read(spaceDetailProvider(widget.spaceId).notifier).updateSpace(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      visibility: _visibility,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings saved')),
      );
      Navigator.of(context).pop();
    }
  }

  Future<void> _confirmDelete() async {
    final state = ref.read(spaceDetailProvider(widget.spaceId));
    final spaceName = state.space?.title ?? 'this space';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Space'),
        content: Text(
          'Are you sure you want to delete "$spaceName"? This action cannot be undone and all content will be permanently deleted.',
        ),
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
      await ref.read(spacesProvider.notifier).deleteSpace(widget.spaceId);
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(spaceDetailProvider(widget.spaceId));

    if (state.isLoading && state.space == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Space Settings'),
        actions: [
          if (_hasChanges)
            TextButton(
              onPressed: _isLoading ? null : _saveChanges,
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        onChanged: _markAsChanged,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'General',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Text(
              'Visibility',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _VisibilitySelector(
              value: _visibility,
              onChanged: (value) {
                setState(() => _visibility = value);
                _markAsChanged();
              },
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Danger Zone',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete_forever),
              label: const Text('Delete Space'),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisibilitySelector extends StatelessWidget {
  final SpaceVisibility? value;
  final ValueChanged<SpaceVisibility> onChanged;

  const _VisibilitySelector({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _VisibilityOption(
          visibility: SpaceVisibility.private,
          title: 'Private',
          description: 'Only members can access',
          icon: Icons.lock,
          isSelected: value == SpaceVisibility.private,
          onTap: () => onChanged(SpaceVisibility.private),
        ),
        _VisibilityOption(
          visibility: SpaceVisibility.public,
          title: 'Public',
          description: 'Anyone can access',
          icon: Icons.public,
          isSelected: value == SpaceVisibility.public,
          onTap: () => onChanged(SpaceVisibility.public),
        ),
        _VisibilityOption(
          visibility: SpaceVisibility.unlisted,
          title: 'Unlisted',
          description: 'Anyone with the link can access',
          icon: Icons.link,
          isSelected: value == SpaceVisibility.unlisted,
          onTap: () => onChanged(SpaceVisibility.unlisted),
        ),
      ],
    );
  }
}

class _VisibilityOption extends StatelessWidget {
  final SpaceVisibility visibility;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _VisibilityOption({
    required this.visibility,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withValues(alpha: 0.3),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        subtitle: Text(description),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
            : null,
        onTap: onTap,
      ),
    );
  }
}
