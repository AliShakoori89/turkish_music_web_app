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
  final List<MusicModel> musics;
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
          .map((item) => MusicModel.fromJson(item))
          .toList(),
      creationDate: json['creationDate'],
    );
  }
}

class MusicModel {
  final int id;
  final String name;
  final int playCount;
  final String imageSource;
  final String fileSource;
  final String minute;
  final String second;
  final String? singerName;
  final List<CategoryInfo> categories;
  final int albumId;
  final String? album;
  final String creationDate;

  MusicModel({
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

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'],
      name: json['name'],
      playCount: json['playCount'],
      imageSource: json['imageSource'],
      fileSource: json['fileSource'],
      minute: json['minute'],
      second: json['second'],
      singerName: json['singerName'],
      categories: (json['categories'] as List)
          .map((item) => CategoryInfo.fromJson(item))
          .toList(),
      albumId: json['albumId'],
      album: json['album'],
      creationDate: json['creationDate'],
    );
  }
}

class CategoryInfo {
  final int id;
  final String imageSource;
  final String title;
  final String creationDate;

  CategoryInfo({
    required this.id,
    required this.imageSource,
    required this.title,
    required this.creationDate,
  });

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['id'],
      imageSource: json['imageSource'],
      title: json['title'],
      creationDate: json['creationDate'],
    );
  }
}
