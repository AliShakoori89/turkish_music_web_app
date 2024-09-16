import 'package:turkish_music_app/data/model/save_song_model.dart';

abstract class RecentlyPlaySongEvent {
  List<Object> get props => [];
}

class GetAllPlayedSongsEvent extends RecentlyPlaySongEvent{}

class SavePlayedSongIDToRecentlyPlayedEvent extends RecentlyPlaySongEvent{
  final SaveSongModel recentlyPlayedSongIdModel;

  SavePlayedSongIDToRecentlyPlayedEvent({required this.recentlyPlayedSongIdModel});

  @override
  List<Object> get props => [recentlyPlayedSongIdModel];
}


