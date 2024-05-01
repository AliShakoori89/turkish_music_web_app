class SongModel {
  SongModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });
  late final List<SongDataModel> data;
  late final bool success;
  late final String message;
  late final int lastPage;

  SongModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>SongDataModel.fromJson(e)).toList();
    success = json['success'];
    message = json['message'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['success'] = success;
    _data['message'] = message;
    _data['lastPage'] = lastPage;
    return _data;
  }
}

class SongDataModel {
  SongDataModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.fileSource,
    required this.minute,
    required this.second,
    this.categories,
    this.albumId,
    this.album,
  });
  late final int id;
  late final String name;
  late final String imageSource;
  late final String fileSource;
  late final String minute;
  late final String second;
  late List<SongCategoriesModel>? categories;
  late int? albumId;
  late SongAlbumModel? album;

  SongDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    minute = json['minute'];
    second = json['second'];
    categories = List.from(json['categories']).map((e)=>SongCategoriesModel.fromJson(e)).toList();
    albumId = json['albumId'];
    album = SongAlbumModel.fromJson(json['album']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['fileSource'] = fileSource;
    _data['minute'] = minute;
    _data['second'] = second;
    _data['categories'] = categories?.map((e)=>e.toJson()).toList();
    _data['albumId'] = albumId;
    _data['album'] = album?.toJson();
    return _data;
  }
}

class SongCategoriesModel {
  SongCategoriesModel({
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
  late final SongSingerModel singer;
  late final List<String> musics;

  SongAlbumModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer = SongSingerModel.fromJson(json['singer']);
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

class SongSingerModel {
  SongSingerModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });
  late final int id;
  late final String name;
  late final String imageSource;
  late final bool isBest;

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