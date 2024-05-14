abstract class PlayListEvent {
  List<Object> get props => [];
}

class AddMusicToPlaylistEvent extends PlayListEvent{
  final int songID;

  AddMusicToPlaylistEvent({
    required this.songID});

  @override
  List<Object> get props => [songID];
}

class RemoveMusicFromPlaylistEvent extends PlayListEvent{
  final int musicID;

  RemoveMusicFromPlaylistEvent({
    required this.musicID});

  @override
  List<Object> get props => [musicID];
}

class GetAllMusicInPlaylistEvent extends PlayListEvent{}

class SaveSongIDEvent extends PlayListEvent{
  final int songID;

  SaveSongIDEvent({
    required this.songID});

  @override
  List<Object> get props => [songID];
}

class RemoveSongIDEvent extends PlayListEvent{
  final int songID;

  RemoveSongIDEvent({
    required this.songID});

  @override
  List<Object> get props => [songID];
}

class SearchSongIDEvent extends PlayListEvent{
  final int songID;

  SearchSongIDEvent({
    required this.songID});

  @override
  List<Object> get props => [songID];
}