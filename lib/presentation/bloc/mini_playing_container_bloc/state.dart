import 'package:equatable/equatable.dart';

enum MiniPlayingContainerStatus { initial, success, error, loading }

extension MiniPlayingContainerStatusX on MiniPlayingContainerStatus {
  bool get isInitial => this == MiniPlayingContainerStatus.initial;
  bool get isSuccess => this == MiniPlayingContainerStatus.success;
  bool get isError => this == MiniPlayingContainerStatus.error;
  bool get isLoading => this == MiniPlayingContainerStatus.loading;
}

class MiniPlayingContainerState extends Equatable{

  const MiniPlayingContainerState({
    required this.status,
    required this.visibility,
    required this.songID,
    required this.albumID
  });

  static MiniPlayingContainerState initial() => const MiniPlayingContainerState(
    status: MiniPlayingContainerStatus.initial,
    visibility: false,
    albumID: 0,
    songID: 0
  );

  final MiniPlayingContainerStatus status;
  final bool visibility;
  final int songID;
  final int albumID;

  @override
  // TODO: implement props
  List<Object?> get props => [status, visibility, songID, albumID];

  MiniPlayingContainerState copyWith({
    MiniPlayingContainerStatus? status,
    bool? visibility,
    int? songID,
    int? albumID
  }) {
    return MiniPlayingContainerState(
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      songID: songID ?? this.songID,
      albumID: albumID ?? this.albumID,
    );
  }
}