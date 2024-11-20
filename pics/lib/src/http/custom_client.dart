import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

@immutable
class CustomClient extends BaseClient {
  final Client _client;

  CustomClient({required Client client}) : _client = client;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['Authorization'] = 'Bearer';
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';

    log("this calling");
    log("${request.headers}");
    return _client.send(request);
  }
}
