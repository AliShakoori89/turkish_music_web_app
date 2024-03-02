// To parse this JSON data, do
//
//     final singer = singerFromJson(jsonString);

import 'dart:convert';

SingerModel singerFromJson(String str) => SingerModel.fromJson(json.decode(str));

String singerToJson(SingerModel data) => json.encode(data.toJson());

class SingerModel {
  List<SingerDataModel> data;
  bool success;
  String message;
  int lastPage;

  SingerModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });

  factory SingerModel.fromJson(Map<String, dynamic> json) => SingerModel(
    data: List<SingerDataModel>.from(json["data"].map((x) => SingerDataModel.fromJson(x))),
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

class SingerDataModel {
  int id;
  String name;
  String imageSource;
  bool isBest;

  SingerDataModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });

  factory SingerDataModel.fromJson(Map<String, dynamic> json) => SingerDataModel(
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
