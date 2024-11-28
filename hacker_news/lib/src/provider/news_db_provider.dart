import 'package:hacker_news/src/constants/sql_command.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider {
  Database? database;

  Future<void> init() async {
    final document = await getApplicationDocumentsDirectory();
    final path = join(document.path, 'sqlite.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {},
    );
  }

  Future<ItemModel?> getItem(int id) async {
    final maps = await database!.query(
      SqlCommand.items,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final map = maps.first;
      return ItemModel.fromDb(map);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return database!.insert(
      SqlCommand.items,
      item.toDb(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }
}
