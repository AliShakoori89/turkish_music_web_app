import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

  DatabaseHelper();

  static const _databaseName = "MusicDatabase.db";
  static const _databaseVersion = 1;

  static const musicTable = 'MusicTable';
  static const columnSongId = 'SongId';
  static const columnSongName = 'SongName';
  static const columnSingerName = 'SingerName';
  static const columnSingerId = 'SingerId';
  static const columnDuration = 'Duration';
  static const columnImagePath = 'ImagePath';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  FutureOr<Database> get database async =>
      _database ??= await _initiateDatabase();

  _initiateDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  FutureOr _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $musicTable ('
        '$columnSongId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnSongName TEXT,'
        '$columnSingerName TEXT,'
        '$columnSingerId TEXT,'
        '$columnDuration INTEGER,'
        '$columnImagePath TEXT'
        ')'
    );
  }
}