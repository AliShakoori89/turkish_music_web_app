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
    required this.playBoxSong,
    required this.songTime,
    required this.minute,
    required this.second
  });

  static PlayBoxState initial() => const PlayBoxState(
    status: PlayBoxStatus.initial,
    playBoxSong: [],
    songTime: 0.0,
    minute: 0,
    second: '0'
  );

  final PlayBoxStatus status;
  final List<NewSongDataModel>? playBoxSong;
  final double songTime;
  final int minute;
  final String second;

  @override
  // TODO: implement props
  List<Object?> get props => [status, playBoxSong, songTime, minute, second];

  PlayBoxState copyWith({
    PlayBoxStatus? status,
    List<NewSongDataModel>? playBoxSong,
    double? songTime,
    int? minute,
    String? second
  }) {
    return PlayBoxState(
      status: status ?? this.status,
      playBoxSong: playBoxSong ?? this.playBoxSong,
      songTime: songTime ?? this.songTime,
      minute: minute ?? this.minute,
      second: second ?? this.second
    );
  }
}