import 'package:flutter_testing/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.I;

@injectableInit
Future<void> configureDependencies(String env) async =>
    getIt.init(environment: env);
