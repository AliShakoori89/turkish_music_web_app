/// data : [{"id":0,"name":"string","imageSource":"string","singerId":0,"singer":{"id":0,"name":"string","imageSource":"string"},"musics":[{"id":0,"name":"string","imageSource":"string","fileSource":"string","albumId":0,"album":"string"}]}]
/// success : true
/// message : "string"
/// lastPage : 0

class Album {
  Album({
      List<Data> data, 
      bool success, 
      String message, 
      num lastPage,}){
    _data = data;
    _success = success;
    _message = message;
    _lastPage = lastPage;
}

  Album.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _lastPage = json['lastPage'];
  }
  List<Data> _data;
  bool _success;
  String _message;
  num _lastPage;
Album copyWith({  List<Data> data,
  bool success,
  String message,
  num lastPage,
}) => Album(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  lastPage: lastPage ?? _lastPage,
);
  List<Data> get data => _data;
  bool get success => _success;
  String get message => _message;
  num get lastPage => _lastPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['lastPage'] = _lastPage;
    return map;
  }

}

/// id : 0
/// name : "string"
/// imageSource : "string"
/// singerId : 0
/// singer : {"id":0,"name":"string","imageSource":"string"}
/// musics : [{"id":0,"name":"string","imageSource":"string","fileSource":"string","albumId":0,"album":"string"}]

class Data {
  Data({
      num id, 
      String name, 
      String imageSource, 
      num singerId, 
      Singer singer, 
      List<Musics> musics,}){
    _id = id;
    _name = name;
    _imageSource = imageSource;
    _singerId = singerId;
    _singer = singer;
    _musics = musics;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageSource = json['imageSource'];
    _singerId = json['singerId'];
    _singer = json['singer'] != null ? Singer.fromJson(json['singer']) : null;
    if (json['musics'] != null) {
      _musics = [];
      json['musics'].forEach((v) {
        _musics.add(Musics.fromJson(v));
      });
    }
  }
  num _id;
  String _name;
  String _imageSource;
  num _singerId;
  Singer _singer;
  List<Musics> _musics;
Data copyWith({  num id,
  String name,
  String imageSource,
  num singerId,
  Singer singer,
  List<Musics> musics,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  imageSource: imageSource ?? _imageSource,
  singerId: singerId ?? _singerId,
  singer: singer ?? _singer,
  musics: musics ?? _musics,
);
  num get id => _id;
  String get name => _name;
  String get imageSource => _imageSource;
  num get singerId => _singerId;
  Singer get singer => _singer;
  List<Musics> get musics => _musics;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageSource'] = _imageSource;
    map['singerId'] = _singerId;
    if (_singer != null) {
      map['singer'] = _singer.toJson();
    }
    if (_musics != null) {
      map['musics'] = _musics.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 0
/// name : "string"
/// imageSource : "string"
/// fileSource : "string"
/// albumId : 0
/// album : "string"

class Musics {
  Musics({
      num id, 
      String name, 
      String imageSource, 
      String fileSource, 
      num albumId, 
      String album,}){
    _id = id;
    _name = name;
    _imageSource = imageSource;
    _fileSource = fileSource;
    _albumId = albumId;
    _album = album;
}

  Musics.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageSource = json['imageSource'];
    _fileSource = json['fileSource'];
    _albumId = json['albumId'];
    _album = json['album'];
  }
  num _id;
  String _name;
  String _imageSource;
  String _fileSource;
  num _albumId;
  String _album;
Musics copyWith({  num id,
  String name,
  String imageSource,
  String fileSource,
  num albumId,
  String album,
}) => Musics(  id: id ?? _id,
  name: name ?? _name,
  imageSource: imageSource ?? _imageSource,
  fileSource: fileSource ?? _fileSource,
  albumId: albumId ?? _albumId,
  album: album ?? _album,
);
  num get id => _id;
  String get name => _name;
  String get imageSource => _imageSource;
  String get fileSource => _fileSource;
  num get albumId => _albumId;
  String get album => _album;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageSource'] = _imageSource;
    map['fileSource'] = _fileSource;
    map['albumId'] = _albumId;
    map['album'] = _album;
    return map;
  }

}

/// id : 0
/// name : "string"
/// imageSource : "string"

class Singer {
  Singer({
      num id, 
      String name, 
      String imageSource,}){
    _id = id;
    _name = name;
    _imageSource = imageSource;
}

  Singer.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _imageSource = json['imageSource'];
  }
  num _id;
  String _name;
  String _imageSource;
Singer copyWith({  num id,
  String name,
  String imageSource,
}) => Singer(  id: id ?? _id,
  name: name ?? _name,
  imageSource: imageSource ?? _imageSource,
);
  num get id => _id;
  String get name => _name;
  String get imageSource => _imageSource;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['imageSource'] = _imageSource;
    return map;
  }

}