import 'package:equatable/equatable.dart';

import '../../../data/model/new-song_model.dart';

enum PlayBoxStatus { initial, success, error, loading }

extension PlayBoxStatusX on PlayBoxStatus {
  bool get isInitial => this == PlayBoxStatus.initial;
  bool get isSuccess => this == PlayBoxStatus.success;
  bool get isError => this == PlayBoxStatus.error;
  bool get isLoading => this == PlayBoxStatus.loading;
}

class PlayBoxState extends Equatable{

  const PlayBoxState({
    required this.status,
    required this.playBoxSong
  });

  static PlayBoxState initial() => const PlayBoxState(
    status: PlayBoxStatus.initial,
    playBoxSong: []
  );

  final PlayBoxStatus status;
  final List<NewSongDataModel>? playBoxSong;

  @override
  // TODO: implement props
  List<Object?> get props => [status, playBoxSong];

  PlayBoxState copyWith({
    PlayBoxStatus? status,
    List<NewSongDataModel>? playBoxSong
  }) {
    return PlayBoxState(
      status: status ?? this.status,
      playBoxSong: playBoxSong ?? this.playBoxSong
    );
  }
}