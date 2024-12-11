import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_testing/runner.dart';
import 'package:injectable/injectable.dart';

void main() {
  FlavorConfig(
    variables: {
      'base_url': 'https://yashagozwan.id',
    },
  );

  runner(Environment.prod);
}
