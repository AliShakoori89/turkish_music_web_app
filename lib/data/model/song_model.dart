class SongModel {
  SongModel({
    this.data,
    this.success,
    this.message,
    this.lastPage,
  });
  List<SongDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

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
  SongDataModel({
    this.id,
    this.name,
    this.imageSource,
    this.fileSource,
    this.minute,
    this.second,
    this.singerName,
    this.categories,
    this.albumId,
    this.album,
  });
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  String? singerName;
  List<SongCategoriesModel>? categories;
  int? albumId;
  SongAlbumModel? album;

  SongDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    singerName = json['singerName'];
    if (json['categories'] != null) {
      categories = <SongCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new SongCategoriesModel.fromJson(v));
      });
    }    albumId = json['albumId'];
    album = json['album'] != null ? new SongAlbumModel.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['fileSource'] = fileSource;
    _data['minute'] = minute;
    _data['second'] = second;
    _data['singerName'] = singerName;
    if (this.categories != null) {
      _data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }    _data['albumId'] = albumId;
    if (this.album != null) {
      _data['album'] = this.album!.toJson();
    }
    return _data;
  }
}

class SongCategoriesModel {
  SongCategoriesModel({
    this.id,
    this.imageSource,
    this.title,
    this.musics,
    this.creationDate,
  });
  int? id;
  String? imageSource;
  String? title;
  List<String>? musics;
  String? creationDate;

  SongCategoriesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    imageSource = json['imageSource'];
    title = json['title'];
    musics = List.castFrom<dynamic, String>(json['musics']);
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['imageSource'] = imageSource;
    _data['title'] = title;
    _data['musics'] = musics;
    _data['creationDate'] = creationDate;
    return _data;
  }
}

class SongAlbumModel {
  SongAlbumModel({
    this.id,
    this.name,
    this.imageSource,
    this.singerId,
    this.isNew,
    this.singer,
    this.musics,
  });
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  SongSingerModel? singer;
  List<String>? musics;

  SongAlbumModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    json['singer'] != null ? new SongSingerModel.fromJson(json['singer']) : null;
    musics = List.castFrom<dynamic, String>(json['musics']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['singerId'] = singerId;
    _data['isNew'] = isNew;
    if (this.singer != null) {
      _data['singer'] = this.singer!.toJson();
    }    _data['musics'] = musics;
    return _data;
  }
}

class SongSingerModel {
  SongSingerModel({
    this.id,
    this.name,
    this.imageSource,
    this.isBest,
  });
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  SongSingerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    isBest = json['isBest'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['isBest'] = isBest;
    return _data;
  }
}