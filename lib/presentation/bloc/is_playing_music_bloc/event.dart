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

class GetIsPlayingMusicEvent extends IsPlayingMusicEvent{

  GetIsPlayingMusicEvent();

  @override
  List<Object> get props => [];
}