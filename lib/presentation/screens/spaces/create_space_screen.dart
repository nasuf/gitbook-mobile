import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../widgets/common/loading_button.dart';

/// Screen for creating a new space
class CreateSpaceScreen extends ConsumerStatefulWidget {
  const CreateSpaceScreen({super.key});

  @override
  ConsumerState<CreateSpaceScreen> createState() => _CreateSpaceScreenState();
}

class _CreateSpaceScreenState extends ConsumerState<CreateSpaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  SpaceVisibility _visibility = SpaceVisibility.private;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createSpace() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final space = await ref.read(spacesProvider.notifier).createSpace(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          visibility: _visibility,
        );

    setState(() => _isLoading = false);

    if (space != null && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Space'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter space title',
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
                labelText: 'Description (optional)',
                hintText: 'Enter space description',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            Text(
              'Visibility',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _VisibilityOption(
              title: 'Private',
              description: 'Only members can access',
              icon: Icons.lock,
              isSelected: _visibility == SpaceVisibility.private,
              onTap: () => setState(() => _visibility = SpaceVisibility.private),
            ),
            _VisibilityOption(
              title: 'Public',
              description: 'Anyone can access',
              icon: Icons.public,
              isSelected: _visibility == SpaceVisibility.public,
              onTap: () => setState(() => _visibility = SpaceVisibility.public),
            ),
            _VisibilityOption(
              title: 'Unlisted',
              description: 'Anyone with the link can access',
              icon: Icons.link,
              isSelected: _visibility == SpaceVisibility.unlisted,
              onTap: () => setState(() => _visibility = SpaceVisibility.unlisted),
            ),
            const SizedBox(height: 32),
            LoadingButton(
              onPressed: _createSpace,
              isLoading: _isLoading,
              label: 'Create Space',
            ),
          ],
        ),
      ),
    );
  }
}

class _VisibilityOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _VisibilityOption({
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
