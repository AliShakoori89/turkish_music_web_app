class GetAllMusicModel {
  List<GetAllMusicDataModel>? data;
  bool? success;
  String? message;
  int? lastPage;

  GetAllMusicModel({this.data, this.success, this.message, this.lastPage});

  GetAllMusicModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GetAllMusicDataModel>[];
      json['data'].forEach((v) {
        data!.add(new GetAllMusicDataModel.fromJson(v));
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

class GetAllMusicDataModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  List<GetAllMusicCategoriesModel>? categories;
  int? albumId;
  GetAllMusicAlbumModel? album;

  GetAllMusicDataModel(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.minute,
        this.second,
        this.categories,
        this.albumId,
        this.album});

  GetAllMusicDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    if (json['categories'] != null) {
      categories = <GetAllMusicCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new GetAllMusicCategoriesModel.fromJson(v));
      });
    }
    albumId = json['albumId'];
    album = json['album'] != null ? new GetAllMusicAlbumModel.fromJson(json['album']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imageSource'] = this.imageSource;
    data['fileSource'] = this.fileSource;
    data['minute'] = this.minute;
    data['second'] = this.second;
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

class GetAllMusicCategoriesModel {
  int? id;
  String? imageSource;
  String? title;
  List<String>? musics;
  String? creationDate;

  GetAllMusicCategoriesModel(
      {this.id, this.imageSource, this.title, this.musics, this.creationDate});

  GetAllMusicCategoriesModel.fromJson(Map<String, dynamic> json) {
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

class GetAllMusicAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  GetAllMusicSingerModelSinger? singer;
  List<String>? musics;

  GetAllMusicAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer,
        this.musics});

  GetAllMusicAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? new GetAllMusicSingerModelSinger.fromJson(json['singer']) : null;
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

class GetAllMusicSingerModelSinger {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  GetAllMusicSingerModelSinger({this.id, this.name, this.imageSource, this.isBest});

  GetAllMusicSingerModelSinger.fromJson(Map<String, dynamic> json) {
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
