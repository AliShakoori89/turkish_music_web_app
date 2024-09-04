part of 'audio_control_bloc.dart';

@immutable
class AudioControlEvent {}

class PlaySongEvent extends AudioControlEvent {
  final SongDataModel currentSong;
  final List<AlbumDataMusicModel> currentAlbum;
  PlaySongEvent({required this.currentSong, required this.currentAlbum});
}

class PlayNextSongEvent extends AudioControlEvent {
  final List<AlbumDataMusicModel> currentAlbum;

  PlayNextSongEvent({required this.currentAlbum});
}

class PlayPreviousSongEvent extends AudioControlEvent {
  final List<AlbumDataMusicModel> currentAlbum;

  PlayPreviousSongEvent({required this.currentAlbum});
}

class PauseSongEvent extends AudioControlEvent {}

class initialSongEvent extends AudioControlEvent {}

class ResumeSongEvent extends AudioControlEvent {}

class StopRepeatingEvent extends AudioControlEvent {}

class RepeatSongEvent extends AudioControlEvent {}

class SongCompletedEvent extends AudioControlEvent {}

class AudioPositionChangedEvent extends AudioControlEvent {
  final Duration position;
  AudioPositionChangedEvent({required this.position});
}
