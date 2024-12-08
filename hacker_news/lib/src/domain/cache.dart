import 'package:hacker_news/src/model/item_model.dart';

abstract interface class Cache {
  Future<int> addItem(ItemModel item);

  Future<int> clear();
}
