abstract class PlayingSongEvent {
  List<Object> get props => [];
}

class SetPlayingSongEvent extends PlayingSongEvent{
  final String songFilePath;
  final String singerName;
  final String imagePath;
  final bool isPlaying;

  SetPlayingSongEvent({
    required this.songFilePath,
    required this.singerName,
    required this.imagePath,
    required this.isPlaying});

  @override
  List<Object> get props => [songFilePath, singerName, imagePath, isPlaying];
}

class SetPreviousSongFileEvent extends PlayingSongEvent{
  final String previousSongFilePath;

  SetPreviousSongFileEvent({
    required this.previousSongFilePath});

  @override
  List<Object> get props => [previousSongFilePath];
}

class GetPlayingSongEvent extends PlayingSongEvent{

  GetPlayingSongEvent();

  @override
  List<Object> get props => [];
}

class GetPreviousSongFileEvent extends PlayingSongEvent{

  GetPreviousSongFileEvent();

  @override
  List<Object> get props => [];
}