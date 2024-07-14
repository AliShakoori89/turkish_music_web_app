abstract class SongEvent {
  List<Object> get props => [];
}

class FetchNewSongs extends SongEvent {}
class FetchAllSongs extends SongEvent {}
class FetchAlbumSongs extends SongEvent {
  final int id;

  FetchAlbumSongs({required this.id});
}