import 'dart:developer';

import 'package:food_delivery/models/log_level.model.dart';

class LoggingService {
  static LoggingService? _instance;
  static LoggingService getInstance() {
    _instance ??= LoggingService();
    _instance!._start();
    return _instance!;
  }

  void _start() {
    logd(LogLevel.INFO, "$runtimeType started");
  }

  void logd(LogLevel logLevel, String message, {StackTrace? stacktrace}) =>
      log(message, stackTrace: stacktrace);
}
