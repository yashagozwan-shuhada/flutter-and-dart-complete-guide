import 'package:hacker_news/src/domain/cache.dart';
import 'package:hacker_news/src/domain/source.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/provider/news_api_provider.dart';
import 'package:hacker_news/src/provider/news_db_provider.dart';
import 'package:http/http.dart';

class NewsRepositoryV2 {
  final sources = <Source>[
    NewsDbProvider.instance(),
    NewsApiProvider(Client()),
  ];

  final caches = <Cache>[
    NewsDbProvider.instance(),
  ];

  Future<List<int>> getTopIds() => sources[1].getTopIds();

  Future<ItemModel> getItem(int id) async {
    ItemModel? item;
    Source? source;

    for (source in sources) {
      item = await source.getItem(id);
      if (item != null) break;
    }

    for (final cache in caches) {
      if (source?.runtimeType != source.runtimeType) {
        await cache.addItem(item!);
      }
    }

    return item!;
  }

  Future<void> clearCache() async {
    for (final cache in caches) {
      await cache.clear();
    }
  }
}
