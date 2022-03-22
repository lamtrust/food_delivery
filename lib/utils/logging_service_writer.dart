import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:food_delivery/models/log_level.model.dart';
import 'package:food_delivery/models/logging.model.dart';
import 'package:food_delivery/services/index.dart';
import 'package:food_delivery/services/logging.service.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

const String externalLogFilename = "tumai_log.txt";
const String externalBackupLogFilename = "tumai_backup_log.txt";

class LoggingServiceWriter {
  final LoggingService _loggingService = locator<LoggingService>();
  File? _logFile;
  String? _logFilename;
  File? _backupLogFile;
  String? _backupLogFilename;

  Future<void> init() async {
    if (Platform.isAndroid) {
      Directory? directory = await getExternalStorageDirectory();
      _loggingService.log(
          LogLevel.INFO, "External path reported ${directory!.path}");
      _logFilename = join(directory.path, externalLogFilename);
      _logFile = File(_logFilename!);
      _backupLogFilename = join(directory.path, externalBackupLogFilename);
      _backupLogFile = File(_backupLogFilename!);
      connectLogWriter();
    }
  }

  void connectLogWriter() {
    _loggingService.setWriter(_writer);
  }

  void _writer(Logging logging) {
    try {
      if (_logFile!.existsSync() && _logFile!.lengthSync() > 1000000) {
        if (_backupLogFile!.existsSync()) {
          _backupLogFile!.deleteSync();
        }
        _backupLogFile = _logFile!.renameSync(_backupLogFilename!);
        _logFile = File(_logFilename!);
      }
      _logFile!.writeAsStringSync(
        '${DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now())} ${logging.message}\r\n',
        mode: FileMode.append,
        flush: true,
      );
    } catch (e) {
      debugPrint("Error while writing to file ${e.toString()}");
    }
  }
}
