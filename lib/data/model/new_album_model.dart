// To parse this JSON data, do
//
//     final newAlbumModel = newAlbumModelFromJson(jsonString);

import 'dart:convert';

NewAlbumModel newAlbumModelFromJson(String str) => NewAlbumModel.fromJson(json.decode(str));

String newAlbumModelToJson(NewAlbumModel data) => json.encode(data.toJson());

class NewAlbumModel {
  List<NewAlbumDataModel> data;
  bool success;
  String message;
  int lastPage;

  NewAlbumModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });

  factory NewAlbumModel.fromJson(Map<String, dynamic> json) => NewAlbumModel(
    data: List<NewAlbumDataModel>.from(json["data"].map((x) => NewAlbumDataModel.fromJson(x))),
    success: json["success"],
    message: json["message"],
    lastPage: json["lastPage"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "message": message,
    "lastPage": lastPage,
  };
}

class NewAlbumDataModel {
  int id;
  String name;
  String imageSource;
  int singerId;
  bool isNew;
  NewAlbumSingerModel singer;
  List<NewAlbumMusicModel> musics;

  NewAlbumDataModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.singerId,
    required this.isNew,
    required this.singer,
    required this.musics,
  });

  factory NewAlbumDataModel.fromJson(Map<String, dynamic> json) => NewAlbumDataModel(
    id: json["id"],
    name: json["name"],
    imageSource: json["imageSource"],
    singerId: json["singerId"],
    isNew: json["isNew"],
    singer: NewAlbumSingerModel.fromJson(json["singer"]),
    musics: List<NewAlbumMusicModel>.from(json["musics"].map((x) => NewAlbumMusicModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageSource": imageSource,
    "singerId": singerId,
    "isNew": isNew,
    "singer": singer.toJson(),
    "musics": List<dynamic>.from(musics.map((x) => x.toJson())),
  };
}

class NewAlbumMusicModel {
  int id;
  String name;
  String imageSource;
  String fileSource;
  int albumId;
  String album;

  NewAlbumMusicModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.fileSource,
    required this.albumId,
    required this.album,
  });

  factory NewAlbumMusicModel.fromJson(Map<String, dynamic> json) => NewAlbumMusicModel(
    id: json["id"],
    name: json["name"],
    imageSource: json["imageSource"],
    fileSource: json["fileSource"],
    albumId: json["albumId"],
    album: json["album"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageSource": imageSource,
    "fileSource": fileSource,
    "albumId": albumId,
    "album": album,
  };
}

class NewAlbumSingerModel {
  int id;
  String name;
  String imageSource;
  bool isBest;

  NewAlbumSingerModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });

  factory NewAlbumSingerModel.fromJson(Map<String, dynamic> json) => NewAlbumSingerModel(
    id: json["id"],
    name: json["name"],
    imageSource: json["imageSource"],
    isBest: json["isBest"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageSource": imageSource,
    "isBest": isBest,
  };
}
