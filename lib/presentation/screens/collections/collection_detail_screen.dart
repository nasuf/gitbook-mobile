import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/space_entity.dart';
import '../../providers/space_provider.dart';
import '../../providers/user_provider.dart';

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

/// Screen for viewing collection details
class CollectionDetailScreen extends ConsumerWidget {
  final SpaceCollection collection;

  const CollectionDetailScreen({
    super.key,
    required this.collection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final spacesState = ref.watch(spacesProvider);
    final spacesInCollection = spacesState.spacesInCollection(collection.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(collection.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Collection Header
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
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _convertEmojiCode(collection.emoji) != null
                              ? Text(
                                  _convertEmojiCode(collection.emoji)!,
                                  style: const TextStyle(fontSize: 32),
                                )
                              : Icon(
                                  Icons.folder_outlined,
                                  size: 32,
                                  color: theme.colorScheme.onSecondaryContainer,
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              collection.title,
                              style: theme.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${spacesInCollection.length} space${spacesInCollection.length == 1 ? '' : 's'}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (collection.description != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      collection.description!,
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
          // Spaces in Collection
          Text(
            'Spaces',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          if (spacesInCollection.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.folder_open_outlined,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No spaces in this collection',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...spacesInCollection.map((space) => _SpaceCard(
                  space: space,
                  onTap: () {
                    ref.read(recentSpacesProvider.notifier).addRecent(
                          space,
                          organizationTitle: ref
                              .read(organizationsProvider)
                              .currentOrganization
                              ?.title,
                        );
                    Navigator.of(context).pushNamed('/space/${space.id}');
                  },
                )),
          const SizedBox(height: 16),
          // Collection Info
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
                  value: collection.createdAt != null
                      ? _formatDate(collection.createdAt!)
                      : 'Unknown',
                ),
                const Divider(height: 1),
                _InfoRow(
                  label: 'Last Updated',
                  value: collection.updatedAt != null
                      ? _formatDate(collection.updatedAt!)
                      : 'Unknown',
                ),
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

class _SpaceCard extends StatelessWidget {
  final Space space;
  final VoidCallback onTap;

  const _SpaceCard({
    required this.space,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
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
        title: Text(space.title),
        subtitle: space.description != null
            ? Text(
                space.description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
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
          Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
