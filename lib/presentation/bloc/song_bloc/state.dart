import 'package:equatable/equatable.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/song_model.dart';

enum SongStatus { initial, success, error, loading }

extension SongStatusX on SongStatus {
  bool get isInitial => this == SongStatus.initial;
  bool get isSuccess => this == SongStatus.success;
  bool get isError => this == SongStatus.error;
  bool get isLoading => this == SongStatus.loading;
}

class SongState extends Equatable{

  const SongState({
    required this.status,
    required this.allSongList,
    required this.newSongList,
    required this.albumSongList,
    required this.callback
  });

  static SongState initial() => const SongState(
      status: SongStatus.initial,
      allSongList: [],
      newSongList: [],
      albumSongList: [],
      callback: _defaultCallbackFunction
  );

  final SongStatus status;
  final List<SongDataModel> allSongList;
  final List<SongDataModel> newSongList;
  final List<SongDataModel> albumSongList;
  final Function callback;

  @override
  // TODO: implement props
  List<Object?> get props => [status, allSongList, newSongList, albumSongList, callback];

  SongState copyWith({
    SongStatus? status,
    List<SongDataModel>? allSongList,
    List<SongDataModel>? newSongList,
    List<SongDataModel>? albumSongList,
    Function? callback
  }) {
    return SongState(
      status: status ?? this.status,
      allSongList: allSongList ?? this.allSongList,
      newSongList: newSongList ?? this.newSongList,
      albumSongList: albumSongList ?? this.albumSongList,
      callback: callback ?? this.callback
    );
  }

  static void _defaultCallbackFunction() {
    // Define the default behavior of the callback function, or leave it empty
  }
}