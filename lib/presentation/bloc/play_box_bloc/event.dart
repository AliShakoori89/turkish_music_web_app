abstract class PlayBoxEvent {
  List<Object> get props => [];
}

class PlayBoxListEvent extends PlayBoxEvent{
  final String songName;

  PlayBoxListEvent({required this.songName});

  @override
  List<Object> get props => [songName];

}

class CalculateSongTimeEvent extends PlayBoxEvent{
  final String songFile;

  CalculateSongTimeEvent({required this.songFile});

  @override
  List<Object> get props => [songFile];

}