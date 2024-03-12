abstract class MusicEvent {
  List<Object> get props => [];
}

class GetMusicEvent extends MusicEvent{
  final int musicId;

  GetMusicEvent({required this.musicId});

  @override
  List<Object> get props => [musicId];
}


