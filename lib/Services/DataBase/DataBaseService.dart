import 'package:rss_client/Exceptions/DataBaseExceptions/DataBaseException.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:rss_client/Models/RSSNewsItemModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async' as Async;

class TableNames {
  TableNames._();

  static final String channels = 'channels';
  static final String newsItems = 'newsItems';
}

class DataBaseService {

  static DataBaseService shared = new DataBaseService();

  Async.Future<Database> _database;

  Async.Future<Database> _getDB() async {
    if (await _database == null) {
      await createDB();
    }
    return _database;
  }

  Async.Future<void> createDB() async {
    try {
      _database = openDatabase(
        join(await getDatabasesPath(), 'channels_db.db'),
        onCreate: (db, version) async {
          await db.execute("CREATE TABLE ${TableNames.channels}(${RSSChannelModel.entityModel})");
          await db.execute("CREATE TABLE ${TableNames.newsItems}(${RSSNewsItemModel.entityModel})");
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          print(oldVersion);
          if (oldVersion <= 1) {
            await db.execute("CREATE TABLE ${TableNames.newsItems}(${RSSNewsItemModel.entityModel})");
          } else {
            if (oldVersion <= 2) {
              await db.execute(
                  "ALTER TABLE ${TableNames.newsItems} ADD COLUMN source TEXT");
            }
            if (oldVersion <= 3) {
              await db.execute("ALTER TABLE ${TableNames
                  .newsItems} ADD COLUMN isFavourite INTEGER");
            }
          }
        },
        version: 4,
      );
    } catch (_) {
      throw DataBaseException.cannotCreateDB;
    }
  }

  Async.Future<void> insert(String tableName, Map<String, dynamic> dbMap) async {
    try {
      final Database db = await _getDB();

      await db.insert(
          tableName,
          dbMap,
          conflictAlgorithm: ConflictAlgorithm.replace
      );
    } catch (_) {
      throw DataBaseException.cannotInsertNewItemToDB;
    }
  }

  Async.Future<void> remove(String tableName, String where, List<dynamic> whereArgs) async {
    try {
      final Database db = await _getDB();

      await db.delete(
          tableName,
          where: where,
          whereArgs: whereArgs
      );
    } catch (_) {
      throw DataBaseException.cannotRemoveItemFromDB;
    }
  }

  Async.Future<void> update(String tableName, Map<String, dynamic> dbMap, String where, List<dynamic> whereArgs) async {
    try {
      final Database db = await _getDB();

      await db.update(
        tableName,
        dbMap,
        where: where,
        whereArgs: whereArgs
      );
    } catch (_) {
      throw DataBaseException.cannotUpdateItemFromDB;
    }
  }

  Async.Future<List<Map<String, dynamic>>> getAllQuery(String tableName, {String where, List<dynamic> whereArgs}) async {
    try {
      final Database db = await _getDB();
      return await db.query(
          tableName,
        where: where,
        whereArgs: whereArgs
      );
    } catch (_) {
      throw DataBaseException.cannotLoadDB;
    }
  }

}