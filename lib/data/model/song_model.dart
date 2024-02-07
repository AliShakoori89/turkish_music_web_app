class SongModel {
  String? songId;
  String? songName;
  String? singerId;
  String? duration;
  String? imagePath;
  String? singerName;

  SongModel({
    this.songId,
    this.songName,
    this.singerId,
    this.duration,
    this.imagePath,
    this.singerName,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    songId: json['songId'],
    songName: json['songName'],
    singerId: json['singerId'],
    duration: json['duration'],
    imagePath: json['imagePath'],
    singerName: json['singerName'],
  );

  Map<String, dynamic> toJson() => {
    'songId': songId,
    'songName': songName,
    'singerId': singerId,
    'duration': duration,
    'imagePath': imagePath,
    'singerName': singerName,
  };
}