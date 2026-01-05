import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../widgets/common/loading_button.dart';

/// Type of content to create
enum CreateType { space, collection }

/// Screen for creating a new space or collection
class CreateSpaceScreen extends ConsumerStatefulWidget {
  const CreateSpaceScreen({super.key});

  @override
  ConsumerState<CreateSpaceScreen> createState() => _CreateSpaceScreenState();
}

class _CreateSpaceScreenState extends ConsumerState<CreateSpaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  CreateType _createType = CreateType.space;
  SpaceVisibility _visibility = SpaceVisibility.private;
  SpaceCollection? _parentCollection;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load collections for parent selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(spacesProvider.notifier).loadAllCollections();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool success = false;

    if (_createType == CreateType.collection) {
      final collection = await ref.read(spacesProvider.notifier).createCollection(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
          );
      success = collection != null;
    } else {
      final space = await ref.read(spacesProvider.notifier).createSpace(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
            visibility: _visibility,
            parentCollectionId: _parentCollection?.id,
          );
      success = space != null;
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spacesState = ref.watch(spacesProvider);
    final collections = spacesState.allCollections;

    return Scaffold(
      appBar: AppBar(
        title: Text(_createType == CreateType.collection ? 'Create Collection' : 'Create Space'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Type selector
            Text(
              'Type',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            SegmentedButton<CreateType>(
              segments: const [
                ButtonSegment(
                  value: CreateType.space,
                  label: Text('Space'),
                  icon: Icon(Icons.description_outlined),
                ),
                ButtonSegment(
                  value: CreateType.collection,
                  label: Text('Collection'),
                  icon: Icon(Icons.folder_outlined),
                ),
              ],
              selected: {_createType},
              onSelectionChanged: (selected) {
                setState(() {
                  _createType = selected.first;
                  // Reset parent when switching to collection
                  if (_createType == CreateType.collection) {
                    _parentCollection = null;
                  }
                });
              },
            ),
            const SizedBox(height: 24),

            // Title
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: _createType == CreateType.collection
                    ? 'Enter collection title'
                    : 'Enter space title',
                border: const OutlineInputBorder(),
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

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Parent collection (only for spaces)
            if (_createType == CreateType.space) ...[
              Text(
                'Parent Collection (optional)',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _ParentCollectionDropdown(
                collections: collections,
                selectedCollection: _parentCollection,
                onChanged: (collection) {
                  setState(() => _parentCollection = collection);
                },
              ),
              const SizedBox(height: 24),
            ],

            // Visibility (only for spaces)
            if (_createType == CreateType.space) ...[
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
            ],

            // Create button
            LoadingButton(
              onPressed: _create,
              isLoading: _isLoading,
              label: _createType == CreateType.collection ? 'Create Collection' : 'Create Space',
            ),
          ],
        ),
      ),
    );
  }
}

class _ParentCollectionDropdown extends StatelessWidget {
  final List<SpaceCollection> collections;
  final SpaceCollection? selectedCollection;
  final ValueChanged<SpaceCollection?> onChanged;

  const _ParentCollectionDropdown({
    required this.collections,
    required this.selectedCollection,
    required this.onChanged,
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
    // Build menu entries
    final menuEntries = <DropdownMenuEntry<String?>>[
      const DropdownMenuEntry<String?>(
        value: null,
        label: 'None (Standalone Space)',
        leadingIcon: Icon(Icons.description_outlined, size: 20),
      ),
      ...collections.map((collection) {
        final emoji = _convertEmojiCode(collection.emoji);
        return DropdownMenuEntry<String?>(
          value: collection.id,
          label: collection.title,
          leadingIcon: emoji != null
              ? Text(emoji, style: const TextStyle(fontSize: 18))
              : const Icon(Icons.folder_outlined, size: 20),
        );
      }),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String?>(
          initialSelection: selectedCollection?.id,
          width: constraints.maxWidth,
          menuHeight: 300,
          requestFocusOnTap: false,
          enableFilter: false,
          expandedInsets: EdgeInsets.zero,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          dropdownMenuEntries: menuEntries,
          onSelected: (value) {
            if (value == null) {
              onChanged(null);
            } else {
              final collection = collections.firstWhere((c) => c.id == value);
              onChanged(collection);
            }
          },
        );
      },
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
