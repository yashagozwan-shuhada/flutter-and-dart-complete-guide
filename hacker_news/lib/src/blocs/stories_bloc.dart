import 'dart:developer' as dev;

import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/repository/news_repository_v2.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  StoriesBloc() {
    _itemFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  final _repository = NewsRepositoryV2();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemFetcher = BehaviorSubject<int>();

  /// getter to stream
  Stream<List<int>> get topIds => _topIds.stream;
  Stream<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  /// getter to sink
  void Function(int id) get getItem => _itemFetcher.sink.add;

  Future<void> fetchTopIds() async {
    final ids = await _repository.getTopIds();
    _topIds.sink.add(ids);
  }

  Future<void> clearCache() => _repository.clearCache();

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>> _itemsTransformer() =>
      ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (cache, id, index) {
          dev.log('$index', name: 'StoriesBloc');

          cache[id] = _repository.getItem(id);

          return cache;
        },
        <int, Future<ItemModel>>{},
      );

  void dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemFetcher.close();
  }
}
