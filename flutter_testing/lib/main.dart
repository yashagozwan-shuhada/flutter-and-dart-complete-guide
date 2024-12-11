import 'package:flutter/material.dart';
import 'package:flutter_testing/app.dart';
import 'package:flutter_testing/core/config/app_config.dart';

void main() async {
  await AppConfig.init();

  runApp(const App());
}
