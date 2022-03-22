import 'package:food_delivery/services/storage.service.dart';
import 'package:food_delivery/utils/logging_service_writer.dart';
import 'package:get_it/get_it.dart';

import 'application_information.service.dart';
import 'dialog.service.dart';
import 'logging.service.dart';

GetIt locator = GetIt.instance;

Future setupServices() async {
  StorageService _instance = await StorageService.getInstance();
  LoggingService _loggingInstance = LoggingService.getInstance();
  ApplicationInformationService _applicationInformationInstance =
      await ApplicationInformationService.getInstance();

  locator.registerSingleton<StorageService>(_instance);
  locator.registerSingleton<DialogService>(DialogService());
  locator.registerSingleton<LoggingService>(_loggingInstance);
  locator.registerSingleton<ApplicationInformationService>(
      _applicationInformationInstance);
  await LoggingServiceWriter().init();
}
