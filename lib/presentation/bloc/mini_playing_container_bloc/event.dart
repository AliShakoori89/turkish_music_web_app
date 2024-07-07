abstract class MiniPlayingContainerEvent {
  List<Object> get props => [];
}

class FirstPlayingSongEvent extends MiniPlayingContainerEvent{}

class CheckPlayingSongEvent extends MiniPlayingContainerEvent{}

class WriteRequirementForMiniPlayingSongContainerEvent extends MiniPlayingContainerEvent{
  final String songName;
  final String songFile;
  final String songImage;
  final String singerName;

  WriteRequirementForMiniPlayingSongContainerEvent({required this.songName,
    required this.songFile, required this.songImage, required this.singerName});

  @override
  List<Object> get props => [songName, songFile, songImage, singerName];
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