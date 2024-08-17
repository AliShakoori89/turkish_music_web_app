import 'package:equatable/equatable.dart';
import 'package:turkish_music_app/data/model/recently_played_song_Id_model.dart';

import '../../../data/model/album_model.dart';
import '../../../data/model/song_model.dart';

enum RecentlyPlaySongStatus { initial, success, error, loading }

extension RecentliPlaySongStatusX on RecentlyPlaySongStatus {
  bool get isInitial => this == RecentlyPlaySongStatus.initial;
  bool get isSuccess => this == RecentlyPlaySongStatus.success;
  bool get isError => this == RecentlyPlaySongStatus.error;
  bool get isLoading => this == RecentlyPlaySongStatus.loading;
}

class RecentlyPlaySongState extends Equatable{

  const RecentlyPlaySongState({
    required this.status,
    required this.allRecentlySongs
  });

  static RecentlyPlaySongState initial() => const RecentlyPlaySongState(
    status: RecentlyPlaySongStatus.initial,
    allRecentlySongs: <AlbumDataMusicModel>[]
  );

  final RecentlyPlaySongStatus status;
  final List<AlbumDataMusicModel> allRecentlySongs;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  RecentlyPlaySongState copyWith({
    RecentlyPlaySongStatus? status,
    List<AlbumDataMusicModel>? allRecentlySongs
  }) {
    return RecentlyPlaySongState(
      status: status ?? this.status,
      allRecentlySongs: allRecentlySongs ?? this.allRecentlySongs
    );
  }
}