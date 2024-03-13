class AlbumModel {
  List<Data>? data;
  bool? success;
  String? message;
  int? lastPage;

  AlbumModel({this.data, this.success, this.message, this.lastPage});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    data['message'] = message;
    data['lastPage'] = lastPage;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  Singer? singer;
  List<Musics>? musics;

  Data(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer,
        this.musics});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? Singer.fromJson(json['singer']) : null;
    if (json['musics'] != null) {
      musics = <Musics>[];
      json['musics'].forEach((v) {
        musics!.add(Musics.fromJson(v));
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

class Singer {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  Singer({this.id, this.name, this.imageSource, this.isBest});

  Singer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    isBest = json['isBest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['isBest'] = isBest;
    return data;
  }
}

class Musics {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  int? albumId;
  String? album;

  Musics(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.albumId,
        this.album});

  Musics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    albumId = json['albumId'];
    album = json['album'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['fileSource'] = fileSource;
    data['albumId'] = albumId;
    data['album'] = album;
    return data;
  }
}
