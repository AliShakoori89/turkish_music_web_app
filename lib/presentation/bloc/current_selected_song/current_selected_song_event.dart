part of 'current_selected_song_bloc.dart';

abstract class CurrentSelectedSongEvent {}

class SelectSongEvent extends CurrentSelectedSongEvent {
  final SongDataModel songModel;

  SelectSongEvent({required this.songModel});
}

class PlayNextSongEvent extends CurrentSelectedSongEvent {
  final List<AlbumDataMusicModel> songs;

  PlayNextSongEvent({required this.songs});
}

class PlayPreviousSongEvent extends CurrentSelectedSongEvent {
  final List<AlbumDataMusicModel> songs;

  PlayPreviousSongEvent({required this.songs});
}

class SelectedSongCompleteEvent extends CurrentSelectedSongEvent {
  final SongDataModel songModel;

  SelectedSongCompleteEvent({required this.songModel});
}

class CurrentSelectedSongErrorEvent extends CurrentSelectedSongEvent {
  final String errorMessage;

  CurrentSelectedSongErrorEvent(this.errorMessage);
}
