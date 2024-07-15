part of 'audio_control_bloc.dart';

@immutable
sealed class AudioControlState {}

final class AudioControlInitial extends AudioControlState {}

final class AudioPlayedState extends AudioControlState {}

final class AudioPausedState extends AudioControlState {}

final class AudioErrorState extends AudioControlState {}

final class AudioLoadingNewSong extends AudioControlState {}

final class AudioSelectedSongFetched extends AudioControlState {
  final SongDataModel songModel;

  AudioSelectedSongFetched({required this.songModel});
}