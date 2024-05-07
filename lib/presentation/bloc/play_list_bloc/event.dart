abstract class PlayListEvent {
  List<Object> get props => [];
}

class AddMusicToPlaylistEvent extends PlayListEvent{
  final int userID;
  final int musicID;

  AddMusicToPlaylistEvent({
    required this.userID,
    required this.musicID});

  @override
  List<Object> get props => [userID, musicID];
}

class RemoveMusicFromPlaylistEvent extends PlayListEvent{
  final int userID;
  final int musicID;

  RemoveMusicFromPlaylistEvent({
    required this.userID,
    required this.musicID});

  @override
  List<Object> get props => [userID, musicID];
}

class GetAllMusicInPlaylistEvent extends PlayListEvent{}