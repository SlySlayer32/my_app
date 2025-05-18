import 'package:flutter/foundation.dart';

enum Environment {
  development,
  staging,
  production,
}

class EnvironmentConfig {
  const EnvironmentConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableFirebaseAnalytics,
    required this.enableCrashlytics,
  });
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool enableFirebaseAnalytics;
  final bool enableCrashlytics;

  static const EnvironmentConfig development = EnvironmentConfig(
    environment: Environment.development,
    apiBaseUrl: 'https://dev-api.example.com',
    enableLogging: true,
    enableFirebaseAnalytics: false,
    enableCrashlytics: false,
  );

  static const EnvironmentConfig staging = EnvironmentConfig(
    environment: Environment.staging,
    apiBaseUrl: 'https://staging-api.example.com',
    enableLogging: true,
    enableFirebaseAnalytics: true,
    enableCrashlytics: true,
  );

  static const EnvironmentConfig production = EnvironmentConfig(
    environment: Environment.production,
    apiBaseUrl: 'https://api.example.com',
    enableLogging: false,
    enableFirebaseAnalytics: true,
    enableCrashlytics: true,
  );

  bool get isDevelopment => environment == Environment.development;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.production;
  bool get isDebugMode => kDebugMode;
  bool get isReleaseMode => kReleaseMode;
}
