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
        showAlert();
      } else {
        _coordinate = await _locationService.getCoordinate();
        setState(() {});
      }
    });
  }

  void showAlert() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
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
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _initial();
    super.initState();
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
              onPressed: showAlert,
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
