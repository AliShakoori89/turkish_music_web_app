part of 'audio_control_bloc.dart';

@immutable
class AudioControlEvent {}

class PlaySong extends AudioControlEvent {
  final SongDataModel currentSong;
  final List<AlbumDataMusicModel> currentAlbum;
  PlaySong({required this.currentSong, required this.currentAlbum});
}

class PauseSong extends AudioControlEvent {}

class initialSong extends AudioControlEvent {
  final List<AlbumDataMusicModel> songs;
  initialSong({required this.songs});
}

class ResumeSong extends AudioControlEvent {}

class StopRepeating extends AudioControlEvent {}

class RepeatSong extends AudioControlEvent {}

class SongCompleted extends AudioControlEvent {
  final List<AlbumDataMusicModel> songs;
  SongCompleted({required this.songs});
}
