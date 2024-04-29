part of 'current_selected_song_bloc.dart';

@immutable
sealed class CurrentSelectedSongState {}

final class CurrentSelectedSongInitial extends CurrentSelectedSongState {}

final class SelectedSongFetched extends CurrentSelectedSongState {
  final int songId;
  final String songName;
  final String songFile;
  final String songImage;
  final String singerName;

  SelectedSongFetched({required this.songId, required this.songName,
    required this.songFile, required this.songImage, required this.singerName});
}

final class LoadingNewSong extends CurrentSelectedSongState {}
