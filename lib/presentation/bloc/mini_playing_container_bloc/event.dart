abstract class MiniPlayingContainerEvent {
  List<Object> get props => [];
}

class FirstPlayingSongEvent extends MiniPlayingContainerEvent{}
class CheckPlayingSongEvent extends MiniPlayingContainerEvent{}

// class GetSingerAllAlbumEvent extends AlbumEvent{
//   final int id;
//
//   GetSingerAllAlbumEvent({required this.id});
//
//   @override
//   List<Object> get props => [id];
// }