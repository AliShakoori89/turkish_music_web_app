class SongModel {
  String? songId;
  String? songName;
  String? userid;
  String? duration;
  String? coverImageUrl;
  String? singerName;

  SongModel({
    this.songId,
    this.songName,
    this.userid,
    this.duration,
    this.coverImageUrl,
    this.singerName,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    songId: json['songId'],
    songName: json['songName'],
    userid: json['userid'],
    duration: json['duration'],
    coverImageUrl: json['cover_image_url'],
    singerName: json['singerName'],
  );

  Map<String, dynamic> toJson() => {
    'songId': songId,
    'songName': songName,
    'userid': userid,
    'duration': duration,
    'cover_image_url': coverImageUrl,
    'singerName': singerName,
  };
}