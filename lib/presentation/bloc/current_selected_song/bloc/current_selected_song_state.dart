part of 'current_selected_song_bloc.dart';

@immutable
sealed class CurrentSelectedSongState {}

final class CurrentSelectedSongInitial extends CurrentSelectedSongState {}

final class SelectedSongFetched extends CurrentSelectedSongState {
  final SongDataModel songModel;

  SelectedSongFetched({required this.songModel});
}

final class LoadingNewSong extends CurrentSelectedSongState {}
