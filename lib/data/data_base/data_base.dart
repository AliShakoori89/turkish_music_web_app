import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/recently_played_song_Id_model.dart';

class DatabaseHelper{

  DatabaseHelper();

  static const _databaseName = "MusicDatabase.db";
  static const _databaseVersion = 1;

  static const recentlyPlaylistTable = 'RecentlyPlaylistTable';
  static const columnSongId = 'SongId';

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
    await db.execute('CREATE TABLE $recentlyPlaylistTable ('
        '$columnSongId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL'
        ')'
    );
  }

  Future<bool> saveRecentlyPlayedSongId(RecentlyPlayedSongIdModel recentlyPlayedSongIdModel) async {
    var dbExpense = await database;
    print(recentlyPlayedSongIdModel.id);
    await dbExpense.insert(recentlyPlaylistTable, recentlyPlayedSongIdModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<RecentlyPlayedSongIdModel>> getAllRecentlyPlayedSongId() async {
    var dbExpense = await database;
    var listMap = await dbExpense.rawQuery('SELECT * FROM $recentlyPlaylistTable');
    var listRecentlyPlayedSongId = <RecentlyPlayedSongIdModel>[];
    for (Map<String, dynamic> m in listMap) {
      listRecentlyPlayedSongId.add(RecentlyPlayedSongIdModel.fromJson(m));
    }
    return listRecentlyPlayedSongId;
  }
}