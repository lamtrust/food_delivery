import 'package:location/location.dart' show Location, LocationData;
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static LocationService? _instance;
  static Location? _location;

  static Future<LocationService> getInstance() async {
    _instance ??= LocationService();

    _location ??= Location();

    return _instance!;
  }

  Future<void> getLocationPermission() async {
    final PermissionStatus locationPermission =
        await Permission.locationWhenInUse.request();
    if (locationPermission.isGranted) {
      return;
    } else {
      return;
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    await getLocationPermission();

    LocationData _locationData = await _location!.getLocation();
    return _locationData;
  }
}
