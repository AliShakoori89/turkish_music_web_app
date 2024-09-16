import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/save_song_model.dart';

class DatabaseHelper{

  DatabaseHelper();

  static const _databaseName = "MusicDatabase.db";
  static const _databaseVersion = 1;

  static const recentlyPlaylistTable = 'RecentlyPlaylistTable';
  static const columnRecentlyPlayedSongId = 'songId';
  static const columnRecentlyPlayedSongName = 'songName';
  static const columnRecentlyPlayedSingerName = 'singerName';
  static const columnRecentlyPlayedImagePath = 'imageFilePath';
  static const columnRecentlyPlayedAudioFilePath = 'audioFilePath';
  static const columnRecentlyPlayedAudioFileMin = 'audioFileMin';
  static const columnRecentlyPlayedAudioFileSec = 'audioFileSec';
  static const columnRecentlyPlayedAudioFileAlbumId = 'audioFileAlbumId';

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
        '$columnRecentlyPlayedSongId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnRecentlyPlayedSongName TEXT,'
        '$columnRecentlyPlayedSingerName TEXT,'
        '$columnRecentlyPlayedImagePath TEXT,'
        '$columnRecentlyPlayedAudioFilePath TEXT,'
        '$columnRecentlyPlayedAudioFileMin TEXT,'
        '$columnRecentlyPlayedAudioFileSec TEXT,'
        '$columnRecentlyPlayedAudioFileAlbumId INTEGER'
        ')'
    );
  }

  Future<bool> saveRecentlyPlayedSong(SaveSongModel recentlyPlayedSongIdModel) async {
    var dbExpense = await database;
    print("111111111111111111111            "+recentlyPlayedSongIdModel.imageFilePath.toString());
    await dbExpense.insert(recentlyPlaylistTable, recentlyPlayedSongIdModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<SaveSongModel>> getAllRecentlyPlayedSong() async {
    var dbExpense = await database;
    var listMap = await dbExpense.rawQuery('SELECT * FROM $recentlyPlaylistTable');
    var listRecentlyPlayedSong = <SaveSongModel>[];
    for (Map<String, dynamic> m in listMap) {
      listRecentlyPlayedSong.add(SaveSongModel.fromJson(m));
    }
    return listRecentlyPlayedSong;
  }
}