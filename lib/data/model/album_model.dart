class AlbumModel {
  List<AlbumDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

  AlbumModel({this.data, this.success, this.message, this.lastPage});

  AlbumModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AlbumDataModel>[];
      json['data'].forEach((v) {
        data!.add(AlbumDataModel.fromJson(v));
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

class AlbumDataModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  AlbumDataSingerModel? singer;
  List<AlbumDataMusicModel>? musics;

  AlbumDataModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer,
        this.musics});

  AlbumDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? AlbumDataSingerModel.fromJson(json['singer']) : null;
    if (json['musics'] != null) {
      musics = <AlbumDataMusicModel>[];
      json['musics'].forEach((v) {
        musics!.add(AlbumDataMusicModel.fromJson(v));
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

class AlbumDataSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  AlbumDataSingerModel({this.id, this.name, this.imageSource, this.isBest});

  AlbumDataSingerModel.fromJson(Map<String, dynamic> json) {
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

class AlbumDataMusicModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  int? albumId;
  String? album;
  String? minute;
  String? second;

  AlbumDataMusicModel(
    {this.id,
      this.name,
      this.imageSource,
      this.fileSource,
      this.albumId,
      this.album,
      this.minute,
      this.second});

  AlbumDataMusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    albumId = json['albumId'];
    album = json['album'];
    minute = json['minute'];
    second = json['second'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['imageSource'] = imageSource;
    data['fileSource'] = fileSource;
    data['albumId'] = albumId;
    data['album'] = album;
    data['minute'] = minute;
    data['second'] = second;
    return data;
  }
}
