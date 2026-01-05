import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../providers/auth_provider.dart';

/// Handler for OAuth callback deep links
class OAuthCallbackHandler extends ConsumerStatefulWidget {
  final Uri uri;

  const OAuthCallbackHandler({
    super.key,
    required this.uri,
  });

  @override
  ConsumerState<OAuthCallbackHandler> createState() =>
      _OAuthCallbackHandlerState();
}

class _OAuthCallbackHandlerState extends ConsumerState<OAuthCallbackHandler> {
  String? _error;
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    _handleCallback();
  }

  Future<void> _handleCallback() async {
    try {
      final code = widget.uri.queryParameters['code'];
      final error = widget.uri.queryParameters['error'];
      final errorDescription = widget.uri.queryParameters['error_description'];

      if (error != null) {
        setState(() {
          _error = errorDescription ?? error;
          _isProcessing = false;
        });
        return;
      }

      if (code == null) {
        setState(() {
          _error = 'No authorization code received';
          _isProcessing = false;
        });
        return;
      }

      // Exchange code for tokens
      await ref.read(authNotifierProvider.notifier).loginWithOAuth(
            authorizationCode: code,
            redirectUri: AppConfig.current.redirectUri,
          );

      if (mounted) {
        // Navigate to home or close
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isProcessing) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                Text(
                  'Completing sign in...',
                  style: theme.textTheme.titleMedium,
                ),
              ] else if (_error != null) ...[
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  'Sign in failed',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
