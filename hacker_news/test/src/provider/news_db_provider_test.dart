import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/constants/sql_command.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:hacker_news/src/provider/news_db_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockNewsDbProvider extends NewsDbProvider {
  @override
  Future<void> init() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiNoIsolate;
    database = await openDatabase(
      inMemoryDatabasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(SqlCommand.createTableItems);
      },
    );
  }
}

void main() {
  group('NewsDbProvider', () {
    late MockNewsDbProvider mockNewsDbProvider;

    setUpAll(() async {
      mockNewsDbProvider = MockNewsDbProvider();
      await mockNewsDbProvider.init();
    });

    test('should return int when addItem called', () async {
      final item = ItemModel(
        by: 'John Doe',
        kids: [1],
        deleted: true,
        dead: false,
      );
      final result = await mockNewsDbProvider.addItem(item);
      expect(result, 1);
    });

    test('should return item model when getItem called', () async {
      final item = await mockNewsDbProvider.getItem(1);
      expect(item, isA<ItemModel>());
      expect(item?.by, 'John Doe');
      expect(item?.kids, [1]);
      expect(item?.deleted, true);
      expect(item?.dead, false);
    });
  });
}
