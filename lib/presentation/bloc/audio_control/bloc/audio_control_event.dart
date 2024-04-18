part of 'audio_control_bloc.dart';

@immutable
sealed class AudioControlEvent {}

final class PlaySong extends AudioControlEvent {
  final int songId;
  final String songName;
  final String songFile;
  final String songImage;

  PlaySong({required this.songId, required this.songName, required this.songFile, required this.songImage});
}

final class PauseSong extends AudioControlEvent {}

final class ResumeSong extends AudioControlEvent {}

final class SongCompleted extends AudioControlEvent {}

final class UpdateTimeDuration extends AudioControlEvent {}

final class UpdateSeekPositionDuration extends AudioControlEvent {}
