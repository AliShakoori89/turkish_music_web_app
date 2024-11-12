class NewSongModel {
  final List<NewSongDataModel> data;
  final bool success;
  final String message;
  final int lastPage;

  NewSongModel({
    required this.data,
    required this.success,
    required this.message,
    required this.lastPage,
  });

  factory NewSongModel.fromJson(Map<String, dynamic> json) {
    return NewSongModel(
      data: (json['data'] as List).map((item) => NewSongDataModel.fromJson(item)).toList(),
      success: json['success'],
      message: json['message'],
      lastPage: json['lastPage'],
    );
  }
}

class NewSongDataModel {
  final int id;
  final String name;
  final bool isNew;
  final int playCount;
  final String imageSource;
  final String fileSource;
  final String minute;
  final String second;
  final String singerName;
  final List<NewSongCategoryModel> categories;
  final int albumId;
  final NewSongAlbumModel album;
  final DateTime creationDate;

  NewSongDataModel({
    required this.id,
    required this.name,
    required this.isNew,
    required this.playCount,
    required this.imageSource,
    required this.fileSource,
    required this.minute,
    required this.second,
    required this.singerName,
    required this.categories,
    required this.albumId,
    required this.album,
    required this.creationDate,
  });

  factory NewSongDataModel.fromJson(Map<String, dynamic> json) {
    return NewSongDataModel(
      id: json['id'],
      name: json['name'],
      isNew: json['isNew'],
      playCount: json['playCount'],
      imageSource: json['imageSource'],
      fileSource: json['fileSource'],
      minute: json['minute'],
      second: json['second'],
      singerName: json['singerName'],
      categories: (json['categories'] as List).map((item) => NewSongCategoryModel.fromJson(item)).toList(),
      albumId: json['albumId'],
      album: NewSongAlbumModel.fromJson(json['album']),
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}

class NewSongCategoryModel {
  final int id;
  final String imageSource;
  final String title;
  final DateTime creationDate;

  NewSongCategoryModel({
    required this.id,
    required this.imageSource,
    required this.title,
    required this.creationDate,
  });

  factory NewSongCategoryModel.fromJson(Map<String, dynamic> json) {
    return NewSongCategoryModel(
      id: json['id'],
      imageSource: json['imageSource'],
      title: json['title'],
      creationDate: DateTime.parse(json['creationDate']),
    );
  }
}

class NewSongAlbumModel {
  final int id;
  final String name;
  final String imageSource;
  final int singerId;
  final bool isNew;
  final NewSongSingerModel singer;
  final List<String> musics;

  NewSongAlbumModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.singerId,
    required this.isNew,
    required this.singer,
    required this.musics,
  });

  factory NewSongAlbumModel.fromJson(Map<String, dynamic> json) {
    return NewSongAlbumModel(
      id: json['id'],
      name: json['name'],
      imageSource: json['imageSource'],
      singerId: json['singerId'],
      isNew: json['isNew'],
      singer: NewSongSingerModel.fromJson(json['singer']),
      musics: List<String>.from(json['musics']),
    );
  }
}

class NewSongSingerModel {
  final int id;
  final String name;
  final String imageSource;
  final bool isBest;

  NewSongSingerModel({
    required this.id,
    required this.name,
    required this.imageSource,
    required this.isBest,
  });

  factory NewSongSingerModel.fromJson(Map<String, dynamic> json) {
    return NewSongSingerModel(
      id: json['id'],
      name: json['name'],
      imageSource: json['imageSource'],
      isBest: json['isBest'],
    );
  }
}
