abstract class PlayBoxEvent {
  List<Object> get props => [];
}

class PlayBoxListEvent extends PlayBoxEvent{
  final String songName;

  PlayBoxListEvent({required this.songName});

  @override
  List<Object> get props => [songName];

}