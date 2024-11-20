import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pics/src/http/custom_client.dart';

@immutable
class CustomHttp {
  final CustomClient _client;
  final String? _baseUrl;

  const CustomHttp({
    String? baseUrl,
    required CustomClient client,
  })  : _baseUrl = baseUrl,
        _client = client;

  Uri urlConcat(
    String url,
  ) =>
      Uri.parse(_baseUrl == null ? url : _baseUrl + url);

  Future<Response> get(String url, {Map<String, dynamic>? headers}) =>
      _client.get(urlConcat(url));

  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _client.post(
        urlConcat(url),
        headers: headers,
        body: body,
        encoding: encoding,
      );
}
