abstract class MiniPlayingContainerEvent {
  List<Object> get props => [];
}

class FirstPlayingSongEvent extends MiniPlayingContainerEvent{}

class CheckPlayingSongEvent extends MiniPlayingContainerEvent{}

class WriteRequirementForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{
  final String songName;
  final String songFile;
  final String songImage;

  WriteRequirementForMiniPlayingSongContainerEvent({required this.songName, required this.songFile, required this.songImage});

  @override
  List<Object> get props => [songName, songFile, songImage];
}

class ReadRequirementForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{

}


// class GetSingerAllAlbumEvent extends AlbumEvent{
//   final int id;
//
//   GetSingerAllAlbumEvent({required this.id});
//
//   @override
//   List<Object> get props => [id];
// }