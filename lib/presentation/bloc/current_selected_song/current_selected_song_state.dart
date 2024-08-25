part of 'current_selected_song_bloc.dart';

@immutable
class CurrentSelectedSongState {}

class CurrentSelectedSongInitial extends CurrentSelectedSongState {}

class SelectedSongFetched extends CurrentSelectedSongState {
  final SongDataModel songModel;

  SelectedSongFetched({required this.songModel});
}

class LoadingNewSong extends CurrentSelectedSongState {}
