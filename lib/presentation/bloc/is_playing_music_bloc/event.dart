abstract class IsPlayingMusicEvent {
  List<Object> get props => [];
}

class SetIsPlayingMusicEvent extends IsPlayingMusicEvent{
  final String musicFilePath;
  final String singerName;
  final String imagePath;
  final bool isPlaying;

  SetIsPlayingMusicEvent({
    required this.musicFilePath,
    required this.singerName,
    required this.imagePath,
    required this.isPlaying});

  @override
  List<Object> get props => [musicFilePath, singerName, imagePath, isPlaying];
}

class SetPreviousSongFileEvent extends IsPlayingMusicEvent{
  final String previousSongFilePath;

  SetPreviousSongFileEvent({
    required this.previousSongFilePath});

  @override
  List<Object> get props => [previousSongFilePath];
}

class GetIsPlayingMusicEvent extends IsPlayingMusicEvent{

  GetIsPlayingMusicEvent();

  @override
  List<Object> get props => [];
}

class GetPreviousSongFileEvent extends IsPlayingMusicEvent{

  GetPreviousSongFileEvent();

  @override
  List<Object> get props => [];
}