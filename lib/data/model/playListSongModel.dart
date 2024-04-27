class PlayListModel {
  PlayListModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });
  late final PlayListDataModel data;
  late final bool success;
  late final String message;
  late final int lastPage;

  PlayListModel.fromJson(Map<String, dynamic> json){
    data = PlayListDataModel.fromJson(json['data']);
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['success'] = success;
    _data['message'] = message;
    _data['lastPage'] = lastPage;
    return _data;
  }
}

class PlayListDataModel {
  PlayListDataModel({
    required this.id,
    required this.userId,
    required this.musics,
  });
  late final int id;
  late final int userId;
  late final List<PlayListSongModel> musics;

  PlayListDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['userId'];
    musics = List.from(json['musics']).map((e)=>PlayListSongModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['userId'] = userId;
    _data['musics'] = musics.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class PlayListSongModel {
  PlayListSongModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.fileSource,
    required this.categories,
    required this.albumId,
    required this.album,
  });
  late final int id;
  late final String name;
  late final String imageSource;
  late final String fileSource;
  late final List<PlayListCategoriesModel> categories;
  late final int albumId;
  late final PlayListAlbumModel album;

  PlayListSongModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    categories = List.from(json['categories']).map((e)=>PlayListCategoriesModel.fromJson(e)).toList();
    albumId = json['albumId'];
    album = PlayListAlbumModel.fromJson(json['album']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['fileSource'] = fileSource;
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    _data['albumId'] = albumId;
    _data['album'] = album.toJson();
    return _data;
  }
}

class PlayListCategoriesModel {
  PlayListCategoriesModel({
    required this.id,
    required this.imageSource,
    required this.title,
    required this.musics,
    required this.creationDate,
  });
  late final int id;
  late final String imageSource;
  late final String title;
  late final List<String> musics;
  late final String creationDate;

  PlayListCategoriesModel.fromJson(Map<String, dynamic> json){
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

class PlayListAlbumModel {
  PlayListAlbumModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.singerId,
    required this.isNew,
    required this.singer,
    required this.musics,
  });
  late final int id;
  late final String name;
  late final String imageSource;
  late final int singerId;
  late final bool isNew;
  late final PlayListSingerModel singer;
  late final List<String> musics;

  PlayListAlbumModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer = PlayListSingerModel.fromJson(json['singer']);
    musics = List.castFrom<dynamic, String>(json['musics']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['singerId'] = singerId;
    _data['isNew'] = isNew;
    _data['singer'] = singer.toJson();
    _data['musics'] = musics;
    return _data;
  }
}

class PlayListSingerModel {
  PlayListSingerModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });
  late final int id;
  late final String name;
  late final String imageSource;
  late final bool isBest;

  PlayListSingerModel.fromJson(Map<String, dynamic> json){
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