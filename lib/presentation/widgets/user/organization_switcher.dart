import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/organization_model.dart';
import '../../providers/user_provider.dart';

/// Widget for switching between organizations
class OrganizationSwitcher extends ConsumerWidget {
  final VoidCallback? onOrganizationChanged;

  const OrganizationSwitcher({
    super.key,
    this.onOrganizationChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(organizationsProvider);
    final theme = Theme.of(context);

    if (state.isLoading && state.organizations.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.organizations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_outlined,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No organizations found',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(organizationsProvider.notifier).refresh(),
      child: ListView.builder(
        itemCount: state.organizations.length,
        itemBuilder: (context, index) {
          final org = state.organizations[index];
          final isSelected = org.id == state.currentOrganization?.id;

          return _OrganizationTile(
            organization: org,
            isSelected: isSelected,
            onTap: () {
              ref
                  .read(organizationsProvider.notifier)
                  .setCurrentOrganization(org);
              onOrganizationChanged?.call();
            },
          );
        },
      ),
    );
  }
}

class _OrganizationTile extends StatelessWidget {
  final OrganizationModel organization;
  final bool isSelected;
  final VoidCallback? onTap;

  const _OrganizationTile({
    required this.organization,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.surfaceContainerHighest,
        child: Text(
          _getInitials(organization.title),
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      title: Text(
        organization.title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      selected: isSelected,
      onTap: onTap,
    );
  }

  String _getInitials(String title) {
    final words = title.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '?';
    if (words.length == 1) {
      return words[0].substring(0, words[0].length.clamp(0, 2)).toUpperCase();
    }
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }
}

/// Bottom sheet for selecting an organization
class OrganizationSwitcherBottomSheet extends StatelessWidget {
  final VoidCallback? onOrganizationChanged;

  const OrganizationSwitcherBottomSheet({
    super.key,
    this.onOrganizationChanged,
  });

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onOrganizationChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => OrganizationSwitcherBottomSheet(
        onOrganizationChanged: onOrganizationChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle
            Container(
              width: 32,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Switch Organization',
                style: theme.textTheme.titleLarge,
              ),
            ),
            const Divider(),
            // List
            Expanded(
              child: OrganizationSwitcher(
                onOrganizationChanged: () {
                  onOrganizationChanged?.call();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
