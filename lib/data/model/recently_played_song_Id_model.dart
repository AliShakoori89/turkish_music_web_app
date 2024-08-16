class RecentlyPlayedSongIdModel {
  int? id;

  RecentlyPlayedSongIdModel({this.id});

  Map<String, dynamic> toJson() {
    return {
      "SongId": id,
    };
  }

  factory RecentlyPlayedSongIdModel.fromJson(Map<String, dynamic> parsedJson) {
    return RecentlyPlayedSongIdModel(
        id: parsedJson['SongId']
    );
  }
}