import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/provider/news_api_provider.dart';
import 'package:http/http.dart' show Client, Response, ClientException;
import 'package:http/testing.dart' show MockClient;

void main() {
  group("NewsApiProvider", () {
    late final NewsApiProvider newsApiProvider;

    setUpAll(() {
      final client = Client();
      newsApiProvider = NewsApiProvider(client);
    });

    test("should return a list of int when getTopIds called", () async {
      final ids = await newsApiProvider.getTopIds();
      expect(ids, isList);
      expect(ids, isNotEmpty);
      expect(ids, isA<List<int>>());
    });

    test("should return a instance of ItemModel when getItem called", () async {
      final item = await newsApiProvider.getItem(8863);
      expect(item, isA<ItemModel>());
      expect(item.id, 8863);
      expect(item.type, 'story');
      expect(item.by, 'dhouston');
      expect(item.kids, isList);
      expect(item.kids, isA<List<int>>());
      expect(item.kids, isNotEmpty);
    });
  });

  group("NewsApiProviderMock", () {
    late final NewsApiProvider newsApiProvider;

    setUpAll(() {
      final client = MockClient(
        (request) async {
          if (request.url.path == "/v0/topstories.json") {
            final data = [1, 2, 3];
            return Response(json.encode(data), 200);
          }

          if (request.url.path.contains("/v0/item/")) {
            final id = request.url.path.split("/").last.split('.').first;
            final data = {'id': int.parse(id)};
            return Response(json.encode(data), 200);
          }

          throw ClientException("Url path not found");
        },
      );
      newsApiProvider = NewsApiProvider(client);
    });

    test("should return a list of int when getTopIds called", () async {
      final ids = await newsApiProvider.getTopIds();
      expect(ids, isList);
      expect(ids, isNotEmpty);
      expect(ids, isA<List<int>>());
    });

    test("should return a instance of ItemModel when getItem called", () async {
      final item = await newsApiProvider.getItem(777);
      expect(item, isA<ItemModel>());
      expect(item.id, 777);
    });
  });
}
