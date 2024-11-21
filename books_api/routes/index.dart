import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:sources/sources.dart';

Response onRequest(RequestContext context) {
  const status = BookStatusModel();
  return Response(
    headers: {'Content-Type': 'application/json'},
    body: json.encode(status.toJson()),
  );
}
