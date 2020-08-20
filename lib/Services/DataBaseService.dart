import 'package:flutter/cupertino.dart';
import 'package:rss_client/Exceptions/DataBaseExceptions/DataBaseException.dart';
import 'package:rss_client/Models/RSSChannelModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async' as Async;

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
        onCreate: (db, version) {
          return db.execute(
              "CREATE TABLE channels(title Text, source TEXT PRIMARY KEY, description TEXT, imageUrl TEXT)"
          );
        },
        version: 1,
      );
    } catch (_) {
      throw DataBaseException.cannotCreateDB;
    }
  }

  Async.Future<void> insertChannel(RSSChannelModel channel) async {
    try {
      final Database db = await _getDB();

      await db.insert(
          'channels',
          channel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace
      );
    } catch (_) {
      throw DataBaseException.cannotInsertNewItemToDB;
    }
  }

  Async.Future<List<RSSChannelModel>> getAllChannels() async {
    try {
      final Database db = await _getDB();
      final List<Map<String, dynamic>> maps = await db.query('channels');
      return maps.map((element) =>
      new RSSChannelModel(
          title: element['title'],
          description: element['description'],
          imageUrl: element['imageUrl'],
          source: element['source']
      )).toList();
    } catch (_) {
      throw DataBaseException.cannotLoadDB;
    }
  }
}