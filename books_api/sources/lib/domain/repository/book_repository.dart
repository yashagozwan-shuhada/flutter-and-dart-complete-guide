import 'package:sources/domain/model/book_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>> getBooks();
}
