class CategoryModel {
  CategoryModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });
  late final List<CategoryDataModel> data;
  late final bool success;
  late final String message;
  late final int lastPage;

  CategoryModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>CategoryDataModel.fromJson(e)).toList();
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

class CategoryDataModel {
  CategoryDataModel({
    required this.id,
    required this.imageSource,
    required this.title,
    required this.musics,
    required this.creationDate,
  });
  late final int id;
  late final String imageSource;
  late final String title;
  late final List<CategoryMusicModel> musics;
  late final String creationDate;

  CategoryDataModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    imageSource = json['imageSource'];
    title = json['title'];
    musics = List.from(json['musics']).map((e)=>CategoryMusicModel.fromJson(e)).toList();
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['imageSource'] = imageSource;
    _data['title'] = title;
    _data['musics'] = musics.map((e)=>e.toJson()).toList();
    _data['creationDate'] = creationDate;
    return _data;
  }
}

class CategoryMusicModel {
  CategoryMusicModel({
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
  late final List<String> categories;
  late final int albumId;
  late final CategoryAlbumModel album;

  CategoryMusicModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    fileSource = json['fileSource'];
    categories = List.castFrom<dynamic, String>(json['categories']);
    albumId = json['albumId'];
    album = CategoryAlbumModel.fromJson(json['album']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['imageSource'] = imageSource;
    _data['fileSource'] = fileSource;
    _data['categories'] = categories;
    _data['albumId'] = albumId;
    _data['album'] = album.toJson();
    return _data;
  }
}

class CategoryAlbumModel {
  CategoryAlbumModel({
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
  late final CategorySingerModel singer;
  late final List<String> musics;

  CategoryAlbumModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imageSource = json['imageSource'];
    singerId = json['singerId'];
    isNew = json['isNew'];
    singer = CategorySingerModel.fromJson(json['singer']);
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

class CategorySingerModel {
  CategorySingerModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });
  late final int id;
  late final String name;
  late final String imageSource;
  late final bool isBest;

  CategorySingerModel.fromJson(Map<String, dynamic> json){
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