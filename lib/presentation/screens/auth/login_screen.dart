import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/config/app_config.dart';
import '../../../domain/entities/auth_entity.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/loading_button.dart';

/// Login screen with OAuth and API token options
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _apiTokenController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showApiTokenInput = false;
  bool _obscureToken = true;

  @override
  void dispose() {
    _apiTokenController.dispose();
    super.dispose();
  }

  Future<void> _launchOAuthLogin() async {
    final config = AppConfig.current;
    final authUrl = Uri.parse(
      '${config.baseUrl}/oauth/authorize'
      '?client_id=${config.clientId}'
      '&redirect_uri=${Uri.encodeComponent(config.redirectUri)}'
      '&response_type=code'
      '&scope=content:read content:write',
    );

    if (await canLaunchUrl(authUrl)) {
      await launchUrl(authUrl, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open browser for login')),
        );
      }
    }
  }

  Future<void> _loginWithApiToken() async {
    if (!_formKey.currentState!.validate()) return;

    final token = _apiTokenController.text.trim();
    await ref.read(authNotifierProvider.notifier).loginWithApiToken(token);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);

    // Show error snackbar if there's an error
    ref.listen<AuthUiState>(authNotifierProvider, (previous, next) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: theme.colorScheme.error,
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: theme.colorScheme.onError,
              onPressed: () {
                ref.read(authNotifierProvider.notifier).clearError();
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo and title
                  Icon(
                    Icons.menu_book_rounded,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'GitBook',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to access your documentation',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),

                  // OAuth login button
                  LoadingButton(
                    onPressed: authState.isLoading ? null : _launchOAuthLogin,
                    isLoading: authState.isLoading && !_showApiTokenInput,
                    label: 'Sign in with GitBook',
                    icon: Icons.login,
                  ),
                  const SizedBox(height: 16),

                  // Divider
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'or',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // API Token option
                  if (!_showApiTokenInput) ...[
                    LoadingOutlinedButton(
                      onPressed: () {
                        setState(() {
                          _showApiTokenInput = true;
                        });
                      },
                      label: 'Use API Token',
                      icon: Icons.key,
                    ),
                  ] else ...[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _apiTokenController,
                            obscureText: _obscureToken,
                            decoration: InputDecoration(
                              labelText: 'API Token',
                              hintText: 'Enter your GitBook API token',
                              prefixIcon: const Icon(Icons.key),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureToken
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureToken = !_obscureToken;
                                  });
                                },
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your API token';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _loginWithApiToken(),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      _showApiTokenInput = false;
                                      _apiTokenController.clear();
                                    });
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: LoadingButton(
                                  onPressed: authState.isLoading
                                      ? null
                                      : _loginWithApiToken,
                                  isLoading: authState.isLoading,
                                  label: 'Sign In',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Help text
                  Text(
                    'You can find your API token in your GitBook account settings.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
