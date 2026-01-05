/// App configuration based on environment
enum Environment { dev, staging, prod }

class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;
  final String clientId;
  final String redirectUri;

  const AppConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.clientId,
    required this.redirectUri,
  });

  static AppConfig? _instance;

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception('AppConfig not initialized. Call AppConfig.init() first.');
    }
    return _instance!;
  }

  /// Get current config (alias for instance)
  static AppConfig get current => instance;

  static void init(Environment env) {
    _instance = switch (env) {
      Environment.dev => const AppConfig._(
          environment: Environment.dev,
          apiBaseUrl: 'https://api.gitbook.com/v1',
          enableLogging: true,
          clientId: 'gitbook-mobile-dev',
          redirectUri: 'gitbook://oauth/callback',
        ),
      Environment.staging => const AppConfig._(
          environment: Environment.staging,
          apiBaseUrl: 'https://api.gitbook.com/v1',
          enableLogging: true,
          clientId: 'gitbook-mobile-staging',
          redirectUri: 'gitbook://oauth/callback',
        ),
      Environment.prod => const AppConfig._(
          environment: Environment.prod,
          apiBaseUrl: 'https://api.gitbook.com/v1',
          enableLogging: false,
          clientId: 'gitbook-mobile',
          redirectUri: 'gitbook://oauth/callback',
        ),
    };
  }

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;

  /// Base URL without API version path
  String get baseUrl => 'https://api.gitbook.com';
}
