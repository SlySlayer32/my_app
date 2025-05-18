import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/core/config/environment_config.dart';

/// Utility for logging based on environment configuration
class AppLogger {
  static final EnvironmentConfig _config = GetIt.instance<EnvironmentConfig>();

  /// Log a debug message
  static void d(String tag, String message) {
    if (_config.enableLogging || kDebugMode) {
      debugPrint('DEBUG [$tag]: $message');
    }
  }

  /// Log an info message
  static void i(String tag, String message) {
    if (_config.enableLogging || kDebugMode) {
      debugPrint('INFO [$tag]: $message');
    }
  }

  /// Log a warning message
  static void w(String tag, String message) {
    if (_config.enableLogging || kDebugMode) {
      debugPrint('WARNING [$tag]: $message');
    }
  }

  /// Log an error message
  static void e(String tag, String message, {StackTrace? stackTrace}) {
    if (_config.enableLogging || kDebugMode) {
      debugPrint('ERROR [$tag]: $message');
      if (stackTrace != null) {
        debugPrint(stackTrace.toString());
      }
    }

    // In non-development environments, you could send errors to a service like Firebase Crashlytics
    if (!_config.isDevelopment && _config.enableCrashlytics) {
      // Example: FirebaseCrashlytics.instance.recordError(message, stackTrace);
    }
  }
}
