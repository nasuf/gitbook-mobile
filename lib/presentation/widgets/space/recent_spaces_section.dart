import 'package:flutter/material.dart';

import '../../../domain/entities/space_entity.dart';

/// Horizontal scrollable list of recent spaces
class RecentSpacesSection extends StatelessWidget {
  final List<RecentSpaceItem> items;
  final void Function(RecentSpaceItem) onSpaceTap;

  const RecentSpacesSection({
    super.key,
    required this.items,
    required this.onSpaceTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return _RecentSpaceCard(
            item: item,
            onTap: () => onSpaceTap(item),
          );
        },
      ),
    );
  }
}

class _RecentSpaceCard extends StatelessWidget {
  final RecentSpaceItem item;
  final VoidCallback onTap;

  const _RecentSpaceCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.description_outlined,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  item.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item.organizationTitle != null)
                Text(
                  item.organizationTitle!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
