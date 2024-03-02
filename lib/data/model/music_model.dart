class MusicModel {
  List<MusicDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

  MusicModel({this.data, this.success, this.message, this.lastPage});

  MusicModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MusicDataModel>[];
      json['data'].forEach((v) {
        data!.add(MusicDataModel.fromJson(v));
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

class MusicDataModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  int? albumId;
  MusicAlbumModel? album;

  MusicDataModel(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.albumId,
        this.album});

  MusicDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    albumId = json['albumId'];
    album = json['album'] != null ? MusicAlbumModel.fromJson(json['album']) : null;
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

class MusicAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  MusicSingerModel? singer;
  List<String>? musics;

  MusicAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.singer,
        this.musics});

  MusicAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    singer =
    json['singer'] != null ? MusicSingerModel.fromJson(json['singer']) : null;
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

class MusicSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  MusicSingerModel({this.id, this.name, this.imageSource, this.isBest});

  MusicSingerModel.fromJson(Map<String, dynamic> json) {
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