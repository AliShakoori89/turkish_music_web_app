import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SaveSongModel {
  @HiveField(0)
  String songName;

  @HiveField(1)
  String singerName;

  @HiveField(2)
  String imageFilePath;

  @HiveField(3)
  String audioFilePath;

  @HiveField(4)
  String audioFileMin;

  @HiveField(5)
  String audioFileSec;

  @HiveField(6)
  String albumName;

  @HiveField(7)
  int audioFileAlbumId;

  SaveSongModel({
    required this.songName,
    required this.singerName,
    required this.imageFilePath,
    required this.audioFilePath,
    required this.audioFileMin,
    required this.audioFileSec,
    required this.albumName,
    required this.audioFileAlbumId,
  });

  factory SaveSongModel.fromJson(Map<String, dynamic> json) => SaveSongModel(
    songName: json['songName'],
    singerName: json['singerName'],
    imageFilePath: json['imageFilePath'],
    audioFilePath: json['audioFilePath'],
    audioFileMin: json['audioFileMin'],
    audioFileSec: json['audioFileSec'],
    albumName: json['albumName'],
    audioFileAlbumId: json['audioFileAlbumId'],
  );

  Map<String, dynamic> toJson() => {
    'songName': songName,
    'singerName': singerName,
    'imageFilePath': imageFilePath,
    'audioFilePath': audioFilePath,
    'audioFileMin': audioFileMin,
    'audioFileSec': audioFileSec,
    'albumName': albumName,
    'audioFileAlbumId': audioFileAlbumId,
  };
}
