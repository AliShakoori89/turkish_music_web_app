class NewSongModel {
  List<NewSongDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

  NewSongModel({this.data, this.success, this.message, this.lastPage});

  NewSongModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NewSongDataModel>[];
      json['data'].forEach((v) {
        data!.add(new NewSongDataModel.fromJson(v));
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

class NewSongDataModel {
  int? id;
  String? name;
  bool? isNew;
  int? playCount;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  String? singerName;
  List<NewSongCategoriesModel>? categories;
  int? albumId;
  NewSongAlbumModel? album;
  String? creationDate;

  NewSongDataModel(
      {this.id,
        this.name,
        this.isNew,
        this.playCount,
        this.imageSource,
        this.fileSource,
        this.minute,
        this.second,
        this.singerName,
        this.categories,
        this.albumId,
        this.album,
        this.creationDate});

  NewSongDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isNew = json['isNew'];
    playCount = json['playCount'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    singerName = json['singerName'];
    if (json['categories'] != null) {
      categories = <NewSongCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new NewSongCategoriesModel.fromJson(v));
      });
    }
    albumId = json['albumId'];
    album = json['album'] != null ? new NewSongAlbumModel.fromJson(json['album']) : null;
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isNew'] = this.isNew;
    data['playCount'] = this.playCount;
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
    data['creationDate'] = this.creationDate;
    return data;
  }
}

class NewSongCategoriesModel {
  int? id;
  String? imageSource;
  String? title;
  String? creationDate;

  NewSongCategoriesModel({this.id, this.imageSource, this.title, this.creationDate});

  NewSongCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageSource = json['imageSource'];
    title = json['title'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageSource'] = this.imageSource;
    data['title'] = this.title;
    data['creationDate'] = this.creationDate;
    return data;
  }
}

class NewSongAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  NewSongSingerModel? singer;

  NewSongAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer});

  NewSongAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? new NewSongSingerModel.fromJson(json['singer']) : null;
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
    return data;
  }
}

class NewSongSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  NewSongSingerModel({this.id, this.name, this.imageSource, this.isBest});

  NewSongSingerModel.fromJson(Map<String, dynamic> json) {
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
