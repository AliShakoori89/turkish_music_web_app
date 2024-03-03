// To parse this JSON data, do
//
//     final newSongModel = newSongModelFromJson(jsonString);

import 'dart:convert';

NewSongModel newSongModelFromJson(String str) => NewSongModel.fromJson(json.decode(str));

String newSongModelToJson(NewSongModel data) => json.encode(data.toJson());

class NewSongModel {
  List<NewSongDataModel> data;
  bool success;
  String message;
  int lastPage;

  NewSongModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });

  factory NewSongModel.fromJson(Map<String, dynamic> json) => NewSongModel(
    data: List<NewSongDataModel>.from(json["data"].map((x) => NewSongDataModel.fromJson(x))),
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

class NewSongDataModel {
  int id;
  String name;
  String imageSource;
  String fileSource;
  int singerId;
  Singer singer;

  NewSongDataModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.fileSource,
    required this.singerId,
    required this.singer,
  });

  factory NewSongDataModel.fromJson(Map<String, dynamic> json) => NewSongDataModel(
    id: json["id"],
    name: json["name"],
    imageSource: json["imageSource"],
    fileSource: json["fileSource"],
    singerId: json["singerId"],
    singer: Singer.fromJson(json["singer"]),
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

class Singer {
  int id;
  String name;
  String imageSource;
  bool isBest;

  Singer({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });

  factory Singer.fromJson(Map<String, dynamic> json) => Singer(
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
