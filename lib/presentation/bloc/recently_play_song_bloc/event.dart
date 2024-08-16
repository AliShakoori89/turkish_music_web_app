import 'package:turkish_music_app/data/model/recently_played_song_Id_model.dart';

abstract class RecentlyPlaySongEvent {
  List<Object> get props => [];
}

class GetAllPlayedSongsEvent extends RecentlyPlaySongEvent{}

class SavePlayedSongIDToRecentlyPlayedEvent extends RecentlyPlaySongEvent{
  final RecentlyPlayedSongIdModel recentlyPlayedSongIdModel;

  SavePlayedSongIDToRecentlyPlayedEvent({required this.recentlyPlayedSongIdModel});

  @override
  List<Object> get props => [recentlyPlayedSongIdModel];
}


