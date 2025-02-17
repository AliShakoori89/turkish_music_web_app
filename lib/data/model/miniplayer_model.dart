import 'album_model.dart';

class MiniPlayerModel{
  int? songID;
  String? songName;
  String? songsSingerName;
  String? songImagePath;
  String? songFilePath;
  String? minute;
  String? second;
  int? categoryID;
  int? albumID;
  List<AlbumDataMusicModel>? songList;

  MiniPlayerModel({
    required this.songID,
    required this.songName,
    required this.songsSingerName,
    required this.songImagePath,
    required this.songFilePath,
    required this.minute,
    required this.second,
    required this.categoryID,
    required this.albumID,
    required this.songList
  });
}