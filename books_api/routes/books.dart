import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';

import 'package:sources/sources.dart';

Future<Response> onRequest(RequestContext context) async {
  final bookRepository = ioc<BookRepository>();

  final books = await bookRepository.getBooks();

  final booksMap = books.map((e) => e.toJson()).toList();

  return Response(
    headers: {'Content-Type': 'application/json'},
    body: json.encode(booksMap),
  );
}
