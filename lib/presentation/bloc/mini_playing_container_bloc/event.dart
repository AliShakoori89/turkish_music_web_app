abstract class MiniPlayingContainerEvent {
  List<Object> get props => [];
}

class FirstPlayingSongEvent extends MiniPlayingContainerEvent{}

class CheckPlayingSongEvent extends MiniPlayingContainerEvent{}

class WriteSongIDForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{
  final int songID;
  final int albumID;

  WriteSongIDForMiniPlayingSongContainerEvent({
    required this.songID,
    required this.albumID
  });

  @override
  List<Object> get props => [songID, albumID];
}

class ReadSongIDForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{}


// class GetSingerAllAlbumEvent extends AlbumEvent{
//   final int id;
//
//   GetSingerAllAlbumEvent({required this.id});
//
//   @override
//   List<Object> get props => [id];
// }