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
        data!.add(new SongDataModel.fromJson(v));
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

class SongDataModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  String? singerName;
  List<SongDataCategoriesModel>? categories;
  int? albumId;
  SongDataAlbumModel? album;

  SongDataModel(
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

  SongDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    singerName = json['singerName'];
    if (json['categories'] != null) {
      categories = <SongDataCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new SongDataCategoriesModel.fromJson(v));
      });
    }
    albumId = json['albumId'];
    album = json['album'] != null ? new SongDataAlbumModel.fromJson(json['album']) : null;
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
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    return data;
  }
}

class SongDataCategoriesModel {
  int? id;
  String? imageSource;
  String? title;
  List<String>? musics;
  String? creationDate;

  SongDataCategoriesModel(
      {this.id, this.imageSource, this.title, this.musics, this.creationDate});

  SongDataCategoriesModel.fromJson(Map<String, dynamic> json) {
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

class SongDataAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  SongDataSingerModel? singer;
  List<String>? musics;

  SongDataAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer,
        this.musics});

  SongDataAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? new SongDataSingerModel.fromJson(json['singer']) : null;
    musics = json['musics'].cast<String>();
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
    data['musics'] = this.musics;
    return data;
  }
}

class SongDataSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  SongDataSingerModel({this.id, this.name, this.imageSource, this.isBest});

  SongDataSingerModel.fromJson(Map<String, dynamic> json) {
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
