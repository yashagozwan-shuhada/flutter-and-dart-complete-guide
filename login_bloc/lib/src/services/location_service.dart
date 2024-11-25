import 'package:login_bloc/src/models/coordinate_model.dart';

enum LocationStatus {
  denied,
  deniedForever,
  grand,
}

abstract interface class LocationService {
  Future<bool> requestService();

  Future<bool> isGpsEnable();

  Future<bool> checkPermission();

  Future<LocationStatus> getStatus();

  Future<CoordinateModel> getCoordinate();

  Future<CoordinateModel?> getCoordinateWithRequestPermission();

  Future<void> openAppSettings();
}
