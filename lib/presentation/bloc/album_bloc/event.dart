abstract class AlbumEvent {
  List<Object> get props => [];
}

class GetNewAlbumEvent extends AlbumEvent{}

class GetSingerAllAlbumEvent extends AlbumEvent{
  final int id;

  GetSingerAllAlbumEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetAlbumLengthEvent extends AlbumEvent{
  final int id;

  GetAlbumLengthEvent({required this.id});
  @override
  List<Object> get props => [id];

}

class GetAlbumAllSongsEvent extends AlbumEvent{
  final int albumId;

  GetAlbumAllSongsEvent({required this.albumId});
  @override
  List<Object> get props => [albumId];

}