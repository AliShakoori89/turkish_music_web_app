class CategoryModel {
  final List<CategoryDataModel> data;
  final bool success;
  final String message;
  final int lastPage;

  CategoryModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      data: (json['data'] as List)
          .map((item) => CategoryDataModel.fromJson(item))
          .toList(),
      success: json['success'],
      message: json['message'],
      lastPage: json['lastPage'],
    );
  }
}

class CategoryDataModel {
  final int id;
  final String imageSource;
  final String title;
  final List<CategoryMusicModel> musics;
  final String creationDate;

  CategoryDataModel({
    required this.id,
    required this.imageSource,
    required this.title,
    required this.musics,
    required this.creationDate,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      id: json['id'],
      imageSource: json['imageSource'],
      title: json['title'],
      musics: (json['musics'] as List)
          .map((item) => CategoryMusicModel.fromJson(item))
          .toList(),
      creationDate: json['creationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageSource': imageSource,
      'title': title,
      'musics': musics.map((item) => item.toJson()).toList(),
      'creationDate': creationDate,
    };
  }
}

class CategoryMusicModel {
  final int id;
  final String name;
  final int playCount;
  final String imageSource;
  final String fileSource;
  final String minute;
  final String second;
  final String? singerName;
  final List<CategoryInfoModel> categories;
  final int albumId;
  final String? album;
  final String creationDate;

  CategoryMusicModel({
    required this.id,
    required this.name,
    required this.playCount,
    required this.imageSource,
    required this.fileSource,
    required this.minute,
    required this.second,
    this.singerName,
    required this.categories,
    required this.albumId,
    this.album,
    required this.creationDate,
  });

  factory CategoryMusicModel.fromJson(Map<String, dynamic> json) {
    return CategoryMusicModel(
      id: json['id'],
      name: json['name'],
      playCount: json['playCount'],
      imageSource: json['imageSource'],
      fileSource: json['fileSource'],
      minute: json['minute'],
      second: json['second'],
      singerName: json['singerName'],
      categories: (json['categories'] as List)
          .map((item) => CategoryInfoModel.fromJson(item))
          .toList(),
      albumId: json['albumId'],
      album: json['album'],
      creationDate: json['creationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'playCount': playCount,
      'imageSource': imageSource,
      'fileSource': fileSource,
      'minute': minute,
      'second': second,
      'singerName': singerName,
      'categories': categories.map((item) => item.toJson()).toList(),
      'albumId': albumId,
      'album': album,
      'creationDate': creationDate,
    };
  }
}

class CategoryInfoModel {
  final int id;
  final String imageSource;
  final String title;
  final String creationDate;

  CategoryInfoModel({
    required this.id,
    required this.imageSource,
    required this.title,
    required this.creationDate,
  });

  factory CategoryInfoModel.fromJson(Map<String, dynamic> json) {
    return CategoryInfoModel(
      id: json['id'],
      imageSource: json['imageSource'],
      title: json['title'],
      creationDate: json['creationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageSource': imageSource,
      'title': title,
      'creationDate': creationDate,
    };
  }
}
