import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/constants/sql_command.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactoryFfiNoIsolate, sqfliteFfiInit;

void main() {
  group('SQLiteTest', () {
    late Database database;

    setUpAll(() async {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfiNoIsolate;

      database = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(SqlCommand.createTableItems);
        },
      );
    });

    test('should create table and insert items data ', () async {
      final item = ItemModel(
        by: 'John Doe',
        kids: [1, 2, 3],
      );

      final affectedRows = await Future.wait(
        [
          database.insert(SqlCommand.items, item.toDb()),
          database.insert(SqlCommand.items, ItemModel().toDb()),
        ],
      );

      expect(affectedRows, [1, 2]);

      final items = await database.query(SqlCommand.items);

      expect(
        items,
        <Map<String, dynamic>>[
          ItemModel(id: 1, by: 'John Doe', kids: [1, 2, 3]).toDb(),
          ItemModel(id: 2).toJson(),
        ],
      );
    });

    test('should return data item when getItem called', () async {
      final data = await database.query(
        SqlCommand.items,
        where: 'id=?',
        whereArgs: [1],
      );

      final items = data.map(ItemModel.fromDb).map((e) => e.toJson()).toList();

      expect(items, isList);
      expect(items, isNotEmpty);
      expect(items, <Map<String, dynamic>>[
        ItemModel(id: 1, by: 'John Doe', kids: [1, 2, 3]).toJson(),
      ]);

      final item = data.map(ItemModel.fromDb).firstOrNull;
      expect(item?.id, 1);
      expect(item?.by, 'John Doe');
    });

    tearDownAll(() async {
      await database.close();
    });
  });
}
