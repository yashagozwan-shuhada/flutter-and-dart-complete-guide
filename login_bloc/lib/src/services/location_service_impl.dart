import 'package:location/location.dart';
import 'package:login_bloc/src/models/coordinate_model.dart';
import 'package:login_bloc/src/services/location_service.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationServiceImpl implements LocationService {
  final _location = Location();

  Future<CoordinateModel> _getCoordinateNoRequestService() async {
    final locationData = await _location.getLocation();

    return CoordinateModel(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
      isMocked: locationData.isMock,
    );
  }

  @override
  Future<CoordinateModel> getCoordinate() async {
    await requestService();

    final locationData = await _location.getLocation();

    return CoordinateModel(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
      isMocked: locationData.isMock,
    );
  }

  @override
  Future<bool> checkPermission() async {
    await requestService();
    return false;
  }

  @override
  Future<bool> requestService() => _location.requestService();

  @override
  Future<bool> isGpsEnable() => _location.serviceEnabled();

  @override
  Future<void> openAppSettings() async {
    await handler.openAppSettings();
  }

  @override
  Future<LocationStatus> getStatus() async {
    final status = await _location.requestPermission();

    switch (status) {
      case PermissionStatus.granted || PermissionStatus.grantedLimited:
        return LocationStatus.grand;
      case PermissionStatus.denied:
        return LocationStatus.denied;
      case PermissionStatus.deniedForever:
        return LocationStatus.deniedForever;
    }
  }

  @override
  Future<CoordinateModel?> getCoordinateWithRequestPermission() async {
    final isEnable = await isGpsEnable();

    if (!isEnable) {
      await requestService();
    }

    final status = await getStatus();

    if (status == LocationStatus.denied ||
        status == LocationStatus.deniedForever) {
      return null;
    }

    return _getCoordinateNoRequestService();
  }
}
