import 'dart:convert';

import 'package:hacker_news/src/model/item_model.dart';
import 'package:http/http.dart' show Client;

class NewsApiProvider {
  static const _baseUrl = "https://hacker-news.firebaseio.com/v0";

  final Client _client;

  NewsApiProvider(this._client);

  Future<List<int>> getTopIds() async {
    final response = await _client.get(Uri.parse("$_baseUrl/topstories.json"));
    final ids = json.decode(response.body) as List<dynamic>;
    return ids.map((e) => e as int).toList();
  }

  Future<ItemModel> getItem(int id) async {
    final response = await _client.get(Uri.parse("$_baseUrl/item/$id.json"));
    final parsedJson = json.decode(response.body);
    final item = ItemModel.fromJson(parsedJson);
    return item;
  }
}
