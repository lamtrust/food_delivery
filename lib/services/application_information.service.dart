import 'package:package_info_plus/package_info_plus.dart';

class ApplicationInformationService {
  static ApplicationInformationService? _instance;
  static PackageInfo? _packageInfo;

  static Future<ApplicationInformationService> getInstance() async {
    _instance ??= ApplicationInformationService();

    _packageInfo ??= await PackageInfo.fromPlatform();

    return _instance!;
  }

  PackageInfo get packageInfo => _packageInfo!;
}
