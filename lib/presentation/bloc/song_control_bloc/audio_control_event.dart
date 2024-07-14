part of 'audio_control_bloc.dart';

@immutable
sealed class AudioControlEvent {}

final class PlaySong extends AudioControlEvent {
  final SongDataModel currentSong;
  PlaySong({required this.currentSong});
}

final class PlayNextSong extends AudioControlEvent {
  final List<SongDataModel> songs;

  PlayNextSong({required this.songs});
}

final class PauseSong extends AudioControlEvent {}

final class ResumeSong extends AudioControlEvent {}

final class SongCompleted extends AudioControlEvent {}
