part of 'current_selected_song_bloc.dart';

abstract class CurrentSelectedSongState {}

class CurrentSelectedSongInitialState extends CurrentSelectedSongState {}

class LoadingNewSongState extends CurrentSelectedSongState {}

class SelectedSongFetchedState extends CurrentSelectedSongState {
  final SongDataModel songModel;

  SelectedSongFetchedState({required this.songModel});
}

class SelectedSongCompletedState extends CurrentSelectedSongState {
  final SongDataModel songModel;

  SelectedSongCompletedState({required this.songModel});
}

class CurrentSelectedSongErrorState extends CurrentSelectedSongState {
  final String errorMessage;

  CurrentSelectedSongErrorState(this.errorMessage);
}
