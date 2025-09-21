import 'dart:developer' as developer;

class Logger {
  static void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    developer.log(
      '❌ ERROR: $message',
      name: 'PropertyApp',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void logInfo(String message) {
    developer.log('ℹ️ INFO: $message', name: 'PropertyApp');
  }

  static void logWarning(String message) {
    developer.log('⚠️ WARNING: $message', name: 'PropertyApp');
  }

  static void logNetworkError(String endpoint, dynamic error) {
    developer.log(
      '🌐 NETWORK ERROR: Failed to fetch $endpoint - Check internet connection',
      name: 'PropertyApp',
      error: error,
    );
  }
}