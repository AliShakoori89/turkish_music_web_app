part of 'audio_control_bloc.dart';

@immutable
class AudioControlEvent {}

class PlaySong extends AudioControlEvent {
  final SongDataModel currentSong;
  final List<AlbumDataMusicModel> currentAlbum;
  PlaySong({required this.currentSong, required this.currentAlbum});
}

class PlayNextSong extends AudioControlEvent {
  final List<AlbumDataMusicModel> currentAlbum;

  PlayNextSong({required this.currentAlbum});
}

class PauseSong extends AudioControlEvent {}

class initialSong extends AudioControlEvent {}

class ResumeSong extends AudioControlEvent {}

class StopRepeating extends AudioControlEvent {}

class RepeatSong extends AudioControlEvent {}

class SongCompletedEvent extends AudioControlEvent {}

class AudioPositionChangedEvent extends AudioControlEvent {
  final Duration position;
  AudioPositionChangedEvent({required this.position});
}
