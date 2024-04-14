abstract class IsPlayingMusicEvent {
  List<Object> get props => [];
}

class SetIsPlayingMusicEvent extends IsPlayingMusicEvent{
  final String musicFilePath;

  SetIsPlayingMusicEvent({required this.musicFilePath});

  @override
  List<Object> get props => [musicFilePath];
}