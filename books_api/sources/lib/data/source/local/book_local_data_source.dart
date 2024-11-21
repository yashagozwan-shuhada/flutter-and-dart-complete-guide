import 'package:injectable/injectable.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:sources/domain/repository/book_repository.dart';
import 'package:sources/domain/model/book_model.dart';

@lazySingleton
class BookLocalDataSource implements BookRepository {
  final MySQLConnection _mySQLConnection;

  const BookLocalDataSource(this._mySQLConnection);

  @override
  Future<List<BookModel>> getBooks() async {
    final result = await _mySQLConnection.execute("""
      SELECT * FROM books;
    """);

    return result.rows.map((e) => BookModel.fromJson(e.typedAssoc())).toList();
  }
}
