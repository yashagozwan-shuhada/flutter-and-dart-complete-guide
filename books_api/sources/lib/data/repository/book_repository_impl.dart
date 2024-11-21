import 'package:injectable/injectable.dart';
import 'package:sources/data/source/local/book_local_data_source.dart';
import 'package:sources/domain/model/book_model.dart';
import 'package:sources/domain/repository/book_repository.dart';

@LazySingleton(as: BookRepository)
class BookRepositoryImpl implements BookRepository {
  final BookLocalDataSource _local;

  BookRepositoryImpl(this._local);

  @override
  Future<List<BookModel>> getBooks() => _local.getBooks();
}
