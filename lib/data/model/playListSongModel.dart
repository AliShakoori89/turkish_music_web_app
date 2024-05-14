class PlaylistModel {
  PlayListDataModel? data;
  bool? success;
  String? message;
  int? lastPage;

  PlaylistModel({this.data, this.success, this.message, this.lastPage});

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new PlayListDataModel.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    data['lastPage'] = this.lastPage;
    return data;
  }
}

class PlayListDataModel {
  int? id;
  int? userId;
  List<PlaylistMusicModel>? musics;
  List<NewMusics>? newMusics;

  PlayListDataModel({this.id, this.userId, this.musics, this.newMusics});

  PlayListDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    if (json['musics'] != null) {
      musics = <PlaylistMusicModel>[];
      json['musics'].forEach((v) {
        musics!.add(new PlaylistMusicModel.fromJson(v));
      });
    }
    if (json['newMusics'] != null) {
      newMusics = <NewMusics>[];
      json['newMusics'].forEach((v) {
        newMusics!.add(new NewMusics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    if (this.musics != null) {
      data['musics'] = this.musics!.map((v) => v.toJson()).toList();
    }
    if (this.newMusics != null) {
      data['newMusics'] = this.newMusics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlaylistMusicModel {
  int? id;
  String? name;
  String? imageSource;
  String? fileSource;
  String? minute;
  String? second;
  List<PlaylistCategoriesModel>? categories;
  String? singerName;
  int? albumId;
  PlaylistAlbumModel? album;

  PlaylistMusicModel(
      {this.id,
        this.name,
        this.imageSource,
        this.fileSource,
        this.minute,
        this.second,
        this.categories,
        this.singerName,
        this.albumId,
        this.album});

  PlaylistMusicModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    if (json['categories'] != null) {
      categories = <PlaylistCategoriesModel>[];
      json['categories'].forEach((v) {
        categories!.add(new PlaylistCategoriesModel.fromJson(v));
      });
    }
    singerName = json['singerName'];
    albumId = json['albumId'];
    album = json['album'] != null ? new PlaylistAlbumModel.fromJson(json['album']) : null;
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

class PlaylistCategoriesModel {
  int? id;
  String? imageSource;
  String? title;
  List<String>? musics;
  String? creationDate;

  PlaylistCategoriesModel(
      {this.id, this.imageSource, this.title, this.musics, this.creationDate});

  PlaylistCategoriesModel.fromJson(Map<String, dynamic> json) {
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

class PlaylistAlbumModel {
  int? id;
  String? name;
  String? imageSource;
  int? singerId;
  bool? isNew;
  PlaylistSingerModel? singer;
  List<String>? musics;

  PlaylistAlbumModel(
      {this.id,
        this.name,
        this.imageSource,
        this.singerId,
        this.isNew,
        this.singer,
        this.musics});

  PlaylistAlbumModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer =
    json['singer'] != null ? new PlaylistSingerModel.fromJson(json['singer']) : null;
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

class PlaylistSingerModel {
  int? id;
  String? name;
  String? imageSource;
  bool? isBest;

  PlaylistSingerModel({this.id, this.name, this.imageSource, this.isBest});

  PlaylistSingerModel.fromJson(Map<String, dynamic> json) {
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

class NewMusics {
  int? id;
  String? name;
  String? minute;
  String? second;
  String? imageSource;
  String? fileSource;
  int? singerId;
  PlaylistSingerModel? singer;

  NewMusics(
      {this.id,
        this.name,
        this.minute,
        this.second,
        this.imageSource,
        this.fileSource,
        this.singerId,
        this.singer});

  NewMusics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    minute = json['minute'];
    second = json['second'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    singerId = json['singerId'];
    singer =
    json['singer'] != null ? new PlaylistSingerModel.fromJson(json['singer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['minute'] = this.minute;
    data['second'] = this.second;
    data['imageSource'] = this.imageSource;
    data['fileSource'] = this.fileSource;
    data['singerId'] = this.singerId;
    if (this.singer != null) {
      data['singer'] = this.singer!.toJson();
    }
    return data;
  }
}
