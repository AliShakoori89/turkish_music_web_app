class NewAlbumModel {
  List<NewAlbumDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

  NewAlbumModel({this.data, this.success, this.message, this.lastPage});

  NewAlbumModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NewAlbumDataModel>[];
      json['data'].forEach((v) {
        data!.add(NewAlbumDataModel.fromJson(v));
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

class NewAlbumDataModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  NewAlbumSingerModel? singer;
  List<NewAlbumMusicsModel>? musics;

  NewAlbumDataModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer,
        this.musics});

  NewAlbumDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? NewAlbumSingerModel.fromJson(json['singer']) : null;
    if (json['musics'] != null) {
      musics = <NewAlbumMusicsModel>[];
      json['musics'].forEach((v) {
        musics!.add(NewAlbumMusicsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['singerId'] = singerId;
    data['isNew'] = isNew;
    if (singer != null) {
      data['singer'] = singer!.toJson();
    }
    if (musics != null) {
      data['musics'] = musics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewAlbumSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  NewAlbumSingerModel({this.id, this.name, this.imageSource, this.isBest});

  NewAlbumSingerModel.fromJson(Map<String, dynamic> json) {
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

class NewAlbumMusicsModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  int? albumId;
  String? album;

  NewAlbumMusicsModel(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.albumId,
        this.album});

  NewAlbumMusicsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    albumId = json['albumId'];
    album = json['album'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['fileSource'] = fileSource;
    data['albumId'] = albumId;
    data['album'] = album;
    return data;
  }
}
