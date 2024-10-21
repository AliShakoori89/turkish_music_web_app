abstract class AlbumEvent {
  List<Object> get props => [];
}

class GetNewAlbumEvent extends AlbumEvent{}

class GetAllAlbumEvent extends AlbumEvent{
  final String char;

  GetAllAlbumEvent({required this.char});

  @override
  List<Object> get props => [char];
}

class GetSingerAllAlbumEvent extends AlbumEvent{
  final int id;

  GetSingerAllAlbumEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class ResetAlbumStateEvent extends AlbumEvent {}

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