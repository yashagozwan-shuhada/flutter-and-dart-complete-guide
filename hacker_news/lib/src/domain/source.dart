import 'package:hacker_news/src/model/item_model.dart';

abstract interface class Source {
  Future<List<int>> getTopIds();

  Future<ItemModel?> getItem(int id);
}
