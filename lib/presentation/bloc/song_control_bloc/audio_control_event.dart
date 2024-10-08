part of 'audio_control_bloc.dart';

@immutable
class AudioControlEvent {}

class PlaySongEvent extends AudioControlEvent {
  final SongDataModel currentSong;
  final List<AlbumDataMusicModel> currentAlbum;
  late List<FileSystemEntity> localSongs;
  PlaySongEvent({required this.currentSong, required this.currentAlbum});
}

class PlayNextSongEvent extends AudioControlEvent {
  final List<AlbumDataMusicModel> currentAlbum;
  final String singerName;

  PlayNextSongEvent({required this.currentAlbum, required this.singerName});
}

class PlayNextLocalSongEvent extends AudioControlEvent {
  final List<FileSystemEntity> currentAlbum;

  PlayNextLocalSongEvent({required this.currentAlbum});
}

class PlayPreviousSongEvent extends AudioControlEvent {
  final List<AlbumDataMusicModel> currentAlbum;
  final String singerName;

  PlayPreviousSongEvent({required this.currentAlbum, required this.singerName});
}

class PlayPreviousLocalSongEvent extends AudioControlEvent {
  final List<FileSystemEntity> localSongs;

  PlayPreviousLocalSongEvent({required this.localSongs});
}

class PauseSongEvent extends AudioControlEvent {}

class PlaySelectedSongEvent extends AudioControlEvent {
  final SongDataModel currentSong;
  final List<AlbumDataMusicModel> currentAlbum;

  PlaySelectedSongEvent({required this.currentSong
    , required this.currentAlbum});
}

class initialSongEvent extends AudioControlEvent {}

class ResumeSongEvent extends AudioControlEvent {}

class StopRepeatingEvent extends AudioControlEvent {}

class RepeatSongEvent extends AudioControlEvent {}

class SongCompletedEvent extends AudioControlEvent {}

class AudioPlayDisposeEvent extends AudioControlEvent {}

class AudioPositionChangedEvent extends AudioControlEvent {
  final Duration position;
  AudioPositionChangedEvent({required this.position});
}
