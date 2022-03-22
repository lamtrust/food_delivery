import 'package:food_delivery/models/log_level.model.dart';

class Logging {
  String id;
  String timestamp;
  LogLevel logLevel;
  String message;
  String stacktrace;

  Logging({
    required this.id,
    required this.timestamp,
    required this.logLevel,
    required this.message,
    this.stacktrace = "",
  });

  @override
  String toString() {
    List<String> result = [];
    result.add("[LOGGING] ${logLevel.toString()} $timestamp Message: $message");
    if (stacktrace.isNotEmpty) {
      result.add("[LOGGING] StackTrace: $stacktrace");
    }
    return result.join("\n");
  }
}
