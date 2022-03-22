import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/log_level.model.dart';
import 'package:food_delivery/models/logging.model.dart';
import 'package:uuid/uuid.dart';

class LoggingService {
  static LoggingService? _instance;
  static LoggingService getInstance() {
    _instance ??= LoggingService();
    _instance!._start();
    return _instance!;
  }

  final int _maxCacheRows = 1000;
  List<Logging> _cacheLog = [];
  void Function(Logging logging)? _writer;

  void _start() {
    log(LogLevel.INFO, "$runtimeType started");
  }

  void setWriter(void Function(Logging logging) writer) {
    _writer = writer;
    _cacheLog.forEach((a) {
      _writer!(a);
    });
  }

  void log(LogLevel logLevel, String message, {String stacktrace = ""}) {
    var logged_log = Logging(
      id: Uuid().v4(),
      message: message,
      logLevel: logLevel,
      timestamp: DateTime.now().toUtc().toIso8601String(),
      stacktrace: stacktrace,
    );

    debugPrint(logged_log.toString());

    if (Platform.isAndroid) {
      if (_writer == null) {
        debugPrint("Writer is not available");
        _cacheLog.add(logged_log);
        if (_cacheLog.length > _maxCacheRows) {
          _cacheLog.removeRange(0, _cacheLog.length - _maxCacheRows);
        }
      } else {
        _writer!(logged_log);
      }
    }
  }
}
