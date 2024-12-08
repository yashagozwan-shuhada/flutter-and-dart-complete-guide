import 'package:hacker_news/src/constants/sql_command.dart';
import 'package:hacker_news/src/domain/cache.dart';
import 'package:hacker_news/src/domain/source.dart';
import 'package:hacker_news/src/model/item_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  NewsDbProvider() {
    init();
  }

  factory NewsDbProvider.instance() {
    return _dbProvider ??= NewsDbProvider._instance();
  }

  NewsDbProvider._instance();

  static Database? database;

  static NewsDbProvider? _dbProvider;

  Future<void> init() async {
    final document = await getApplicationDocumentsDirectory();
    final path = join(document.path, 'sqlite.db');
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {},
    );
  }

  @override
  Future<ItemModel?> getItem(int id) async {
    final maps = await database?.query(
      SqlCommand.items,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps != null) {
      if (maps.isNotEmpty) {
        final map = maps.first;
        return ItemModel.fromDb(map);
      }
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) async {
    final result = await database?.insert(
      SqlCommand.items,
      item.toDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    return result ?? -1;
  }

  @override
  Future<List<int>> getTopIds() => Future.value([]);

  @override
  Future<int> clear() async {
    final result = await database?.delete(SqlCommand.items);
    return result ?? -1;
  }
}
