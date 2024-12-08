import 'dart:developer' as dev;
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/repository/news_repository_v2.dart';
import 'package:rxdart/rxdart.dart';

class CommentsBloc {
  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  final _repository = NewsRepositoryV2();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  Stream<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  void Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  ScanStreamTransformer<int, Map<int, Future<ItemModel>>>
      _commentsTransformer() {
    return ScanStreamTransformer(
      (cache, id, index) {
        dev.log('$index', name: 'CommentsBloc');

        cache[id] = _repository.getItem(id);

        /// : fetching data recursively
        cache[id]?.then(
          (item) {
            item.kids?.forEach(
              (kidId) => fetchItemWithComments(kidId),
            );
          },
        );

        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }

  void dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
