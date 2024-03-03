// To parse this JSON data, do
//
//     final newSongModel = newSongModelFromJson(jsonString);

import 'dart:convert';

NewMusicModel newSongModelFromJson(String str) => NewMusicModel.fromJson(json.decode(str));

String newSongModelToJson(NewMusicModel data) => json.encode(data.toJson());

class NewMusicModel {
  List<NewMusicDataModel> data;
  bool success;
  String message;
  int lastPage;

  NewMusicModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });

  factory NewMusicModel.fromJson(Map<String, dynamic> json) => NewMusicModel(
    data: List<NewMusicDataModel>.from(json["data"].map((x) => NewMusicDataModel.fromJson(x))),
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

class NewMusicDataModel {
  int id;
  String name;
  String imageSource;
  String fileSource;
  int singerId;
  NewMusicSingerModel singer;

  NewMusicDataModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.fileSource,
    required this.singerId,
    required this.singer,
  });

  factory NewMusicDataModel.fromJson(Map<String, dynamic> json) => NewMusicDataModel(
    id: json["id"],
    name: json["name"],
    imageSource: json["imageSource"],
    fileSource: json["fileSource"],
    singerId: json["singerId"],
    singer: NewMusicSingerModel.fromJson(json["singer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageSource": imageSource,
    "fileSource": fileSource,
    "singerId": singerId,
    "singer": singer.toJson(),
  };
}

class NewMusicSingerModel {
  int id;
  String name;
  String imageSource;
  bool isBest;

  NewMusicSingerModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });

  factory NewMusicSingerModel.fromJson(Map<String, dynamic> json) => NewMusicSingerModel(
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
