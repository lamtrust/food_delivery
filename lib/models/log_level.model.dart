import 'package:localregex/enum.dart';

class LogLevel<String> extends Enum {
  /// DEBUG log level should be used for information that may be needed for diagnosing issues and troubleshooting or when running application in the test environment for the purpose of making sure everything is running correctly
  /// [LogLevel.DEBUG]
  static final LogLevel DEBUG = LogLevel("DEBUG");

  /// The standard log level indicating that something happened, the application entered a certain state
  /// [LogLevel.INFO]
  static final LogLevel INFO = LogLevel("INFO");

  /// The log level that indicates that something unexpected happened in the application, a problem, or a situation that might disturb one of the processes. But that doesn’t mean that the application failed. The WARN level should be used in situations that are unexpected, but the code can continue the work. For example, a parsing error occurred that resulted in a certain document not being processed.
  /// [LogLevel.WARNING]
  static final LogLevel WARNING = LogLevel("WARNING");

  ///  The log level that should be used when the application hits an issue preventing one or more functionalities from properly functioning. The ERROR log level can be used when one of the payment systems is not available
  ///  [LogLevel.ERROR]
  static final LogLevel ERROR = LogLevel("ERROR");

  /// The log level that tells that the application encountered an event or entered a state in which one of the crucial business functionality is no longer working. A CRITICAL log level may be used when the application is not able to connect to a crucial data store like a database
  /// [LogLevel.CRITICAL]
  static final LogLevel CRITICAL = LogLevel("CRITICAL");

  /// The most fine-grained information only used in rare cases where you need the full visibility of what is happening in your application and inside the third-party libraries that you use. You can expect the TRACE logging level to be very verbose. You can use it for example to annotate each step in the algorithm or each individual query with parameters in your code.
  /// [LogLevel.TRACE]
  static final LogLevel TRACE = LogLevel("TRACE");

  LogLevel(String value) : super(value);
}
