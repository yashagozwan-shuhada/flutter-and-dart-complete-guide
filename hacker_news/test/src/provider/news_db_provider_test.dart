import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show databaseFactoryFfiNoIsolate, sqfliteFfiInit;

void main() {
  group("", () {
    setUp(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfiNoIsolate;
    });

    setUpAll(() {});

    test("should create table and insert users data ", () async {
      final db = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute("""CREATE TABLE IF NOT EXISTS users(
              name TEXT NOT NULL
            );
            """);
        },
      );

      final rowAffected = await db.insert('users', {'name': 'yasha'});
      expect(rowAffected, 1);

      final users = await db.query("users");

      expect(
        users,
        [
          {'name': 'yasha'}
        ],
      );

      await db.close();
    });
  });
}
