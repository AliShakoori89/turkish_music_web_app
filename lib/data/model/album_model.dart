import 'package:turkish_music_app/data/model/new-song_model.dart';

import 'category_model.dart';

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
        data!.add(new AlbumDataModel.fromJson(v));
      });
    }
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    data['lastPage'] = this.lastPage;
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
    json['singer'] != null ? new AlbumDataSingerModel.fromJson(json['singer']) : null;
    if (json['musics'] != null) {
      musics = <AlbumDataMusicModel>[];
      json['musics'].forEach((v) {
        musics!.add(new AlbumDataMusicModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageSource'] = this.imageSource;
    data['singerId'] = this.singerId;
    data['isNew'] = this.isNew;
    if (this.singer != null) {
      data['singer'] = this.singer!.toJson();
    }
    if (this.musics != null) {
      data['musics'] = this.musics!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageSource'] = this.imageSource;
    data['isBest'] = this.isBest;
    return data;
  }
}

class AlbumDataMusicModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  String? singerName;
  List<AlbumDataCategoriesModel>? categories;
  int? albumId;
  String? album;

  AlbumDataMusicModel(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.minute,
        this.second,
        this.singerName,
        this.categories,
        this.albumId,
        this.album});

  AlbumDataMusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    singerName = json['singerName'];
    if (json['categories'] != null) {
      categories = <AlbumDataCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new AlbumDataCategoriesModel.fromJson(v));
      });
    }
    albumId = json['albumId'];
    album = json['album'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageSource'] = this.imageSource;
    data['fileSource'] = this.fileSource;
    data['minute'] = this.minute;
    data['second'] = this.second;
    data['singerName'] = this.singerName;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['albumId'] = this.albumId;
    data['album'] = this.album;
    return data;
  }

  factory AlbumDataMusicModel.fromCategoryMusicModel(CategoryMusicsModel model) {
    return AlbumDataMusicModel(
      id: model.id,
      name: model.name,
      imageSource: model.imageSource,
      fileSource: model.fileSource,
      minute: model.minute,
      second: model.second,
      singerName: model.singerName,
      albumId: model.albumId,
    );
  }

  factory AlbumDataMusicModel.fromNewSongDataModel(NewSongDataModel model) {
    return AlbumDataMusicModel(
      id: model.id,
      name: model.name,
      imageSource: model.imageSource,
      fileSource: model.fileSource,
      minute: model.minute,
      second: model.second,
      singerName: model.singerName,
      albumId: model.albumId,
    );
  }
}

class AlbumDataCategoriesModel {
  int? id;
  String? imageSource;
  String? title;
  List<String>? musics;
  String? creationDate;

  AlbumDataCategoriesModel(
      {this.id, this.imageSource, this.title, this.musics, this.creationDate});

  AlbumDataCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageSource = json['imageSource'];
    title = json['title'];
    musics = json['musics'].cast<String>();
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageSource'] = this.imageSource;
    data['title'] = this.title;
    data['musics'] = this.musics;
    data['creationDate'] = this.creationDate;
    return data;
  }
}
