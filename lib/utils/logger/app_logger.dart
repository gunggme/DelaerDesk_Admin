import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error;

  String get emoji {
    switch (this) {
      case LogLevel.debug:
        return '🔍';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
    }
  }
}

class AppLogger {
  final String className;

  const AppLogger(this.className);

  void debug(String message) {
    _log(LogLevel.debug, message);
  }

  void info(String message) {
    _log(LogLevel.info, message);
  }

  void warning(String message) {
    _log(LogLevel.warning, message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message);
    if (error != null) {
      _log(LogLevel.error, 'Error details: $error');
    }
    if (stackTrace != null) {
      _log(LogLevel.error, 'Stack trace: $stackTrace');
    }
  }

  void _log(LogLevel level, String message) {
    if (kDebugMode) {
      final timestamp = DateTime.now().toString().split('.').first;
      print('${level.emoji} [$timestamp] $className: $message');
    }
  }
}
