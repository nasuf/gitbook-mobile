/// App configuration based on environment
enum Environment { dev, staging, prod }

class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;

  const AppConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
  });

  static AppConfig? _instance;

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception('AppConfig not initialized. Call AppConfig.init() first.');
    }
    return _instance!;
  }

  static void init(Environment env) {
    _instance = switch (env) {
      Environment.dev => const AppConfig._(
          environment: Environment.dev,
          apiBaseUrl: 'https://api.gitbook.com/v1',
          enableLogging: true,
        ),
      Environment.staging => const AppConfig._(
          environment: Environment.staging,
          apiBaseUrl: 'https://api.gitbook.com/v1',
          enableLogging: true,
        ),
      Environment.prod => const AppConfig._(
          environment: Environment.prod,
          apiBaseUrl: 'https://api.gitbook.com/v1',
          enableLogging: false,
        ),
    };
  }

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}
