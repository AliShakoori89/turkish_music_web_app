part of 'current_selected_song_bloc.dart';

@immutable
sealed class CurrentSelectedSongEvent {}

final class PlayNextSong extends CurrentSelectedSongEvent {
  final List<SongDataModel> songs;

  PlayNextSong({required this.songs});
}

final class PlayPreviousSong extends CurrentSelectedSongEvent {
  final List<SongDataModel> songs;

  PlayPreviousSong({required this.songs});
}

final class SelectSong extends CurrentSelectedSongEvent {
  final SongDataModel songModel;

  SelectSong({required this.songModel});
}
