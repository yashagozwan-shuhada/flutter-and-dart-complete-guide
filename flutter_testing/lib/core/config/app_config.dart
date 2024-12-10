import 'dart:developer';

import 'package:flutter_testing/core/di/di.dart';
import 'package:injectable/injectable.dart';

class AppConfig {
  const AppConfig._();

  static Future<void> init() async {
    const env = String.fromEnvironment('env');

    if (env == 'fake') {
      await configureDependencies(Environment.test);
      log('fake');
    } else if (env == 'dev') {
      await configureDependencies(Environment.dev);
      log('dev');
    } else if (env == 'prod') {
      await configureDependencies(Environment.prod);
      log('prod');
    } else {
      assert(true, 'NO ENV PARAM');
    }
  }
}
