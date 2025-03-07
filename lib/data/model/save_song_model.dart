class SaveSongModel {
  int? id;
  String? songName;
  String? singerName;
  String? imageFilePath;
  String? audioFilePath;
  String? audioFileMin;
  String? audioFileSec;
  String? albumName;
  int? audioFileAlbumId;

  SaveSongModel({this.id, this.songName, this.singerName,
  this.audioFilePath, this.imageFilePath, this.audioFileMin,
  this.audioFileSec, this.audioFileAlbumId, this.albumName});

  Map<String, dynamic> toJson() {
    return {
      "songId": id,
      "songName": songName,
      "singerName": singerName,
      "imageFilePath": imageFilePath,
      "audioFilePath": audioFilePath,
      "audioFileMin": audioFileMin,
      "audioFileSec": audioFileSec,
      "albumName": albumName,
      "audioFileAlbumId": audioFileAlbumId
    };
  }

  factory SaveSongModel.fromJson(Map<String, dynamic> parsedJson) {
    return SaveSongModel(
      id: parsedJson['songId'],
      songName: parsedJson['songName'],
      singerName: parsedJson['singerName'],
      imageFilePath: parsedJson['imageFilePath'],
      audioFilePath: parsedJson['audioFilePath'],
      audioFileMin: parsedJson["audioFileMin"],
      audioFileSec: parsedJson['audioFileSec'],
      albumName: parsedJson['albumName'],
      audioFileAlbumId: parsedJson['audioFileAlbumId']
    );
  }
}