class SongModel {
  List<SongDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

  SongModel({this.data, this.success, this.message, this.lastPage});

  SongModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SongDataModel>[];
      json['data'].forEach((v) {
        data!.add(SongDataModel.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    data['lastPage'] = lastPage;
    return data;
  }
}

class SongDataModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  int? albumId;
  SongAlbumModel? album;

  SongDataModel(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.albumId,
        this.album});

  SongDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    albumId = json['albumId'];
    album = json['album'] != null ? SongAlbumModel.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['fileSource'] = fileSource;
    data['albumId'] = albumId;
    if (album != null) {
      data['album'] = album!.toJson();
    }
    return data;
  }
}

class SongAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  SongSingerModel? singer;
  List<String>? musics;

  SongAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.singer,
        this.musics});

  SongAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    singer =
    json['singer'] != null ? SongSingerModel.fromJson(json['singer']) : null;
    musics = json['musics'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['singerId'] = singerId;
    if (singer != null) {
      data['singer'] = singer!.toJson();
    }
    data['musics'] = musics;
    return data;
  }
}

class SongSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  SongSingerModel({this.id, this.name, this.imageSource, this.isBest});

  SongSingerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    isBest = json['isBest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['isBest'] = isBest;
    return data;
  }
}