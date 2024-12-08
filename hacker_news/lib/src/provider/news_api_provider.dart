import 'dart:convert';

import 'package:hacker_news/src/domain/source.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider implements Source {
  NewsApiProvider(this._client);

  final Client _client;

  static const _baseUrl = 'https://hacker-news.firebaseio.com/v0';

  @override
  Future<List<int>> getTopIds() async {
    final response = await _client.get(Uri.parse('$_baseUrl/topstories.json'));
    final ids = json.decode(response.body) as List<dynamic>;
    return ids.cast<int>();
  }

  @override
  Future<ItemModel?> getItem(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/item/$id.json'));
    final parsedJson = json.decode(response.body) as Map<String, dynamic>;
    final item = ItemModel.fromJson(parsedJson);
    return item;
  }
}
