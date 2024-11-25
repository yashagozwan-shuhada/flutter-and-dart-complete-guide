import 'package:flutter/material.dart';
import 'package:login_bloc/src/constants/image_asset_path.dart';
import 'package:login_bloc/src/models/coordinate_model.dart';
import 'package:login_bloc/src/services/location_service.dart';
import 'package:login_bloc/src/services/location_service_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LocationService _locationService;

  CoordinateModel? _coordinate;

  Future<void> _initial() async {
    _locationService = LocationServiceImpl();

    await Future(() async {
      final status = await _locationService.getStatus();

      if (status == LocationStatus.denied ||
          status == LocationStatus.deniedForever) {
        if (context.mounted) {
          showAlert(context);
        }
      } else {
        _coordinate = await _locationService.getCoordinate();
        setState(() {});
      }
    });
  }

  Future<void> _initialV2() async {
    _locationService = LocationServiceImpl();
    var result = await _locationService.getCoordinateWithRequestPermission();
    while (result == null) {
      if (context.mounted) {
        await showAlert(context);
        result = await _locationService.getCoordinateWithRequestPermission();
      }
    }

    _coordinate = result;
    setState(() {});
  }

  @override
  void initState() {
    _initialV2();
    super.initState();
  }

  Future<void> showAlert(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog.adaptive(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageAssetPath.gps,
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 16),
                const Text(
                  'GPS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Permission gps is disabled, go to settings and enable gps service',
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => _locationService.openAppSettings(),
                  child: const Text('Go to Settings'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Checking gps...'),
            if (_coordinate != null)
              Text(
                'latitude: ${_coordinate?.latitude}, longitude: ${_coordinate?.longitude}',
              ),
            ElevatedButton(
              onPressed: () {
                showAlert(context);
              },
              child: const Text(
                'Show Settings',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
