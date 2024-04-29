part of 'song_control_bloc.dart';

@immutable
sealed class SongControlEvent {}

final class PlaySong extends SongControlEvent {
  final int songId;
  final String songName;
  final String songFile;
  final String songImage;

  PlaySong({required this.songId, required this.songName, required this.songFile, required this.songImage});
}

final class PauseSong extends SongControlEvent {}

final class ResumeSong extends SongControlEvent {}

final class SongCompleted extends SongControlEvent {}

final class UpdateTimeDuration extends SongControlEvent {}

final class UpdateSeekPositionDuration extends SongControlEvent {}
