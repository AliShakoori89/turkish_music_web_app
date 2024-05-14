import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/song_model.dart';

import '../../../data/model/playListSongModel.dart';

enum PlayListStatus { initial, success, error, loading }

extension PlayListStatusX on PlayListStatus {
  bool get isInitial => this == PlayListStatus.initial;
  bool get isSuccess => this == PlayListStatus.success;
  bool get isError => this == PlayListStatus.error;
  bool get isLoading => this == PlayListStatus.loading;
}

class PlaylistState extends Equatable{

  const PlaylistState({
    required this.status,
    required this.playlistSongs,
    required this.isFavorite
  });

  static PlaylistState initial() => const PlaylistState(
    status: PlayListStatus.initial,
    playlistSongs: <PlaylistMusicModel>[],
    isFavorite: false
  );

  final PlayListStatus status;
  final List<PlaylistMusicModel> playlistSongs;
  final bool isFavorite;

  @override
  // TODO: implement props
  List<Object?> get props => [status, playlistSongs, isFavorite];

  PlaylistState copyWith({
    PlayListStatus? status,
    List<PlaylistMusicModel>? playlistSongs,
    bool? isFavorite
  }) {
    return PlaylistState(
      status: status ?? this.status,
      playlistSongs: playlistSongs ?? this.playlistSongs,
      isFavorite: isFavorite ?? this.isFavorite
    );
  }
}