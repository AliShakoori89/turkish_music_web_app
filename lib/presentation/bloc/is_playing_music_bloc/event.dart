abstract class IsPlayingMusicEvent {
  List<Object> get props => [];
}

class SetIsPlayingMusicEvent extends IsPlayingMusicEvent{
  final String musicFilePath;
  final String singerName;
  final String imagePath;

  SetIsPlayingMusicEvent({
    required this.musicFilePath,
    required this.singerName,
    required this.imagePath});

  @override
  List<Object> get props => [musicFilePath, singerName, imagePath];
}

class GetIsPlayingMusicEvent extends IsPlayingMusicEvent{

  GetIsPlayingMusicEvent();

  @override
  List<Object> get props => [];
}