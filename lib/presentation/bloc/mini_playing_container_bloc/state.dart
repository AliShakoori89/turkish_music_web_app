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
    required this.albumID,
    required this.pageName,
    required this.categoryID
  });

  static MiniPlayingContainerState initial() => const MiniPlayingContainerState(
    status: MiniPlayingContainerStatus.initial,
    visibility: false,
    albumID: 0,
    songID: 0,
    pageName: '',
    categoryID: 1
  );

  final MiniPlayingContainerStatus status;
  final bool visibility;
  final int songID;
  final int albumID;
  final String pageName;
  final int categoryID;

  @override
  // TODO: implement props
  List<Object?> get props => [status, visibility, songID, albumID, pageName, categoryID];

  MiniPlayingContainerState copyWith({
    MiniPlayingContainerStatus? status,
    bool? visibility,
    int? songID,
    int? albumID,
    String? pageName,
    int? categoryID
  }) {
    return MiniPlayingContainerState(
      status: status ?? this.status,
      visibility: visibility ?? this.visibility,
      songID: songID ?? this.songID,
      albumID: albumID ?? this.albumID,
      pageName: pageName ?? this.pageName,
      categoryID: categoryID ?? this.categoryID
    );
  }
}