import 'package:equatable/equatable.dart';
import '../../../data/model/playListSongModel.dart';

enum PlayButtonStatus { initial, success, error, loading }

extension PlayButtonStatusX on PlayButtonStatus {
  bool get isInitial => this == PlayButtonStatus.initial;
  bool get isSuccess => this == PlayButtonStatus.success;
  bool get isError => this == PlayButtonStatus.error;
  bool get isLoading => this == PlayButtonStatus.loading;
}

class PlayButtonState extends Equatable{

  const PlayButtonState({
    required this.status,
    required this.playButtonState,
  });

  static PlayButtonState initial() => const PlayButtonState(
      status: PlayButtonStatus.initial,
      playButtonState: false,
  );

  final PlayButtonStatus status;
  final bool playButtonState;

  @override
  // TODO: implement props
  List<Object?> get props => [status, playButtonState];

  PlayButtonState copyWith({
    PlayButtonStatus? status,
    bool? playButtonState
  }) {
    return PlayButtonState(
        status: status ?? this.status,
        playButtonState: playButtonState ?? this.playButtonState
    );
  }
}