part of 'current_selected_song_bloc.dart';

@immutable
class CurrentSelectedSongEvent {}

class PlayNextSong extends CurrentSelectedSongEvent {
  final List<AlbumDataMusicModel> songs;

  PlayNextSong({required this.songs});
}

class PlayPreviousSong extends CurrentSelectedSongEvent {
  final List<AlbumDataMusicModel> songs;

  PlayPreviousSong({required this.songs});
}

class SelectSong extends CurrentSelectedSongEvent {
  final SongDataModel songModel;

  SelectSong({required this.songModel});
}
