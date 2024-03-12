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