import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/song_model.dart';

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
  });

  static PlaylistState initial() => const PlaylistState(
    status: PlayListStatus.initial,
    playlistSongs: <SongDataModel>[],
  );

  final PlayListStatus status;
  final List<SongDataModel> playlistSongs;

  @override
  // TODO: implement props
  List<Object?> get props => [status, playlistSongs];

  PlaylistState copyWith({
    PlayListStatus? status,
    List<SongDataModel>? playlistSongs,
  }) {
    return PlaylistState(
      status: status ?? this.status,
      playlistSongs: playlistSongs ?? this.playlistSongs,
    );
  }
}