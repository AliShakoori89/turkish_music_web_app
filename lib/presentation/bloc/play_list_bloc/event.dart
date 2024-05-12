abstract class PlayListEvent {
  List<Object> get props => [];
}

class AddMusicToPlaylistEvent extends PlayListEvent{
  final int musicID;

  AddMusicToPlaylistEvent({
    required this.musicID});

  @override
  List<Object> get props => [musicID];
}

class RemoveMusicFromPlaylistEvent extends PlayListEvent{
  final int musicID;

  RemoveMusicFromPlaylistEvent({
    required this.musicID});

  @override
  List<Object> get props => [musicID];
}

class GetAllMusicInPlaylistEvent extends PlayListEvent{}