abstract class MiniPlayingContainerEvent {
  List<Object> get props => [];
}

class FirstPlayingSongEvent extends MiniPlayingContainerEvent{}

class CheckPlayingSongEvent extends MiniPlayingContainerEvent{}

class WriteSongIDForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{
  final int songID;
  final int albumID;
  final int categoryID;
  final String pageName;

  WriteSongIDForMiniPlayingSongContainerEvent({
    required this.songID,
    required this.albumID,
    required this.categoryID,
    required this.pageName
  });

  @override
  List<Object> get props => [songID, albumID, categoryID, pageName];
}

class ReadSongIDForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{}

class RefreshMiniPlayerEvent extends MiniPlayingContainerEvent{}


// class GetSingerAllAlbumEvent extends AlbumEvent{
//   final int id;
//
//   GetSingerAllAlbumEvent({required this.id});
//
//   @override
//   List<Object> get props => [id];
// }