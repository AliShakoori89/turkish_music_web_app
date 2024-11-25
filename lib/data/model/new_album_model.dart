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
        data!.add(new NewAlbumDataModel.fromJson(v));
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
    json['singer'] != null ? new NewAlbumSingerModel.fromJson(json['singer']) : null;
    if (json['musics'] != null) {
      musics = <NewAlbumMusicsModel>[];
      json['musics'].forEach((v) {
        musics!.add(new NewAlbumMusicsModel.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageSource'] = this.imageSource;
    data['isBest'] = this.isBest;
    return data;
  }
}

class NewAlbumMusicsModel {
  int? id;
  String? name;
  bool? isNew;
  int? playCount;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  String? singerName;
  List<NewAlbumCategoriesModel>? categories;
  int? albumId;
  NewAlbumAlbumModel? album;
  String? creationDate;

  NewAlbumMusicsModel(
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

  NewAlbumMusicsModel.fromJson(Map<String, dynamic> json) {
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
      categories = <NewAlbumCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new NewAlbumCategoriesModel.fromJson(v));
      });
    }
    albumId = json['albumId'];
    album = json['album'] != null ? new NewAlbumAlbumModel.fromJson(json['album']) : null;
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

class NewAlbumCategoriesModel {
  int? id;
  String? imageSource;
  String? title;
  String? creationDate;

  NewAlbumCategoriesModel({this.id, this.imageSource, this.title, this.creationDate});

  NewAlbumCategoriesModel.fromJson(Map<String, dynamic> json) {
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

class NewAlbumAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  NewAlbumSingerModel? singer;

  NewAlbumAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer});

  NewAlbumAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? new NewAlbumSingerModel.fromJson(json['singer']) : null;
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
