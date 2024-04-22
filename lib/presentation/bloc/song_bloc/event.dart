abstract class SongEvent {
  List<Object> get props => [];
}

class GetSongEvent extends SongEvent{
  final int songId;

  GetSongEvent({required this.songId});

  @override
  List<Object> get props => [songId];
}


