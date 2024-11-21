import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:sources/runner.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  runner();

  return serve(handler, ip, port);
}
