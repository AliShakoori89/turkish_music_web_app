abstract class SongEvent {
  List<Object> get props => [];
}

class FetchNewSongsEvent extends SongEvent {}
class FetchAllSongsEvent extends SongEvent {}
class FetchSongEvent extends SongEvent {
  final int songID;

  FetchSongEvent({required this.songID});

  @override
  List<Object> get props => [songID];
}