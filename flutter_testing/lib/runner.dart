import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_testing/app.dart';
import 'package:flutter_testing/core/di/di.dart';

Future<void> runner(String env) async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies(env);
  runApp(const App());
}
