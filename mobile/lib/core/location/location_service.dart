import 'package:geolocator/geolocator.dart';

class LocationService {
  const LocationService();

  Future<Position> determinePosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationServiceDisabledException();
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationPermissionException('Location permission was denied.');
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationPermissionException(
        'Location permission is permanently denied. Enable it in Settings.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }
}

class LocationPermissionException implements Exception {
  const LocationPermissionException(this.message);
  final String message;

  @override
  String toString() => message;
}
