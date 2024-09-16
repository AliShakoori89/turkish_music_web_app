import 'package:equatable/equatable.dart';
import '../../../data/model/album_model.dart';

enum DownloadSongStatus { initial, success, error, loading }

extension DownloadSongStatusX on DownloadSongStatus {
  bool get isInitial => this == DownloadSongStatus.initial;
  bool get isSuccess => this == DownloadSongStatus.success;
  bool get isError => this == DownloadSongStatus.error;
  bool get isLoading => this == DownloadSongStatus.loading;
}

class DownloadSongState extends Equatable{

  const DownloadSongState({
    required this.status,
    required this.allDownloadSong
  });

  static DownloadSongState initial() => const DownloadSongState(
    status: DownloadSongStatus.initial,
    allDownloadSong: <AlbumDataMusicModel>[]
  );

  final DownloadSongStatus status;
  final List<AlbumDataMusicModel> allDownloadSong;

  @override
  // TODO: implement props
  List<Object?> get props => [status];

  DownloadSongState copyWith({
    DownloadSongStatus? status,
    List<AlbumDataMusicModel>? allDownloadSong
  }) {
    return DownloadSongState(
      status: status ?? this.status,
      allDownloadSong: allDownloadSong ?? this.allDownloadSong
    );
  }
}