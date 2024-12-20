import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/home/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group("GET /home", () {
    test("test", () async {
      final context = _MockRequestContext();
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.body(), completion(contains("yasha")));
    });
  });
}
