import 'package:location/location.dart';

class LocationService {
  static LocationService? _instance;
  static Location? _location;

  static Future<LocationService> getInstance() async {
    _instance ??= LocationService();

    _location ??= Location();

    return _instance!;
  }

  Future<void> init() async {
    bool _serviceEnabled = await _location!.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location!.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    PermissionStatus _permissionGranted = await _location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    bool _serviceEnabled = await _location!.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location!.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    PermissionStatus _permissionGranted = await _location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    LocationData _locationData = await _location!.getLocation();
    return _locationData;
  }
}
