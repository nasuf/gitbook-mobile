import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/user_entity.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/organization_switcher.dart';
import '../../widgets/user/user_avatar.dart';

/// User profile screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final orgsState = ref.watch(organizationsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          // User info section
          _buildUserSection(context, authState.user, theme),

          const Divider(),

          // Current organization
          _buildOrganizationSection(context, ref, orgsState, theme),

          const Divider(),

          // Account actions
          _buildAccountSection(context, ref, theme),
        ],
      ),
    );
  }

  Widget _buildUserSection(
    BuildContext context,
    User? user,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          UserAvatar(user: user, size: 80),
          const SizedBox(height: 16),
          Text(
            user?.name ?? 'Unknown User',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (user?.email != null) ...[
            const SizedBox(height: 4),
            Text(
              user!.email!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOrganizationSection(
    BuildContext context,
    WidgetRef ref,
    OrganizationsState orgsState,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'ORGANIZATION',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              _getOrgInitials(orgsState.currentOrganization?.title),
              style: TextStyle(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          title: Text(
            orgsState.currentOrganization?.title ?? 'No organization selected',
          ),
          subtitle: orgsState.organizations.length > 1
              ? Text('${orgsState.organizations.length} organizations')
              : null,
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            OrganizationSwitcherBottomSheet.show(context);
          },
        ),
      ],
    );
  }

  Widget _buildAccountSection(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'ACCOUNT',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: theme.colorScheme.error,
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(color: theme.colorScheme.error),
          ),
          onTap: () => _showLogoutConfirmation(context, ref),
        ),
      ],
    );
  }

  String _getOrgInitials(String? title) {
    if (title == null) return '?';
    final words = title.trim().split(RegExp(r'\s+'));
    if (words.isEmpty) return '?';
    if (words.length == 1) {
      return words[0].substring(0, words[0].length.clamp(0, 2)).toUpperCase();
    }
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authNotifierProvider.notifier).logout();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(userSettingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Appearance section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'APPEARANCE',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            subtitle: Text(_getThemeLabel(settingsState.settings.themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeSelector(context, ref, settingsState),
          ),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Font Size'),
            subtitle: Text('${settingsState.settings.fontSize.toInt()} pt'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showFontSizeSelector(context, ref, settingsState),
          ),

          const Divider(),

          // Editor section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'EDITOR',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit_note),
            title: const Text('Default Editor Mode'),
            subtitle:
                Text(_getEditorModeLabel(settingsState.settings.defaultEditorMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showEditorModeSelector(context, ref, settingsState),
          ),

          const Divider(),

          // Offline section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'OFFLINE',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.offline_bolt_outlined),
            title: const Text('Offline Mode'),
            subtitle: const Text('Cache content for offline access'),
            value: settingsState.settings.offlineModeEnabled,
            onChanged: (value) {
              ref.read(userSettingsProvider.notifier).updateOfflineMode(value);
            },
          ),

          const Divider(),

          // About section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'ABOUT',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
          ListTile(
            leading: const Icon(Icons.gavel_outlined),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // TODO: Open terms of service
            },
          ),
        ],
      ),
    );
  }

  String _getThemeLabel(ThemeModeSetting mode) {
    switch (mode) {
      case ThemeModeSetting.light:
        return 'Light';
      case ThemeModeSetting.dark:
        return 'Dark';
      case ThemeModeSetting.system:
        return 'System';
    }
  }

  String _getEditorModeLabel(EditorMode mode) {
    switch (mode) {
      case EditorMode.wysiwyg:
        return 'Visual Editor';
      case EditorMode.markdown:
        return 'Markdown';
      case EditorMode.split:
        return 'Split View';
    }
  }

  void _showThemeSelector(
    BuildContext context,
    WidgetRef ref,
    UserSettingsState state,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Theme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...ThemeModeSetting.values.map((mode) => RadioListTile<ThemeModeSetting>(
                title: Text(_getThemeLabel(mode)),
                value: mode,
                groupValue: state.settings.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(userSettingsProvider.notifier).updateThemeMode(value);
                  }
                  Navigator.of(context).pop();
                },
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showFontSizeSelector(
    BuildContext context,
    WidgetRef ref,
    UserSettingsState state,
  ) {
    final sizes = [12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0];

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Font Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...sizes.map((size) => RadioListTile<double>(
                title: Text('${size.toInt()} pt'),
                value: size,
                groupValue: state.settings.fontSize,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(userSettingsProvider.notifier).updateFontSize(value);
                  }
                  Navigator.of(context).pop();
                },
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showEditorModeSelector(
    BuildContext context,
    WidgetRef ref,
    UserSettingsState state,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Editor Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...EditorMode.values.map((mode) => RadioListTile<EditorMode>(
                title: Text(_getEditorModeLabel(mode)),
                value: mode,
                groupValue: state.settings.defaultEditorMode,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(userSettingsProvider.notifier).updateEditorMode(value);
                  }
                  Navigator.of(context).pop();
                },
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
