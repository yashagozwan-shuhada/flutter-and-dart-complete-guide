import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/provider/news_api_provider.dart';
import 'package:hacker_news/src/provider/news_db_provider.dart';

class NewsRepository {
  const NewsRepository(
    this._apiProvider,
    this._dbProvider,
  );

  final NewsApiProvider _apiProvider;
  final NewsDbProvider _dbProvider;

  Future<List<int>> getTopIds() => _apiProvider.getTopIds();

  Future<ItemModel> getItem(int id) async {
    var item = await _dbProvider.getItem(id);
    if (item != null) return item;
    item = await _apiProvider.getItem(id);
    await _dbProvider.addItem(item);
    return item;
  }
}
